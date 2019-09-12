//
//  CartSixNumberCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartSixNumberCell.h"

@implementation CartSixNumberCell

-(UIButton *)numberBtn {
    
    if (!_numberBtn) {
        
        _numberBtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:YAHEI andBackgroundImage:nil andImage:IMAGE(@"") andTarget:self andAction:@selector(selectnumClick:) andType:UIButtonTypeCustom];
        [self addSubview:_numberBtn];
        _numberBtn.titleLabel.font = FONT(12);
        [_numberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-10);
        }];
    }
    return _numberBtn;
}

-(UILabel *)Oddslab {
    
    if (!_Oddslab) {
        
        _Oddslab = [Tools createLableWithFrame:CGRectZero andTitle:@"" andfont:FONT(10) andTitleColor:[UIColor lightGrayColor] andBackgroundColor:CLEAR andTextAlignment:1];
        [self addSubview:_Oddslab];
        [_Oddslab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self);
            make.top.equalTo(self.numberBtn.mas_bottom).offset(2);
        }];
    }
    
    return _Oddslab;
}

-(void)setTitle:(NSString *)title {
    
    [self.numberBtn setTitle:title forState:UIControlStateNormal];
    
    if (self.type == 1) {
    
        [self.numberBtn setBackgroundImage:[Tools numbertoimage:title Withselect:NO] forState:UIControlStateNormal];
        [self.numberBtn setBackgroundImage:[Tools numbertoimage:title Withselect:YES] forState:UIControlStateSelected];
        self.numberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
    }
    else {
        
        [self.numberBtn setBackgroundImage:IMAGE(@"cartbigunselect") forState:UIControlStateNormal];
        [self.numberBtn setBackgroundImage:IMAGE(@"cartbigselect") forState:UIControlStateSelected];
        self.numberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

-(void)selectnumClick:(UIButton *)sender {
    
    if (self.selectBlock) {
        
        self.selectBlock(sender);
    }
}


@end
