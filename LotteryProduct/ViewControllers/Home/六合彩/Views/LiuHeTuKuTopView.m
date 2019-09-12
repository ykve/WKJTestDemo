//
//  LiuHeTuKuTopView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/17.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiuHeTuKuTopView.h"
#import "UIImage+color.h"

@implementation LiuHeTuKuTopView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    UIButton *aaBtn = [[UIButton alloc] init];
    [aaBtn setTitle:@"上一期" forState:UIControlStateNormal];
    [aaBtn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    aaBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [aaBtn setTitleColor:[[CPTThemeConfig shareManager] LiuheTuKuOrangeColor] forState:UIControlStateNormal];
    aaBtn.backgroundColor = [UIColor clearColor];
    aaBtn.layer.borderWidth = 1.0;
    aaBtn.layer.borderColor = [[CPTThemeConfig shareManager] LiuheTuKuOrangeColor].CGColor;
    aaBtn.layer.cornerRadius = 3;
    aaBtn.tag = 100;
    [self addSubview:aaBtn];
    _preBtn = aaBtn;
    
    [aaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 22));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"-";
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleLabel];
    _titleLbl = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    UIButton *bbBtn = [[UIButton alloc] init];
    [bbBtn setTitle:@"上一期" forState:UIControlStateNormal];
    [bbBtn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bbBtn setTitleColor:[[CPTThemeConfig shareManager] LiuheTuKuOrangeColor] forState:UIControlStateNormal];
    bbBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    bbBtn.backgroundColor = [UIColor clearColor];
    bbBtn.layer.borderWidth = 1.0;
    bbBtn.layer.borderColor = [[CPTThemeConfig shareManager] LiuheTuKuOrangeColor].CGColor;
    bbBtn.layer.cornerRadius = 3;
    bbBtn.tag = 101;
    [self addSubview:bbBtn];
    _nextBtn = bbBtn;
    
    [bbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 22));
    }];
    
}


- (void)onBtnClick:(UIButton *)sender {//tag 100 上一期  200 下一期

    if ([self.delegate respondsToSelector:@selector(selectPerios:)]) {
        [self.delegate selectPerios:sender];
    }
}




@end
