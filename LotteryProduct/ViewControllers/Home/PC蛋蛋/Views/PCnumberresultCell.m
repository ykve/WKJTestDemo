//
//  PCnumberresultCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/13.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PCnumberresultCell.h"

@implementation PCnumberresultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.numberlab.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
