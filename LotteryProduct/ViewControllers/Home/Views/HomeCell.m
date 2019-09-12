//
//  HomeCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell ()

@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (nonatomic, retain) UIView *myView1;

@end

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_CellContentView];

    self.sanjiaoImgView.image = [[CPTThemeConfig shareManager] IM_home_SanJiaoImage];
    self.sanjiaoImgView.hidden = YES;
    self.titlelab.textColor = [[CPTThemeConfig shareManager] CO_Home_VC_Cell_Titlelab_Text];
    self.subTitleLbl.textColor = [[CPTThemeConfig shareManager] CO_Home_VC_Cell_SubTitlelab_Text];
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

- (void)setIsHiddened:(BOOL)isHiddened
{
    _isHiddened = isHiddened;
    if (!_isHiddened) {
        [self addSubview:self.myView1];
        
        [self.myView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(8);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(13, 15));
        }];
        
    }else{
        
        [self.myView1 removeFromSuperview];
        
    }
}


- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (!isSelected) {
        self.sanjiaoImgView.hidden = NO;
    }else{
        self.sanjiaoImgView.hidden = YES;
    }
    
}

@end
