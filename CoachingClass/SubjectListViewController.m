//
//  SubjectScoresListViewController.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 22/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "SubjectListViewController.h"
#import "ScoresListTableViewCell.h"
#import "GetAllSubjectWiseResponseObject.h"
#import "GetAllSubjectWiseScoreRequestObject.h"
#import "SubjectGraphViewController.h"

@interface SubjectListViewController () {
    
    GetAllSubjectWiseResponseObject* allSubjectObj;
    
}

@end

@implementation SubjectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    NSString* attendStr = [[SharedClass sharedInstance] loadDataForService:kGetAllSubjectWiseScore andStudentId:[[SharedClass sharedInstance] selectedStudentId]];
    if (attendStr) {
        NSMutableDictionary* dict = [[SharedClass sharedInstance] getDictionaryFromJSONString:attendStr];
        allSubjectObj = [[GetAllSubjectWiseResponseObject alloc] initWithDictionary:dict];
    }
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self startGetAllSubjectWiserService];
    
}


#pragma mark - API Handling

- (void) startGetAllSubjectWiserService {
    
    [SVProgressHUD showWithStatus:@"Fetching All Subject Scores"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kGetAllSubjectWiseScore;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForGetAllSubjectWiseScore]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(GetAllSubjectWiseResponseObject *)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey isEqualToString:kGetAllSubjectWiseScore]) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"Scores Updated Successfully"];
        allSubjectObj = responseData;
        [self.listTblView reloadData];
        
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

- (NSMutableDictionary *) prepareDictionaryForGetAllSubjectWiseScore {
    
    GetAllSubjectWiseScoreRequestObject* obj = [[GetAllSubjectWiseScoreRequestObject alloc] init];
    
    NSString* content = [[SharedClass sharedInstance] loadDataForService:kSubmitStudentService andStudentId:[[SharedClass sharedInstance] selectedStudentId]];
    NSMutableDictionary *dict = [[SharedClass sharedInstance] getDictionaryFromJSONString:content];
    
    obj.studentId = [[[dict valueForKey:GetStudentsInfoDetailsKey] objectAtIndex:0] valueForKey:StudentsIdKey];
    
    return [obj createRequestDictionary];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImage *) getImageForIndex:(long) index {
    
    int imgIndex = index%5;
    
    if (imgIndex == 0) {
        return [UIImage imageNamed:@"performance.png"];
    }
    if (imgIndex == 1) {
        return [UIImage imageNamed:@"attendance.png"];
    }
    if (imgIndex == 2) {
        return [UIImage imageNamed:@"comments.png"];
    }
    if (imgIndex == 3) {
        return [UIImage imageNamed:@"contact.png"];
    }
    
    return [UIImage imageNamed:@"freebies.png"];
    
}


#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return allSubjectObj.listOfAllSubjects.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString* identifier = @"ScoresListTableViewCell";
    ScoresListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"ScoresListTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imgView.image = [self getImageForIndex:indexPath.row];
    cell.title.text = [[allSubjectObj.listOfAllSubjects objectAtIndex:indexPath.row] valueForKey:SubjectNameKey];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"showSubjectGraphSegue" sender:nil];
    
    
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showSubjectGraphSegue"]) {
        
        SubjectGraphViewController* controller = (SubjectGraphViewController *)[segue destinationViewController];
        controller.subjectObj = [[SingleSubjectObject alloc] initWithDictionary:[allSubjectObj.listOfAllSubjects objectAtIndex:selectedIndex]];
        controller.navTitleText = [[allSubjectObj.listOfAllSubjects objectAtIndex:selectedIndex] valueForKey:SubjectNameKey];
        
    }
    
}


@end
