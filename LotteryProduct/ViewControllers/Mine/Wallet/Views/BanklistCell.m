//
//  BanklistCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/10.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "BanklistCell.h"

@implementation BanklistCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(UIImageView *)backimgv {
    
    if (!_backimgv) {
        
        _backimgv = [[UIImageView alloc]init];
        [self addSubview:_backimgv];
    }
    
    return _backimgv;
}

-(UIImageView *)iconimgv {
    
    if (!_iconimgv) {
        
        _iconimgv = [[UIImageView alloc]init];
        [self addSubview:_iconimgv];
    }
    return _iconimgv;
}

-(UILabel *)banknamelab {
    
    if (!_banknamelab) {
        
        _banknamelab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(15) andTitleColor:LINECOLOR andBackgroundColor:CLEAR andTextAlignment:0];
        [self addSubview:_banknamelab];
    }
    return _banknamelab;
}

-(UILabel *)banktypelab {
    
    if (!_banktypelab) {
        
        _banktypelab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:[UIColor colorWithHex:@"D68B00" Withalpha:0.7] andBackgroundColor:CLEAR andTextAlignment:0];
        [self addSubview:_banktypelab];
    }
    return _banktypelab;
}

-(UILabel *)bankcardlab {
    
    if (!_bankcardlab) {
        
        _bankcardlab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(14) andTitleColor:LINECOLOR andBackgroundColor:CLEAR andTextAlignment:0];
        [self addSubview:_bankcardlab];
    }
    return _bankcardlab;
}



-(void)layoutSubviews {
    
    [self.backimgv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    
    [self.iconimgv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(20);
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.centerY.equalTo(self);
    }];
    
    [self.banknamelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.iconimgv);
        make.left.equalTo(self.iconimgv.mas_right).offset(10);
    }];
    
    [self.banktypelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.banknamelab.mas_right).offset(8);
        make.centerY.equalTo(self.banknamelab);
    }];
    
    [self.bankcardlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.banknamelab);
        make.top.equalTo(self.banknamelab.mas_bottom).offset(8);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
