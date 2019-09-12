//
//  CartHomeCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/30.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartHomeCell.h"

@implementation CartHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.stopwatch = [[WB_Stopwatch alloc]initWithLabel:self.timelab andTimerType:WBTypeTimer];
    [self.stopwatch setTimeFormat:@"HH:mm:ss"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
