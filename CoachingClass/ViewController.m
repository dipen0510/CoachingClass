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
    
    studentArr = [[NSMutableArray alloc] init];
    
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


#pragma mark - API Handling

- (void) startSubmitStudentService {
    
    [SVProgressHUD showWithStatus:@"Validating student info"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kSubmitStudentService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForSubmitStudentService]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(SubmitStudentDetailsResponseObject *)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey isEqualToString:kSubmitStudentService]) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"Student Info Validated Successfully"];
        [self performSegueWithIdentifier:@"showHomeSegue" sender:nil];
        
        
    }
    
    
}


-(void) didFinishServiceWithFailure:(NSString *)errorMsg {
    
    [SVProgressHUD dismiss];
    
    if (![errorMsg isEqualToString:@""]) {
        [self showMessage:errorMsg withTitle:@"Newtwork Error"];
    }
    else {
        [self showMessage:@"Request timed out, please try again later." withTitle:@"Newtwork Error"];
    }
    
    return;
    
}



#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForSubmitStudentService {
    
    SumbitStudentDetailsRequestObject* obj = [[SumbitStudentDetailsRequestObject alloc] init];
    obj.studentsInfoDetails = studentArr;
    
    return [obj createRequestDictionary];
    
}

- (NSMutableDictionary *) prepareStudentObjectFromCurrent {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:self.studentNameTextField.text forKey:StudentNameKey];
    [dict setObject:self.rollNumberTextField.text forKey:RollNoKey];
    [dict setObject:self.pinCodeTextField.text forKey:PinCodeKey];
    [dict setObject:self.dateOfBirthTextField.text forKey:DOBKey];
    
    return dict;
    
}


#pragma mark - User Action


- (BOOL) isFormValid {
    
    NSString* name = self.studentNameTextField.text;
    NSString* rollno = self.rollNumberTextField.text;
    NSString* dob = self.dateOfBirthTextField.text;
    NSString* pincode = self.pinCodeTextField.text;
    
    if (!name || [name isEqualToString:@""]) {
        return false;
    }
    if (!rollno || [rollno isEqualToString:@""]) {
        return false;
    }
    if (!dob || [dob isEqualToString:@""]) {
        return false;
    }
    if (!pincode || [pincode isEqualToString:@""]) {
        return false;
    }
    
    
//    
//    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@."];
//    s = [s invertedSet];
//    NSRange r = [user rangeOfCharacterFromSet:s];
//    if (r.location != NSNotFound) {
//        return false;
//    }
    
    
    
    return true;
    
}


- (IBAction)submitButtonTapped:(id)sender {
    
    if ([self isFormValid]) {
        
        [studentArr addObject:[self prepareStudentObjectFromCurrent]];
        [self startSubmitStudentService];
        
    }
    else {
        
        [self showMessage:@"Please check all input fields and try again." withTitle:@"Invalid Form"];
        
    }
    
}

- (IBAction)addMoreStudentButtonTapped:(id)sender {
    
    if ([self isFormValid]) {
        
        [studentArr addObject:[self prepareStudentObjectFromCurrent]];
        [self clearFormData];
        
    }
    else {
        
        [self showMessage:@"Please check all input fields and try again." withTitle:@"Invalid Form"];
        
    }
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

- (void) clearFormData {
    
    self.studentNameTextField.text = @"";
    self.dateOfBirthTextField.text = @"";
    self.pinCodeTextField.text = @"";
    self.rollNumberTextField.text = @"";
    
    [self.view endEditing:YES];
    
}



#pragma mark - Show Alert

-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //do something when click button
    }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}


@end
