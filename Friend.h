//
//  Friend.h
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Correspondence, Dislike, Like;

typedef NS_ENUM(NSUInteger, FriendContactBy) {
    FriendContactByEmail,
    FriendContactByText,
    FriendContactByPhone,
    FriendContactByMeeting,
};

NS_ASSUME_NONNULL_BEGIN

@interface Friend : NSManagedObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BOOL)isStale;

@end

NS_ASSUME_NONNULL_END

#import "Friend+CoreDataProperties.h"
