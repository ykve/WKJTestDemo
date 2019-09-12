//
//  SixRecommendCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixRecommendCell.h"

@implementation SixRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)didClickZanBtn:(UIButton *)sender {
    
    [self.delegate clickZanBtn:sender];
}


@end
