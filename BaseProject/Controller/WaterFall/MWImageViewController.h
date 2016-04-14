//
//  MWImageViewController.h
//  BaseProject
//
//  Created by CHC on 16/1/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWImageViewController : UIViewController

@property (nonatomic, strong) UIImage *image;
@property (strong, nonatomic) NSURL * imageUrl;
@property (nonatomic, assign) BOOL isHidden;


@end
