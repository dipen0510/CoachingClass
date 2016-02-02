//
//  GetAttendanceResponseObject.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 03/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "GetAttendanceResponseObject.h"

@implementation GetAttendanceResponseObject

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _attendedDaysFromLastMonth = dictionary[AttendedDaysFromLastMonthKey];
    _attendedDaysFromLastWeek = dictionary[AttendedDaysFromLastWeekKey];
    _attendedDaysFromStart = dictionary[AttendedDaysFromStartKey];
    _totalDaysFromLastMonth = dictionary[TotalDaysFromLastMonthKey];
    _totalDaysFromLastWeek = dictionary[TotalDaysFromLastWeekKey];
    _totalDaysFromStart = dictionary[TotalDaysFromStartKey];
    
    return self;
}

@end
