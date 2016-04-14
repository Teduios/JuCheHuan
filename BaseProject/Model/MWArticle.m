//
//  CHCArticle.m
//  MyCar
//
//  Created by CHC on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MWArticle.h"

@implementation MWArticle

+(id)articleWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc]initWithDictionary:dictionary];
}
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        self.title = dictionary[@"title"];
        self.digest = dictionary[@"digest"];
        self.time = dictionary[@"lmodify"];
        self.imageURL = [NSURL URLWithString:dictionary[@"imgsrc"]];
        self.contentURL = [NSURL URLWithString:dictionary[@"url_3w"]];
        self.source = dictionary[@"source"];
        self.voteCount = dictionary[@"votecount"];
        self.replyCount = dictionary[@"replyCount"];
    }
    return self;
}


//+(NSArray *)articleFromJSON:(NSDictionary *)jsonDictionary
+(NSArray *)myworldFromJSONId:(id)jsonDictionary
{
    NSArray *array = jsonDictionary[@"T1348654060988"];
    
    NSMutableArray *articleMutableArray = [NSMutableArray array];
    for (NSDictionary *articleDic in array) {
        MWArticle *article = [self articleWithDictionary:articleDic];
        [articleMutableArray addObject:article];
    }
    //排序
    return [self sortWithMutableArray:articleMutableArray];
}

+(NSArray *)sortWithMutableArray:(NSMutableArray *)mutableArray
{
    for (int i = 0 ; i<mutableArray.count-1 ; i++) {
        for (int j = 0 ; j <mutableArray.count-i - 1; j++) {
            MWArticle *article1 = mutableArray[j];
            MWArticle *article2 = mutableArray[j+1];
            // MYLog(@"%d////original : %@  : %@",j,news1.updateTime,news2.updateTime);
            if ([article1.time compare: article2.time]== NSOrderedAscending) {
                mutableArray[j] = article2;
                mutableArray[j+1] = article1;
                // MYLog(@"sorted : %@ > %@",news1.updateTime,news2.updateTime);
            }
        }
    }
    return [mutableArray copy];
}







@end
















