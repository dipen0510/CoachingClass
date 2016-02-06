//
//  GetTeacherCommentResponseObject.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 06/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "GetTeacherCommentResponseObject.h"

@implementation GetTeacherCommentResponseObject

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _getTeachersCommentsDetails = dictionary[GetTeachersCommentsDetailsKey];
    
    return self;
}

@end
