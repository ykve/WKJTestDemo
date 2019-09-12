//
//  TodayTwoCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "TodayTwoCell.h"

@implementation TodayTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.progressview.transform = CGAffineTransformMakeScale(1.0, 3.0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
