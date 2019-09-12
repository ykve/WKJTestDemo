//
//  HistoryResultCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/8.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HistoryResultCell.h"

@implementation HistoryResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    for (NSLayoutConstraint *rightconst in self.rights) {
        
        rightconst.constant = 15/SCAL;
    }
    
    for (UIButton *btn in self.numberBtns) {
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0 );
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
