//
//  GetAllTestWiseRequestObject.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 10/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "GetAllTestWiseRequestObject.h"

@implementation GetAllTestWiseRequestObject

@synthesize studentId;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:studentId forKey:StudentIDKey];
    
    return dict;
}

@end
