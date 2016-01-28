//
//  CommentsTableViewCell.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 29/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *commentsDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentsTxtView;
@end
