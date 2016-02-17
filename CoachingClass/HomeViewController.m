//
//  HomeViewController.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 22/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "HomeViewController.h"
#import "GetAllSubjectWiseResponseObject.h"
#import "GetAllSubjectWiseScoreRequestObject.h"
#import "AllTestGraphViewController.h"


@interface HomeViewController () {
    
    GetAllSubjectWiseResponseObject* allSubjectObj;
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customSetup];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)subjectWiseScoresButtonTapped:(id)sender {
    
    [self performSegueWithIdentifier:@"showSubjectScoresSegue" sender:nil];
    
}

- (IBAction)testWiseScoresButtonTapped:(id)sender {
    
    [self performSegueWithIdentifier:@"showTestListSegue" sender:nil];
    
}

- (IBAction)alltestPerformanceButtonTapped:(id)sender {
    
    NSString* attendStr = [[SharedClass sharedInstance] loadDataForService:kGetAllSubjectWiseScore];
    if (attendStr) {
        NSMutableDictionary* dict = [[SharedClass sharedInstance] getDictionaryFromJSONString:attendStr];
        allSubjectObj = [[GetAllSubjectWiseResponseObject alloc] initWithDictionary:dict];
        [self performSegueWithIdentifier:@"showAllSubjectGraphSegue" sender:nil];
    }
    else {
        
        [self startGetAllSubjectWiserService];
        
    }
    
}


#pragma mark - API Handling

- (void) startGetAllSubjectWiserService {
    
    [SVProgressHUD showWithStatus:@"Fetching All Subject Scores"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kGetAllSubjectWiseScore;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForGetAllSubjectWiseScore]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(GetAllSubjectWiseResponseObject *)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey isEqualToString:kGetAllSubjectWiseScore]) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"Scores Updated Successfully"];
        allSubjectObj = responseData;
        [self performSegueWithIdentifier:@"showAllSubjectGraphSegue" sender:nil];
        
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

- (NSMutableDictionary *) prepareDictionaryForGetAllSubjectWiseScore {
    
    GetAllSubjectWiseScoreRequestObject* obj = [[GetAllSubjectWiseScoreRequestObject alloc] init];
    
    NSString* content = [[SharedClass sharedInstance] loadDataForService:kSubmitStudentService];
    NSMutableDictionary *dict = [[SharedClass sharedInstance] getDictionaryFromJSONString:content];
    
    obj.studentId = [[[dict valueForKey:GetStudentsInfoDetailsKey] objectAtIndex:0] valueForKey:StudentsIdKey];
    
    return [obj createRequestDictionary];
    
}


#pragma mark state preservation / restoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Save what you need here
    
    [super encodeRestorableStateWithCoder:coder];
}


- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}


- (void)applicationFinishedRestoringState
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Call whatever function you need to visually restore
    [self customSetup];
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     
     if ([[segue identifier] isEqualToString:@"showAllSubjectGraphSegue"]) {
         
         AllTestGraphViewController* controller = (AllTestGraphViewController *)[segue destinationViewController];
         controller.allSubjectObj = allSubjectObj;
         
         
     }
     
     
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

@end
