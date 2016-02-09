//
//  SingleSubjectWiseTest.m
//  Coaching Class
//
//  Created by Dipen Sekhsaria on 29/11/15.
//  Copyright © 2015 Star Deep. All rights reserved.
//

#import "SingleSubjectObject.h"

@implementation SingleSubjectObject


- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _comments = dictionary[CommentsKey];
    _listOfAllTest = dictionary[ListOfAllTestKey];
    _subjectId = dictionary[SubjectIdKey];
    _subjectName = dictionary[SubjectNameKey];
    
    
    return self;
}


@end
