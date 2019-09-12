//
//  NN_sel_xianBtn.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/9.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "NN_sel_xianBtn.h"

@implementation NN_sel_xianBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        NSString *img = [[CPTThemeConfig shareManager] NN_Xian_selImg];
        [self setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        [self setTitleColor:[[CPTThemeConfig shareManager] NN_xian_selColor] forState:UIControlStateNormal];

    }
    return self;
}
@end
