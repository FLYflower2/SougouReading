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


@interface YTSearchViewController ()

@property (nonatomic, strong) YTSearchBar *searchBar;
@property (nonatomic, copy) NSString *searchContent;        // 搜索内容
@property (nonatomic, strong) YTSearchFooter *footer;  // 推荐搜索
@property (nonatomic, strong) NSArray *hotSearchWords;      // 推荐搜索关键词

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
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
  //  [self.searchBar becomeFirstResponder];
    self.navigationItem.titleView = self.searchBar;
    
    __weak YTSearchBar *wSearchBar = self.searchBar;
    WeakSelf;
    self.searchBar.searchBarTextDidChangedBlock = ^{ // 文本编辑回调
        weakSelf.searchContent = wSearchBar.text;
        [weakSelf.tableView reloadData]; // 时刻刷新界面
    };
    self.searchBar.searchBarDidSearchBlock = ^{ // 搜索回调
//        [XCFSearchKeywordsTool addNewWord:wSearchBar.text];
//        [weakSelf pushResultVCWithResult:[NSString stringWithFormat:@"%@ \n %@", weakSelf.typeString[0], wSearchBar.text]];
    };
}

- (void)setupFooter{
    YTSearchFooter *footer = [[YTSearchFooter alloc] initWithFrame:CGRectMake(0, 0, YTScreenWidth, 270)];
    footer.hidden = self.searchContent.length;
    footer.keywords = self.hotSearchWords;
    WeakSelf;
    // 点击回调 点击就搜索
    footer.searchCallBack = ^(NSUInteger index) {
        NSLog(@"search");
//        [XCFSearchKeywordsTool addNewWord:weakSelf.hotSearchWords[index]];
//        NSString *displayString = [NSString stringWithFormat:@"%@：%@", weakSelf.typeString[0], weakSelf.hotSearchWords[index]];
//        [weakSelf pushResultVCWithResult:displayString];
    };
    //点击换一换，回调，改变数组
    footer.changeKeyWord = ^(NSUInteger index){
        NSLog(@"change");
    };
    
   // self.tableView.tableFooterView = footer;
    self.tableView.tableHeaderView = footer;
    self.footer = footer;


}

- (void)setupTableView {
    self.tableView.sectionHeaderHeight = 0.1;
    self.tableView.sectionFooterHeight = 0.1;
}

//点击空白，键盘消失
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.searchBar resignFirstResponder];
    
}

-(void)cancel{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}
@end
