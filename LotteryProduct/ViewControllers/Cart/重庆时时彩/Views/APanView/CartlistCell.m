//
//  CartlistCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartlistCell.h"

@implementation CartlistCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)delClick:(UIButton *)sender {
    
    if (self.deleteBlock) {
        
        self.deleteBlock();
    }
}

- (IBAction)missClick:(UIButton *)sender {
    
    NSInteger num = self.countlab.text.integerValue;
    
    if (num == 1) {
        
        if (self.updataBlock) {
            
            self.updataBlock(num);
        }
        return;
    }
    else {
        
        self.countlab.text = [NSString stringWithFormat:@"%ld",--num];
        
        if (self.updataBlock) {
            
            self.updataBlock(num);
        }
    }
}

- (IBAction)addClick:(UIButton *)sender {
    
    NSInteger num = self.countlab.text.integerValue;
    
    if (num == 200) {
        
        if (self.updataBlock) {
            
            self.updataBlock(num);
        }
        return;
    }
    else {
        
        self.countlab.text = [NSString stringWithFormat:@"%ld",++num];
        
        if (self.updataBlock) {
            
            self.updataBlock(num);
        }
    }
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
