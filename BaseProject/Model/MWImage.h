//
//  MWImage.h
//  MyWorldVideo
//
//  Created by tarena on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

//http://api.lovebizhi.com/android_v3.php?a=category&spdy=1&tid=798&order=hot&color_id=3&device=nubia%28NX507J%29&uuid=fcbee865a8102969f325d07cebf2ba4c&mode=1&client_id=1001&device_id=51209718&model_id=102&size_id=0&channel_id=70&screen_width=1080&screen_height=1920&bizhi_width=2160&bizhi_height=1920&version_code=73&language=zh-CN&mac=&original=0&p=1

#import <Foundation/Foundation.h>


@interface MWImage : NSObject

@property (nonatomic,strong) NSURL *littleImageURL;
@property (nonatomic,copy) NSURL *imageShow;   //图片网址


+ (id)carWithImageDic:(NSDictionary *)imageDic;
//+ (NSArray*)imageFromJson:(NSDictionary *)jsonDic;
+(NSArray *)myworldFromJSONId:(id)jsonDictionary;



@end
