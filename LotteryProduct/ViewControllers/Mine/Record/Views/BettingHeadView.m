//
//  BettingHeadView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "BettingHeadView.h"

@implementation BettingHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self.beforBtn setImagePosition:WPGraphicBtnTypeLeft spacing:3];
    [self.afterBtn setImagePosition:WPGraphicBtnTypeRight spacing:3];
    [self.lotteryBtn setImagePosition:WPGraphicBtnTypeRight spacing:3];
    [self.putmoneyBtn setImagePosition:WPGraphicBtnTypeRight spacing:3];
    [self.addmoneyBtn setImagePosition:WPGraphicBtnTypeRight spacing:3];
    [self.timeBtn setImagePosition:WPGraphicBtnTypeRight spacing:3];
    
//    [Tools getDateWithDate:[NSDate date] success:^(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second, NSString *week) {
//        
//        self.datelab.text = [NSString stringWithFormat:@"%ld月%ld日 %@",month,day,week];
//    }];
}

- (IBAction)beforClick:(UIButton *)sender {
    
    if (self.selectClickBlock) {
        
        self.selectClickBlock(1,sender);
    }
}

- (IBAction)afterClick:(UIButton *)sender {
    
    if (self.selectClickBlock) {
        
        self.selectClickBlock(2,sender);
    }
}

- (IBAction)dateClick:(UIButton *)sender {
    
    if (self.selectClickBlock) {
        
        self.selectClickBlock(3,sender);
    }
}
- (IBAction)lotteryClick:(UIButton *)sender {
    
    if (self.selectClickBlock) {
        
        self.selectClickBlock(4,sender);
    }
}

- (IBAction)putmoneyClick:(UIButton *)sender {
    
    if (self.selectClickBlock) {
        
        self.selectClickBlock(5,sender);
    }
}

- (IBAction)addmoneyClick:(UIButton *)sender {
    
    if (self.selectClickBlock) {
        
        self.selectClickBlock(6,sender);
    }
}

- (IBAction)timeClick:(UIButton *)sender {
    
    if (self.selectClickBlock) {
        
        self.selectClickBlock(7,sender);
    }
}



@end
