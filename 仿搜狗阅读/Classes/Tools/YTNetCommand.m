//
//  YTNetCommand.m
//  每日烹
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTNetCommand.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "YTsearchKeyWords.h"

@interface NSObject()


@end

@implementation YTNetCommand
//这个方法暂时没用
//+(void)httpRequest:(NSString *)urlStr param:(NSDictionary *)param apikey:(NSString *)apikey{
//
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];
//
//
//    [manager GET :urlStr parameters:param  success:^(AFHTTPRequestOperation *operation, id responseObject) {
//      
//    //NSLog(@"%@", responseObject);
//        
//        NSArray *MenuItemArr = [YTMenuItem mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"tngou"]];
//        for (YTMenuItem *itm in MenuItemArr) {
//          //  NSLog(@"%@",itm.message);
//      
//        }
//    
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    NSLog(@"%@", error);
//    
//    }];
//}
//  下载图片
+(UIImage *)downloadImageWithImgStr:(NSString *)imgUrlStr placeholderImageStr:(NSString *)placeholderImageStr imageView:(UIImageView *)imageView{

    [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:[UIImage imageNamed:placeholderImageStr] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      //  NSLog(@"cacheType:%ld",(long)cacheType);
      //  NSLog(@"imageurl:%@",imageURL);
    }];

    UIImage *img = imageView.image;
    return img;
    
}

+ (NSArray *)netRequestReturnArray:(NSString *)urlStr param:(NSDictionary *)param valueKey:(NSString *)valueKey{
   __block NSArray *array = [NSArray array];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET :urlStr
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              array = [YTsearchKeyWords mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:valueKey]];
              
              
          }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    NSLog(@"rr %@",array);
    return  array;
}


@end
