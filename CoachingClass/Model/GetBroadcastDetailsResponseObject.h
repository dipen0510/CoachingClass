//
//  GetBroadcastDetailsResponseObject.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 18/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetBroadcastDetailsResponseObject : NSObject

@property (nonatomic, strong) NSString* broadcastDate;
@property (nonatomic, strong) NSString* fromDate;
@property (nonatomic, strong) NSString* heading;
@property (nonatomic, strong) NSString* summary;
@property (nonatomic, strong) NSString* teacherName;
@property (nonatomic, strong) NSString* toDate;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
