//
//  HomeCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "BuyLeftCell.h"

@interface BuyLeftCell ()


@property (weak, nonatomic) IBOutlet UIView *bottomLine;


@property (nonatomic, retain) UIView *myView1;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation BuyLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lineView.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_LineViewColor];
//    self.backView.backgroundColor = [[CPTThemeConfig shareManager] HomeViewBackgroundColor];
//    self.backView.backgroundColor = CLEAR;
//
//    self.titlelab.textColor = [[CPTThemeConfig shareManager] CO_Home_VC_Cell_Titlelab_Text];
//    if(!_isWorkView){
//        @weakify(self)
//        _isWorkView = [[UIView alloc] init];
//        [self.iconimgv addSubview:_isWorkView];
//        [_isWorkView mas_makeConstraints:^(MASConstraintMaker *make) {
//            @strongify(self)
//            make.left.top.bottom.right.equalTo(self.iconimgv);
//        }];
//        _isWorkView.backgroundColor = BLACK;
//        _isWorkView.alpha = 0.4;
//    }
//    _isWorkView.hidden = YES;
//
//    if(!_rBtn){
//        @weakify(self)
//        _rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.iconimgv addSubview:_rBtn];
//        [_rBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            @strongify(self)
//            make.top.right.equalTo(self.iconimgv);
//            make.width.height.offset(16);
//        }];
//    }
//    _rBtn.hidden = YES;
}

@end
