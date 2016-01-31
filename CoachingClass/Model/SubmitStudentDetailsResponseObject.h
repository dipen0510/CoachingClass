//
//  SubmitStudentDetailsResponseObject.h
//  HappPost
//
//  Created by Dipen Sekhsaria on 29/11/15.
//  Copyright © 2015 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubmitStudentDetailsResponseObject : NSObject

@property (nonatomic, strong) NSMutableArray* getStudentsInfoDetails;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
