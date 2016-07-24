//
//  Correspondence.m
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import "Correspondence.h"
#import "Friend.h"
#import "Location.h"

@implementation Correspondence

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"Correspondence" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
    return @"Correspondence";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription entityForName:@"Correspondence" inManagedObjectContext:moc_];
}

@end
