//
//  CPTBuy_FantanCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/3/7.
//  Copyright © 2019年 vsskyblue. All rights reserved.
//

#import "CPTBuy_FantanCell.h"
#import "Fantan_Button.h"
#import "Fantan_OddModel.h"
@implementation CPTBuy_FantanCell
{
    NSMutableArray *_selectedArray;
    NSMutableArray *_allBtnArray;
    NSMutableArray *_allLabs;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _selectedArray = [NSMutableArray array];
    _allBtnArray = [NSMutableArray array];
    _allLabs = [NSMutableArray array];
    [_allLabs addObject:_lab0];
    [_allLabs addObject:_lab1];
    [_allLabs addObject:_lab2];
    [_allLabs addObject:_lab3];
    [_allLabs addObject:_lab4];
    [_allLabs addObject:_lab5];
    [_allLabs addObject:_lab6];
    [_allLabs addObject:_lab7];
    [_allLabs addObject:_lab8];
    [_allLabs addObject:_lab9];
    [_allLabs addObject:_lab10];
    [_allLabs addObject:_lab11];
    [_allLabs addObject:_lab12];
    [_allLabs addObject:_lab13];
    [_allLabs addObject:_lab14];
    [_allLabs addObject:_lab15];
    [_allLabs addObject:_lab16];
    [_allLabs addObject:_lab17];
    [_allLabs addObject:_lab18];
    [_allLabs addObject:_lab19];
    [_allLabs addObject:_lab20];
    [_allLabs addObject:_lab21];
    [_allLabs addObject:_lab22];
    [_allLabs addObject:_lab23];
    [_allLabs addObject:_lab24];
    [_allLabs addObject:_lab25];
    [_selectedArray removeAllObjects];
    [_allBtnArray removeAllObjects];
    for (UIView *sView in _bigSquareView.subviews) {
        if([sView isKindOfClass:[UIStackView class]]){
            UIStackView *stView = (UIStackView *)sView;
            for (UIView *view in stView.arrangedSubviews) {
                for (UIView *view1 in view.subviews) {
                    if([view1 isKindOfClass:[Fantan_Button class]]){
                        [_allBtnArray addObject:(Fantan_Button *)view1];
                    }
                }
            }
        }else{
            for (UIView *centerView in sView.subviews) {
                if([centerView isKindOfClass:[UIStackView class]]){
                    UIStackView *centerStackView = (UIStackView *)centerView;
                    for (UIView *v2 in centerStackView.arrangedSubviews) {
                        for (UIView *v3 in v2.subviews) {
                            if([v3 isKindOfClass:[Fantan_Button class]]){
                                [_allBtnArray addObject:(Fantan_Button *)v3];
                            }
                        }
                    }
                }else{
                    for (UIView *v4 in centerView.subviews) {
                        if([v4 isKindOfClass:[Fantan_Button class]]){
                            [_allBtnArray addObject:(Fantan_Button *)v4];
                        }
                    }
                }
            }
        }
    }
    MBLog(@"%ld",_allBtnArray.count);
    for (Fantan_Button *btn in _allBtnArray) {
        MBLog(@"%ld",btn.tag);
    }
    self.contentView.backgroundColor = [[CPTThemeConfig shareManager] Buy_fantanCellBgColor];
    self.backgroundColor = [[CPTThemeConfig shareManager] Buy_fantanCellBgColor];
    self.iconImgView.backgroundColor = [[CPTThemeConfig shareManager] Fantan_iconColor];
//    sKinThemeType sKinThemeType = [[AppDelegate shareapp] sKinThemeType];
//    if(sKinThemeType == SKinType_Theme_Dark){//
//        self.backgroundColor =
//    }else if (sKinThemeType == SKinType_Theme_White){
//
//    }

}
- (void)clear{
    for (Fantan_Button *btn in _allBtnArray) {
        btn.selected = NO;
    }
    [_selectedArray removeAllObjects];
    
}
- (void)clearAllWithRandom:(BOOL)isRandom{
    if(isRandom){//机选
        [self clear];
        NSInteger index = random()%25;
        [_selectedArray addObject:[NSString stringWithFormat:@"%ld",(long)index]];
        for (Fantan_Button *btn in _allBtnArray) {
            for (NSString *sel in _selectedArray) {
                if(sel.integerValue == btn.tag){
                    btn.selected = YES;
                }
            }
        }
    }else{//清空
        [self clear];
    }
    if(self.updateSelectedArray){
        self.updateSelectedArray(_selectedArray);
    }
   
}
- (IBAction)selectPlay:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.selected == YES){
        [_selectedArray addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }else{
        [_selectedArray removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }
    if(self.updateSelectedArray){
        self.updateSelectedArray(_selectedArray);
    }
    
}
- (void)setODDsWithArray:(NSMutableArray *)array{
    for(int i = 0; i < array.count; i++){
        Fantan_OddModel *model = array[i];
        UILabel *lab = _allLabs[i];
        lab.text = model.odds;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
