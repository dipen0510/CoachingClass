//
//  SharedClass.m
//  PampersRewards
//
//  Created by Dipen Sekhsaria on 03/11/15.
//  Copyright © 2015 ProcterAndGamble. All rights reserved.
//

#import "SharedClass.h"

@implementation SharedClass

@synthesize selectedStudentId,selectedStudentName;


static SharedClass *singletonObject = nil;

+ (id) sharedInstance
{
    if (! singletonObject) {
        
        singletonObject = [[SharedClass alloc] init];
    }
    return singletonObject;
}

- (id)init
{
    if (! singletonObject) {
        
        singletonObject = [super init];
        // Uncomment the following line to see how many times is the init method of the class is called
        // NSLog(@"%s", __PRETTY_FUNCTION__);
    }
    return singletonObject;
}

-(NSDateFormatter* )getUTCDateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return dateFormatter;
}

-(NSDate* )getCurrentUTCFormatDate
{
    
    NSDate* localDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    
    NSDate* utcDate = [dateFormatter dateFromString:dateString];
    
    return utcDate;
}


#pragma mark - Local Storage Handling

- (void)saveData: (NSString*)data ForService:(NSString *)service andStudentId:(NSString *)studentId
{
    if (data != nil)
    {
        
        [self removeServiceData:service forStudentId:studentId];
        
        NSString *documentsDirectory = [self getDocumentDirectoryPath];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"%@_%@.txt",service,studentId] ];
        
        [data writeToFile:path atomically:YES
                       encoding:NSUTF8StringEncoding error:nil];
    }
}

- (NSString*)loadDataForService:(NSString *)service andStudentId:(NSString *)studentId
{
    NSString *documentsDirectory = [self getDocumentDirectoryPath];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                     [NSString stringWithFormat:@"%@_%@.txt",service,studentId] ];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    return content;
}

- (void)removeServiceData:(NSString *)service forStudentId:(NSString *)studentId
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [self getDocumentDirectoryPath];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"%@_%@.txt",service,studentId] ];
    
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:path error:&error];
    if (success) {
       NSLog(@"Successfully Removed %@",[error localizedDescription]);
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}


- (NSString *) getDocumentDirectoryPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
    
}

#pragma mark - Profile Image local storage

- (void) saveProfileImage:(UIImage *)image forStudentId:(NSString *)studentId {
    
    if (image != nil)
    {
        NSString *documentsDirectory = [self getDocumentDirectoryPath];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"%@.png",studentId]];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
        
    }
    
}

- (UIImage *) loadProfileImageForStudentId:(NSString *)studentId {
    
    NSString *documentsDirectory = [self getDocumentDirectoryPath];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"%@.png",studentId]];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    
    if (image) {
        return image;
    }
    
    return [UIImage imageNamed:@"Person.png"];
    
    
}

#pragma mark - Data Manipulator

- (NSMutableDictionary *) getDictionaryFromJSONString:(NSString *)jsonString {
    
    NSError* e;
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
    
    return dict;
    
}



@end
