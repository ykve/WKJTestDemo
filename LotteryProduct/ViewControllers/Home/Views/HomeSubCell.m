//
//  HomeSubCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomeSubCell.h"

@implementation HomeSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titlelab.textColor = [[CPTThemeConfig shareManager] CO_home_SubCellTitleText];
}

@end
