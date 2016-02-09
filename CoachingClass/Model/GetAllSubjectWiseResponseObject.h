//
//  GetAllSubjectWiseResponseObject.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 09/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAllSubjectWiseResponseObject : NSObject

@property (nonatomic, strong) NSMutableArray* listOfAllSubjects;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
