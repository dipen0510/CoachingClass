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
#import "SingleSubjectObject.h"

@interface SubjectGraphViewController : GraphBaseViewController {
    
    
    
}

@property (weak, nonatomic) IBOutlet BarChartView *chartView;
@property (strong, nonatomic) SingleSubjectObject* subjectObj;
@property (weak, nonatomic) IBOutlet UITextView *commentsTxtView;

- (IBAction)backButtonTapped:(id)sender;

@end
