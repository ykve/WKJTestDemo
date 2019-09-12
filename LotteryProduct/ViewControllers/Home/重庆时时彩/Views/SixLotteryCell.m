//
//  SixLotteryCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixLotteryCell.h"

@implementation SixLotteryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)videoClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(1);
    }
}

- (IBAction)photosClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(2);
    }
}

- (IBAction)searchClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(3);
    }
}

- (IBAction)historyClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(4);
    }
}

- (IBAction)newsClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(5);
    }
}

- (IBAction)recommendClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(6);
    }
}

- (IBAction)calendarClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(7);
    }
}

- (IBAction)AIClick:(UIButton *)sender {
    
    if (self.actionClickBlock) {
        
        self.actionClickBlock(8);
    }
}

@end
