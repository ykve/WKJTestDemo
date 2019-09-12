//
//  CircleHomeTableViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/3/11.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CircleHomeTableViewCell.h"

@implementation CircleHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backVeiw.layer.cornerRadius = 5;
    self.backVeiw.layer.masksToBounds = YES;
    self.backImageView.layer.cornerRadius = 5;
    self.backImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
