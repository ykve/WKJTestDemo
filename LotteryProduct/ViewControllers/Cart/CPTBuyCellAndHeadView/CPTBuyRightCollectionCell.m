//
//  CPTBuyRightCollectionCell
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CPTBuyRightCollectionCell.h"

@interface CPTBuyRightCollectionCell ()



@end

@implementation CPTBuyRightCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.ballButton.userInteractionEnabled = NO;
//    self.backgroundColor = self.bcV.backgroundColor =self.selBCV.backgroundColor  =[[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
    self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] CO_Home_VC_Cell_SubTitlelab_Text];
    [self.ballButton setTitleColor: [[CPTThemeConfig shareManager] Buy_RightBtn_Title_UnSelC] forState:UIControlStateNormal];
//    [self.ballButton setTitleColor: [[CPTThemeConfig shareManager] Buy_RightBtn_Title_SelC] forState:UIControlStateSelected];
    [self.ballButton setTintColor:[[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC]];
//    self.contentView.backgroundColor  = [UIColor yellowColor];
    self.ballButton.backgroundColor = CLEAR;
    if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
        self.backgroundColor = self.bcV.backgroundColor =self.selBCV.backgroundColor  = CLEAR;
        self.subTitleLbl.textColor = [UIColor colorWithHex:@"0E2B20"];
    }else{
        self.backgroundColor = self.bcV.backgroundColor =self.selBCV.backgroundColor  =[[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
    }
}

- (void)configUIByModel:(CPTBuyBallModel *)model{
    
}

- (void)setModel:(CPTBuyBallModel *)model{
    _model = model;
    self.subTitleLbl.text = model.subTitle;
    [self.ballButton setTitle:model.title forState:UIControlStateNormal];
    [self.ballButton setSelected:model.selected];
    if(model.selected){
        self.selBCV.layer.borderWidth = 1.5;
        if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
            self.selBCV.layer.borderColor = [UIColor colorWithHex:@"FF8610"].CGColor;
        }else{
            self.selBCV.layer.borderColor = [UIColor colorWithHex:@"ff5b10"].CGColor;
        }
        self.selBCV.layer.cornerRadius = 12;
        
        [self.ballButton setBackgroundImage:[Tools sixnumberSelectimage:self.model.title ] forState:UIControlStateNormal];
        [self.ballButton setTitleColor: WHITE forState:UIControlStateNormal];
        [self.ballButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.ballButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(35);
        }];

    }else{
        [self.ballButton setBackgroundImage:[Tools numbertoimage:self.model.title Withselect:self.model.selected] forState:UIControlStateNormal];
        self.selBCV.layer.borderWidth = 0;
        self.selBCV.layer.borderColor = [[CPTThemeConfig shareManager] CO_NavigationBar_TintColor].CGColor;
        self.selBCV.layer.cornerRadius = 0;
        [self.ballButton setTitleColor: [[CPTThemeConfig shareManager] Buy_RightBtn_Title_UnSelC] forState:UIControlStateNormal];
        [self.ballButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        [self.ballButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(40);
        }];
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
    [self.ballButton setBackgroundImage:[Tools numbertoimage:self.model.title Withselect:_isSelected] forState:UIControlStateNormal];
    [self.ballButton setSelected:_isSelected];
    self.model.selected = _isSelected;

    if (!isSelected) {
        self.selBCV.layer.borderWidth = 0;
        self.selBCV.layer.borderColor = BASECOLOR.CGColor;;//[UIColor colorWithHex:@"ff5b10"].CGColor;
        self.selBCV.layer.cornerRadius = 0;
        [self.ballButton setBackgroundImage:[Tools numbertoimage:self.model.title Withselect:_isSelected] forState:UIControlStateNormal];
        [self.ballButton setTitleColor: [[CPTThemeConfig shareManager] Buy_RightBtn_Title_UnSelC] forState:UIControlStateNormal];
        [self.ballButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        [self.ballButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(40);
        }];
    }else{
        [self.ballButton setBackgroundImage:[Tools sixnumberSelectimage:self.model.title ] forState:UIControlStateNormal];
        [self.ballButton setTitleColor: WHITE forState:UIControlStateNormal];
        [self.ballButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

            self.selBCV.layer.borderWidth = 1.5;
            self.selBCV.layer.cornerRadius = 12;
        if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
            self.selBCV.layer.borderColor = [UIColor colorWithHex:@"FF8610"].CGColor;//[UIColor colorWithHex:@"ff5b10"].CGColor;
        }else{
            self.selBCV.layer.borderColor = [UIColor colorWithHex:@"ff5b10"].CGColor;
        }
        [self.ballButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(35);
        }];
    }
    
}

@end
