
//
//  CPTBuyHeadViewTableViewHeadView.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/17.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuyHeadViewTableViewHeadView.h"

@implementation CPTBuyHeadViewTableViewHeadView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.lab1.textColor =  [[CPTThemeConfig shareManager] Fantan_historyHeaderLabColor];
    self.lab2.textColor = [[CPTThemeConfig shareManager] Fantan_historyHeaderLabColor];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_Buy_Footer_Back];

    }
    return self;
}
@end
