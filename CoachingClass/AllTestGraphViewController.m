//
//  AllTestGraphViewController.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 17/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "AllTestGraphViewController.h"

@interface AllTestGraphViewController () <ChartViewDelegate>

@end

@implementation AllTestGraphViewController

@synthesize allTestObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupBarLineChartView:_chartView];
    
    _chartView.delegate = self;
    
    
    BalloonMarker *marker = [[BalloonMarker alloc] initWithColor:[UIColor colorWithWhite:180/255. alpha:1.0] font:[UIFont systemFontOfSize:12.0] insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
    marker.minimumSize = CGSizeMake(80.f, 40.f);
    _chartView.marker = marker;
    
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
    
    
    
    [self setDataCount:(int)allTestObj.allTestData.count range:[self findMaxTotalMarks]];
    
    _chartView.clipsToBounds = YES;
    _chartView.backgroundColor = [UIColor colorWithRed:251./255. green:148./255. blue:0 alpha:1.0];
    _chartView.layer.cornerRadius = 10.0;
    
}


- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:[[allTestObj.allTestData objectAtIndex:i] valueForKey:TestTitleKey]];
    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        
        SingleTestObject* testObj = [[SingleTestObject alloc] initWithDictionary:[allTestObj.allTestData objectAtIndex:i]];
        
        double total = 0.0;
        
        for (int j = 0; j < testObj.subjectDetailsOfTest.count ; j++) {
            
            double val = [[[testObj.subjectDetailsOfTest objectAtIndex:j] valueForKey:ObtainedMarksKey] doubleValue];
            total = total + val;
            
        }
        
        double totalPercent = (total * 100) / ([testObj.totalMarks floatValue] * testObj.subjectDetailsOfTest.count);
        
        [yVals addObject:[[ChartDataEntry alloc] initWithValue:totalPercent xIndex:i]];
    }
    
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithYVals:yVals label:@"DataSet 1"];
    
    //set1.lineDashLengths = @[@5.f, @2.5f];
    //set1.highlightLineDashLengths = @[@5.f, @2.5f];
    [set1 setColor:UIColor.blackColor];
    [set1 setCircleColor:UIColor.blackColor];
    set1.lineWidth = 1.0;
    set1.circleRadius = 3.0;
    set1.drawCircleHoleEnabled = NO;
    set1.valueFont = [UIFont systemFontOfSize:9.f];
    
    NSArray *gradientColors = @[
                                (id)[UIColor colorWithWhite:1.0 alpha:0.7].CGColor,
                                (id)[UIColor colorWithWhite:1.0 alpha:0.1].CGColor
                                ];
    CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
    
    set1.fillAlpha = 1.f;
    set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
    set1.drawFilledEnabled = YES;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];
    
    _chartView.data = data;
    
    [_chartView zoom:(count/10.0) scaleY:1.0 x:0 y:0];
    
    [_chartView animateWithXAxisDuration:2.5 easingOption:ChartEasingOptionEaseInOutQuart];
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


- (int) findMaxTotalMarks {
    
    int max = 0;
    
    for (int j = 0; j < allTestObj.allTestData.count; j++) {
        
        SingleTestObject* testObj = [[SingleTestObject alloc] initWithDictionary:[allTestObj.allTestData objectAtIndex:j]];
        
        if ([testObj.totalMarks intValue] > max) {
                max = [testObj.totalMarks intValue];
        }
        
    }
    
    return max;
    
}


- (int) findMaxNumberOfTests:(NSMutableArray *) arr {
    
    int max = 0;
    
    for (int i = 0; i<arr.count; i++) {
        
        NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
        tmpArr = [arr objectAtIndex:i];
        
        if (max < tmpArr.count) {
            max = (int)tmpArr.count;
        }
        
        
    }
    
    return max;
    
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
