//
//  BookshelfViewController.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/2.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "BookshelfViewController.h"
#import "AppDelegate.h"
#import "XTPopView.h"
#import "YTBookItem.h"
#import "YTBookCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "YTSqliteTool.h"
#import "YTBookstoreViewController.h"
@interface BookshelfViewController ()<selectIndexPathDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *booksArr;
    
    NSInteger indexRow;
    BOOL deleteBtnFlag;
}
- (IBAction)searchBtnClick:(id)sender;
- (IBAction)iconBtnClick:(id)sender;
- (IBAction)addBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation BookshelfViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    deleteBtnFlag = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self addDoubleTapGesture];
  
    [self setupDataBase];

    
}

- (void)viewWillAppear:(BOOL)animated{
    booksArr = [YTBookItem readDatabase];
    //添加最后一项，是一个带加号的图片
    YTBookItem *itm = [[YTBookItem alloc]init];
    itm.imageKey = @"addbtnInshelf";
    [booksArr addObject:itm];
    
    
    [self.collectionView reloadData];
    
}

#pragma mark <UICollectionViewDataSource>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(13,8,10,8);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return booksArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YTBookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    YTBookItem *item = booksArr[indexPath.row];
    cell.imageView.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.imageKey];
    cell.bookNameView.text = item.name;
    //如果小说没有封面，就使用默认图
    if (cell.imageView.image == nil) {
        cell.imageView.image = [UIImage imageNamed:@"default_cover_blue"];
    }
    //如果是最后一项，则显示加号图
    if ([item.imageKey isEqualToString:@"addbtnInshelf"]) {
        cell.imageView.image = [UIImage imageNamed:@"addbtnInshelf"];
        
    }
    
    cell.indexPath = indexPath;
    cell.deleteBtn.hidden = deleteBtnFlag?YES:NO;
    cell.delegate =  self;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    //如果点击最后一项，就跳转到书城界面
    if (indexPath.row == booksArr.count -1 ) {
         self.tabBarController.selectedIndex = 1;
    }
                                              
                                              
}


- (IBAction)searchBtnClick:(id)sender {
    [YTNavAnimation NavPushAnimation:self.navigationController.view];
    UISearchController *searchVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"searchVC"];
    [[self navigationController]pushViewController:searchVC animated:NO];
}

- (IBAction)iconBtnClick:(id)sender {
    [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
}

- (IBAction)addBtnClick:(id)sender {
    
    [self setupPopView];
    
}

- (void)selectIndexPathRow:(NSInteger)index{
    switch (index) {
        case 0:
        {
            NSLog(@"编辑");
        }
            break;
        case 1:
        {
            NSLog(@"列表模式");
        }
            break;
        case 2:
        {
            NSLog(@"本地传书");
        }
            break;

        default:
            break;
    }
}
- (void)setupPopView{
    
    CGPoint point = CGPointMake(_addBtn.center.x,_addBtn.center.y + 45);
    XTPopView *view1 = [[XTPopView alloc] initWithOrigin:point Width:130 Height:40 * 3 Type:XTTypeOfUpRight Color:[UIColor whiteColor] superView:self.view];
    view1.dataArray = @[@"编辑",@"列表模式", @"本地传书"];
    view1.images = @[@"bookShelfPopMenuedit",@"bookShelfPopMenulist", @"bookShelfPopMenuImport"];
    view1.fontSize = 13;
    view1.row_height = 40;
    view1.titleTextColor = [UIColor blackColor];
    view1.delegate = self;
    [view1 popView];
}
- (void)hideAllDeleteBtn{
    if (!deleteBtnFlag) {
        deleteBtnFlag = YES;
        [self.collectionView reloadData];
    }
    
}
- (void)showAllDeleteBtn{
    deleteBtnFlag = NO;
    [self.collectionView reloadData];
}
- (void)handleDoubleTap:(UITapGestureRecognizer *) gestureRecognizer{
    [self hideAllDeleteBtn];
    
}
- (void)addDoubleTapGesture{
    UITapGestureRecognizer *doubletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubletap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubletap];
}
- (void)setupDataBase{
    //    //创建表
    NSString *sql = @"create table if not exists t_bookshelf (id integer primary key autoincrement,book text,imagekey text);";
    [YTSqliteTool execWithSql:sql];
    
}
@end
