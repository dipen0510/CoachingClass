//
//  SubjectScoresListViewController.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 22/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectScoresListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray* tableArr;
    
}

@property (strong, nonatomic) IBOutlet UITableView *listTblView;

- (IBAction)backButtonTapped:(id)sender;

@end
