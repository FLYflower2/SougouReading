//
//  YTDiscoverViewController.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/2.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTDiscoverViewController.h"

@interface YTDiscoverViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *discoverWebView;

@end

@implementation YTDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.discoverWebView.scrollView.bounces = NO;
    
    //加载网络地址
  //  self.discoverWebView.delegate = self;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://k.sogou.com/abs/ios/v3/find"]];
    [self.discoverWebView loadRequest:request];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
