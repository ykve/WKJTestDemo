//
//  CollectionBaseCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/6.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CollectionBaseCell.h"

@implementation CollectionBaseCell

-(UILabel *)titlelab {
    
    if (!_titlelab) {
        
        _titlelab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(14) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
        [self addSubview:_titlelab];
        
        
    }
    return _titlelab;
}

-(UIButton *)iconBtn {
    
    if (!_iconBtn) {
        
        _iconBtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:YAHEI andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(undo) andType:UIButtonTypeCustom];
        [_iconBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 5, 0)];
        [self addSubview:_iconBtn];
        
    }
    return _iconBtn;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:self.bounds];
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.userInteractionEnabled = NO;
        [_textView setContentInset:UIEdgeInsetsMake(-8, 0, 0, 0)];
        [self.contentView addSubview:_textView];
    }
    return _textView;
}

-(void)layoutSubviews {
    
    if (_titlelab) {
        
        [_titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 10, 0, 10));
        }];
    }
    
    if (_iconBtn) {
        
        [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (IS_IPHONEX) {
                
                make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
            }
            else{
                make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }
            
        }];
    }
    if (_textView) {
        
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
}

@end
