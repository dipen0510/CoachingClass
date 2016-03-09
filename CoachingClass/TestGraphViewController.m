//
//  TestGraphViewController.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 10/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "TestGraphViewController.h"
#import "CoachingClass-Swift.h"

@interface TestGraphViewController () <ChartViewDelegate>

@end

@implementation TestGraphViewController

@synthesize testObj,navTitleText;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupBarLineChartView:_chartView];
    
    _chartView.delegate = self;
    
    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawValueAboveBarEnabled = YES;
    
    _chartView.maxVisibleValueCount = 60;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.labelTextColor = [UIColor whiteColor];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.spaceBetweenLabels = 2.0;
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.startAtZeroEnabled = YES;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 8;
    leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];
    leftAxis.valueFormatter.maximumFractionDigits = 1;
    //    leftAxis.valueFormatter.negativeSuffix = @" $";
    //    leftAxis.valueFormatter.positiveSuffix = @" $";
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.labelTextColor = [UIColor whiteColor];
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.enabled = NO;
    //    rightAxis.drawGridLinesEnabled = NO;
    //    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    //    rightAxis.labelCount = 8;
    //    rightAxis.valueFormatter = leftAxis.valueFormatter;
    //    rightAxis.spaceTop = 0.15;
    
    //    _chartView.legend.position = ChartLegendPositionBelowChartLeft;
    //    _chartView.legend.form = ChartLegendFormSquare;
    //    _chartView.legend.formSize = 9.0;
    //    _chartView.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    //    _chartView.legend.xEntrySpace = 4.0;
    _chartView.legend.enabled = NO;
    
    
    
    [self setDataCount:(int)testObj.subjectDetailsOfTest.count range:[testObj.totalMarks intValue]];
    
    _chartView.clipsToBounds = YES;
    _chartView.backgroundColor = [UIColor colorWithRed:251./255. green:148./255. blue:0 alpha:1.0];
    _chartView.layer.cornerRadius = 10.0;
    
    self.navTitleLabel.text = navTitleText;
    
    //self.commentsTxtView.text = subjectObj.comments;
    
}


- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:[[testObj.subjectDetailsOfTest objectAtIndex:i] valueForKey:SubjectNameKey]];
    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double val = [[[testObj.subjectDetailsOfTest objectAtIndex:i] valueForKey:ObtainedMarksKey] doubleValue];
        [yVals addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:@"Marks"];
    set1.barSpace = 0.35;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
    
    _chartView.data = data;
    
    [_chartView zoom:(count/10.0) scaleY:1.0 x:0 y:0];
    
    [_chartView animateWithYAxisDuration:1.4 easingOption:ChartEasingOptionEaseInOutQuart];
}


#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
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


- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
