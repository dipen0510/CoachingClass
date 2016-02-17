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
#import "GetAllSubjectWiseResponseObject.h"
#import "SingleSubjectObject.h"

@interface AllTestGraphViewController : GraphBaseViewController {
    
    
    
}

@property (weak, nonatomic) IBOutlet BarChartView *chartView;
@property (weak, nonatomic) IBOutlet UITextView *commentsTxtView;
@property (strong, nonatomic) GetAllSubjectWiseResponseObject* allSubjectObj;

- (IBAction)backButtonTapped:(id)sender;

@end
