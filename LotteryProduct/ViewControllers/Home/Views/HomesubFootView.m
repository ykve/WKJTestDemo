//
//  HomesubFootView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomesubFootView.h"

@implementation HomesubFootView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor =  [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_ViewBack2];//kColor(49, 50, 55);
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
       self.backgroundColor =  [UIColor hexStringToColor:@"F0F0F0"];
    }
}
- (IBAction)checkmoreClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (self.showallBlock) {
        
        self.showallBlock(sender.selected);
    }
}

@end
