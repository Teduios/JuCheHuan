//
//  MWJudge.h
//  MyWorldVideo
//
//  Created by tarena on 15/12/13.
//  Copyright © 2015年 tarena. All rights reserved.
//http://api.ycapp.yiche.com/news/getnewslist?serialid=&pageindex=1&pagesize=20&categoryid=1

#import <Foundation/Foundation.h>


@interface MWJudge : NSObject
@property (nonatomic,copy) NSString *judgeTitle;
@property (nonatomic,copy) NSURL *judgeURL;
@property (nonatomic,copy) NSString *judgeDate;
@property (nonatomic,copy) NSString *judgeCommentCount;


+ (id)carWithJudgeDic:(NSDictionary *)judgeDic;
//+ (NSArray*)judgeFromJson:(NSDictionary *)jsonDic;
+(NSArray *)myworldFromJSONId:(id)jsonDictionary;




@end
