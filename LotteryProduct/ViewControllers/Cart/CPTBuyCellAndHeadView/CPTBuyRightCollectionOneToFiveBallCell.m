//
//  CPTBuyRightCollectionOneToFiveBallCell.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/3/11.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuyRightCollectionOneToFiveBallCell.h"

@implementation CPTBuyRightCollectionOneToFiveBallCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.ballButton.userInteractionEnabled = NO;
    [self.ballButton setTitleColor: [[CPTThemeConfig shareManager] Buy_RightBtn_Title_UnSelC] forState:UIControlStateNormal];
    //    [self.ballButton setTitleColor: [[CPTThemeConfig shareManager] Buy_RightBtn_Title_SelC] forState:UIControlStateSelected];
    [self.ballButton setTintColor:[[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC]];
    //    self.contentView.backgroundColor  = [UIColor yellowColor];
    if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
        self.backgroundColor = self.bcV.backgroundColor =self.selBCV.backgroundColor = self.ballButton.backgroundColor = CLEAR;
        self.subTitleLbl.textColor = [UIColor colorWithHex:@"0E2B20"];
    }else{
        self.backgroundColor = self.bcV.backgroundColor =self.selBCV.backgroundColor = self.ballButton.backgroundColor =[[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] CO_Home_VC_Cell_SubTitlelab_Text];

    }

}

- (void)configUIByModel:(CPTBuyBallModel *)model{
    
}

- (void)setModel:(CPTBuyBallModel *)model{
    _model = model;
    self.subTitleLbl.text = model.subTitle;
    [self.ballButton setBackgroundImage:[Tools numbertoimage:self.model.title Withselect:self.model.selected] forState:UIControlStateNormal];
    self.ballButton.titleLabel.text = model.title;
    [self.ballButton setTitle:model.title forState:UIControlStateNormal];
    [self.ballButton setSelected:model.selected];
    if(model.selected){
        [self.ballButton setTitleColor: WHITE forState:UIControlStateNormal];
        [self.ballButton setBackgroundImage:IMAGE(@"buy_zc_ball2_red") forState:UIControlStateNormal];
    }else{
        [self.ballButton setTitleColor: BLACK forState:UIControlStateNormal];
        [self.ballButton setBackgroundImage:IMAGE(@"buy_zc_ball2_white") forState:UIControlStateNormal];
    }
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    [self.ballButton setBackgroundImage:[Tools numbertoimage:self.model.title Withselect:_isSelected] forState:UIControlStateNormal];
    [self.ballButton setSelected:_isSelected];
    self.model.selected = _isSelected;
    if(isSelected){
        [self.ballButton setTitleColor: WHITE forState:UIControlStateNormal];
        [self.ballButton setBackgroundImage:IMAGE(@"buy_zc_ball2_red") forState:UIControlStateNormal];
    }else{
        [self.ballButton setTitleColor: BLACK forState:UIControlStateNormal];
        [self.ballButton setBackgroundImage:IMAGE(@"buy_zc_ball2_white") forState:UIControlStateNormal];
    }
}

@end
