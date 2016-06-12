//
//  YTBookItem.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/11.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTBookItem.h"
#import "YTSqliteTool.h"
@implementation YTBookItem

+ (instancetype) BookItemWithName:(NSString *)name imageKey:(NSString *)imageKey{
    YTBookItem *bookItem = [[YTBookItem alloc]init];
    bookItem.name = name;
    bookItem.imageKey = imageKey;
    return bookItem;

}

+(NSMutableArray *)readDatabase{
    NSMutableArray *booksArray = [NSMutableArray array];
    NSString *sql = @"select * from t_bookshelf;";
    //读取数据存到数组里
    booksArray = [YTSqliteTool selectWithSql:sql];
    
    
    return booksArray;
}

@end
