//
//  Dislike.m
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import "Dislike.h"
#import "Friend.h"
#import "Location.h"

@implementation Dislike

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"Dislike" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
    return @"Dislike";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription entityForName:@"Dislike" inManagedObjectContext:moc_];
}

@end
