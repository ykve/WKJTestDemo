//
//  LiuHeTuKuLeftTableViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/17.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiuHeTuKuLeftTableViewCell.h"

@interface LiuHeTuKuLeftTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *seperatorLine;


@end

@implementation LiuHeTuKuLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.seperatorLine.backgroundColor = [[CPTThemeConfig shareManager] LiuheTuKuLeftTableViewSeperatorLineColor];
    self.leftLine.backgroundColor = [[CPTThemeConfig shareManager] LiuheTuKuTextRedColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (!isSelected) {
        
        self.leftLine.hidden = YES;
        self.titleLbl.textColor = [[CPTThemeConfig shareManager] grayColor666];
    }else{
        
        self.leftLine.hidden = NO;
        self.titleLbl.textColor = [[CPTThemeConfig shareManager] LiuheTuKuTextRedColor];
        
    }
    
}

@end
