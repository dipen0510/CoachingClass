//
//  SubmitStudentDetailsResponseObject.m
//  HappPost
//
//  Created by Dipen Sekhsaria on 29/11/15.
//  Copyright © 2015 Star Deep. All rights reserved.
//

#import "SubmitStudentDetailsResponseObject.h"

@implementation SubmitStudentDetailsResponseObject

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _getStudentsInfoDetails = dictionary[GetStudentsInfoDetailsKey];
    
    return self;
}

@end
