//
//  MineMessageCell.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/3/3.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "MineMessageCell.h"

@interface MineMessageCell()


@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation MineMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timelab.textColor = [UIColor colorWithHex:@"C48936"];
    self.timelab.font = [UIFont systemFontOfSize:13];
    self.contentlab.font = [UIFont systemFontOfSize:13];
    self.titlelab.font = [UIFont boldSystemFontOfSize:13];
    
    self.titlelab.textColor = [[CPTThemeConfig shareManager] CO_Home_Gonggao_TopTitleText];
    self.topBackView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_Gonggao_Cell_MessageTopViewBack];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.icon.image = IMAGE([[CPTThemeConfig shareManager] messageIconName]);
    self.seperatorLine.backgroundColor = [UIColor lightGrayColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
