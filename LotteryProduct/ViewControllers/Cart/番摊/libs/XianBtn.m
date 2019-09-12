//
//  XianBtn.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/9.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "XianBtn.h"
#import "ColorTool.h"
@implementation XianBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
// [[CPTThemeConfig shareManager] Buy_fantanTimeColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setTitleColor:[[CPTThemeConfig shareManager] Buy_NNXianTxColor_normal] forState:UIControlStateNormal];
        [self setTitleColor:[[CPTThemeConfig shareManager] Buy_NNXianTxColor_sel] forState:UIControlStateSelected];
        
        UIImage *img = [[CPTThemeConfig shareManager] NN_XianBgImg];
        UIImage *imgSel = [[CPTThemeConfig shareManager] NN_XianBgImg_sel];
        [self setBackgroundImage:img forState:UIControlStateNormal];
        [self setBackgroundImage:imgSel forState:UIControlStateSelected];
    }
    return self;
}
@end
