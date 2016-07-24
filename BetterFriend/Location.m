//
//  Location.m
//  BetterFriend
//
//  Created by Daniel DeCovnick on 7/23/16.
//  Copyright © 2016 BetterFriend. All rights reserved.
//

#import "Location.h"

@implementation Location
+ (LocationType)locationTypeFromString:(NSString *)typeString {
    if ([typeString isEqualToString:@"Activity"]) {
        return 0;
    }
    else if ([typeString isEqualToString:@"Location"]) {
        return 2;
    }
    else if ([typeString isEqualToString:@"Food"]) {
        return 1;
    }
    else if ([typeString isEqualToString:@"Event"]) {
        return 3;
    }
    return -1;
}
@end
