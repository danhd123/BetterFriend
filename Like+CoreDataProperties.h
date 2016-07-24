//
//  Like+CoreDataProperties.h
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/24/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Like.h"

NS_ASSUME_NONNULL_BEGIN

@interface Like (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Location *> *foundAt;
@property (nullable, nonatomic, retain) NSSet<Friend *> *likedBy;

@end

@interface Like (CoreDataGeneratedAccessors)

- (void)addFoundAtObject:(Location *)value;
- (void)removeFoundAtObject:(Location *)value;
- (void)addFoundAt:(NSSet<Location *> *)values;
- (void)removeFoundAt:(NSSet<Location *> *)values;

- (void)addLikedByObject:(Friend *)value;
- (void)removeLikedByObject:(Friend *)value;
- (void)addLikedBy:(NSSet<Friend *> *)values;
- (void)removeLikedBy:(NSSet<Friend *> *)values;

@end

NS_ASSUME_NONNULL_END
