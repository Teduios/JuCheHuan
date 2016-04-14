//
//  MWNewsTableViewCell.h
//  My world
//
//  Created by tarena on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWNewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) id cellData;
@property (weak, nonatomic) IBOutlet UILabel *s4Label;

@end
