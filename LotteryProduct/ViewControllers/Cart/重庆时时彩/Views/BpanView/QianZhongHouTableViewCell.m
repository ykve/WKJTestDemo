//
//  QianZhongHouTableViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/15.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "QianZhongHouTableViewCell.h"

@interface QianZhongHouTableViewCell()

@property (nonatomic, strong) NSMutableArray *selectQianZhongHouLabelArray;


@end

@implementation QianZhongHouTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UIButton *btn in self.numberBtns) {
        
        btn.backgroundColor = [UIColor colorWithHex:@"2C3036"];
        btn.tintColor = [UIColor clearColor];
        
    }
    
    for (UILabel *lbl in self.peiLvLabels) {
        lbl.font = [UIFont systemFontOfSize:14];
        lbl.textColor = [UIColor lightGrayColor];
    }
    
    for (UILabel *lbl in self.numberBallLabels) {
        lbl.font = [UIFont systemFontOfSize:16];
        lbl.textColor = [UIColor whiteColor];
    }
    
}
- (IBAction)seleBalls:(UIButton *)sender {
    
    sender.selected = sender.selected ? NO : YES;
    
    if (sender.selected) {
        
        sender.backgroundColor = [UIColor colorWithHex:@"9C2D33"];
        
        for (UILabel *lbl in self.numberBallLabels) {
            if (lbl.tag == sender.tag) {
                [self.selectQianZhongHouLabelArray addObject:lbl];
            }
        }
        
    }else{
        
        for (UILabel *lbl in self.numberBallLabels) {
            if (lbl.tag == sender.tag) {
                [self.selectQianZhongHouLabelArray removeObject:lbl];
            }
        }
        
        sender.backgroundColor = [UIColor colorWithHex:@"2C3036"];
        
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"qianZhongHouSelectOtherBall" object:self.selectQianZhongHouLabelArray];
}



- (NSMutableArray *)selectQianZhongHouLabelArray{
    if (!_selectQianZhongHouLabelArray) {
        _selectQianZhongHouLabelArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectQianZhongHouLabelArray;
}
@end
