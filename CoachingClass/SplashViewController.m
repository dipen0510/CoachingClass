//
//  SplashViewController.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 03/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if ([[SharedClass sharedInstance] loadDataForService:kSubmitStudentService]) {
        [self performSegueWithIdentifier:@"showHomeSegue" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"showLoginSegue" sender:nil];
    }
    
    
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
