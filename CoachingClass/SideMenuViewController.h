//
//  SideMenuViewController.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 22/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    
    NSMutableArray* tableArr;
    
}

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *studentNameLabel;

@end
