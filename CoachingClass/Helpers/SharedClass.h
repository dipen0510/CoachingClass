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

@property (strong, nonatomic) NSString* selectedStudentName;
@property (strong, nonatomic) NSString* selectedStudentId;

- (void)saveData: (NSString*)data ForService:(NSString *)service andStudentId:(NSString *)studentId;
- (NSString*)loadDataForService:(NSString *)service andStudentId:(NSString *)studentId;
- (void)removeServiceData:(NSString *)service forStudentId:(NSString *)studentId;

- (void) saveProfileImage:(UIImage *)image forStudentId:(NSString *)studentId;
- (UIImage *) loadProfileImageForStudentId:(NSString *)studentId;

- (NSMutableDictionary *) getDictionaryFromJSONString:(NSString *)jsonString;

@end
