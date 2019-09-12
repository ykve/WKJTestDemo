//
//  IGKbetPK10Cell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/26.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "IGKbetPK10Cell.h"

@interface IGKbetPK10Cell()

@property (weak, nonatomic) IBOutlet UIView *seperatorLine;


@end

@implementation IGKbetPK10Cell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.seperatorLine.backgroundColor = [[CPTThemeConfig shareManager] OpenLotteryVC_SeperatorLineBackgroundColor];
    
    self.nextimgv.image = IMAGE([[CPTThemeConfig shareManager] NextStepArrowImage]);
    for (NSLayoutConstraint *rightconst in self.rights) {
        rightconst.constant = 20/SCAL;
    }
    
    for (UILabel *lbl in self.numberLbls) {
        lbl.font = BOLDFONT(14);
    }
    for (UIButton *btn in self.numberBtns) {
        btn.titleLabel.font = BOLDFONT(14);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
