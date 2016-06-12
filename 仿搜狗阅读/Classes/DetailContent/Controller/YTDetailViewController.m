//
//  YTDetailViewController.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/10.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTDetailViewController.h"
#import "YTChaptersItem.h"
#import <MJExtension.h>
@interface YTDetailViewController ()<UIWebViewDelegate>
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
    self.detailWebView.delegate = self;
    
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
    NSString *sql = [NSString stringWithFormat:@"insert into t_bookshelf (book,imagekey,bookid,md,count,author,loc,eid,bkey,token) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@');",self.bookName,self.bookName,self.bookid,self.md,self.count,self.author,self.loc,self.eid,self.bkey,self.token];
    [YTSqliteTool execWithSql:sql];
    
    


}

- (IBAction)buying:(id)sender {
}
#pragma mark - 根据章节对象建立数据表，每本书一个数据表
- (void)setupChapterTable:(NSString *)bookname{
    
    NSString *sql = [NSString stringWithFormat:@"create table if not exists t_%@chapters (id integer primary key autoincrement,free text,gl text,buy text,rmb text,name text,md5 text);",self.bookName];
    
    [YTSqliteTool execWithSql:sql];
    
}
//因为一些情况，暂时网络请求不到，所以先放着不用,原因是返回的数据不是标准json格式
- (void)requestChapters{
    NSDictionary *param = @{@"bkey":self.bkey,
                            @"v":@"0",
                            @"uid":@"80C5B623E2F3031DC4B1874096C54217@qq.sohu.com",
                            @"token":@"4244558c08b4ee4e9791b06cca4ec139",
                            @"eid":@"1136"
                            };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET :menuUrl
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              // NSArray *tempArr = [YTChaptersItem mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"chapter"]];
              //  NSLog(@"%d",tempArr.count);
              NSLog(@"success");
          }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"%@",error);
              NSLog(@"faild");
          }];
}
@end
