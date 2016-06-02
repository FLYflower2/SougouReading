//
//  YTSearchController.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/2.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTSearchController.h"

@interface YTSearchController ()

- (IBAction)cancelBtnClick:(id)sender;

@end

@implementation YTSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;

    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topline"] forBarMetrics:UIBarMetricsDefault];
//    NSDictionary *titleAttr = @{
//                                NSForegroundColorAttributeName:[UIColor whiteColor],
//                                NSFontAttributeName:[UIFont systemFontOfSize:18]
//                                };
//    [self.navigationController.navigationBar setTitleTextAttributes:titleAttr];
}



- (IBAction)cancelBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
