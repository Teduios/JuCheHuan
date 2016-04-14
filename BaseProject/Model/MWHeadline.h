//
//  MWHeadline.h
//  MyCar
//
//  Created by CHC on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.

//
//http://api.ycapp.yiche.com/appnews/toutiaov51/?platform=1&length=20&page=1

#import <Foundation/Foundation.h>


/**新闻头条*/
@interface MWHeadline : NSObject

@property (strong, nonatomic) NSString * title;//title
@property (strong, nonatomic) NSURL * picURL;//picCover
@property (assign, nonatomic) NSString * commentCount;//评论数
@property (strong, nonatomic) NSString * time;//publishTime

+(id)headlineWithDictionary:(NSDictionary *)dictionary;
//+(NSArray *)parseHeadlineWithDictionary:(NSDictionary *)dictionary;
+(NSArray *)myworldFromJSONId:(id)jsonDictionary;



@end
