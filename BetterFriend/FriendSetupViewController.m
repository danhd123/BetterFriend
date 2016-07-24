//
//  FriendSetupViewController.m
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import "FriendSetupViewController.h"
#import "Friend.h"
#import "AppDelegate.h"
#import "ManageTableViewController.h"

static double sDefaultContactFrequency = 3.0 * 7.0 * 24.0 * 60.0 * 60.0;

@interface FriendSetupViewController ()

@end

@implementation FriendSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditing:)];
    self.titleLabel.text = [NSString stringWithFormat:@"Be a better friend to %@.", self.setupFriend.name];
    self.whenLabel.text = [NSString stringWithFormat:@"When did you last see %@?", self.setupFriend.name];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doneEditing:(id)sender {
    self.setupFriend.lastContacted = self.datePicker.date.timeIntervalSinceNow;
    self.setupFriend.contactFrequency = sDefaultContactFrequency;
    self.setupFriend.contactTypePreference = self.contactMethodControl.selectedSegmentIndex;
    [APP_MOC save:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{ //maybe possibly avoid an unlikely stack overflow
            [(ManageTableViewController *)self.presentingViewController setupNextNewFriend];
        });
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
