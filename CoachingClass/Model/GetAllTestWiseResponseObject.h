//
//  GetAllTestWiseResponseObject.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 10/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAllTestWiseResponseObject : NSObject

@property (nonatomic, strong) NSMutableArray* allTestData;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
