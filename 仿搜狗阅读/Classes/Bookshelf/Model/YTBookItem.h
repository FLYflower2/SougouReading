//
//  YTBookItem.h
//  仿搜狗阅读
//
//  Created by Mac on 16/6/11.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTBookItem : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *imageKey;

+ (instancetype) BookItemWithName:(NSString *)name imageKey:(NSString *)imageKey;

+(NSMutableArray *)readDatabase;
@end
