//
//  YTLeftslideViewController.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/10.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTLeftslideViewController.h"
#import "YTLeftslideCell.h"
#import "YTLeftslideSectionHeaderView.h"
#import "YTLeftslideSectionFooterView.h"
@interface YTLeftslideViewController ()

@end

@implementation YTLeftslideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.bounces = NO;
    [self setupBackgroundImage];
    
}

- (void)setupBackgroundImage{
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personalCenterBg"]];
    [self.tableView setBackgroundView:imageView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows

    return 6;
}

#pragma mark -header样式
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    // create the parent view that will hold header Label
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , YTScreenWidth, 150)];

    [YTLeftslideSectionHeaderView addHeaderToView:customView];
    
    return customView;
}
#pragma mark -footer样式
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , YTScreenWidth, 115)];
    [YTLeftslideSectionFooterView addFooterToView:customView];
    
    return customView;
}
#pragma mark - header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 150;
}

#pragma mark - footr高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 115;
}
#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"reuseCell";
    YTLeftslideCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell==nil) {
        cell = [[YTLeftslideCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"充值";
            cell.detailTextLabel.text = @"新用户充值多少返多少";
            cell.imageView.image = [UIImage imageNamed:@"personalCenter_pay"];
            break;
            
        case 1:
            cell.textLabel.text = @"每日签到";
            cell.detailTextLabel.text = @"连续30天中大奖";
            cell.imageView.image = [UIImage imageNamed:@"personalCenter_sign"];
            break;
            
        case 2:
            cell.textLabel.text = @"云书架";
            cell.detailTextLabel.text = @"设备自动同步,好书连连看";
            cell.imageView.image = [UIImage imageNamed:@"personalCenter_cloudshelf"];
            break;
            
        case 3:
            cell.textLabel.text = @"听书专区";
            cell.detailTextLabel.text = @"即将上线敬请期待";
            cell.imageView.image = [UIImage imageNamed:@"personalCenter_listen"];
            break;
            
        case 4:
            cell.textLabel.text = @"充值记录";
            cell.imageView.image = [UIImage imageNamed:@"personalCenter_payList"];
            break;
            
        case 5:
            cell.textLabel.text = @"购买记录";
            cell.imageView.image = [UIImage imageNamed:@"personalCenter_buyList"];
            break;
            
        default:
            break;
    }
    
    return cell;
}

@end
