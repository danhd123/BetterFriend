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
#import "Friend+CoreDataProperties.h"
#import "Location+CoreDataProperties.h"
#import <Contacts/Contacts.h>
#import "Like+CoreDataProperties.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@property MFMailComposeViewController *composeVC;
@property MFMessageComposeViewController *messageVC;
@property BOOL shouldCheckForStaleFriends;
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
    
    //get events
    NSData *eventsData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Events" withExtension:@"json"]];
    NSArray *events = [NSJSONSerialization JSONObjectWithData:eventsData options:0 error:nil];
    if (self.objects == nil) {
        self.objects = [NSMutableArray array];
    }
    [self.objects addObjectsFromArray:events];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self checkForStaleFriends];
}

- (void)checkForStaleFriends {
    if (!self.shouldCheckForStaleFriends)
    {
        return;
    }
    NSFetchRequest *friendRequest = [[NSFetchRequest alloc] initWithEntityName:[Friend entityName]];
    NSArray<Friend *> *friends = [APP_MOC executeFetchRequest:friendRequest error:nil];
    __block BOOL reached = NO;
    for (Friend *f in friends) {
        if (f.isStale) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Hang out with %@?", f.name]
                                                                           message:[NSString stringWithFormat:@"Do you want to reach out to %@ to hang out on 8/3 at 4 PM?", f.name]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Reach out!" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      reached = YES;
                                                                        if (reached == YES)
                                                                        {
                                                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                                [self attemptMailSendWithFriend:f date:nil location:nil];
                                                                            });
                                                                        }

                                                                  }];
            
            [alert addAction:defaultAction];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Remind me soon!" style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * action) {
                                                               //set timer for 5 minutes before reminding user to reach out again
                                                            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:^{}];

        }
    }
}

- (void)attemptMailSendWithFriend:(Friend *)f date:(NSDate *)date location:(Location *)location {
    if (![MFMailComposeViewController canSendMail]) {
        NSLog(@"something has gone terribly wrong");
        return;
    }
    
    self.composeVC = [[MFMailComposeViewController alloc] init];
    self.composeVC.mailComposeDelegate = self;
    
    // Configure the fields of the interface.
    NSFetchRequest *locationReq = [[NSFetchRequest alloc] initWithEntityName:[Location entityName]];
    locationReq.predicate = [NSComparisonPredicate predicateWithLeftExpression:[NSExpression expressionForKeyPath:@"name"] rightExpression:[NSExpression expressionForConstantValue:@"Trouble Cafe"] modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:NSDiacriticInsensitivePredicateOption];
    NSArray *results = [APP_MOC executeFetchRequest:locationReq error:nil];
    Location *demolocation = results[0];
    location = demolocation;
    NSArray *keysToFetch = @[CNContactEmailAddressesKey, CNContactNicknameKey, CNContactGivenNameKey, CNContactFamilyNameKey];
    CNContactStore *contactStore = [CNContactStore new];
    CNContact *contact = [contactStore unifiedContactWithIdentifier:f.contactsIdentifier keysToFetch:keysToFetch error:nil];
    NSString *recipEmail = contact.emailAddresses[0].value;
    [self.composeVC setToRecipients:@[recipEmail]];
    NSOrderedSet *gf = location.goodFor;
    Like *first = gf[0];
    NSString *subsubj = first.name;
    NSString *subj = [NSString stringWithFormat:@"%@ sometime soon?", subsubj];
    [self.composeVC setSubject:subj ];
//    [self.composeVC setMessageBody:@"Foobar" isHTML:NO];
    [self.composeVC setMessageBody:[NSString stringWithFormat:@"Hi %@,\n\nI hope you're doing well. I've been enjoying the weather out here in San Francisco.\n\nJust wanted to drop a line and see if you were free to catch up. Are you free to grab %@ 8/3 at 4 PM?\n\nI look forward to talking to you soon.\n\nCheers,\n%@", contact.givenName ?: contact.familyName, subsubj/*, date TODO: format better */, @"Daniel"]
                       isHTML:NO];
    
    // Present the view controller modally.
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:self.composeVC animated:YES completion:nil];
//    });
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
//    if (result == MFMailComposeResultSent || result == MFMailComposeResultSaved) {
//        //success
//        //TODO record this in the DB. We'll need the Friend and Location to create a Correspondence.
//    }
//    else {
//        [self dismissViewControllerAnimated:YES completion:^{
//        }];
//    }
    self.shouldCheckForStaleFriends = NO;
    [controller dismissViewControllerAnimated:YES completion:^{
        
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(demo_remindAboutNearStaleFriend:) userInfo:nil repeats:NO];
    }];
}

- (void)demo_remindAboutNearStaleFriend:(NSTimer *)firedTimer {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Hang out with Sebastian?"]
                                                                   message:[NSString stringWithFormat:@"Do you want to reach out to Sebastian to hang out on 8/4 at 4 PM?"]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Reach out!" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                  [self attemptTextSendWithFriend:nil date:nil location:nil];
                                                              });
                                                          }];
    
    [alert addAction:defaultAction];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Remind me soon!" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) {
                                                       //set timer for 5 minutes before reminding user to reach out again
                                                   }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{
        ;
    }];
}

- (void)attemptTextSendWithFriend:(Friend *)f date:(NSDate *)date location:(Location *)location {
    if (![MFMessageComposeViewController canSendText]) {
        NSLog(@"Something has gone wrong here");
        return;
    }
    self.messageVC = [[MFMessageComposeViewController alloc] init];
    self.messageVC.messageComposeDelegate = self;
    if (f == nil) { //because we're doing a demo, say
        //todo: finish this
        self.messageVC = [[MFMessageComposeViewController alloc] init];
        NSArray *keysToFetch = @[CNContactPhoneNumbersKey, CNContactNicknameKey, CNContactGivenNameKey, CNContactFamilyNameKey];
        CNContactStore *contactStore = [CNContactStore new];
        CNContact *contact = [contactStore unifiedContactsMatchingPredicate:[CNContact predicateForContactsMatchingName:@"Sebastian Park"] keysToFetch:keysToFetch error:nil][0];
        NSString *recipPhone = contact.phoneNumbers[0].value.stringValue;
        [self.messageVC setRecipients:@[recipPhone]];
        [self.messageVC setBody:@"Hey Sebastian! It's been too long since we last caught up. Want to hang out somewhere next Wednesday (8/4)? Say 4PM? LMK!"];
        [self presentViewController:self.messageVC animated:YES completion:^{
            ;
        }];
    }
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    self.shouldCheckForStaleFriends = NO;
    [self.messageVC dismissViewControllerAnimated:YES completion:^{
        ;
    }];
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
    self.shouldCheckForStaleFriends = YES;
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

    NSDictionary *object = self.objects[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ with %@", object[@"Action"], object[@"Person"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", object[@"Date"], object[@"Time"]];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Upcoming Meetups";
}

@end
