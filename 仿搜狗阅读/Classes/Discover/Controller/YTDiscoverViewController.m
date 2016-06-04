//
//  YTDiscoverViewController.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/2.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTDiscoverViewController.h"

#import "YTSearchViewController.h"
@interface YTDiscoverViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *discoverWebView;

- (IBAction)searchBtnClick:(id)sender;

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






- (IBAction)searchBtnClick:(id)sender {
    [YTNavAnimation NavPushAnimation:self.navigationController.view];
    YTSearchViewController *searchVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"searchVC"];
    [[self navigationController]pushViewController:searchVC animated:NO];
}
@end
