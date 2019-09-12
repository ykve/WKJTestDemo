//
//  CartChongqinHeadView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartChongqinHeadView.h"

@implementation CartChongqinHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    
}
- (IBAction)lookallClick:(UIButton *)sender {
    
    if (self.lookallBlock) {
        
        self.lookallBlock();
    }
}

@end
