//
//  GetTeacherCommentResponseObject.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 06/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTeacherCommentResponseObject : NSObject

@property (nonatomic, strong) NSMutableArray* getTeachersCommentsDetails;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
