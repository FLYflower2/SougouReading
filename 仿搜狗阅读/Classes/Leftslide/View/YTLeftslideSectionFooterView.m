//
//  YTLeftslideSectionFooterView.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/10.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTLeftslideSectionFooterView.h"

@implementation YTLeftslideSectionFooterView

+ (void)addFooterToView:(UIView *)superView{
    
    
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"YTLeftslideSectionFooterView" owner:nil options:nil] lastObject];
    view.backgroundColor = [UIColor clearColor];
    
    [superView addSubview:view];
    
    
}

@end
