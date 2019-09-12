//
//  DoubleSideHeaderView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/15.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "DoubleSideHeaderView.h"

@implementation DoubleSideHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.titleLbl.font = [UIFont systemFontOfSize:18];
    self.titleLbl.textColor = [UIColor colorWithHex:@"f6d79e"];
}

@end
