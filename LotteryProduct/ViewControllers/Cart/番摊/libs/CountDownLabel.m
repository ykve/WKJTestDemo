//
//  CountDownLabel.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/8.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CountDownLabel.h"

@implementation CountDownLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.textColor = [[CPTThemeConfig shareManager] Buy_fantanTimeColor];
        self.font = [UIFont boldSystemFontOfSize:15];
    }
    return self;
}

@end
