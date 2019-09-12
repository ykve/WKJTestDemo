//
//  IGKbetSixCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/26.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "IGKbetSixCell.h"

@interface IGKbetSixCell()
@property (weak, nonatomic) IBOutlet UIView *bottonLine;

@end

@implementation IGKbetSixCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bottonLine.backgroundColor = [[CPTThemeConfig shareManager] OpenLotteryVC_SeperatorLineBackgroundColor];
    for (NSLayoutConstraint *rightconst in self.rights) {
        
        rightconst.constant = 20/SCAL;
    }
    
    for (UILabel *lbl in self.numberlabs) {
        lbl.font = BOLDFONT(14);
        lbl.textColor = [[CPTThemeConfig shareManager] SixOpenHeaderSubtitleTextColor];

    }
    for (UIButton *btn in self.numberBtns) {
        btn.titleLabel.font = BOLDFONT(14);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
