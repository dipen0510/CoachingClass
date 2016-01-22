//
//  SubjectScoresListViewController.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 22/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "SubjectScoresListViewController.h"
#import "ScoresListTableViewCell.h"

@interface SubjectScoresListViewController ()

@end

@implementation SubjectScoresListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self generateDataSource];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) generateDataSource {
    
    tableArr = [[NSMutableArray alloc] init];
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"Subject 1" forKey:@"title"];
    [dict setObject:@"performance.png" forKey:@"image"];
    [tableArr addObject:dict];
    
    NSMutableDictionary* dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setObject:@"Subject 2" forKey:@"title"];
    [dict1 setObject:@"attendance.png" forKey:@"image"];
    [tableArr addObject:dict1];
    
    NSMutableDictionary* dict2 = [[NSMutableDictionary alloc] init];
    [dict2 setObject:@"Subject 3" forKey:@"title"];
    [dict2 setObject:@"comments.png" forKey:@"image"];
    [tableArr addObject:dict2];
    
    NSMutableDictionary* dict3 = [[NSMutableDictionary alloc] init];
    [dict3 setObject:@"Subject 4" forKey:@"title"];
    [dict3 setObject:@"contact.png" forKey:@"image"];
    [tableArr addObject:dict3];
    
    NSMutableDictionary* dict4 = [[NSMutableDictionary alloc] init];
    [dict4 setObject:@"Subject 5" forKey:@"title"];
    [dict4 setObject:@"freebies.png" forKey:@"image"];
    [tableArr addObject:dict4];
    
}


#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tableArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString* identifier = @"ScoresListTableViewCell";
    ScoresListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"ScoresListTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imgView.image = [UIImage imageNamed:[[tableArr objectAtIndex:indexPath.row] valueForKey:@"image"]];
    cell.title.text = [[tableArr objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
