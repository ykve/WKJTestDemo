//
//  BpanLeftTableViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "BpanLeftTableViewCell.h"
#import "UIImage+color.h"

@implementation BpanLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleBtn.backgroundColor = MAINCOLOR;
    self.backgroundColor = [UIColor clearColor];

    [self.titleBtn setBackgroundImage:[UIImage imageWithColor:BASECOLOR size:self.titleBtn.size] forState:UIControlStateNormal];
    [self.titleBtn setBackgroundImage:[UIImage imageWithColor:MAINCOLOR size:self.titleBtn.size] forState:UIControlStateSelected];

    [self.titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleBtn setTitleColor:BASECOLOR forState:UIControlStateSelected];


}

@end
