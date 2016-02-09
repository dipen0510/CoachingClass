//
//  GetAllTestWiseResponseObject.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 10/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "GetAllTestWiseResponseObject.h"

@implementation GetAllTestWiseResponseObject

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _allTestData = dictionary[AllTestDataKey];
    
    return self;
}

@end
