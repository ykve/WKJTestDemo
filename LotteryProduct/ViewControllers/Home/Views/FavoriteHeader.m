//
//  HomeHeaderView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "FavoriteHeader.h"
#import "IGKbetModel.h"
#import "NoticeView.h"

@interface FavoriteHeader()<UIScrollViewDelegate>

@end

@implementation FavoriteHeader


- (void)awakeFromNib {
    [super awakeFromNib];
//    self.line1.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_News_LineView];
//    self.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_HeadView_Back];
    self.backgroundColor = CLEAR;
    
    
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        self.titleL.textColor = self.remindLbl.textColor = [UIColor colorWithHex:@"000000"];//[[CPTThemeConfig shareManager]
        self.line1.backgroundColor = [UIColor hexStringToColor:@"CCCCCC"];
    }else{
        self.remindLbl.textColor = [UIColor colorWithHex:@"FFFFFF"];//[[CPTThemeConfig shareManager]
    }
}

- (IBAction)clickEdit:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickEdit:)]) {
        [self.delegate clickEdit:sender];
    }
}


@end
