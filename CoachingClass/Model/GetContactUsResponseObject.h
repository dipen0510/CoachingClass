//
//  GetContactUsResponseObject.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 07/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetContactUsResponseObject : NSObject

@property (nonatomic, strong) NSString* address;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* info;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, strong) NSString* website;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
