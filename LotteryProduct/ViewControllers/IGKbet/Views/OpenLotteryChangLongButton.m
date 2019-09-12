//
//  OpenLotteryChangLongButton.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/7.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "OpenLotteryChangLongButton.h"

@interface OpenLotteryChangLongButton ()

@end

@implementation OpenLotteryChangLongButton

- (void)awakeFromNib{
    [super awakeFromNib];

    self.backgroundColor = [[CPTThemeConfig shareManager] ChangLongRightBtnBackgroundColor];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.width/SCAL, 20)];
    titleLbl.font = [UIFont systemFontOfSize:15/SCAL];
    titleLbl.textColor = [[CPTThemeConfig shareManager] ChangLongRightBtnTitleNormalColor];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.text = @"单";
    [self addSubview:titleLbl];
    self.titleLbl = titleLbl;
 
    UILabel *subTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLbl.frame), self.width/SCAL, 20)];
    subTitleLbl.font = [UIFont systemFontOfSize:11/SCAL];
    subTitleLbl.textColor = [[CPTThemeConfig shareManager] ChangLongRightBtnSubtitleNormalColor];
    subTitleLbl.textAlignment = NSTextAlignmentCenter;
    subTitleLbl.text = @"赔1.999";
    self.subTitleLbl = subTitleLbl;
    [self addSubview:subTitleLbl];
    
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.titleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnTitleSelectColor];
        self.backgroundColor = [[CPTThemeConfig shareManager] AoZhouMiddleBtnSelectBackgroundColor];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnSelectSubtitleColor];
    }else{
        self.titleLbl.textColor = [[CPTThemeConfig shareManager] ChangLongRightBtnTitleNormalColor];
        self.backgroundColor = [[CPTThemeConfig shareManager] ChangLongRightBtnBackgroundColor];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] ChangLongRightBtnSubtitleNormalColor];
        
        if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
            self.layer.borderColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.4].CGColor;
            self.layer.borderWidth = 1;
        }

    }
}

@end
