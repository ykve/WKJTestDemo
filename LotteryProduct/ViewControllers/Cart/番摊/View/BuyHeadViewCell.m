//
//  BuyHeadViewCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/3/8.
//  Copyright © 2019年 vsskyblue. All rights reserved.
//

#import "BuyHeadViewCell.h"

@implementation BuyHeadViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [[CPTThemeConfig shareManager] Buy_fantanBgColor];
    self.leftView.backgroundColor = [[CPTThemeConfig shareManager] Buy_fantanBgColor];
    self.rightView.backgroundColor = [[CPTThemeConfig shareManager] Buy_fantanBgColor];
    self.tableView.backgroundColor = self.hrView.backgroundColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
