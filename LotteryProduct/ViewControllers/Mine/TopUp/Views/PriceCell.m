//
//  PriceCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/11.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PriceCell.h"

@implementation PriceCell

-(UILabel *)pricelab {
    
    if (!_pricelab) {
        
        _pricelab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(14) andTitleColor:BASECOLOR andBackgroundColor:WHITE andTextAlignment:1];
        _pricelab.layer.cornerRadius = 3;
        _pricelab.layer.borderColor = BASECOLOR.CGColor;
        _pricelab.layer.borderWidth = 0.5;
        _pricelab.layer.masksToBounds = YES;
        [self addSubview:_pricelab];
    }
    return _pricelab;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_pricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
    }];
}
@end
