//
//  DrawSixLotteryCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "DrawSixLotteryCell.h"

@implementation DrawSixLotteryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.stopWatchLabel = [[WB_Stopwatch alloc]initWithLabel:self.endtimelab andTimerType:WBTypeTimer];
    [self.stopWatchLabel setTimeFormat:@"dd天HH时mm分ss秒"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
