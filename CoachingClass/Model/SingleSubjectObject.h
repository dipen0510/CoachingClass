//
//  SingleSubjectWiseTest.h
//  Coaching Class
//
//  Created by Dipen Sekhsaria on 29/11/15.
//  Copyright © 2015 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleSubjectObject : NSObject

@property (nonatomic, strong) NSString* comments;
@property (nonatomic, strong) NSMutableArray* listOfAllTest;
@property (nonatomic, strong) NSString* subjectId;
@property (nonatomic, strong) NSString* subjectName;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
