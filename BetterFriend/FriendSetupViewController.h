//
//  FriendSetupViewController.h
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Friend;

@interface FriendSetupViewController : UIViewController
@property (strong, nonatomic) Friend *setupFriend;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *contactMethodControl;
@property (weak, nonatomic) IBOutlet UILabel *whenLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
