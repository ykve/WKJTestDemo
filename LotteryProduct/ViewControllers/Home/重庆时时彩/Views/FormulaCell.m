//
//  FormulaCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/6.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "FormulaCell.h"

@implementation FormulaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIssixtype:(NSInteger)issixtype {
    
    _issixtype = issixtype;
    
    if (issixtype == 1) {
        
        self.sixnumber.hidden = NO;
        self.versionlab_width.constant = 30;
        self.sixnumber.adjustsFontSizeToFitWidth = YES;
    }
    else if (issixtype == 2) {
        
        self.sixnumber.hidden = YES;
        self.timelab.hidden = YES;
        self.timelab_width.constant = 0;
        self.versionlab_width.constant = 45+55;
    }
}

@end
