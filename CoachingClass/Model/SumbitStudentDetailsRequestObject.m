//
//  SumbitStudentDetailsRequestObject.m
//  HappPost
//
//  Created by Dipen Sekhsaria on 06/12/15.
//  Copyright © 2015 Star Deep. All rights reserved.
//

#import "SumbitStudentDetailsRequestObject.h"

@implementation SumbitStudentDetailsRequestObject

@synthesize studentsInfoDetails;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:studentsInfoDetails forKey:StudentsInfoDetailsKey];
    
    return dict;
}

@end
