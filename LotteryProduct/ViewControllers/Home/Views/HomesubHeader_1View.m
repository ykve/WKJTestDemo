//
//  HomesubHeader_1View.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomesubHeader_1View.h"

@interface HomesubHeader_1View ()
@property (weak, nonatomic) IBOutlet UIView *topSeperatorLine;
@property (weak, nonatomic) IBOutlet UIView *bottomSperatorLine;
@property (weak, nonatomic) IBOutlet UIView *top1seperatorLine;
@property (weak, nonatomic) IBOutlet UIView *top2SeperatorLine;


@end

@implementation HomesubHeader_1View

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_ViewBack2];//kColor(49, 50, 55);
    self.stopWatchLabel = [[WB_Stopwatch alloc]initWithLabel:self.timelab andTimerType:WBTypeTimer];
    
    self.topSeperatorLine.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_line_ViewBack];
    self.bottomSperatorLine.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_line_ViewBack];
    
    self.top1seperatorLine.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_line_ViewBack];
    self.top2SeperatorLine.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_line_ViewBack];
    
    self.timelab.textColor = [[CPTThemeConfig shareManager] CO_Home_SubheaderTimeLblText];

         self.versionlab.textColor = self.sellversionlab.textColor =self.releaseversionlab.textColor = [[CPTThemeConfig shareManager] KeyTitleColor];

    
    for (UILabel *lbl in self.numberlabs) {
//        lbl.backgroundColor = [UIColor colorWithHex:@"c22122"];
        lbl.backgroundColor = [[CPTThemeConfig shareManager] CO_home_SubheaderBallBtnBack];
        lbl.font = BOLDFONT(15);
    }
    
    for (UILabel *lbl in self.numberTitleLabels) {
        lbl.textColor = [[CPTThemeConfig shareManager] CO_Home_SubHeaderTitleColor];
    }
    for (UILabel *lbl in self.numberSubLabels) {
        lbl.textColor = [[CPTThemeConfig shareManager] CO_Home_SubHeaderSubtitleColor];

    }
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        self.backgroundColor =  [UIColor hexStringToColor:@"E0E0E0"];
    }
    [self.stopWatchLabel setTimeFormat:@"HH:mm:ss"];
}

@end
