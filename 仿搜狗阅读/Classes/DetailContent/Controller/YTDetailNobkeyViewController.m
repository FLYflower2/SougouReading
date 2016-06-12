//
//  YTDetailNobkeyViewController.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/11.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTDetailNobkeyViewController.h"

@interface YTDetailNobkeyViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *detailNobekyWebView;
- (IBAction)addToShelf:(id)sender;
- (IBAction)startReading:(id)sender;
@end

@implementation YTDetailNobkeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.bookName;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.detailNobekyWebView.scrollView.bounces = NO;
    
    [self detailNobekyWebViewRequest];

    
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




- (void)detailNobekyWebViewRequest{
    NSString *urlStr =  [NSString stringWithFormat:@"http://k.sogou.com/abs/ios/v3/pirated?md=%@&shelfmd=&cuuid=426dbaf97b0d3b1ed3791d4bb83b80c719be6300&ppid=80C5B623E2F3031DC4B1874096C54217@qq.sohu.com&versioncode=3.5.0&eid=1136",self.md];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.detailNobekyWebView loadRequest:request];

}


- (IBAction)addToShelf:(id)sender {
    [YTNetCommand downloadAndStoredImage:self.imageUrlStr imageKey:self.bookName];
    //存图片的key就是用书名，所以sql的两个参数都是bookName

    NSString *sql = [NSString stringWithFormat:@"insert into t_bookshelf (book,imagekey) values('%@','%@');",self.bookName,self.bookName];
    [YTSqliteTool execWithSql:sql];
    
}

- (IBAction)startReading:(id)sender {
}


@end
