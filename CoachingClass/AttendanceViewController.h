//
//  AttendanceViewController.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 29/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendanceViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *revealButtonItem;

@property (weak, nonatomic) IBOutlet UILabel *lastOneWeekDaysAttendedLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastOneMonthDaysAttendedLabel;
@property (weak, nonatomic) IBOutlet UILabel *FromStartDaysAttendedLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastOneWeekTotalDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastOneMonthTotalDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *FromStartTotalDaysLabel;

@end