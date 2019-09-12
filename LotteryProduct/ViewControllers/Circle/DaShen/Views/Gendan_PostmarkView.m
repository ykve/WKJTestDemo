//
//  Gendan_PostmarkView.m
//  LotteryProduct
//
//  Created by pt c on 2019/6/28.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "Gendan_PostmarkView.h"

@implementation Gendan_PostmarkView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = CLEAR;
        
    }
    return self;
}
- (void)setIsGendan:(NSInteger)isGendan{
    _isGendan = isGendan;
    _label.hidden = YES;
    if(_isGendan){
        _imgView.hidden = NO;
        _imgView.image = IMAGE(@"ygd");
    }else{
        _imgView.hidden = YES;
    }
}
- (void)setCode:(NSInteger)code{
    _code = code;
    self.label.transform = CGAffineTransformMakeRotation(-M_PI_4*0.35);
    
    switch (_code) {
        case 0://未中奖
        {
            self.label.hidden = YES;
            _imgView.image = IMAGE(@"wzj");
        }break;
        case 1://和
        {
            self.label.hidden = YES;
            _imgView.image = IMAGE(@"dahe");
        }break;
        case 2://已中奖
        {
            self.label.hidden = NO;
            _imgView.image = IMAGE(@"yzj_num");
        }break;
        default:{
//            _imgView.hidden = YES;
        }break;
    }
    
}
@end
