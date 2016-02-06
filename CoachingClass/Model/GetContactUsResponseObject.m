//
//  GetContactUsResponseObject.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 07/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "GetContactUsResponseObject.h"

@implementation GetContactUsResponseObject

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _address = dictionary[AddressKey];
    _email = dictionary[EmailKey];
    _info = dictionary[InfoKey];
    _phone = dictionary[PhoneKey];
    _website = dictionary[WebsiteKey];
    
    return self;
}

@end
