//
//  Friend+CoreDataProperties.h
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Friend.h"

NS_ASSUME_NONNULL_BEGIN

@interface Friend (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *contactsIdentifier;
@property (nonatomic) NSTimeInterval lastContacted;
@property (nonatomic) double contactFrequency;
@property (nonatomic) int16_t contactTypePreference;
@property (nullable, nonatomic, retain) Like *likes;
@property (nullable, nonatomic, retain) Dislike *dislikes;
@property (nullable, nonatomic, retain) Correspondence *correspondences;

@end

NS_ASSUME_NONNULL_END
