//
//  CPTBuyCollectionLonghuHeadView.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/3/8.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuyCollectionLonghuHeadView.h"

@implementation CPTBuyCollectionLonghuHeadView

-(void)awakeFromNib {
    
    [super awakeFromNib];
    self.titleLabel.textColor = [[CPTThemeConfig shareManager] Buy_CollectionHeadV_TitleC];
    
    if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
        self.backgroundColor = CLEAR;
        [self.longBtn setTitleColor:WHITE forState:UIControlStateNormal];
        [self.huBtn setTitleColor:WHITE forState:UIControlStateNormal];
        self.titleLabel.textColor  = [UIColor hexStringToColor:@"#333333"];

    } else{
        self.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
    }
}

- (IBAction)lookallClick:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:CPTSHOWINFO object:nil];
}


@end
