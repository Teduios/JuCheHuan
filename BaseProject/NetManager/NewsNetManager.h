//
//  NewsNetManager.h
//  BaseProject
//
//  Created by tarena on 15/12/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseNetManager.h"

@interface NewsNetManager : BaseNetManager
//http://c.m.163.com/nc/video/home/1-10.html
//1-10, 从第一条数据开始获取,共获取10条, 11-10, 21-10
+ (id)getNewsListWithStartIndex:(NSInteger)index completionHandle:(void(^)(id model, NSError *error))completionHandle;

@end









