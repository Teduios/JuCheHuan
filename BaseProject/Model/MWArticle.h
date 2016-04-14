//
//  CHCArticle.h
//  MyCar
//
//  Created by CHC on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.

//
//@"http://c.m.163.com/nc/article/list/T1348654060988/0-20.html" //20-20.html


#import <Foundation/Foundation.h>


/**快报*/
@interface MWArticle : NSObject

@property (strong, nonatomic) NSString * title;//title
/**摘要*/
@property (strong, nonatomic) NSString * digest;//digest
@property (strong, nonatomic) NSURL * imageURL;//imgsrc
@property (strong, nonatomic) NSURL * contentURL;//url_3w

/**文章来源*/
@property (strong, nonatomic) NSString * source;//
/**投票数*/
@property (strong, nonatomic) NSString * voteCount;//votecount
/**回复数*/
@property (strong, nonatomic) NSString * replyCount;//replyCount
@property (strong, nonatomic) NSString * time;//lmodify

/**传入字典，返回CHCArticle;*/
+(id)articleWithDictionary:(NSDictionary *)dictionary;

/**解析字典，返回article数组*/
//+(NSArray *)articleFromJSON:(NSDictionary *)jsonDictionary;

+(NSArray *)myworldFromJSONId:(id)jsonDictionary;
@end
