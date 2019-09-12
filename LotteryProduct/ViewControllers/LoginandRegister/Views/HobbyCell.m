//
//  HobbyCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HobbyCell.h"

@implementation HobbyCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectimgv.image = [[CPTThemeConfig shareManager] HobbyCellImage];
}

@end
