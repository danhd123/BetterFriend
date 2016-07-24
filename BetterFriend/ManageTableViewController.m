//
//  ManageTableViewController.m
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/23/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import "ManageTableViewController.h"
#import "FriendManager.h"
#import "Friend.h"
#import "AppDelegate.h"
#import "FriendSetupViewController.h"

@interface ManageTableViewController ()

@property (strong, nonatomic) NSArray<Friend *> *friends;
//@property (strong, nonatomic) NSOperationQueue *
@end

@implementation ManageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriends:)];
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] registerForPushNotifications];
    self.friends = [NSArray array];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFriends:(id)sender {
    CNContactPickerViewController *cpvc = [CNContactPickerViewController new];
    cpvc.delegate = self;
    [self presentViewController:cpvc animated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact *> *)contacts {
    NSMutableArray *tempFriends = [NSMutableArray arrayWithCapacity:contacts.count];
    for (CNContact *contact in contacts) {
        Friend *f = [Friend insertInManagedObjectContext:APP_MOC];
        f.contactsIdentifier = contact.identifier;
        f.name = [contact.givenName stringByAppendingString:contact.familyName];
        [tempFriends addObject:f];
    }
    self.friends = [self.friends arrayByAddingObjectsFromArray:tempFriends];
    [self.tableView reloadData];
    [self setupNextNewFriend];
}

- (void)setupNextNewFriend {
    for (Friend *f in self.friends) {
        if (f.contactFrequency == 0.0) {
            [self performSegueWithIdentifier:@"setupNewFriend" sender:f];
            return;
            //YUCK!!!!!!!!!!!!!!
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 1) {
        return 1;
    }
    else return self.friends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if ([indexPath indexAtPosition:0] == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell" forIndexPath:indexPath];
        cell.textLabel.text = [self.friends[[indexPath indexAtPosition:1]] name];
    }
    else if ([indexPath indexAtPosition:0] == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"LocationsCell" forIndexPath:indexPath];
        
    }
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"setupNewFriend"]) {
        FriendSetupViewController *setupController = [segue destinationViewController];
        setupController.setupFriend = sender;
        setupController.callingViewController = self;
    }
}


@end
