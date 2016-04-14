//
//  MWJudge.m
//  MyWorldVideo
//
//  Created by tarena on 15/12/13.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MWJudge.h"

@implementation MWJudge

+ (id)carWithJudgeDic:(NSDictionary *)judgeDic {
    return [[self alloc]initWithJudge:judgeDic];
}

- (id)initWithJudge:(NSDictionary *)judgeDic {
    if (self = [super init]) {
        NSString *judgeStr = judgeDic[@"filePath"];
        self.judgeURL = [NSURL URLWithString:judgeStr];
        self.judgeTitle = judgeDic[@"title"];
        self.judgeDate = judgeDic[@"publishTime"];
        self.judgeCommentCount = judgeDic[@"commentCount"];
    }
    return self;
}

//+ (NSArray *)judgeFromJson:(NSDictionary *)jsonDic
+(NSArray *)myworldFromJSONId:(id)jsonDictionary
{
    NSDictionary *dataDic = jsonDictionary[@"data"];
    NSArray *listArray = dataDic[@"list"];
    
    NSMutableArray *judgeMutableArray = [NSMutableArray array];
    for (NSDictionary *judgeDic in listArray) {
        MWJudge *judge = [MWJudge carWithJudgeDic:judgeDic];
        [judgeMutableArray addObject:judge];
    }
    return [judgeMutableArray copy];
    
    
}








@end
