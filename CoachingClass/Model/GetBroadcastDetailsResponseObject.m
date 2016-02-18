//
//  GetBroadcastDetailsResponseObject.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 18/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "GetBroadcastDetailsResponseObject.h"

@implementation GetBroadcastDetailsResponseObject

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _broadcastDate = dictionary[BroadcastDateKey];
    _fromDate = dictionary[FromDateKey];
    _heading = dictionary[HeadingKey];
    _summary = dictionary[SummaryKey];
    _teacherName = dictionary[TeacherNameKey];
    _toDate = dictionary[ToDateKey];
    
    return self;
}

@end
