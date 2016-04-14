//
//  MWHeadline.m
//  MyCar
//
//  Created by CHC on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MWHeadline.h"

@implementation MWHeadline

+(id)headlineWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc]initWithDictionary:dictionary];
}
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        self.title = dictionary[@"title"];
        self.picURL = [NSURL URLWithString:dictionary[@"picCover"]];
        self.commentCount = dictionary[@"commentCount"];
        self.time = dictionary [@"publishTime"];
        
    }
    return self;
}




//+(NSArray *)parseHeadlineWithDictionary:(NSDictionary *)dictionary


+(NSArray *)myworldFromJSONId:(id)jsonDictionary

{
    NSArray *array = jsonDictionary[@"data"][@"list"];
    
    NSMutableArray *headlineMutableArray = [NSMutableArray array];
    for (NSDictionary *headlineDic in array) {
        MWHeadline *headline = [MWHeadline headlineWithDictionary:headlineDic];
        [headlineMutableArray addObject:headline];
    }
    return [headlineMutableArray copy];
}









@end







