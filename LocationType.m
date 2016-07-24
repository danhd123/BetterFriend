//
//  LocationType.m
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import "LocationType.h"
#import "Location.h"

@implementation LocationType

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription insertNewObjectForEntityForName:@"LocationType" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
    return @"LocationType";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
    NSParameterAssert(moc_);
    return [NSEntityDescription entityForName:@"LocationType" inManagedObjectContext:moc_];
}

@end
