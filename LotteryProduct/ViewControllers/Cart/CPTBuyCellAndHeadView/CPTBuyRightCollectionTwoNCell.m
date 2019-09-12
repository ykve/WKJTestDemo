//
//  CPTBuyRightCollectionTwoNCell
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CPTBuyRightCollectionTwoNCell.h"

@interface CPTBuyRightCollectionTwoNCell ()



@end

@implementation CPTBuyRightCollectionTwoNCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.ballButton.userInteractionEnabled = NO;
    self.ballButton.backgroundColor =  self.bcV.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_BackgroundUnSel];
    self.ballButton.textColor = [[CPTThemeConfig shareManager] Buy_LeftView_Btn_TitleSelC];

    self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_SubTitleCUnSel];

    self.backgroundColor = self.bcV1.backgroundColor =[[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
    
    if([[AppDelegate shareapp] wkjScheme]== Scheme_LotterEight){
            self.backgroundColor = CLEAR;
            self.bcV.backgroundColor = [UIColor hexStringToColor:@"#FFF9EE"];
    }else{
        if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
            self.backgroundColor = CLEAR;
            self.bcV.backgroundColor = [UIColor hexStringToColor:@"E9F4FF"];
        }
    }
    [self.ballButton setFont:MFONT(17/SCAL)];
}

- (void)configUIByModel:(CPTBuyBallModel *)model{
    
}

- (void)setModel:(CPTBuyBallModel *)model{
    _model = model;
//    if(![model.subTitle isEqualToString:@"0"]){
        self.subTitleLbl.text = model.subTitle;
//    }
    self.ballButton.text = model.title;

    self.ballButton.textColor = [[CPTThemeConfig shareManager] Buy_LeftView_Btn_TitleSelC];

    if(_model.selected){
        self.ballButton.backgroundColor =  self.bcV.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_BackgroundSel];
        [self.ballButton setTextColor:[[CPTThemeConfig shareManager] Buy_CollectionCellButton_TitleCSel] ];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_SubTitleCSel];
    }else{
        self.ballButton.backgroundColor =  self.bcV.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_BackgroundUnSel];
        [self.ballButton setTextColor:[[CPTThemeConfig shareManager] Buy_CollectionCellButton_TitleCUnSel] ];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_SubTitleCUnSel];
        if([[AppDelegate shareapp] wkjScheme]== Scheme_LotterEight){
            self.bcV.borderWidth = 0.5;
            self.bcV.backgroundColor = [UIColor hexStringToColor:@"#FFF9EE"];
            self.bcV.borderColor = [UIColor hexStringToColor:@"#FF8610"];
        }else{
            if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
                self.bcV.borderWidth = 0.5;
                self.bcV.backgroundColor = [UIColor hexStringToColor:@"E9F4FF"];
                self.bcV.borderColor = [UIColor hexStringToColor:@"BEDEFF"];
            }
        }
    }
}

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
    }else{
        self.ballButton.backgroundColor =  self.bcV.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_BackgroundUnSel];
        [self.ballButton setTextColor:[[CPTThemeConfig shareManager] Buy_CollectionCellButton_TitleCUnSel]];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] Buy_CollectionCellButton_SubTitleCUnSel];
        
        if([[AppDelegate shareapp] wkjScheme]== Scheme_LotterEight){
                self.bcV.borderWidth = 0.5;
                self.bcV.backgroundColor = [UIColor hexStringToColor:@"#FFF9EE"];
                self.bcV.borderColor = [UIColor hexStringToColor:@"#FF8610"];
        }else{
            if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
                self.bcV.borderWidth = 0.5;
                self.bcV.backgroundColor = [UIColor hexStringToColor:@"E9F4FF"];
                self.bcV.borderColor = [UIColor hexStringToColor:@"BEDEFF"];
            }
        }

    }
}

@end
