//
//  HomesubHeader_3View.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomesubHeader_3View.h"

@interface HomesubHeader_3View()
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine2;


@end

@implementation HomesubHeader_3View

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_ViewBack2];//kColor(49, 50, 55);
    self.stopWatchLabel = [[WB_Stopwatch alloc]initWithLabel:self.timelab andTimerType:WBTypeTimer];
    
    self.topLine.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_line_ViewBack];
    self.bottomLine.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_line_ViewBack];
    self.seperatorLine.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_line_ViewBack];
    self.seperatorLine2.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_line_ViewBack];

    for (UILabel *lbl in self.numberlabs) {
//        lbl.layer.cornerRadius = lbl.size.height/2;
//        lbl.layer.masksToBounds = YES;
        lbl.font = BOLDFONT(15);
    }
    self.timelab.textColor = [[CPTThemeConfig shareManager] CO_Home_SubheaderTimeLblText];

    for (UILabel *lbl in self.numberTitleLabels) {
        lbl.textColor = [[CPTThemeConfig shareManager] CO_Home_SubHeaderTitleColor];
    }
    for (UILabel *lbl in self.numberSubLabels) {
        lbl.textColor = [[CPTThemeConfig shareManager] CO_Home_SubHeaderSubtitleColor];
    }
    self.versionlab.textColor = self.sellversionlab.textColor =self.releaseversionlab.textColor = self.timelab.textColor = [[CPTThemeConfig shareManager] KeyTitleColor];
    
    [self.stopWatchLabel setTimeFormat:@"HH:mm:ss"];
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        self.backgroundColor =  [UIColor hexStringToColor:@"E0E0E0"];
    }
}




@end
