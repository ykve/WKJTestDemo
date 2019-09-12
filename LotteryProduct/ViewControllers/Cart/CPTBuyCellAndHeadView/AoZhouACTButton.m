//
//  AoZhouACTButton.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "AoZhouACTButton.h"
#import "UIImage+color.h"

@interface AoZhouACTButton ()



@end

@implementation AoZhouACTButton


- (void)setModel:(CPTBuyBallModel *)model{
    _model = model;
    
    if (model.selected) {
        self.titleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnTitleSelectColor];
        self.backgroundColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnSelectBackgroundColor];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnSelectSubtitleColor];

    }
}

- (void)awakeFromNib{
    [super awakeFromNib];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.height - 30)/2, (self.width/2)/SCAL - 5/SCAL, 30)];
    titleLbl.font = [UIFont systemFontOfSize:16/SCAL];
    titleLbl.textColor = [UIColor whiteColor];
    titleLbl.textAlignment = NSTextAlignmentRight;
    [self addSubview:titleLbl];
    self.titleLbl = titleLbl;
    
    UILabel *subTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake((self.width/2)/SCAL, titleLbl.y, (self.width/2)/SCAL, titleLbl.height)];
    subTitleLbl.font = [UIFont systemFontOfSize:13/SCAL];
    subTitleLbl.textColor = [UIColor lightGrayColor];
    subTitleLbl.textAlignment = NSTextAlignmentLeft;

    self.subTitleLbl = subTitleLbl;
    [self addSubview:subTitleLbl];
    self.titleLbl.text = self.model.title;
    self.subTitleLbl.text = self.model.subTitle;

    if (self.model.selected) {
        self.titleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnTitleSelectColor];
        self.backgroundColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnSelectBackgroundColor];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnSelectSubtitleColor];
        
    }else{

        self.titleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnTitleNormalColor];
        self.backgroundColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnNormalBackgroundColor];
        self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnNormalSubtitleColor];
  
    }
    if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        self.borderWidth= 0.5;
        self.borderColor = [UIColor hexStringToColor:@"BEDEFF"];
    }
}

- (void)setIsselected:(BOOL)isselected{
    _isselected = isselected;

}


@end
