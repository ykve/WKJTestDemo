//
//  IGKbetResultCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/16.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "IGKbetResultCell.h"

@interface IGKbetResultCell ()

@end

@implementation IGKbetResultCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.line.backgroundColor = [[CPTThemeConfig shareManager] QiCiDetailLineBackgroundColor];
    self.titlelab.textColor = [[CPTThemeConfig shareManager] QiCiDetailTitleColor];
    self.infolab.textColor = [[CPTThemeConfig shareManager] QiCiDetailInfoColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
