//
//  CPTBuyRightCollectionWeiShuCell
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CPTBuyRightCollectionWeiShuCell.h"

@interface CPTBuyRightCollectionWeiShuCell ()



@end

@implementation CPTBuyRightCollectionWeiShuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    

    self.ballButton.textColor = [[CPTThemeConfig shareManager] Buy_LeftView_Btn_TitleSelC];
    
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
    NSInteger index =5-tmpA.count;
 
    for(NSInteger i=0;i<self.numberBtns.count;i++){
        if(i>=index){
            UIButton * btn = self.numberBtns[i];
            btn.hidden = NO;
            btn.titleLabel.text = tmpA[i-index];
            [btn setTitle:tmpA[i-index] forState:UIControlStateNormal];
            [btn setBackgroundImage:[Tools numbertoimage:tmpA[i-index] Withselect:NO] forState:UIControlStateNormal];
        }else{
            UIButton * btn = self.numberBtns[i];
            btn.hidden = YES;
        }
    }
//    [self.ballButton setBackgroundImage:[Tools numbertoimage:self.model.title Withselect:self.model.selected] forState:UIControlStateNormal];
    if(_model.selected){
        self.ballButton.backgroundColor =  self.bcV.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_BackgroundSel];
        [self.ballButton setTextColor:[[CPTThemeConfig shareManager] Buy_CollectionCellButton_TitleCSel] ];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_SubTitleCSel];
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            self.bcV.borderWidth = 0.;
            self.bcV.borderColor = WHITE;
        }
    }else{
        self.ballButton.backgroundColor =  self.bcV.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_BackgroundUnSel];
        [self.ballButton setTextColor:[[CPTThemeConfig shareManager] Buy_CollectionCellButton_TitleCUnSel] ];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_SubTitleCUnSel];
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            self.bcV.borderWidth = 0.5;
            self.bcV.backgroundColor = [UIColor hexStringToColor:@"E9F4FF"];
            self.bcV.borderColor = [UIColor hexStringToColor:@"BEDEFF"];
        }
        self.bcV.backgroundColor = [[CPTThemeConfig shareManager] CO_BuyLot_Right_bcViewBack];
        self.bcV.borderColor = [[CPTThemeConfig shareManager] CO_BuyLot_Right_bcView_border];
    }}

- (void)setIsHiddened:(BOOL)isHiddened
{

}


- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    self.model.selected = _isSelected;
    if(_model.selected){
        self.ballButton.backgroundColor =  self.bcV.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_BackgroundSel];
        [self.ballButton setTextColor:[[CPTThemeConfig shareManager] Buy_CollectionCellButton_TitleCSel] ];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_SubTitleCSel];
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            self.bcV.borderWidth = 0.;
            self.bcV.borderColor = WHITE;
        }
    }else{
        self.ballButton.backgroundColor =  self.bcV.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_BackgroundUnSel];
        [self.ballButton setTextColor:[[CPTThemeConfig shareManager] Buy_CollectionCellButton_TitleCUnSel] ];
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
