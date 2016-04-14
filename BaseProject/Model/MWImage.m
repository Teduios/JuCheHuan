//
//  MWImage.m
//  MyWorldVideo
//
//  Created by tarena on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MWImage.h"

@implementation MWImage
+ (id)carWithImageDic:(NSDictionary *)imageDic {
    return [[self alloc]initWithImageDic:imageDic];
    
}

- (id)initWithImageDic:(NSDictionary *)imageDic {
    if (self = [super init]) {
        NSString *imageStr = imageDic[@"image"][@"diy"];
        NSString *littleImageStr = imageDic[@"image"][@"small"];
        self.imageShow = [NSURL URLWithString:imageStr];
        self.littleImageURL = [NSURL URLWithString:littleImageStr];
    }
    return self;
}

//+(NSArray *)imageFromJson:(NSDictionary *)jsonDic
+(NSArray *)myworldFromJSONId:(id)jsonDictionary
{
//    原始每天的image数据
    NSArray *dataArray = jsonDictionary[@"data"];
    NSMutableArray *imageMutableArray = [NSMutableArray array];
    for (NSDictionary *imageDic in dataArray ) {
        MWImage *image = [MWImage carWithImageDic:imageDic];
        [imageMutableArray addObject:image];
    }
    return [imageMutableArray copy];
    
    
}


@end
