//
//  Header.h
//  MyCar
//
//  Created by CHC on 15/12/20.
//  Copyright © 2015年 tarena. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import "MWArticle.h"
#import "MWHeadline.h"
#import "MWNews.h"
#import "MWPreferentialNews.h"
#import "MWVideo.h"
#import "MWImage.h"
#import "MWJudge.h"

#define CArticleUrl @"http://c.m.163.com/nc/article/list/T1348654060988/0-20.html"

#define CHeadlineUrl @"http://api.ycapp.yiche.com/appnews/toutiaov51/?platform=1&length=20&page=1"

#define CImageUrl @"http://api.lovebizhi.com/android_v3.php?a=category&spdy=1&tid=798&order=hot&color_id=3&device=nubia%28NX507J%29&uuid=fcbee865a8102969f325d07cebf2ba4c&mode=1&client_id=1001&device_id=51209718&model_id=102&size_id=0&channel_id=70&screen_width=1080&screen_height=1920&bizhi_width=2160&bizhi_height=1920&version_code=73&language=zh-CN&mac=&original=0&p=1"

#define CJudgeUrl @"http://api.ycapp.yiche.com/news/getnewslist?serialid=&pageindex=1&pagesize=20&categoryid=1"

#define CNewsUrl @"http://api.ycapp.yiche.com/news/getnewslist?serialid=&pageindex=1&pagesize=20&categoryid=3"

#define CPreferentialNewsUrl @"http://api.app.yiche.com/webapi/dealerpromotionrank.ashx?op=list&cityid=201&serialid=&skip=1&authcode=126A50FA-E10D-42DF-AF03-0D28344F5E38&sourceid=17&ordertype=1&pageindex=1&pagesize=20&sign=be994230392be81361863570bbc030c8"

#define CVideoUrl @"http://api.app.yiche.com/webapi/api.ashx?method=bit.videolist&catid=6&pageindex=1"


#endif /* Header_h */
