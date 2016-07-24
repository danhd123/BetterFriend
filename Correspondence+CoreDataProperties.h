//
//  Correspondence+CoreDataProperties.h
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Correspondence.h"

NS_ASSUME_NONNULL_BEGIN

@interface Correspondence (CoreDataProperties)

@property (nullable, nonatomic, retain) Friend *friend;
@property (nullable, nonatomic, retain) Location *location;

@end

NS_ASSUME_NONNULL_END
