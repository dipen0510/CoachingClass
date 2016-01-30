//
//  SubjectGraphViewController.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 30/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphBaseViewController.h"
#import <Charts/Charts.h>

@interface SubjectGraphViewController : GraphBaseViewController

@property (weak, nonatomic) IBOutlet BarChartView *chartView;
- (IBAction)backButtonTapped:(id)sender;

@end
