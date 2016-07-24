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
@property (nullable, nonatomic, retain) NSString *locationType;
@property (nullable, nonatomic, retain) NSOrderedSet<Correspondence *> *correspondences;
@property (nullable, nonatomic, retain) NSOrderedSet<Like *> *goodFor;
@property (nullable, nonatomic, retain) NSSet<Dislike *> *badFor;

@end

@interface Location (CoreDataGeneratedAccessors)

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

- (void)insertObject:(Like *)value inGoodForAtIndex:(NSUInteger)idx;
- (void)removeObjectFromGoodForAtIndex:(NSUInteger)idx;
- (void)insertGoodFor:(NSArray<Like *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeGoodForAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInGoodForAtIndex:(NSUInteger)idx withObject:(Like *)value;
- (void)replaceGoodForAtIndexes:(NSIndexSet *)indexes withGoodFor:(NSArray<Like *> *)values;
- (void)addGoodForObject:(Like *)value;
- (void)removeGoodForObject:(Like *)value;
- (void)addGoodFor:(NSOrderedSet<Like *> *)values;
- (void)removeGoodFor:(NSOrderedSet<Like *> *)values;

- (void)addBadForObject:(Dislike *)value;
- (void)removeBadForObject:(Dislike *)value;
- (void)addBadFor:(NSSet<Dislike *> *)values;
- (void)removeBadFor:(NSSet<Dislike *> *)values;

@end

NS_ASSUME_NONNULL_END
