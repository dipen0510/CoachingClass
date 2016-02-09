//
//  GetAllSubjectWiseScoreRequestObject.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 09/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAllSubjectWiseScoreRequestObject : NSObject

@property (nonatomic, strong) NSString* studentId;

- (NSMutableDictionary *)createRequestDictionary;

@end
