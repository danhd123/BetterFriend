//
//  Dislike+CoreDataProperties.h
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Dislike.h"

NS_ASSUME_NONNULL_BEGIN

@interface Dislike (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Location *> *foundAt;
@property (nullable, nonatomic, retain) NSSet<Friend *> *dislikedBy;

@end

@interface Dislike (CoreDataGeneratedAccessors)

- (void)addFoundAtObject:(Location *)value;
- (void)removeFoundAtObject:(Location *)value;
- (void)addFoundAt:(NSSet<Location *> *)values;
- (void)removeFoundAt:(NSSet<Location *> *)values;

- (void)addDislikedByObject:(Friend *)value;
- (void)removeDislikedByObject:(Friend *)value;
- (void)addDislikedBy:(NSSet<Friend *> *)values;
- (void)removeDislikedBy:(NSSet<Friend *> *)values;

@end

NS_ASSUME_NONNULL_END
