//
//  CountDownBgView.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/8.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CountDownBgView.h"

@implementation CountDownBgView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//
//}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.backgroundColor = [[CPTThemeConfig shareManager] Fantan_CountDownBgColor];
        self.layer.borderColor = [[CPTThemeConfig shareManager] Fantan_CountDownBoderColor].CGColor;
    }
    return self;
}


@end
