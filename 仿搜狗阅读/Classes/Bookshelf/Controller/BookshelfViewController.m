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
@interface BookshelfViewController ()<selectIndexPathDelegate>
{
    UIView *coverView;
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
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //添加手势相应，点击其他区域，蒙板消失
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    
    
    //导航栏设置
//    UIImage *image = [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem.selectedImage = image;
//    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>



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

- (void)selectIndexPathRow:(NSInteger)index
{
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

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    //移除蒙板
    coverView.frame = self.view.bounds;
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.5;
    [coverView removeFromSuperview];
    
}

@end
