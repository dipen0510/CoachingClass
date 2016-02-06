//
//  CommentsViewController.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 29/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentsTableViewCell.h"
#import "GetTeacherCommentResponseObject.h"
#import "GetTeacherCommentsRequestObject.h"

@interface CommentsViewController () {
    
    GetTeacherCommentResponseObject* commentsObj;
    
}

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString* commentStr = [[SharedClass sharedInstance] loadDataForService:kGetTeacherCommentsService];
    if (commentStr) {
        NSMutableDictionary* dict = [[SharedClass sharedInstance] getDictionaryFromJSONString:commentStr];
        commentsObj = [[GetTeacherCommentResponseObject alloc] initWithDictionary:dict];
    }
    else {
        commentsObj = [[GetTeacherCommentResponseObject alloc] init];
    }
    
    [self customSetup];
    
}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self startGetCommentsService];
    
}


- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem addTarget:self.revealViewController action:@selector( revealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        //[self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:revealViewController.tapGestureRecognizer];
        [revealViewController setFrontViewShadowRadius:10.0];
    }
}



#pragma mark - API Handling

- (void) startGetCommentsService {
    
    [SVProgressHUD showWithStatus:@"Fetching Teacher's Comments"];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kGetTeacherCommentsService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForGetCommentsService]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(GetTeacherCommentResponseObject *)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey isEqualToString:kGetTeacherCommentsService]) {
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"Comments Updated Successfully"];
        commentsObj = responseData;
        [self.commentsTableView reloadData];
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

- (NSMutableDictionary *) prepareDictionaryForGetCommentsService {
    
    GetTeacherCommentsRequestObject* obj = [[GetTeacherCommentsRequestObject alloc] init];
    
    NSString* content = [[SharedClass sharedInstance] loadDataForService:kSubmitStudentService];
    NSMutableDictionary *dict = [[SharedClass sharedInstance] getDictionaryFromJSONString:content];
    
    obj.studentId = [[[dict valueForKey:GetStudentsInfoDetailsKey] objectAtIndex:0] valueForKey:StudentsIdKey];
    
    return [obj createRequestDictionary];
    
}


#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return commentsObj.getTeachersCommentsDetails.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString* identifier = @"CommentsCell";
    CommentsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"CommentsTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    cell.commentsDateLabel.text = [[[[commentsObj.getTeachersCommentsDetails objectAtIndex:indexPath.row] valueForKey:CommentTimeKey] componentsSeparatedByString:@" "] firstObject];
    cell.commentsTimeLabel.text = [NSString stringWithFormat:@"%@ %@",[[[[commentsObj.getTeachersCommentsDetails objectAtIndex:indexPath.row] valueForKey:CommentTimeKey] componentsSeparatedByString:@" "] objectAtIndex:1], [[[[commentsObj.getTeachersCommentsDetails objectAtIndex:indexPath.row] valueForKey:CommentTimeKey] componentsSeparatedByString:@" "] lastObject]];
    cell.commentsTxtView.text = [[commentsObj.getTeachersCommentsDetails objectAtIndex:indexPath.row] valueForKey:CommentsKey];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
