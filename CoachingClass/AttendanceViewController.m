//
//  AttendanceViewController.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 29/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "AttendanceViewController.h"
#import "GetAttendanceRequestObject.h"
#import "GetAttendanceResponseObject.h"

@interface AttendanceViewController () {
    
    GetAttendanceResponseObject* attendanceObj;
    
}

@end

@implementation AttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customSetup];
    
    NSString* attendStr = [[SharedClass sharedInstance] loadDataForService:kGetAttendanceService];
    if (attendStr) {
        NSMutableDictionary* dict = [[SharedClass sharedInstance] getDictionaryFromJSONString:attendStr];
        attendanceObj = [[GetAttendanceResponseObject alloc] initWithDictionary:dict];
        [self setupUIValues];
    }
    else {
        self.lastOneMonthDaysAttendedLabel.text = [NSString stringWithFormat:@"%d",0];
        self.lastOneMonthTotalDaysLabel.text = [NSString stringWithFormat:@"%d",0];
        
        self.lastOneWeekDaysAttendedLabel.text = [NSString stringWithFormat:@"%d",0];
        self.lastOneWeekTotalDaysLabel.text = [NSString stringWithFormat:@"%d",0];
        
        self.FromStartDaysAttendedLabel.text = [NSString stringWithFormat:@"%d",0];
        self.FromStartTotalDaysLabel.text = [NSString stringWithFormat:@"%d",0];
    }
    
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
 
    [self startGetAttendanceService];
    
}


- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem addTarget:self.revealViewController action:@selector( revealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        //[self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:revealViewController.tapGestureRecognizer];
        [revealViewController setFrontViewShadowRadius:10.0];
    }
}

- (void) setupUIValues {
    
    self.lastOneMonthDaysAttendedLabel.text = [NSString stringWithFormat:@"%d",[attendanceObj.attendedDaysFromLastMonth intValue]];
    self.lastOneMonthTotalDaysLabel.text = [NSString stringWithFormat:@"%d",[attendanceObj.totalDaysFromLastMonth intValue]];
    
    self.lastOneWeekDaysAttendedLabel.text = [NSString stringWithFormat:@"%d",[attendanceObj.attendedDaysFromLastWeek intValue]];
    self.lastOneWeekTotalDaysLabel.text = [NSString stringWithFormat:@"%d",[attendanceObj.totalDaysFromLastWeek intValue]];
    
    self.FromStartDaysAttendedLabel.text = [NSString stringWithFormat:@"%d",[attendanceObj.attendedDaysFromStart intValue]];
    self.FromStartTotalDaysLabel.text = [NSString stringWithFormat:@"%d",[attendanceObj.totalDaysFromStart intValue]];
    
}


#pragma mark - API Handling

- (void) startGetAttendanceService {
    
    [SVProgressHUD showWithStatus:@"Fetching Attendance Records"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kGetAttendanceService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForGetAttendanceService]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(GetAttendanceResponseObject *)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey isEqualToString:kGetAttendanceService]) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"Records Updated Successfully"];
        attendanceObj = responseData;
        [self setupUIValues];
        
    }
    
    
}


-(void) didFinishServiceWithFailure:(NSString *)errorMsg {
    
    [SVProgressHUD dismiss];
    
    if (![errorMsg isEqualToString:@""]) {
        [self showMessage:errorMsg withTitle:@"Newtwork Error"];
    }
    else {
        [self showMessage:@"Request timed out, please try again later." withTitle:@"Newtwork Error"];
    }
    
    return;
    
}



#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForGetAttendanceService {
    
    GetAttendanceRequestObject* obj = [[GetAttendanceRequestObject alloc] init];
    
    NSString* content = [[SharedClass sharedInstance] loadDataForService:kSubmitStudentService];
    NSMutableDictionary *dict = [[SharedClass sharedInstance] getDictionaryFromJSONString:content];
    
    obj.studentId = [[[dict valueForKey:GetStudentsInfoDetailsKey] objectAtIndex:0] valueForKey:StudentsIdKey];
    
    return [obj createRequestDictionary];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Show Alert

-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //do something when click button
    }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
