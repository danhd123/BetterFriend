//
//  FriendManager.h
//  BetterFriend
//
//  Created by Zac Bowling on 7/23/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Friend.h"
@import Contacts;

@interface FriendManager : NSObject

-(NSArray<Friend *>*)friends;

-(Friend *)addFriendWithContact:(CNContact *)contact;

-(void)removeFriend:(Friend *)fri;

-(void)save;

@end
