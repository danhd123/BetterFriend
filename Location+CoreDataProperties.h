//
//  Location+CoreDataProperties.h
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Location.h"

NS_ASSUME_NONNULL_BEGIN

@interface Location (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *subtype;
@property (nonatomic) int16_t price;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *detail;
@property (nullable, nonatomic, retain) Correspondence *correspondences;
@property (nullable, nonatomic, retain) Like *goodFor;
@property (nullable, nonatomic, retain) Dislike *badFor;
@property (nullable, nonatomic, retain) LocationType *type;

@end

NS_ASSUME_NONNULL_END
