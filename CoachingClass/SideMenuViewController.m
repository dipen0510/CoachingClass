//
//  SideMenuViewController.m
//  CoachingClass
//
//  Created by Dipen Sekhsaria on 22/01/16.
//  Copyright © 2016 Star Deep. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SideMenuTableViewCell.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self generateDataSource];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2.;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) generateDataSource {
    
    tableArr = [[NSMutableArray alloc] init];
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"Performance" forKey:@"title"];
    [dict setObject:@"performance_tab.png" forKey:@"image"];
    [tableArr addObject:dict];
    
    NSMutableDictionary* dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setObject:@"Attendance" forKey:@"title"];
    [dict1 setObject:@"attendance_tab.png" forKey:@"image"];
    [tableArr addObject:dict1];
    
    NSMutableDictionary* dict2 = [[NSMutableDictionary alloc] init];
    [dict2 setObject:@"Comments" forKey:@"title"];
    [dict2 setObject:@"comments_tab.png" forKey:@"image"];
    [tableArr addObject:dict2];
    
    NSMutableDictionary* dict3 = [[NSMutableDictionary alloc] init];
    [dict3 setObject:@"Contact Us" forKey:@"title"];
    [dict3 setObject:@"contact_tab.png" forKey:@"image"];
    [tableArr addObject:dict3];
    
    NSMutableDictionary* dict4 = [[NSMutableDictionary alloc] init];
    [dict4 setObject:@"Freebies" forKey:@"title"];
    [dict4 setObject:@"freebies_tab.png" forKey:@"image"];
    [tableArr addObject:dict4];
    
}


#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tableArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    NSString* identifier = @"SideMenuCell";
    SideMenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"SideMenuTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    cell.tabImageView.image = [UIImage imageNamed:[[tableArr objectAtIndex:indexPath.row] valueForKey:@"image"]];
    cell.tabLabel.text = [[tableArr objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
    
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
