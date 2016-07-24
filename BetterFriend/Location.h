//
//  Location.h
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/23/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LocationType) {
    LocationTypeActivity,
    LocationTypeFood,
    LocationTypeLocation,
    LocationTypeEvent
};

@interface Location : NSObject
+ (LocationType)locationTypeFromString:(NSString *)typeString;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) LocationType type;
@property (nonatomic, copy) NSString *subdescription;
@end
