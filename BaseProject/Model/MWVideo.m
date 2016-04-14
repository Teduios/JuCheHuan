//
//  MWVideo.m
//  MyWorldVideo
//
//  Created by tarena on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MWVideo.h"

@implementation MWVideo

+(id)carWithVideoDic:(NSDictionary *)videoDic {
    return [[self alloc]initWithVideoDic:videoDic];
    
}

- (id)initWithVideoDic:(NSDictionary *)videoDic {
    if (self = [super init]) {
        // NSURL    *videoImage;      播放图片ImageLink,这是个URL
        NSString *imageStr= videoDic[@"ImageLink"];
        self.videoImage = [NSURL URLWithString:imageStr];
        // NSString *videoCreated;    //发布时间
        
        self.videoCreatedTime = videoDic[@"CreatedOn"];
        // NSString *videoTitle;      //视频标题
        self.videoTitle = videoDic[@"Title"];
        // NSURL    *videoMp4;        //视频
        NSString *Mp4Str = videoDic[@"Mp4Link"];
        self.videoMp4 = [NSURL URLWithString:Mp4Str];
        // NSString *videoVisit;      //播放次数
        self.videoVisit = videoDic[@"TotalVisit"];
        // NSString *videoSummary;    //详情介绍
        self.videoSummary = videoDic[@"Summary"];
        // NSString *videoAuthor;     //视频发布者
        self.videoAuthor = videoDic[@"Author"];
        // NSString *videoDuration;   //视频时长
        self.videoDuration = videoDic[@"Duration"];
       
    }
    return self;
}

//+ (NSArray *)videoFromJson:(NSDictionary *)jsonDic
+(NSArray *)myworldFromJSONId:(id)jsonDictionary
{
    //  原始每天数据
    NSDictionary *dataDic = jsonDictionary[@"Data"];
    
    //    原始video表的数据
    NSArray *videoArray = dataDic[@"Table"];
    //    可变数组
    NSMutableArray *videoMutableArray = [NSMutableArray array];
    for (NSDictionary *videoDic in videoArray) {
        MWVideo *video = [MWVideo carWithVideoDic:videoDic];
        [videoMutableArray addObject:video];
  
    }
        return [videoMutableArray copy];
}
    


@end
