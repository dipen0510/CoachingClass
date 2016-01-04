//
//  ViewController.h
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 05/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *studentNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *rollNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTextField;
@property (weak, nonatomic) IBOutlet UITextField *pinCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)submitButtonTapped:(id)sender;
- (IBAction)addMoreStudentButtonTapped:(id)sender;

@end

