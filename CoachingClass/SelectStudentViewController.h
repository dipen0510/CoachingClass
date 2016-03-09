//
//  SelectStudentViewController.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 09/03/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectStudentViewController : UIViewController {
    
    NSMutableArray* tableArr;
    int selectedIndex;
    
}

@property (weak, nonatomic) IBOutlet UITableView *listTblView;

- (IBAction)cancelButtonTapped:(id)sender;
- (IBAction)doneButtonTapped:(id)sender;
@end
