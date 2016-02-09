//
//  TestListViewController.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 10/02/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, DataSyncManagerDelegate> {
    
    long selectedIndex;
    
}

@property (strong, nonatomic) IBOutlet UITableView *listTblView;

- (IBAction)backButtonTapped:(id)sender;


@end
