//
//  GetAllSubjectWiseScoreRequestObject.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 09/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "GetAllSubjectWiseScoreRequestObject.h"

@implementation GetAllSubjectWiseScoreRequestObject

@synthesize studentId;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:studentId forKey:StudentIDKey];
    
    return dict;
}

@end
