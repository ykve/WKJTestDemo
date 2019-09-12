//
//  CartChongqin2Cell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/29.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartChongqin2Cell.h"

@implementation CartChongqin2Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)numbersClick:(UIButton *)sender {
    
    if (self.selectBlock) {
        
        self.selectBlock(sender);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
