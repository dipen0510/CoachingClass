//
//  SingleTestObject.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 10/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleTestObject : NSObject

@property (nonatomic, strong) NSString* testID;
@property (nonatomic, strong) NSMutableArray* subjectDetailsOfTest;
@property (nonatomic, strong) NSString* testTitle;
@property (nonatomic, strong) NSString* totalMarks;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
