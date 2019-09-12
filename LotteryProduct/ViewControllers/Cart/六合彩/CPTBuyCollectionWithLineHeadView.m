//
//  CPTBuyCollectionWithLineHeadView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CPTBuyCollectionWithLineHeadView.h"

@implementation CPTBuyCollectionWithLineHeadView

-(void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor  = [[CPTThemeConfig shareManager] Buy_CollectionHeadV_TitleC];
    self.lineView.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionViewLine_C];
    if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
        self.backgroundColor = CLEAR;
        self.titleLabel.textColor = [UIColor hexStringToColor:@"#333333"];

    }else{
        self.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
    }
}

@end
