//
//  MWPreferentialNews.h
//  MyCar
//
//  Created by CHC on 15/12/13.
//  Copyright © 2015年 tarena. All rights reserved.

//http://api.app.yiche.com/webapi/dealerpromotionrank.ashx?op=list&cityid=201&serialid=&skip=1&authcode=126A50FA-E10D-42DF-AF03-0D28344F5E38&sourceid=17&ordertype=1&pageindex=1&pagesize=20&sign=be994230392be81361863570bbc030c8
//城市ID

#import <Foundation/Foundation.h>


/**优惠活动，网址加密不可修改*/
@interface MWPreferentialNews : NSObject

/**更新时间：按时间排序*/
@property (strong, nonatomic) NSString * updateTime; // ** UpdateTime
@property (strong, nonatomic) NSURL * imageURL;//ImageUrl
/**降价活动的车名*/
@property (strong, nonatomic) NSString * carName;// CarName
/**活动店名*/
@property (strong, nonatomic) NSString * shopName;// DealerName
/**存货状况，eg现货充足*/
@property (strong, nonatomic) NSString * storeState;// StoreState
/**销售范围*/
@property (strong, nonatomic) NSString * saleRegion;////SaleRegion
@property (strong, nonatomic) NSURL * contentURL;//NewsUrl
@property (strong, nonatomic) NSString * isFourS;//Is4s

+(id)preferentialNewsWithNewsDictionary:(NSDictionary *)dictionary;
///解析出来的就是数组
//+(NSArray *)parseNewsFromArray:(NSArray *)array;
+(NSArray *)myworldFromJSONId:(id)jsonArray;



@end








