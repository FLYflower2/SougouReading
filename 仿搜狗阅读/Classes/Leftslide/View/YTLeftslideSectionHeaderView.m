//
//  YTLeftslideSectionHeaderView.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/10.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTLeftslideSectionHeaderView.h"

@implementation YTLeftslideSectionHeaderView
               
+ (void)addHeaderToView:(UIView *)superView{
    
   
   UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"YTLeftslideSectionHeaderView" owner:nil options:nil] lastObject];
    view.backgroundColor = [UIColor clearColor];

   [superView addSubview:view];
    
    
}

- (void)awakeFromNib{


}
@end
