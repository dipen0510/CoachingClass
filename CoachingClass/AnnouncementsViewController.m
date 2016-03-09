//
//  AnnouncementsViewController.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 18/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "AnnouncementsViewController.h"
#import "GetBroadcastDetailsResponseObject.h"

@interface AnnouncementsViewController () {
    
    GetBroadcastDetailsResponseObject* broadcastObj;
    
}

@end

@implementation AnnouncementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customSetup];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSString* attendStr = [[SharedClass sharedInstance] loadDataForService:kGetBroadcastDetails andStudentId:[[SharedClass sharedInstance] selectedStudentId]];
    if (attendStr) {
        NSMutableDictionary* dict = [[SharedClass sharedInstance] getDictionaryFromJSONString:attendStr];
        broadcastObj = [[GetBroadcastDetailsResponseObject alloc] initWithDictionary:dict];
        [self setupUIValues];
    }
    else {
        self.headingLabel.text = @"";
        self.summaryTxtView.text = @"";
        self.teacherLabel.text = @"";
    }
    
    [self setupHeaderView];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self startGetBroadcastDetailsService];
    
}

- (void) setupHeaderView {
    
    NSString* attendStr = [[SharedClass sharedInstance] loadDataForService:kSubmitStudentService andStudentId:[[SharedClass sharedInstance] selectedStudentId]];
    
    NSMutableDictionary* dict = [[SharedClass sharedInstance] getDictionaryFromJSONString:attendStr];
    SubmitStudentDetailsResponseObject* studentObj = [[SubmitStudentDetailsResponseObject alloc] initWithDictionary:dict];
    
    self.studentHeaderImageView.layer.masksToBounds = YES;
    self.studentHeaderImageView.layer.cornerRadius = self.studentHeaderImageView.frame.size.height/2.;
    
    self.studentHeaderImageView.image = [[SharedClass sharedInstance] loadProfileImageForStudentId:[[studentObj.getStudentsInfoDetails objectAtIndex:0] valueForKey:StudentsIdKey]];
    self.studentHeaderLabel.text = [[studentObj.getStudentsInfoDetails objectAtIndex:0] valueForKey:StudentNameKey];
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(studentHeaderViewTapped)];
    [self.studentHeaderView addGestureRecognizer:gesture];
    
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
    
    self.headingLabel.text = broadcastObj.heading;
    self.summaryTxtView.text = broadcastObj.summary;
    self.teacherLabel.text = broadcastObj.teacherName;
    
}

- (void) studentHeaderViewTapped {
    
    [self performSegueWithIdentifier:@"showSelectStudentSegue" sender:nil];
    
}

#pragma mark - API Handling

- (void) startGetBroadcastDetailsService {
    
    [SVProgressHUD showWithStatus:@"Fetching Announcement Details"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kGetBroadcastDetails;
    manager.delegate = self;
    [manager startGETWebServicesWithBaseURL];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(GetBroadcastDetailsResponseObject *)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey isEqualToString:kGetBroadcastDetails]) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"Details Updated Successfully"];
        broadcastObj = responseData;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
