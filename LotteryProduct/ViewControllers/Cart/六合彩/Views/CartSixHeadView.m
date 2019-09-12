//
//  CartSixHeadView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartSixHeadView.h"

@implementation CartSixHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    
    [super awakeFromNib];
    [self.downBtn setAdjustsImageWhenHighlighted:NO];
    for (NSLayoutConstraint *rightconst in self.rights) {
        rightconst.constant = 15/SCAL;
    }
}

- (IBAction)lookallClick:(UIButton *)sender {
    
    if (self.lookallBlock) {
        
        self.lookallBlock();
    }
}



@end
