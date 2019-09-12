//
//  CartbeijinGYHCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/13.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartbeijinGYHCell.h"

@implementation CartbeijinGYHCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.numberLabels = [[NSMutableArray alloc]init];
    
    for (int i = 0; i< self.numberBtns.count; i++) {
        
        UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(11) andTitleColor:[UIColor colorWithHex:@"aaaaaa"] andBackgroundColor:CLEAR andTextAlignment:1];
        UIButton *btn = [self.numberBtns objectAtIndex:i];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        [btn addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(btn);
            make.left.equalTo(btn.titleLabel.mas_right).offset(4);
        }];
        
        [self.numberLabels addObject:lab];
    }
}

- (IBAction)numberClick:(UIButton *)sender {
    
    if (self.selectBlock) {
        
        self.selectBlock(sender);
    }
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
