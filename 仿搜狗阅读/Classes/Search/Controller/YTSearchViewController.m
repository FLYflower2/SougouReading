//
//  YTSearchViewController.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/3.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTSearchViewController.h"
#import "Masonry.h"
#import "YTSearchFooter.h"
#import "YTNetCommand.h"
#import "YTsearchKeyWords.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "YTparamLoop.h"
#import "YTsearchResultItem.h"
#import "YTResultCellWithbkey.h"
//#import "YTkeywordsRequest.h"
@interface YTSearchViewController ()

@property (nonatomic, strong) YTSearchBar *searchBar;
@property (nonatomic, copy) NSString *searchContent;        // 搜索内容
@property (nonatomic, strong) YTSearchFooter *footer;  // 推荐搜索
@property (nonatomic, strong) NSArray *hotSearchWords;      // 推荐搜索关键词
@property (nonatomic,strong) NSMutableArray *resultArr;     //搜索结果数组
@end

@implementation YTSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _hotSearchWords = @[@"完美世界",@"大主宰",@"雪鹰领主",@"龙王传说",@"校花的贴身高手",@"武炼巅峰",@"帝霸",@"超品相师",@"武逆",@"换一换" ];
    
    
    
    self.tableView.bounces = NO;
    
    [self setupNavBar];
    [self setupFooter];
    [self setupTableView];
    
    //添加手势相应，输textfield时，点击其他区域，键盘消失
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.resultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     YTResultCellWithbkey *cell = [YTResultCellWithbkey resultCellWithbkeyWithTableView:tableView];
     YTsearchResultItem *searchResultItem = _resultArr[indexPath.row];
     [cell setResultCellWithbkey:searchResultItem];
 
    
    
    return cell;
}



#pragma mark - 属性

- (void)setupNavBar {
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"取消"
                                                                              target:self
                                                                              action:@selector(cancel)];
    
    self.searchBar = [YTSearchBar searchBarWithPlaceholder:@"搜索书城图书"];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(400 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        [self.searchBar becomeFirstResponder];
    });

    self.navigationItem.titleView = self.searchBar;
    
    __weak YTSearchBar *wSearchBar = self.searchBar;
    WeakSelf;
    self.searchBar.searchBarTextDidChangedBlock = ^{ // 文本编辑回调
        weakSelf.searchContent = wSearchBar.text;
        [weakSelf.tableView reloadData]; // 时刻刷新界面
    };
    self.searchBar.searchBarDidSearchBlock = ^{ // 搜索回调
        weakSelf.tableView.tableHeaderView = nil;
        [weakSelf.resultArr removeAllObjects];
        [weakSelf.searchBar resignFirstResponder ];
        NSString *searchKeyword = weakSelf.searchBar.text;
        NSString *pageStr = @"1";
        NSDictionary *param = @{@"keyword":searchKeyword,
                                @"json":@"1",
                                @"p":pageStr,
                                @"eid":@"1136"
                                };
        [weakSelf searchRequest:param];
       
    };
}

- (void)setupFooter{
    YTSearchFooter *footer = [[YTSearchFooter alloc] initWithFrame:CGRectMake(0, 0, YTScreenWidth, 270)];
    footer.hidden = self.searchContent.length;
    footer.keywords = self.hotSearchWords;
    WeakSelf;
    
    __weak YTSearchFooter *weakfooter = footer;
    
    // 点击回调 点击就搜索
    footer.searchCallBack = ^(NSUInteger index) {
        NSLog(@"search");
//        [XCFSearchKeywordsTool addNewWord:weakSelf.hotSearchWords[index]];
//        NSString *displayString = [NSString stringWithFormat:@"%@：%@", weakSelf.typeString[0], weakSelf.hotSearchWords[index]];
//        [weakSelf pushResultVCWithResult:displayString];
    };
    //点击换一换，回调，改变数组
    footer.changeKeyWord = ^(NSUInteger index){
        NSString *startParm = [YTparamLoop paramLoop];
        NSDictionary *param = @{@"rank":@"resou",
                                @"start":startParm,
                                @"length":@"9",
                                @"json":@"1",
                                @"eid":@"1136"
                                };
        [self keywordsRequest:param];
        [weakfooter setKeywords:_hotSearchWords];
    };
    
  //  self.tableView.tableFooterView = footer;
    self.tableView.tableHeaderView = footer;
    self.footer = footer;


}

- (void)setupTableView {
    self.tableView.sectionHeaderHeight = 0.1;
    self.tableView.sectionFooterHeight = 0.1;
    self.tableView.rowHeight = 238;
}

#pragma mark - 点击空白，键盘消失
-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [self.searchBar resignFirstResponder];
    
}

#pragma mark - 点击取消，返回上一界面
-(void)cancel{

    [YTNavAnimation NavPopAnimation:self.navigationController.view];
    [[self navigationController] popViewControllerAnimated:NO];
}

#pragma mark - 点击“换一换”，修改关键词
-(void)keywordsRequest:(NSDictionary *)param{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
      [manager GET :keyWordsUrl
         parameters:param
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSArray *tempArr = [YTsearchKeyWords mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"list"]];

             NSMutableArray *tempStrArr = [NSMutableArray array];
             for (YTsearchKeyWords *k in tempArr) {
                 [tempStrArr addObject:k.book];
             }
             [tempStrArr addObject:@"换一换"];
             //修改数组
             _hotSearchWords = tempStrArr;
             
    
             }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   NSLog(@"%@",error);
                      
            }];

}

#pragma mark - 搜索的网络请求
-(void)searchRequest:(NSDictionary *)param{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET :searchUrl
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              _resultArr = [YTsearchResultItem mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"list"]];
              [self.tableView reloadData];
              NSLog(@"%@",_resultArr);
   
          }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"%@",error);
              
          }];



}

@end
