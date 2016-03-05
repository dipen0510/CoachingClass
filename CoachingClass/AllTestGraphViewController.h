//
//  AllTestGraphViewController.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 17/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphBaseViewController.h"
#import <Charts/Charts.h>
#import "GetAllTestWiseResponseObject.h"
#import "SingleTestObject.h"

@interface AllTestGraphViewController : GraphBaseViewController {
    
    
    
}


@property (weak, nonatomic) IBOutlet LineChartView *chartView;
@property (weak, nonatomic) IBOutlet UITextView *commentsTxtView;
@property (strong, nonatomic) GetAllTestWiseResponseObject* allTestObj;

- (IBAction)backButtonTapped:(id)sender;

@end
