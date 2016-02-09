//
//  GetAllTestWiseRequestObject.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 10/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAllTestWiseRequestObject : NSObject

@property (nonatomic, strong) NSString* studentId;

- (NSMutableDictionary *)createRequestDictionary;

@end
