//
//  MWNews.m
//  MyCar
//
//  Created by CHC on 15/12/13.
//  Copyright © 2015年 tarena. All rights reserved.

//新闻


#import "MWNews.h"

@implementation MWNews

+(id)newsWithNewsDictionary:(NSDictionary *)dictionary
{
    return [[self alloc]initWithNewsDictionary:dictionary];
}
-(id)initWithNewsDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        self.title = dictionary[@"title"];
        self.contentURL = [NSURL URLWithString:dictionary[@"filePath"]];
        self.commentCount = dictionary[@"commentCount"];
        
        self.publishTime = dictionary[@"publishTime"];
        
        NSString *str = dictionary[@"picCover"];
        NSRange r = {27, 15};
        NSString *str1 = [str stringByReplacingCharactersInRange:r withString:@""];
        self.picURL = str1;

//        NSString *picUrlString = dictionary[@"publishTime"];
//        self.picURL= [picUrlString stringByReplacingCharactersInRange:NSMakeRange(26, 15) withString:@""];
    }
    return self;
}

//+(NSArray *)parseNewsWithDictionary:(NSDictionary *)dictionary
+(NSArray *)myworldFromJSONId:(id)jsonDictionary
{
    NSArray *array = jsonDictionary[@"data"][@"list"];
    
    NSMutableArray *newsMutableArray = [NSMutableArray array];
    for (NSDictionary *newsDic in array) {
        MWNews *news = [MWNews newsWithNewsDictionary:newsDic];
        [newsMutableArray addObject:news];
    }
    return [newsMutableArray copy];
}






@end









