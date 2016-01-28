//
//  CommentsTableViewCell.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 29/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "CommentsTableViewCell.h"

@implementation CommentsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.commentsTxtView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.commentsTxtView.layer.borderWidth  = 1.0;
    self.commentsTxtView.layer.cornerRadius = 10.0;
    self.commentsTxtView.textContainerInset = UIEdgeInsetsMake(20, 0, 20, 0);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
