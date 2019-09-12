//
//  CartHomeCollectionViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/12.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CartHomeCollectionViewCell.h"

@interface CartHomeCollectionViewCell()

@end

@implementation CartHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.stopwatch = [[WB_Stopwatch alloc]initWithLabel:self.timelab andTimerType:WBTypeTimer];
    [self.stopwatch setTimeFormat:@"HH:mm:ss"];
    self.timelab.hidden = YES;
    self.seperatorLine.backgroundColor = [UIColor clearColor];
    self.sanjiaoImageView.hidden = YES;

}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (!isSelected) {

        self.sanjiaoImageView.hidden = YES;

    }else{

        self.sanjiaoImageView.hidden = NO;

    }
    
}

@end
