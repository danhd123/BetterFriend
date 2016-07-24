//
//  Like.m
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import "Like.h"
#import "Friend.h"
#import "Location.h"

@implementation Like

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"Like" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
    return @"Like";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription entityForName:@"Like" inManagedObjectContext:moc_];
}

@end
