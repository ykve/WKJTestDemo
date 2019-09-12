//
//  HomeCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ActivityCell.h"

@interface ActivityCell ()

@end

@implementation ActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.backView.backgroundColor = CLEAR;
    self.contentView.backgroundColor = [UIColor hexStringToColor:@"f0f2f5"];
    self.imgv.contentMode = UIViewContentModeScaleToFill;
}

@end
