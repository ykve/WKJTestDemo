//
//  FormulaBottomView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "FormulaBottomView.h"

@implementation FormulaBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    CGFloat w = (SCREEN_WIDTH - 101 - 6)/6;
    self.accuracy_width.constant = 102 + w;
    self.current_width.constant = 102 + w;
    self.max_width.constant = 102 + w;
    
    for (UILabel *lbl in self.currentlabs) {
        lbl.textColor = [[CPTThemeConfig shareManager] CO_KillNumber_LabelText];
        lbl.backgroundColor = [[CPTThemeConfig shareManager] CO_KillNumber_LabelBack];
    }
    for (UILabel *lbl in self.accuracylabs) {
        lbl.textColor = [[CPTThemeConfig shareManager] CO_KillNumber_LabelText];
        lbl.backgroundColor = [[CPTThemeConfig shareManager] CO_KillNumber_LabelBack];
    }
    for (UILabel *lbl in self.maxlabs) {
        lbl.textColor = [[CPTThemeConfig shareManager] CO_KillNumber_LabelText];
        lbl.backgroundColor = [[CPTThemeConfig shareManager] CO_KillNumber_LabelBack];
    }
    for (UILabel *lbl in self.titleLbls) {
        lbl.textColor = [[CPTThemeConfig shareManager] CO_KillNumber_LabelText];
        lbl.backgroundColor = [[CPTThemeConfig shareManager] CO_KillNumber_LabelBack];
    }
}

@end
