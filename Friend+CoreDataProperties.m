//
//  Friend+CoreDataProperties.m
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Friend+CoreDataProperties.h"

@implementation Friend (CoreDataProperties)

@dynamic name;
@dynamic contactsIdentifier;
@dynamic lastContacted;
@dynamic contactFrequency;
@dynamic contactTypePreference;
@dynamic likes;
@dynamic dislikes;
@dynamic correspondences;

@end
