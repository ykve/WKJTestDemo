//
//  CPTBuyLeftButton.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuyLeftButton.h"

@implementation CPTBuyLeftButton

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
    _model = nil;
    _selectModels = nil;
}

- (void)configUI{
    if(!_selectModels){
        _selectModels = [NSMutableArray array];
    }
    _pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 9, 4, 20)];
//    _pointView.layer.cornerRadius = 5.;
    [self addSubview:_pointView];
    _pointView.backgroundColor = [UIColor redColor];//[[CPTThemeConfig shareManager] Buy_LeftView_Btn_PointUnSelC];
    _pointView.hidden = YES;
}

- (void)showUnSelPoint{
    _pointView.hidden = NO;
    _pointView.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_Btn_PointUnSelC];
}

- (void)showSelPoint{
    _pointView.hidden = NO;
    _pointView.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_Btn_PointSelC];
}

- (void)hiddenPoint{
    _pointView.hidden = YES;
}

- (BOOL)checkPointState{
    BOOL isSelect = NO;
    if(_selectModels && _selectModels.count>0){
//        _pointView.hidden = NO;
        isSelect = YES;
        _pointView.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_Btn_PointSelC];
        [[NSNotificationCenter defaultCenter] postNotificationName:OKFORBUY object:@(0)];
        
    }else{
        isSelect = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:OKFORBUY object:@(1)];
//        _pointView.hidden = NO;
        _pointView.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_Btn_PointUnSelC];
    }
    return isSelect;
}


- (void)clearSelectModels{
    if(_selectModels && _selectModels.count>0){
        [_selectModels removeAllObjects];
    }
    [self checkPointState];
}

//- (void)checkPointStateBuy{
//    if(_selectModels && _selectModels.count>0){
//        _pointView.hidden = NO;
//        _pointView.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_Btn_PointSelC];
//        [[NSNotificationCenter defaultCenter] postNotificationName:OKFORBUY object:@(0)];
//        
//    }else{
//        [[NSNotificationCenter defaultCenter] postNotificationName:OKFORBUY object:@(1)];
//        _pointView.hidden = YES;
//        _pointView.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_Btn_PointUnSelC];
//    }
//}

@end
