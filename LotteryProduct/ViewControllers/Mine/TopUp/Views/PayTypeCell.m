//
//  PayTypeCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/11.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PayTypeCell.h"

@implementation PayTypeCell

-(UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
    
}

-(UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(14) andTitleColor:[UIColor hexStringToColor:@"444444"] andBackgroundColor:CLEAR andTextAlignment:1];
//        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)maxMoneyLabel {
    
    if (!_maxMoneyLabel) {
        
        _maxMoneyLabel = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(11) andTitleColor:[UIColor colorWithHex:@"999999"] andBackgroundColor:CLEAR andTextAlignment:1];
        //        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _maxMoneyLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_maxMoneyLabel];
    }
    return _maxMoneyLabel;
}

-(UIView *)bgView {
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithHex:@"#FFF6DF"];
        _bgView.layer.borderWidth = 1;
        _bgView.layer.borderColor = [UIColor colorWithHex:@"#D69C58"].CGColor;
        _bgView.layer.cornerRadius = 5.0;
        [self addSubview:_bgView];
        _bgView.hidden = YES;
    }
    return _bgView;
}

-(UIImageView *)maskImageView {
    
    if (!_maskImageView) {
        
        _maskImageView = [[UIImageView alloc] init];
        _maskImageView.backgroundColor = [UIColor colorWithHex:@"#ECECEC" Withalpha:0.9];
        _maskImageView.layer.borderWidth = 1;
        _maskImageView.layer.borderColor = [UIColor colorWithHex:@"#DDDDDD"].CGColor;
        _maskImageView.layer.cornerRadius = 5.0;
        [self addSubview:_maskImageView];
        _maskImageView.hidden = YES;
    }
    return _maskImageView;
}

-(UILabel *)maskTitleLabel {
    
    if (!_maskTitleLabel) {
        _maskTitleLabel = [Tools createLableWithFrame:CGRectZero andTitle:@"单笔限额" andfont:FONT(14) andTitleColor:[UIColor hexStringToColor:@"333333"] andBackgroundColor:CLEAR andTextAlignment:1];
        [self.maskImageView addSubview:_maskTitleLabel];
    }
    return _maskTitleLabel;
}

-(UILabel *)maskMaxMinMoneyLabel {
    
    if (!_maskMaxMinMoneyLabel) {
        _maskMaxMinMoneyLabel = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(14) andTitleColor:[UIColor hexStringToColor:@"333333"] andBackgroundColor:CLEAR andTextAlignment:1];
        [self.maskImageView addSubview:_maskMaxMinMoneyLabel];
    }
    return _maskMaxMinMoneyLabel;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.centerX.equalTo(self);
        make.width.offset(45);
        make.height.offset(30);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.iconImageView.mas_bottom);
        make.height.offset(16);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(2);
        make.bottom.equalTo(self).offset(-5);
        make.right.equalTo(self).offset(-2);
    }];
    
    [self.maxMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(3);
        make.height.offset(12);
    }];
    
    [self.maskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(2);
        make.bottom.equalTo(self).offset(-5);
        make.right.equalTo(self).offset(-2);
    }];
    
    [self.maskTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.maskImageView.mas_centerX);
        make.top.equalTo(self.maskImageView.mas_top).offset(20);
    }];
    
    [self.maskMaxMinMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.maskImageView.mas_centerX);
        make.top.equalTo(self.maskTitleLabel.mas_bottom).offset(5);
    }];
}
@end
