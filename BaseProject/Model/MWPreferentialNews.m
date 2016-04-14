//
//  MWPreferentialNews.m
//  MyCar
//
//  Created by CHC on 15/12/13.
//  Copyright © 2015年 tarena. All rights reserved.



#import "MWPreferentialNews.h"

@implementation MWPreferentialNews

//@property (strong, nonatomic) NSString * updateTime;//***更新时间：按时间排序***
//@property (strong, nonatomic) NSURL * imageURL;//
//@property (strong, nonatomic) NSString * carName;//降价活动的车名
//@property (strong, nonatomic) NSString * shopName;//活动店名
//@property (strong, nonatomic) NSString * storeState;//存货状况，eg现货充足
//@property (strong, nonatomic) NSString * saleRegion;//销售范围//
//@property (strong, nonatomic) NSURL * contentURL;//
//@property (strong, nonatomic) NSString * isFourS;//

+(id)preferentialNewsWithNewsDictionary:(NSDictionary *)dictionary
{
    return [[MWPreferentialNews alloc]initWithDictionary:dictionary];
}
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        self.updateTime = dictionary[@"UpdateTime"];
        self.imageURL = [NSURL URLWithString:dictionary[@"IamgeUrl"]];
        self.carName = dictionary[@"CarName"];
        self.shopName = dictionary[@"DealerName"];
        self.storeState = dictionary[@"StoreState"];
        self.saleRegion = dictionary[@"SaleRegion"];
        self.contentURL = [NSURL URLWithString:dictionary[@"NewsUrl"]];
        self.isFourS = dictionary[@"Is4s"];

    }
    return self;
}

+(NSArray *)myworldFromJSONId:(id)jsonArray
{
   
    NSMutableArray *newsMutableArray = [NSMutableArray array];
    for (NSDictionary *newsDic in jsonArray) {
        MWPreferentialNews *news = [MWPreferentialNews preferentialNewsWithNewsDictionary:newsDic];
        [newsMutableArray addObject:news];
    
    }
//    NSArray *array =[self sortWithMutableArray:newsMutableArray];
//    for (MWPreferentialNews *news in array) {
//        MYLog(@"%@:%@ ",news,news.updateTime);
//    }
    //排序
    return [self sortWithMutableArray:newsMutableArray ];
}

+(NSArray *)sortWithMutableArray:(NSMutableArray *)mutableArray
{
    for (int i = 0 ; i<mutableArray.count-1 ; i++) {
        for (int j = 0 ; j <mutableArray.count-i - 1; j++) {
            MWPreferentialNews *news1 = mutableArray[j];
            MWPreferentialNews *news2 = mutableArray[j+1];
            // MYLog(@"%d////original : %@  : %@",j,news1.updateTime,news2.updateTime);
            if ([news1.updateTime compare: news2.updateTime]== NSOrderedAscending) {
                mutableArray[j] = news2;
                mutableArray[j+1] = news1;
               // MYLog(@"sorted : %@ > %@",news1.updateTime,news2.updateTime);
            }
        }
    }
    return [mutableArray copy];
}



@end







