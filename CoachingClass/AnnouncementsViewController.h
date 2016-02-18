//
//  AnnouncementsViewController.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 18/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnouncementsViewController : UIViewController<DataSyncManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *revealButtonItem;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UITextView *summaryTxtView;
@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;

@end
