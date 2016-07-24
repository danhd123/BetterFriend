//
//  MasterViewController.m
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/23/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "AppDelegate.h"
#import "Friend.h"
#import "Location.h"
#import <Contacts/Contacts.h>
#import "Like.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *configureButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self action:@selector(configure:)];
    self.navigationItem.rightBarButtonItem = configureButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
    
    //get contacts
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [self checkForStaleFriends];
}

- (void)checkForStaleFriends {
    NSFetchRequest *friendRequest = [[NSFetchRequest alloc] initWithEntityName:[Friend entityName]];
    NSArray<Friend *> *friends = [APP_MOC executeFetchRequest:friendRequest error:nil];
    for (Friend *f in friends) {
        if (f.isStale) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Hang out with %@?", f.name]
                                                                           message:[NSString stringWithFormat:@"Do you want to reach out to %@ to hang out on 8/3 at 4 PM?", f.name]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Reach out" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [self attemptMailSendWithFriend:f date:nil location:nil];
                                                                  }];
            
            [alert addAction:defaultAction];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Remind me soon!" style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * action) {
                                                               //set timer for 5 minutes before reminding user to reach out again
                                                            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];

        }
    }
}

- (void)attemptMailSendWithFriend:(Friend *)f date:(NSDate *)date location:(Location *)location {
    if (![MFMailComposeViewController canSendMail]) {
        NSLog(@"something has gone terribly wrong");
        return;
    }
    
    MFMailComposeViewController* composeVC = [[MFMailComposeViewController alloc] init];
    composeVC.mailComposeDelegate = self;
    
    // Configure the fields of the interface.
    Location *demolocation = [Location new];
    demolocation.name = @"Sightglass";
    Like *demolike = [Like new];
    demolike.name = @"coffee";
    NSOrderedSet *os = [NSOrderedSet orderedSetWithObject:demolike];
    demolocation.goodFor = os;
    location = demolocation;
    
    NSArray *keysToFetch = @[CNContactEmailAddressesKey, CNContactNicknameKey, CNContactGivenNameKey, CNContactFamilyNameKey];
    CNContactStore *contactStore = [CNContactStore new];
    CNContact *contact = [contactStore unifiedContactWithIdentifier:f.contactsIdentifier keysToFetch:keysToFetch error:nil];
    [composeVC setToRecipients:@[contact.emailAddresses]];
    [composeVC setSubject:[NSString stringWithFormat:@"%@ sometime soon?", location.goodFor.firstObject.name]];
    [composeVC setMessageBody:[NSString stringWithFormat:@"Hi %@,\n\nI hope you're doing well. I've been enjoying the weather out here in San Francisco.\n\nJust wanted to drop a line and see if you were free to catch up. Are you free to grab %@ 8/3 at 4 PM?\n\nI look forward to talking to you soon.\n\nCheers,\n%@", contact.nickname ?: contact.givenName ?: contact.familyName, location.goodFor.firstObject.name/*, date TODO: format better */, @"Daniel"]
                       isHTML:NO];
    
    // Present the view controller modally.
    [self presentViewController:composeVC animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configure:(id)sender {
    [self performSegueWithIdentifier:@"showManage" sender:sender];
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
