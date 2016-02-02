//
//  GetAttendanceResponseObject.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 03/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAttendanceResponseObject : NSObject

@property (nonatomic, strong) NSString* attendedDaysFromLastMonth;
@property (nonatomic, strong) NSString* attendedDaysFromLastWeek;
@property (nonatomic, strong) NSString* attendedDaysFromStart;
@property (nonatomic, strong) NSString* totalDaysFromLastMonth;
@property (nonatomic, strong) NSString* totalDaysFromLastWeek;
@property (nonatomic, strong) NSString* totalDaysFromStart;


- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
