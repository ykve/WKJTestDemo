//
//  CPTBuy_NNCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/3/29.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuy_NNCell.h"

@implementation CPTBuy_NNCell
{
    NSMutableArray *_btnArray;
    NSMutableArray *_selectArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btnArray = [NSMutableArray array];
    _selectArray = [NSMutableArray array];
    [_btnArray addObject:_btn1];
    [_btnArray addObject:_btn2];
    [_btnArray addObject:_btn3];
    [_btnArray addObject:_btn4];
    self.contentView.backgroundColor = [[CPTThemeConfig shareManager] Buy_fantanCellBgColor];
    self.backgroundColor = [[CPTThemeConfig shareManager] Buy_fantanCellBgColor];
    self.lineView.backgroundColor = [[CPTThemeConfig shareManager] NN_LinelColor];
    
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){

        for(UIButton *btn in self.btn1s){
            [btn setTitleColor:[UIColor hexStringToColor:@"999999"] forState:UIControlStateNormal];
            btn.borderWidth=0.5;
            btn.layer.cornerRadius = btn.frame.size.width/2;
            btn.borderColor = [UIColor hexStringToColor:@"333333"];
        }

    }
}
- (void)clearAllWithRandom:(BOOL)isRandom{
    if(isRandom){//机选
        [self clear];
        NSInteger index = random()%_btnArray.count;
        [_selectArray addObject:[NSString stringWithFormat:@"%ld",(long)index]];
        for (UIButton *btn in _btnArray) {
            for (NSString *sel in _selectArray) {
                if(sel.integerValue == btn.tag){
                    btn.selected = YES;
                }
            }
        }
    }else{//清空
        [self clear];
    }
    if(self.updateSelection){
        self.updateSelection(_selectArray);
    }
    
}
- (void)clear{
    for (UIButton *btn in _btnArray) {
        btn.selected = NO;
    }
    [_selectArray removeAllObjects];
    
}
- (IBAction)btnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSString *tag = [NSString stringWithFormat:@"%ld",sender.tag];
    if(sender.selected){
        if(![_selectArray containsObject:tag]){
            [_selectArray addObject:tag];
        }
    }else{
        if([_selectArray containsObject:tag]){
            [_selectArray removeObject:tag];
        }
    }
    if(self.updateSelection){
        self.updateSelection(_selectArray);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
