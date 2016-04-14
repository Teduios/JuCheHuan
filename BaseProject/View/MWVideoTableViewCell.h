//
//  MWVideoTableViewCell.h
//  My world
//
//  Created by tarena on 15/12/21.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWVideoTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;

@property (weak, nonatomic) IBOutlet UILabel *videoTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoSummaryLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoDurationLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoDateLabel;








@end
