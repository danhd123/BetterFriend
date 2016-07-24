//
//  Friend.m
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import "Friend.h"
#import "Correspondence.h"
#import "Dislike.h"
#import "Like.h"

@implementation Friend

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
    return @"Friend";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription entityForName:@"Friend" inManagedObjectContext:moc_];
}

- (BOOL)isStale {
    return self.contactFrequency + self.lastContacted < [NSDate date].timeIntervalSinceReferenceDate;
}

@end
