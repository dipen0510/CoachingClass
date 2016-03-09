//
//  ContactUsViewController.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 29/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsViewController : UIViewController <DataSyncManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *revealButtonItem;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIView *studentHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *studentHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *studentHeaderLabel;

@end
