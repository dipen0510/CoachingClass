//
//  FreebiesViewController.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 06/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "FreebiesViewController.h"

@interface FreebiesViewController ()

@end

@implementation FreebiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customSetup];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setupHeaderView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void) studentHeaderViewTapped {
    
    [self performSegueWithIdentifier:@"showSelectStudentSegue" sender:nil];
    
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
