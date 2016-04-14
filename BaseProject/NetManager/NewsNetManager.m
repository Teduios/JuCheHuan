//
//  NewsNetManager.m
//  BaseProject
//
//  Created by tarena on 15/12/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "NewsNetManager.h"
#import "Header.h"

//static AFHTTPSessionManager *manager = nil;
@implementation NewsNetManager
/*
+ (AFHTTPSessionManager *)sharedAFManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
//设置AF对哪些数据类型进行解析
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
//定义请求超时时间长度
        manager.requestSerializer.timeoutInterval = 30;
//还可以设置请求的 头部 httpHeaderField
//可以设置value为nil, 来删除某个key
//        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
        
    });
    return manager;
}
*/
+ (id)getNewsListWithStartIndex:(NSInteger)index completionHandle:(void (^)(id, NSError *))completionHandle{
    
    NSString *path = [NSString stringWithFormat: CArticleUrl, index];
    return [self GET:path parameters:nil completionHandle:^(id responseObj, NSError *error) {
        completionHandle(responseObj, error);
    }];
    
    /*
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
     */
    /*NSString *path = [NSString stringWithFormat: kNewsPath, index];
    return [[self sharedAFManager] GET:path parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        completionHandle(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        completionHandle(nil, error);
    }]; */
}
@end










