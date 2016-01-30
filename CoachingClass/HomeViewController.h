//
//  HomeViewController.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 22/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *revealButtonItem;

- (IBAction)subjectWiseScoresButtonTapped:(id)sender;
- (IBAction)testWiseScoresButtonTapped:(id)sender;
- (IBAction)alltestPerformanceButtonTapped:(id)sender;

@end