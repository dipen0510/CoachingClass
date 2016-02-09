//
//  GetAllSubjectWiseResponseObject.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 09/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "GetAllSubjectWiseResponseObject.h"

@implementation GetAllSubjectWiseResponseObject

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _listOfAllSubjects = dictionary[ListOfAllSubjectsKey];
    
    return self;
}

@end
