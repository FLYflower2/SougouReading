//
//  YTBookstoreViewController.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/2.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTBookstoreViewController.h"
#import "YTSearchViewController.h"
@interface YTBookstoreViewController ()

- (IBAction)searchBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *bookstoreWebView;

@end

@implementation YTBookstoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bookstoreWebView.scrollView.bounces = NO;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://k.sogou.com/abs/ios/v3/girl?gender=1"]];
    [self.bookstoreWebView loadRequest:request];

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

- (IBAction)searchBtnClick:(id)sender {
    [YTNavAnimation NavPushAnimation:self.navigationController.view];
    YTSearchViewController *searchVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"searchVC"];
    
    [[self navigationController]pushViewController:searchVC animated:NO];

}
@end
