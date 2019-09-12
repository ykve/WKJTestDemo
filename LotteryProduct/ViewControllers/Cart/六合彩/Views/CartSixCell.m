//
//  CartSixCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartSixCell.h"

@implementation CartSixCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)blockClick:(UIButton *)sender {
    
    sender.selected = ! sender.selected;
    
    if (self.cartsixBlock) {
        
        self.cartsixBlock(sender);
    }
}




- (IBAction)ballClick:(UIButton *)sender {
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
