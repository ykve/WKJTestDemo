//
//  HomesubHeader_2View.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomesubHeader_2View.h"

@interface HomesubHeader_2View()
@property (weak, nonatomic) IBOutlet UIView *topSeperatorLine;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;

@end

@implementation HomesubHeader_2View

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_ViewBack2];
    
    self.topSeperatorLine.backgroundColor = self.seperatorLine.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_line_ViewBack];
    
    self.timelab.textColor = [[CPTThemeConfig shareManager] CO_Home_SubheaderTimeLblText];
    
    for (UILabel *lbl in self.numberTitleLabels) {
        lbl.textColor = [[CPTThemeConfig shareManager] CO_Home_SubHeaderTitleColor];
    }
    for (UILabel *lbl in self.numberSubLabels) {
        lbl.textColor = [[CPTThemeConfig shareManager] CO_Home_SubHeaderSubtitleColor];
    }
    
    for (UIButton *btn in self.numberBtns) {
        btn.titleLabel.font = BOLDFONT(15);
    }
    
    for (UILabel *lbl in self.numberlabs) {

        lbl.textColor = [[CPTThemeConfig shareManager] CO_Home_SubheaderLHCSubtitleText];
        lbl.font = BOLDFONT(14);

    }
    self.addlab.textColor = self.versionlab.textColor = self.timelab.textColor = [[CPTThemeConfig shareManager] CO_Home_SubheaderLHCSubtitleText];
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        self.backgroundColor =  [UIColor hexStringToColor:@"E0E0E0"];
    }
}

@end
