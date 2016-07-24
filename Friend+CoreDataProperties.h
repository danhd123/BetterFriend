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
@property (nullable, nonatomic, retain) NSSet<Like *> *likes;
@property (nullable, nonatomic, retain) NSSet<Dislike *> *dislikes;
@property (nullable, nonatomic, retain) NSOrderedSet<Correspondence *> *correspondences;

@end

@interface Friend (CoreDataGeneratedAccessors)

- (void)addLikesObject:(Like *)value;
- (void)removeLikesObject:(Like *)value;
- (void)addLikes:(NSSet<Like *> *)values;
- (void)removeLikes:(NSSet<Like *> *)values;

- (void)addDislikesObject:(Dislike *)value;
- (void)removeDislikesObject:(Dislike *)value;
- (void)addDislikes:(NSSet<Dislike *> *)values;
- (void)removeDislikes:(NSSet<Dislike *> *)values;

- (void)insertObject:(Correspondence *)value inCorrespondencesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCorrespondencesAtIndex:(NSUInteger)idx;
- (void)insertCorrespondences:(NSArray<Correspondence *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCorrespondencesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCorrespondencesAtIndex:(NSUInteger)idx withObject:(Correspondence *)value;
- (void)replaceCorrespondencesAtIndexes:(NSIndexSet *)indexes withCorrespondences:(NSArray<Correspondence *> *)values;
- (void)addCorrespondencesObject:(Correspondence *)value;
- (void)removeCorrespondencesObject:(Correspondence *)value;
- (void)addCorrespondences:(NSOrderedSet<Correspondence *> *)values;
- (void)removeCorrespondences:(NSOrderedSet<Correspondence *> *)values;

@end

NS_ASSUME_NONNULL_END
