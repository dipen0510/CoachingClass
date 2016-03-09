//
//  CommentsViewController.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 29/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CommentsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, DataSyncManagerDelegate> {
    
}

@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;
@property (weak, nonatomic) IBOutlet UIButton *revealButtonItem;

@property (weak, nonatomic) IBOutlet UIView *studentHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *studentHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *studentHeaderLabel;

@end
