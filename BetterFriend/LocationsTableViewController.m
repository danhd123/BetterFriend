//
//  LocationsTableViewController.m
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/23/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import "LocationsTableViewController.h"
#import "Location.h"
#import "AppDelegate.h"

@interface LocationsTableViewController ()
@property (nonatomic, strong) NSMutableArray<Location *> *activities;
@property (nonatomic, strong) NSMutableArray<Location *> *food;
@property (nonatomic, strong) NSMutableArray<Location *> *locations;
@property (nonatomic, strong) NSMutableArray<Location *> *events;
@property (nonatomic, strong) NSArray<__kindof NSArray<Location *> *> *allLocations;
@end

@implementation LocationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addLocation:)];
    
    //more usefully...
    self.activities = [[NSMutableArray alloc] init];
    self.food = [[NSMutableArray alloc] init];
    self.locations = [[NSMutableArray alloc] init];
    self.events = [[NSMutableArray alloc] init];
    BOOL done = ![[NSUserDefaults standardUserDefaults] boolForKey:@"LocationsTableViewControllerAlreadyLoadedSampleLocations"];
    if (!done) {
        NSData *locationData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"locations" withExtension:@"json"]];
        NSError *jsonConversionError = nil;
        NSArray *locationArray = [NSJSONSerialization JSONObjectWithData:locationData options:0 error:&jsonConversionError];
        if (!locationArray) {
            NSLog(@"failed to convert JSON to array: %@", jsonConversionError);
            return;
        }
        //TODO: maybe do this in a LocationsManager that connects to Firebase.
        for (NSDictionary *dict in locationArray) {
            Location *location = [Location insertInManagedObjectContext:APP_MOC];
            location.name = dict[@"Thing"];
            location.detail = dict[@"Description"];
            location.locationType = dict[@"Type"];
        }
    }
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[Location entityName]];
    NSArray<Location *> *results = [APP_MOC executeFetchRequest:req error:nil];
    for (Location *location in results) {
        if ([location.locationType isEqualToString:@"Activity"]) {
            [self.activities addObject:location];
        }
        else if ([location.locationType isEqualToString:@"Food"]) {
            [self.food addObject:location];
        }
        else if ([location.locationType isEqualToString:@"Location"]) {
            [self.locations addObject:location];
        }
        else if ([location.locationType isEqualToString:@"Event"]) {
            [self.events addObject:location];
        }
    }
    self.allLocations = [NSArray arrayWithObjects:self.activities, self.food, self.locations, self.events, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addLocation:(id)sender {
    //do nothing, this part is faked.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.activities.count;
            break;
        case 1:
            return self.food.count;
            break;
        case 2:
            return self.locations.count;
            break;
        case 3:
            return self.events.count;
        default:
            return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.allLocations[[indexPath indexAtPosition:0]][[indexPath indexAtPosition:1]].name;
    cell.detailTextLabel.text = self.allLocations[[indexPath indexAtPosition:0]][[indexPath indexAtPosition:1]].detail;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:return @"Activities";
        case 1: return @"Food";
        case 2: return @"Locations";
        case 3: return @"Events";
        default: return nil;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
