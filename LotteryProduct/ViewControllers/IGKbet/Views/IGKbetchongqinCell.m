//
//  IGKbetchongqinCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/26.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "IGKbetchongqinCell.h"

@interface IGKbetchongqinCell()

@property (weak, nonatomic) IBOutlet UIView *seperatorLine;


@end

@implementation IGKbetchongqinCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.seperatorLine.backgroundColor = [[CPTThemeConfig shareManager] OpenLotteryVC_SeperatorLineBackgroundColor];
    for (NSLayoutConstraint *rightconst in self.rights) {
        
        rightconst.constant = 10/SCAL;
    }
    
    for (UILabel *lbl in self.numberlabs) {
        lbl.font = BOLDFONT(14);
    }
    for (UILabel *lbl in self.numSubTitleLbls) {
        lbl.font = BOLDFONT(14);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
