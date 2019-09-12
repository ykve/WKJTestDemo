//
//  CPTBuyRightPaiLieCell.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/3/7.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuyRightPaiLieCell.h"

@implementation CPTBuyRightPaiLieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.ballButton.userInteractionEnabled = NO;
    self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] CO_Home_VC_Cell_SubTitlelab_Text];
    [self.ballButton setTitleColor: WHITE forState:UIControlStateNormal];
    //    [self.ballButton setTitleColor: [[CPTThemeConfig shareManager] Buy_RightBtn_Title_SelC] forState:UIControlStateSelected];
    [self.ballButton setTintColor:[[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC]];
    //    self.contentView.backgroundColor  = [UIColor yellowColor];
    if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
        self.backgroundColor = self.bcV.backgroundColor =self.selBCV.backgroundColor = self.ballButton.backgroundColor = CLEAR;
    }else{
        self.backgroundColor = self.bcV.backgroundColor =self.selBCV.backgroundColor = self.ballButton.backgroundColor =[[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
    }
}

- (void)configUIByModel:(CPTBuyBallModel *)model{
    
}

- (void)setModel:(CPTBuyBallModel *)model{
    _model = model;
    self.subTitleLbl.text = model.subTitle;
//    [self.ballButton setBackgroundImage:[Tools numbertoimage:self.model.title Withselect:self.model.selected] forState:UIControlStateNormal];
    [self.ballButton setBackgroundImage:IMAGE(@"color_red") forState:UIControlStateNormal];
    self.ballButton.titleLabel.text = model.title;
    [self.ballButton setTitle:model.title forState:UIControlStateNormal];
    [self.ballButton setSelected:model.selected];
    if(model.selected){
        self.selBCV.layer.borderWidth = 1;
        self.selBCV.layer.borderColor = [UIColor colorWithHex:@"ff5b10"].CGColor;
        self.selBCV.layer.cornerRadius = 12;
    }else{
        self.selBCV.layer.borderWidth = 0;
        self.selBCV.layer.borderColor = [UIColor colorWithHex:@"ff5b10"].CGColor;
        self.selBCV.layer.cornerRadius = 0;
    }
}

- (void)setIsHiddened:(BOOL)isHiddened
{
    //    _isHiddened = isHiddened;
    //    if (!_isHiddened) {
    //        [self addSubview:self.myView1];
    //
    //        [self.myView1 mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //            make.bottom.equalTo(self).offset(8);
    //            make.centerX.equalTo(self);
    //            make.size.mas_equalTo(CGSizeMake(13, 15));
    //        }];
    //
    //    }else{
    //
    //        [self.myView1 removeFromSuperview];
    //
    //    }
}


- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
//    [self.ballButton setBackgroundImage:[Tools numbertoimage:self.model.title Withselect:_isSelected] forState:UIControlStateNormal];
    [self.ballButton setSelected:_isSelected];
    self.model.selected = _isSelected;
    
    if (!isSelected) {
        self.selBCV.layer.borderWidth = 0;
        self.selBCV.layer.borderColor = [UIColor colorWithHex:@"ff5b10"].CGColor;
        self.selBCV.layer.cornerRadius = 0;
    }else{
        self.selBCV.layer.borderWidth = 1;
        self.selBCV.layer.borderColor = [UIColor colorWithHex:@"ff5b10"].CGColor;
        self.selBCV.layer.cornerRadius = 12;
    }
    
}
@end
