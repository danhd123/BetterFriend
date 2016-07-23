//
//  FriendManager.m
//  BetterFriend
//
//  Created by Zac Bowling on 7/23/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import "FriendManager.h"

static FriendManager *sDefaultFriendManager = nil;

@implementation FriendManager {
    NSMutableArray<Friend *> *_friends;
}

-(id)init {
    self = [super init];
    if (self){
        _friends = [[NSMutableArray alloc] init];
    };
    return self;
}

+ (__kindof FriendManager *)defaultFriendManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sDefaultFriendManager = [[self alloc] init];
    });
    return sDefaultFriendManager;
}

- (Friend *)addFriendWithContact:(CNContact *)contact {
    Friend *f = [Friend new];
    f.contactsIdentifier = contact.identifier;
    f.name = [contact.givenName stringByAppendingString:contact.familyName];
    [_friends addObject:f];
    return f;
}

- (void)addFriendsFromContacts:(NSArray<CNContact *> *)contacts {
    for (CNContact *contact in contacts) {
        (void)[self addFriendWithContact:contact];
    }
}

- (void)removeFriend:(Friend *)fri {
    [_friends removeObject:fri];
}


@end
