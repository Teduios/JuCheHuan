//
//  MWNewsTableViewCell.m
//  My world
//
//  Created by tarena on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "MWNewsTableViewCell.h"
#import "MWArticle.h"
#import "MWHeadline.h"
#import "MWPreferentialNews.h"
#import "UIImageView+WebCache.h"

@implementation MWNewsTableViewCell


- (void)setCellData:(id)cellData {
    if ([cellData isKindOfClass:[MWArticle class]]) {
        MWArticle *article = cellData;
        self.titleLabel.text = article.title;
        [self.imageV sd_setImageWithURL:article.imageURL];
        self.dateLabel.text = article.time;
        self.s4Label.text = @"";
    }
    if ([cellData isKindOfClass:[MWHeadline class]]) {
        MWHeadline *headline = cellData;
        self.titleLabel.text = headline.title;
        self.dateLabel.text = headline.time;
        [self.imageV sd_setImageWithURL:headline.picURL];
        self.s4Label.text = @"";
    }
    if ([cellData isKindOfClass:[MWPreferentialNews class]]) {
        MWPreferentialNews *preferentia = cellData;
        self.titleLabel.text = preferentia.carName;
        self.dateLabel.text = preferentia.updateTime;
        [self.imageV sd_setImageWithURL:preferentia.imageURL];
        self.s4Label.text = preferentia.shopName;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
