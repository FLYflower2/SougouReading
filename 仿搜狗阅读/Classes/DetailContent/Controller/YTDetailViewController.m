//
//  YTDetailViewController.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/10.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTDetailViewController.h"

@interface YTDetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;
- (IBAction)attemptReadingForFree:(id)sender;
- (IBAction)addToShelf:(id)sender;
- (IBAction)buying:(id)sender;

@end

@implementation YTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.title = self.bookName;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.detailWebView.scrollView.bounces = NO;
    
    
    [self detailWebViewRequest];
    

    
}

#pragma mark - webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [LBProgressHUD showHUDto:self.view animated:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
    
}

- (void)detailWebViewRequest{
 //   NSString *gender = @"0";
//    NSString *cuuid = @"426dbaf97b0d3b1ed3791d4bb83b80c719be6300";
//    NSString *ppid = @"80C5B623E2F3031DC4B1874096C54217@qq.sohu.com";
//    NSString *versioncode = @"3.5.0";
//    NSString *eid = @"1136";
  //  NSString *urlStr =  [NSString stringWithFormat:@"http://k.sogou.com/abs/ios/v3/detail?beky=%@&s=&gender=%@&cuuid=%@&ppid=%@&versioncode=%@&eid=%@",self.bkey,gender,cuuid,ppid,versioncode,eid];
    NSString *urlStr =  [NSString stringWithFormat:@"http://k.sogou.com/abs/ios/v3/detail?bkey=%@&s=&gender=0&cuuid=426dbaf97b0d3b1ed3791d4bb83b80c719be6300&ppid=80C5B623E2F3031DC4B1874096C54217@qq.sohu.com&versioncode=3.5.0&eid=1136",self.bkey];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.detailWebView loadRequest:request];
}

- (IBAction)attemptReadingForFree:(id)sender {
}

- (IBAction)addToShelf:(id)sender {
    
    [YTNetCommand downloadAndStoredImage:self.imageUrlStr imageKey:self.bookName];
    //存图片的key就是用书名，所以sql的两个参数都是bookName
    NSString *sql = [NSString stringWithFormat:@"insert into t_bookshelf (book,imagekey) values('%@','%@');",self.bookName,self.bookName];
    [YTSqliteTool execWithSql:sql];
    

}

- (IBAction)buying:(id)sender {
}



@end
