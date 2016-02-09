//
//  SingleTestObject.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 10/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "SingleTestObject.h"

@implementation SingleTestObject

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _testID = dictionary[TestIDKey];
    _subjectDetailsOfTest = dictionary[SubjectDetailsOfTestKey];
    _testTitle = dictionary[TestTitleKey];
    _totalMarks = dictionary[TotalMarksKey];
    
    return self;
}

@end
