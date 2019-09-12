//
//  CQDouniuTableViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/29.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CQDouniuTableViewCell.h"

@interface CQDouniuTableViewCell ()

@property (nonatomic, strong) NSMutableArray *selectTotalDouNiuLabelArray;


@end

@implementation CQDouniuTableViewCell

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
    
    for (UILabel *lbl in self.ballLabels) {
        lbl.font = [UIFont systemFontOfSize:16];
        lbl.textColor = [UIColor whiteColor];
    }
    
}

- (IBAction)selectBalls:(UIButton *)sender {
    
    sender.selected = sender.selected ? NO : YES;
    
    if (sender.selected) {
        
        for (UILabel *lbl in self.ballLabels) {
            if (lbl.tag == sender.tag) {
                [self.selectTotalDouNiuLabelArray addObject:lbl];
            }
        }
        
        sender.backgroundColor = [UIColor colorWithHex:@"9C2D33"];
        
    }else{
        
        for (UILabel *lbl in self.ballLabels) {
            if (lbl.tag == sender.tag) {
                [self.selectTotalDouNiuLabelArray removeObject:lbl];
            }
        }
        
        sender.backgroundColor = [UIColor colorWithHex:@"2C3036"];
        
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"douNiuSelectTotalDragnBall" object:self.selectTotalDouNiuLabelArray];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (NSMutableArray *)selectTotalDouNiuLabelArray{
    if (!_selectTotalDouNiuLabelArray) {
        _selectTotalDouNiuLabelArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectTotalDouNiuLabelArray;
}

@end
