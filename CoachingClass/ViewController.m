//
//  ViewController.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 05/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUIForInitialView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) addGradientToBGView {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:69./255. green:194./255. blue:172./255. alpha:1.0] CGColor], (id)[[UIColor colorWithRed:211./255. green:248./255. blue:205./255. alpha:1.0] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}

- (void) setupUIForInitialView {
    
    [self addGradientToBGView];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.studentNameTextField.frame.size.height - 2, self.studentNameTextField.frame.size.width, 2.0f);
    bottomBorder.backgroundColor = [[UIColor colorWithWhite:1. alpha:0.4] CGColor];
    
    CALayer *bottomBorder1 = [CALayer layer];
    bottomBorder1.frame = CGRectMake(0.0f, self.rollNumberTextField.frame.size.height - 2, self.rollNumberTextField.frame.size.width, 2.0f);
    bottomBorder1.backgroundColor = [[UIColor colorWithWhite:1. alpha:0.4] CGColor];
    
    CALayer *bottomBorder2 = [CALayer layer];
    bottomBorder2.frame = CGRectMake(0.0f, self.dateOfBirthTextField.frame.size.height - 2, self.dateOfBirthTextField.frame.size.width, 2.0f);
    bottomBorder2.backgroundColor = [[UIColor colorWithWhite:1. alpha:0.4] CGColor];
    
    CALayer *bottomBorder3 = [CALayer layer];
    bottomBorder3.frame = CGRectMake(0.0f, self.pinCodeTextField.frame.size.height - 2, self.pinCodeTextField.frame.size.width, 2.0f);
    bottomBorder3.backgroundColor = [[UIColor colorWithWhite:1. alpha:0.4] CGColor];
    
    [self.studentNameTextField.layer addSublayer:bottomBorder];
    [self.rollNumberTextField.layer addSublayer:bottomBorder1];
    [self.dateOfBirthTextField.layer addSublayer:bottomBorder2];
    [self.pinCodeTextField.layer addSublayer:bottomBorder3];
    
    self.submitButton.layer.borderColor = [self.studentNameTextField.textColor CGColor];
    self.submitButton.layer.borderWidth = 1.0;
    self.submitButton.layer.cornerRadius = self.submitButton.frame.size.height/2.;
    
}


- (IBAction)submitButtonTapped:(id)sender {
}

- (IBAction)addMoreStudentButtonTapped:(id)sender {
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

@end
