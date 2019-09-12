//
//  AoZhouACTScrollview.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/6.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "AoZhouACTScrollview.h"

@implementation AoZhouACTScrollview


- (void)configUI{
    @weakify(self)
    UIScrollView * sc = [[UIScrollView alloc] init];
    [self addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.bottom.equalTo(self);
        make.width.offset(SCREEN_WIDTH);
    }];

    sc.userInteractionEnabled = YES;

    _lotteryView = [[[NSBundle mainBundle] loadNibNamed:@"AoZhouActBuyLotteryVeiw" owner:nil options:nil] lastObject];
    
    _lotteryView.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];

    [sc addSubview:_lotteryView];
    [_lotteryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(sc);
        make.width.offset(SCREEN_WIDTH);
        make.height.equalTo(@240);
    }];
    _middleView = [[[NSBundle mainBundle] loadNibNamed:@"AoZhouACTMiddleView" owner:nil options:nil] lastObject];
    _middleView.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
    [sc addSubview:_middleView];
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self->_lotteryView);
        make.width.offset(SCREEN_WIDTH);
        make.top.equalTo(self->_lotteryView.mas_bottom);
        make.height.equalTo(@210);
    }];
    self.userInteractionEnabled = _middleView.userInteractionEnabled = _lotteryView.userInteractionEnabled = YES;
    sc.contentSize = CGSizeMake(SCREEN_WIDTH, 452);
    sc.scrollEnabled = YES;
}
@end
