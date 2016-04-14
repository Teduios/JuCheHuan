//
//  MWDataTool.m
//  MyCar
//
//  Created by CHC on 15/12/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MWDataTool.h"


@interface MWDataTool ()


@end

@implementation MWDataTool
+ (void)getArticleDataAndCallback:(void (^)(id))callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:CArticleUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback([MWArticle myworldFromJSONId:responseObject]);
    } failure:nil];
}

+ (void)getArticleDataAndCallback:(void(^)(id obj))callback withUrl:(NSString *)strURL {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:strURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback([MWArticle myworldFromJSONId:responseObject]);
    } failure:nil];
}

+(void)getHeadlineDataAndCallback:(void (^)(id))callback
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:CHeadlineUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback([MWHeadline myworldFromJSONId:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MYLog(@"error:%@",error);
    }];
}

+(void)getHeadlineDataAndCallback:(void (^)(id))callback withUrl:(NSString *)strURL {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:strURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback([MWHeadline myworldFromJSONId:responseObject]);
    } failure:nil];
}

+(void)getImageDataAndCallback:(void (^)(id))callback
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:CImageUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback([MWImage myworldFromJSONId:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MYLog(@"error:%@",error);
    }];
    
}

+(void)getImageDataAndCallback:(void (^)(id))callback withUrl:(NSString *)strURL {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:strURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback([MWImage myworldFromJSONId:responseObject]);
    } failure:nil];
}

+(void)getJudgeDataAndCallback:(void (^)(id))callback
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:CJudgeUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback([MWJudge myworldFromJSONId:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MYLog(@"error:%@",error);
    }];

}

+(void)getJudgeDataAndCallback:(void (^)(id))callback withURL:(NSString *)strURL {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:strURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback([MWJudge myworldFromJSONId:responseObject]);
    } failure:nil];
}


+(void)getNewsDataAndCallback:(void (^)(id))callback
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:CNewsUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        callback([MWNews myworldFromJSONId:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MYLog(@"error:%@",error);
    }];

}

+(void)getPreferentialNewsDataAndCallback:(void (^)(id))callback
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:CPreferentialNewsUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback([MWPreferentialNews myworldFromJSONId:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MYLog(@"error:%@",error);
    }];
}

+(void)getVideoDataAndCallback:(void (^)(id))callback
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:CVideoUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback([MWVideo myworldFromJSONId:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MYLog(@"error:%@",error);
    }];

}

+(void)getVideoDataAndCallback:(void (^)(id))callback withURL:(NSString *)strURL {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:strURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback([MWVideo myworldFromJSONId:responseObject]);
    } failure:nil];
}

@end




















