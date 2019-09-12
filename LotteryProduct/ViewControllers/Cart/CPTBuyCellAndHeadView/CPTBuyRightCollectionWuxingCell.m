//
//  CPTBuyRightCollectionWuxingCell.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/3/11.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuyRightCollectionWuxingCell.h"

@implementation CPTBuyRightCollectionWuxingCell


- (void)awakeFromNib {
    [super awakeFromNib];
//    self.backgroundColor = self.bcV.backgroundColor =[[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
    self.ballButton.backgroundColor =  self.bcV.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_BackgroundUnSel];
    self.ballButton.userInteractionEnabled = NO;
    self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_SubTitleCUnSel];
    
    if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
        self.backgroundColor = self.bcV.backgroundColor = CLEAR;
    }else{
        self.backgroundColor = self.bcV.backgroundColor =[[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
    }

}

- (void)configUIByModel:(CPTBuyBallModel *)model{
    
}
//kj_sixblue
- (void)setModel:(CPTBuyBallModel *)model{
    _model = model;
    self.ballButton.text = _model.title;
    self.subTitleLbl.text = model.subTitle;
    NSArray *tmpA = [_model.numbers componentsSeparatedByString:@","];
    NSInteger index =12-tmpA.count;
    
    for(NSInteger i=0;i<self.numberBtns.count;i++){
        UIButton * btn = self.numberBtns[i];
        btn.userInteractionEnabled = NO;
        if(i<=5){
            btn.titleLabel.text = tmpA[i];
            [btn setTitle:tmpA[i] forState:UIControlStateNormal];
            [btn setBackgroundImage:[Tools numbertoimage:tmpA[i] Withselect:NO] forState:UIControlStateNormal];
        }
        else if(i-5<=index){
            btn.hidden = YES;
        }else{
            btn.titleLabel.text = tmpA[i-index];
            [btn setTitle:tmpA[i-index] forState:UIControlStateNormal];
            [btn setBackgroundImage:[Tools numbertoimage:tmpA[i-index] Withselect:NO] forState:UIControlStateNormal];
        }
        
    }
    //    [self.ballButton setBackgroundImage:[Tools numbertoimage:self.model.title Withselect:self.model.selected] forState:UIControlStateNormal];
    if(_model.selected){
        self.ballButton.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_TitleCSel];
        self.ballButton.backgroundColor =  self.bcV.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_BackgroundSel];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_SubTitleCSel];
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            self.bcV.borderWidth = 0.;
            self.bcV.borderColor = WHITE;
        }

    }else{
        self.ballButton.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_TitleCUnSel];
        self.ballButton.backgroundColor =  self.bcV.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_BackgroundUnSel];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_SubTitleCUnSel];
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            self.bcV.borderWidth = 0.5;
            self.bcV.backgroundColor = [UIColor hexStringToColor:@"E9F4FF"];
            self.bcV.borderColor = [UIColor hexStringToColor:@"BEDEFF"];
        }
        self.bcV.backgroundColor = [[CPTThemeConfig shareManager] CO_BuyLot_Right_bcViewBack];
        self.bcV.borderColor = [[CPTThemeConfig shareManager] CO_BuyLot_Right_bcView_border];
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
    //    [self.ballButton setSelected:_isSelected];
    self.model.selected = _isSelected;
    if(_model.selected){
        self.ballButton.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_TitleCSel];
        self.ballButton.backgroundColor =  self.bcV.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_BackgroundSel];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_SubTitleCSel];
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            self.bcV.borderWidth = 0.;
            self.bcV.borderColor = WHITE;
        }

    }else{
        self.ballButton.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_TitleCUnSel];
        self.ballButton.backgroundColor =  self.bcV.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_BackgroundUnSel];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_SubTitleCUnSel];
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            self.bcV.borderWidth = 0.5;
            self.bcV.backgroundColor = [UIColor hexStringToColor:@"E9F4FF"];
            self.bcV.borderColor = [UIColor hexStringToColor:@"BEDEFF"];
        }
        self.bcV.backgroundColor = [[CPTThemeConfig shareManager] CO_BuyLot_Right_bcViewBack];
        self.bcV.borderColor = [[CPTThemeConfig shareManager] CO_BuyLot_Right_bcView_border];
    }

    
}

@end
