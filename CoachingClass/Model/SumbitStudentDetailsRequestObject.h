//
//  SumbitStudentDetailsRequestObject.h
//  HappPost
//
//  Created by Dipen Sekhsaria on 06/12/15.
//  Copyright © 2015 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SumbitStudentDetailsRequestObject : NSObject

@property (nonatomic, strong) NSMutableArray* studentsInfoDetails;

- (NSMutableDictionary *)createRequestDictionary;

@end
