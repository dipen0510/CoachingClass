//
//  SelectStudentViewController.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 09/03/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "SelectStudentViewController.h"
#import "SubmitStudentDetailsResponseObject.h"

@interface SelectStudentViewController ()

@end

@implementation SelectStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tableArr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:studentIdArrKey]];
    
    for (int i = 0; i<tableArr.count; i++) {
        
        NSString* attendStr = [[SharedClass sharedInstance] loadDataForService:kSubmitStudentService andStudentId:[tableArr objectAtIndex:i]];
        
        NSMutableDictionary* dict = [[SharedClass sharedInstance] getDictionaryFromJSONString:attendStr];
        SubmitStudentDetailsResponseObject* studentObj = [[SubmitStudentDetailsResponseObject alloc] initWithDictionary:dict];
        
        if ([[[SharedClass sharedInstance] selectedStudentId] intValue] == [[[studentObj.getStudentsInfoDetails objectAtIndex:0] valueForKey:StudentsIdKey] intValue]) {
            selectedIndex = i;
            break;
        }
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tableArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString* identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    
    
    NSString* attendStr = [[SharedClass sharedInstance] loadDataForService:kSubmitStudentService andStudentId:[tableArr objectAtIndex:indexPath.row]];
    
    NSMutableDictionary* dict = [[SharedClass sharedInstance] getDictionaryFromJSONString:attendStr];
    SubmitStudentDetailsResponseObject* studentObj = [[SubmitStudentDetailsResponseObject alloc] initWithDictionary:dict];
    
    cell.textLabel.text = [[studentObj.getStudentsInfoDetails objectAtIndex:0] valueForKey:StudentNameKey];
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.0]];
    
    if (indexPath.row == selectedIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
    
    
}


#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    selectedIndex = (int)indexPath.row;
    
    [tableView reloadData];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneButtonTapped:(id)sender {
    
    [[SharedClass sharedInstance] setSelectedStudentId:[tableArr objectAtIndex:selectedIndex]];
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
