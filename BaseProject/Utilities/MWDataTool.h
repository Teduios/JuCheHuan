//
//  MWDataTool.h
//  MyCar
//
//  Created by CHC on 15/12/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"


@interface MWDataTool : NSObject

+ (void)getArticleDataAndCallback:(void(^)(id obj))callback;
+ (void)getArticleDataAndCallback:(void(^)(id obj))callback withUrl:(NSString *)strURL;

+(void)getHeadlineDataAndCallback:(void(^)(id obj))callback;
+(void)getHeadlineDataAndCallback:(void(^)(id obj))callback withUrl:(NSString *)strURL;

+(void)getImageDataAndCallback:(void(^)(id obj))callback;
+(void)getImageDataAndCallback:(void(^)(id obj))callback withUrl:(NSString *)strURL;

+(void)getJudgeDataAndCallback:(void(^)(id obj))callback;
+(void)getJudgeDataAndCallback:(void(^)(id obj))callback withURL:(NSString *)strURL;

+(void)getNewsDataAndCallback:(void(^)(id obj))callback;
+(void)getPreferentialNewsDataAndCallback:(void(^)(id obj))callback;

+(void)getVideoDataAndCallback:(void(^)(id obj))callback;
+(void)getVideoDataAndCallback:(void(^)(id obj))callback withURL:(NSString *)strURL;

@end
