//
//  SQMenuShowCell.m
//  JHTDoctor
//
//  Created by yangsq on 16/9/22.
//  Copyright © 2016年 yangsq. All rights reserved.
//

#import "SQMenuShowCell.h"

@implementation SQMenuShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.missswitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
}

- (IBAction)missClick:(UISwitch *)sender {
    
    if (self.delegate) {
        
        [self.delegate showmiss:sender.on];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
