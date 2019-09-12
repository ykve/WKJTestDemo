//
//  HomeHeaderView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "BuyLeftHeader.h"
#import "IGKbetModel.h"
#import "NoticeView.h"

@interface BuyLeftHeader()<UIScrollViewDelegate>

@end

@implementation BuyLeftHeader


- (void)awakeFromNib {
    [super awakeFromNib];
//    self.line1.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_News_LineView];
//    self.remindLbl.textColor = [UIColor colorWithHex:@"FFFFFF"];//[[CPTThemeConfig shareManager]
//    self.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_HeadView_Back];
    self.backgroundColor = CLEAR;
}

- (IBAction)clickEdit:(UIButton *)sender {

}


@end
