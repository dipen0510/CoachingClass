//
//  TestGraphViewController.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 10/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphBaseViewController.h"
#import <Charts/Charts.h>
#import "SingleTestObject.h"

@interface TestGraphViewController : GraphBaseViewController

@property (weak, nonatomic) IBOutlet BarChartView *chartView;
@property (strong, nonatomic) SingleTestObject* testObj;
@property (weak, nonatomic) IBOutlet UITextView *commentsTxtView;
@property (weak, nonatomic) IBOutlet UILabel *navTitleLabel;
@property (strong, nonatomic) NSString* navTitleText;

- (IBAction)backButtonTapped:(id)sender;

@end
