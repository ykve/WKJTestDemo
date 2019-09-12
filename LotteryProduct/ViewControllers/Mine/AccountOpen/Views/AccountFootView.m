//
//  AccountFootView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "AccountFootView.h"

@implementation AccountFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    for (UIButton *btn in self.subviews) {
        
        [btn setImagePosition:WPGraphicBtnTypeTop spacing:2];
    }
}

- (IBAction)copyClick:(UIButton *)sender {
    
    if (self.selectFootBlock) {
        
        self.selectFootBlock(0);
    }
}
- (IBAction)delClick:(UIButton *)sender {
    
    if (self.selectFootBlock) {
        
        self.selectFootBlock(1);
    }
}
- (IBAction)erweimaClick:(UIButton *)sender {
    
    if (self.selectFootBlock) {
        
        self.selectFootBlock(2);
    }
}


@end
