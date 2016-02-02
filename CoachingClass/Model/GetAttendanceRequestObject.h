//
//  GetAttendanceRequestObject.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 03/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAttendanceRequestObject : NSObject

@property (nonatomic, strong) NSString* studentId;

- (NSMutableDictionary *)createRequestDictionary;

@end
