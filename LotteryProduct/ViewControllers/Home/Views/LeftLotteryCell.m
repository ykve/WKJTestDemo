//
//  HomeCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "LeftLotteryCell.h"

@interface LeftLotteryCell ()

@end

@implementation LeftLotteryCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.backView.backgroundColor = CLEAR;
    self.contentView.backgroundColor = [UIColor hexStringToColor:@"27282d"];
    self.titlelab.textColor = WHITE;
    
    self.line.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_LineViewColor];
}

@end
