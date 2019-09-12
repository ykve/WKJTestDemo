//
//  HomeCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "FavoriteCell.h"

@interface FavoriteCell ()


@property (weak, nonatomic) IBOutlet UIView *bottomLine;


@property (nonatomic, retain) UIView *myView1;

@end

@implementation FavoriteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.backView.backgroundColor = [[CPTThemeConfig shareManager] HomeViewBackgroundColor];
    self.backView.backgroundColor = CLEAR;

    self.titlelab.textColor = [[CPTThemeConfig shareManager] CO_Home_VC_Cell_Titlelab_Text];
    if(!_isWorkView){
        @weakify(self)
        _isWorkView = [[UIView alloc] init];
        [self.iconimgv addSubview:_isWorkView];
        [_isWorkView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.top.bottom.right.equalTo(self.iconimgv);
        }];
        [_isWorkView setCornerRadius:25];
        _isWorkView.backgroundColor = BLACK;
        _isWorkView.alpha = 0.4;
    }
    _isWorkView.hidden = YES;
    

}

@end
