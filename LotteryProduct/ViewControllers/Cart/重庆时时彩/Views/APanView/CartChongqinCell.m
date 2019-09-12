//
//  CartChongqinCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/26.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartChongqinCell.h"

@implementation CartChongqinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.segment.selectedSegmentIndex = -1;
    [self.segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}forState:UIControlStateSelected];
    
    [self.segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}forState:UIControlStateNormal];
    
    [self.segment setDividerImage:[Tools createImageWithColor:[UIColor lightGrayColor] Withsize:CGSizeMake(1, 20)] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    for (NSLayoutConstraint *rightconst in self.rights) {
        
        rightconst.constant = 20/SCAL;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)segmentClick:(UISegmentedControl *)sender {
    
    if (self.segmentBlock) {
        
        self.segmentBlock(sender.selectedSegmentIndex);
    }
    if (sender.selectedSegmentIndex == 5) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.segment.selectedSegmentIndex = -1;
        });
        
    }
}

- (IBAction)numberClick:(UIButton *)sender {
    
    if (self.selectBlock) {
        
        self.selectBlock(sender.titleLabel.text);
    }
}

@end
