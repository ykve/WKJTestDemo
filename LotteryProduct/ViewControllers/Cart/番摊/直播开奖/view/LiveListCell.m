//
//  LiveListCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/5/23.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiveListCell.h"

@implementation LiveListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _titleLab.backgroundColor = [[CPTThemeConfig shareManager] CO_LiveLot_CellLabelBack];
    _titleLab.textColor = [[CPTThemeConfig shareManager] CO_LiveLot_CellLabelText];
}
- (void)setDataWithModel:(LiveListModel *)model{
    if(model.type1Win.integerValue == 1){
        _img1.hidden = NO;
    }else{
        _img1.hidden = YES;
    }
    if(model.type2Win.integerValue == 1){
        _img2.hidden = NO;
    }else{
        _img2.hidden = YES;
    }
    if(model.type3Win.integerValue == 1){
        _img3.hidden = NO;
    }else{
        _img3.hidden = YES;
    }
    if(model.type4Win.integerValue == 1){
        _img4.hidden = NO;
    }else{
        _img4.hidden = YES;
    }
    if(model.type5Win.integerValue == 1){
        _img5.hidden = NO;
    }else{
        _img5.hidden = YES;
    }
    _lab1.text = model.type1Value;
    _lab2.text = model.type2Value;
    _lab3.text = model.type3Value;
    _lab4.text = model.type4Value;
    _lab5.text = model.type5Value;
    
    _titlelab1.text = model.type1;
    _titlelab2.text = model.type2;
    _titlelab3.text = model.type3;
    _titlelab4.text = model.type4;
    _titlelab5.text = model.type5;
    
    _titleLab.text = [NSString stringWithFormat:@"第%@期推荐",model.issue];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
