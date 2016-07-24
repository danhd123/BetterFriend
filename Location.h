//
//  Location.h
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Correspondence, Dislike, Like, LocationType;

NS_ASSUME_NONNULL_BEGIN

@interface Location : NSManagedObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;

@end

NS_ASSUME_NONNULL_END

#import "Location+CoreDataProperties.h"
