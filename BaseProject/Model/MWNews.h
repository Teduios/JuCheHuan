//
//  MWNews.h
//  MyCar
//
//  Created by CHC on 15/12/13.
//  Copyright © 2015年 tarena. All rights reserved.


//
//http://api.ycapp.yiche.com/news/getnewslist?serialid=&pageindex=1&pagesize=20&categoryid=3


#import <Foundation/Foundation.h>


/**新闻,很少是当天的(几乎没有）*/
@interface MWNews : NSObject

@property (strong, nonatomic) NSString  * title;//title
/**评论数*/
@property (strong, nonatomic) NSString * commentCount;//commentCount
@property (strong, nonatomic) NSURL * contentURL;//filePath 内容详情
/**图片网址*/
@property (strong, nonatomic) NSString * picURL;//picCover **
/**发布时间*/
@property (strong, nonatomic) NSString * publishTime;//publishTime

+(id)newsWithNewsDictionary:(NSDictionary *)dictionary;
//+(NSArray *)parseNewsWithDictionary:(NSDictionary *)dictionary;
+(NSArray *)myworldFromJSONId:(id)jsonDictionary;

@end
