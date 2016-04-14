//
//  MWVideo.h
//  MyWorldVideo
//
//  Created by tarena on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

//http://api.app.yiche.com/webapi/api.ashx?method=bit.videolist&catid=6&pageindex=



#import <Foundation/Foundation.h>


@interface MWVideo : NSObject

@property (nonatomic,copy) NSURL *videoImage;         //播放图片
@property (nonatomic,copy) NSString *videoCreatedTime;    //发布时间
@property (nonatomic,copy) NSString *videoTitle;      //视频标题
@property (nonatomic,copy) NSURL *videoMp4;           //视频
@property (nonatomic,copy) NSString *videoVisit;      //播放次数
@property (nonatomic,copy) NSString *videoSummary;    //详情介绍
@property (nonatomic,copy) NSString *videoAuthor;     //视频发布者
@property (nonatomic,copy) NSString *videoDuration;   //视频时长

//提供接口（ 给定参数，返回一个已经解析好的模型对象）
//每天数据（解析NSDictionary-->Video）
+ (id)carWithVideoDic:(NSDictionary *)videoDic;

//+ (NSArray *)videoFromJson:(NSDictionary *)jsonDic;
+(NSArray *)myworldFromJSONId:(id)jsonDictionary;
@end
