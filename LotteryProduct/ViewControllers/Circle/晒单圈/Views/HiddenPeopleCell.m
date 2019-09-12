//
//  HiddenPeopleCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HiddenPeopleCell.h"

@implementation HiddenPeopleCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)openClick:(UISwitch *)sender {
    
    if (self.onOffBlock) {
        
        self.onOffBlock(sender.on);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
