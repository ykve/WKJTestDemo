//
//  HomeCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "AdCell.h"

@interface AdCell ()

@end

@implementation AdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = self.contentView.backgroundColor= CLEAR;
//    self.contentView.backgroundColor = [UIColor hexStringToColor:@"f0f2f5"];
//    self.imgv.contentMode = UIViewContentModeScaleToFill;
//    self.titlelab.textColor = BLACK;
}

@end
