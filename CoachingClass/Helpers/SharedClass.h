//
//  SharedClass.h
//  PampersRewards
//
//  Created by Dipen Sekhsaria on 03/11/15.
//  Copyright © 2015 ProcterAndGamble. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedClass : NSObject

+ sharedInstance;

@property (strong, nonatomic) NSString* username;

- (void)saveData: (NSString*)data ForService:(NSString *)service;
- (NSString*)loadDataForService:(NSString *)service;
- (void)removeServiceData:(NSString *)service;

- (void) saveProfileImage:(UIImage *)image forStudentId:(NSString *)studentId;
- (UIImage *) loadProfileImageForStudentId:(NSString *)studentId;

- (NSMutableDictionary *) getDictionaryFromJSONString:(NSString *)jsonString;

@end
