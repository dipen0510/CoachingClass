//
//  DataSyncManager.m
//  HappPost
//
//  Created by Dipen Sekhsaria on 15/11/15.
//  Copyright (c) 2015 Star Deep. All rights reserved.
//

#import "DataSyncManager.h"
#import "SubmitStudentDetailsResponseObject.h"
#import "GetAttendanceResponseObject.h"

@implementation DataSyncManager
@synthesize delegate,serviceKey;


-(void)startGETWebServicesWithBaseURL
{
    
    NSURL* url;
    url = [NSURL URLWithString:BaseWebServiceURL];

    
    NSLog(@"Service URl::%@/%@",url,self.serviceKey);
    //NSError *theError = nil;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    
    [manager GET:self.serviceKey parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject valueForKey:statusKey] isEqualToString:@"Success"]) {
                [delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject] andServiceKey:self.serviceKey];
            }
            else {
                [delegate didFinishServiceWithFailure:[responseObject valueForKey:@"Message"]];
            }
            
            
        }
        else {
            [delegate didFinishServiceWithFailure:@"Unexpected network error"];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [delegate didFinishServiceWithFailure:@"Please check your internet connection and try again later."];
       
    }];
    
}


-(void)startPOSTWebServicesWithParams:(NSMutableDictionary *)postData
{
    
    NSURL* url;
    url = [NSURL URLWithString:BaseWebServiceURL];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 300)];
    //manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager POST:self.serviceKey parameters:postData success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                if ([[responseObject valueForKey:statusKey] isEqualToString:@"Success"]) {
                    [delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject] andServiceKey:self.serviceKey];
                }
                else {
                    [delegate didFinishServiceWithFailure:[responseObject valueForKey:@"Message"]];
                }
                
                
            }
            else {
                [delegate didFinishServiceWithFailure:@"Unexpected network error"];
            }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"");
        [delegate didFinishServiceWithFailure:@"Please check your internet connection and try again later."];
        
    }];
    
}




- (id) prepareResponseObjectForServiceKey:(NSString *) responseServiceKey withData:(id)responseObj {
    
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObj options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if ([responseServiceKey isEqualToString:kSubmitStudentService] ) {
        
        [[SharedClass sharedInstance] saveData:jsonString ForService:responseServiceKey];
        
        SubmitStudentDetailsResponseObject* response = [[SubmitStudentDetailsResponseObject alloc] initWithDictionary:responseObj];
        
        return response;
        
    }
    if ([responseServiceKey isEqualToString:kGetAttendanceService] ) {
        
        [[SharedClass sharedInstance] saveData:jsonString ForService:responseServiceKey];
        
        GetAttendanceResponseObject* response = [[GetAttendanceResponseObject alloc] initWithDictionary:responseObj];
        
        return response;
        
    }
    return nil;
    
}

@end
