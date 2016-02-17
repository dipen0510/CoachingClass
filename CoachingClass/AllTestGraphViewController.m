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

@synthesize allSubjectObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupBarLineChartView:_chartView];
    
    _chartView.delegate = self;
    
    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawValueAboveBarEnabled = YES;
    
    _chartView.maxVisibleValueCount = 60;
    
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
    
    
    
    [self setDataCount:(int)allSubjectObj.listOfAllSubjects.count range:[self findMaxTotalMarks]];
    
    _chartView.clipsToBounds = YES;
    _chartView.backgroundColor = [UIColor colorWithRed:251./255. green:148./255. blue:0 alpha:1.0];
    _chartView.layer.cornerRadius = 10.0;
    
}


- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:[[allSubjectObj.listOfAllSubjects objectAtIndex:i] valueForKey:SubjectNameKey]];
    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        
        SingleSubjectObject* subjectObj = [[SingleSubjectObject alloc] initWithDictionary:[allSubjectObj.listOfAllSubjects objectAtIndex:i]];
        
        NSMutableArray* yTempArr = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < subjectObj.listOfAllTest.count ; j++) {

            double val = [[[subjectObj.listOfAllTest objectAtIndex:j] valueForKey:ObtainedMarksKey] doubleValue];
            [yTempArr addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
            
        }
        
        [yVals addObject:yTempArr];
    }
    
    int counter = 0;
    int maxCounter = [self findMaxNumberOfTests:yVals];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    
    while (counter < maxCounter) {
        
        NSMutableArray* finalArr = [[NSMutableArray alloc] init];
        NSString* str;
        
         for (int i = 0; i < yVals.count; i++) {
             
             NSMutableArray* tmpArr = [[NSMutableArray alloc] init];
             tmpArr = (NSMutableArray *)[yVals objectAtIndex:i];
             
             if (counter < tmpArr.count) {
                 [finalArr addObject:[tmpArr objectAtIndex:counter]];
                 SingleSubjectObject* subjectObj = [[SingleSubjectObject alloc] initWithDictionary:[allSubjectObj.listOfAllSubjects objectAtIndex:i]];
                 str = [[subjectObj.listOfAllTest objectAtIndex:counter] valueForKey:TestTitleKey];
             }
             
         }
        
        
        BarChartDataSet *set = [[BarChartDataSet alloc] initWithYVals:finalArr label:str];
        [dataSets addObject:set];
        
        counter++;
        
    }
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    data.groupSpace = 10;
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
    
    _chartView.data = data;
    
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


- (int) findMaxTotalMarks {
    
    int max = 0;
    
    for (int j = 0; j < allSubjectObj.listOfAllSubjects.count; j++) {
        
       SingleSubjectObject* subjectObj = [[SingleSubjectObject alloc] initWithDictionary:[allSubjectObj.listOfAllSubjects objectAtIndex:j]];
        
        NSMutableArray* arr = [subjectObj.listOfAllTest valueForKey:TotalMarksKey];
        
        
        for (int i = 0; i < arr.count; i++) {
            
            if ([[arr objectAtIndex:i] intValue] > max) {
                max = [[arr objectAtIndex:i] intValue];
            }
            
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
