//
//  GetAttendanceRequestObject.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 03/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "GetAttendanceRequestObject.h"

@implementation GetAttendanceRequestObject

@synthesize studentId;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:studentId forKey:StudentIDKey];
    
    return dict;
}

@end
