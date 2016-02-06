//
//  GetTeacherCommentsRequestObject.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 06/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTeacherCommentsRequestObject : NSObject

@property (nonatomic, strong) NSString* studentId;

- (NSMutableDictionary *)createRequestDictionary;

@end
