//
//  GetTeacherCommentsRequestObject.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 06/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "GetTeacherCommentsRequestObject.h"

@implementation GetTeacherCommentsRequestObject

@synthesize studentId;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:studentId forKey:StudentIDKey];
    
    return dict;
}

@end
