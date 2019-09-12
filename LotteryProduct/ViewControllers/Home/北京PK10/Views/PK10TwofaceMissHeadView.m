//
//  PK10TwofaceMissHeadView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10TwofaceMissHeadView.h"

@implementation PK10TwofaceMissHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)numberClick:(UIButton *)sender {
    
    for (UIButton *btn in self.numbrBtns) {
        
        btn.backgroundColor = CLEAR;
        [btn setTitleColor:YAHEI forState:UIControlStateNormal];
    }
    
    sender.backgroundColor = LINECOLOR;
    [sender setTitleColor:WHITE forState:UIControlStateNormal];
    
    if (self.selectindexBlock) {
        
        self.selectindexBlock(sender.tag-100);
    }
    
}


@end
