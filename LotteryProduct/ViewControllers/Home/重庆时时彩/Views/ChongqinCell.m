//
//  ChongqinCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ChongqinCell.h"

@implementation ChongqinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)historyClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(1);
    }
}

- (IBAction)missClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(2);
    }
}

- (IBAction)todayClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(3);
    }
}

- (IBAction)freeClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(4);
    }
}

- (IBAction)lineClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(5);
    }
}
- (IBAction)publicClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(6);
    }
}

@end
