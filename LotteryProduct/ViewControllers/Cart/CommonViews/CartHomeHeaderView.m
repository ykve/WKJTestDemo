//
//  CartHomeHeaderView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/12.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CartHomeHeaderView.h"
#import "CrartHomeSubModel.h"

@interface CartHomeHeaderView()

@end

@implementation CartHomeHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_Buy_Footer_Back];
    
}



- (void)setModel:(CartHomeModel *)model{
    _model = model;
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    topView.backgroundColor = [[CPTThemeConfig shareManager] CartHomeHeaderSeperatorColor];
    [self addSubview:topView];
    
    CGFloat num = 2;
    
    for (int i = 0; i < model.lotterys.count; i ++) {
        
        CGFloat leftmargin = 19;
        CGFloat middleMargin = 17;
        CGFloat topMargin = 40;
        CGFloat lineMargin = 17;
        CGFloat h = 40;
        CGFloat y = topMargin + (h + lineMargin) * (i/2);
        CGFloat w = (SCREEN_WIDTH - middleMargin * (num - 1) - leftmargin * 2)/num;
        CGFloat x = leftmargin + (w + middleMargin) * (i%2);

        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
        
        CrartHomeSubModel *subModel = model.lotterys[i];
        [btn setBackgroundImage:subModel.isWork? IMAGE(@"buy_cell_btn_bgImage"):IMAGE(@"buy_cell_btn_unSelBgImage") forState:UIControlStateNormal];
//        btn.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_Buy_Footer_BtnBack];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;

        [self addSubview:btn];
        btn.tag = i;//subModel.ID;
        [btn setTitle:subModel.name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:@"562209"] forState:UIControlStateNormal];

        btn.titleLabel.font = FONT(18);
        [btn addTarget:self action:@selector(skipToDetailVc:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)skipToDetailVc:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(skipToBPan:)]) {
        
        CrartHomeSubModel *subModel = self.model.lotterys[btn.tag];

        [self.delegate skipToBPan:subModel];
    }
}

- (IBAction)APan:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(skipToBPan:)]) {
        [self.delegate skipToBPan:sender];
    }
}
- (IBAction)BPan:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(skipToBPan:)]) {
        [self.delegate skipToBPan:sender];
    }
}

@end
