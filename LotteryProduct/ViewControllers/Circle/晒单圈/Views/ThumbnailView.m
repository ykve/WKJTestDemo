//
//  ThumbnailView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/12.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ThumbnailView.h"

@implementation ThumbnailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIImageView *)iconimgv {
    
    if (!_iconimgv) {
        
        _iconimgv = [[UIImageView alloc]init];
        _iconimgv.contentMode = UIViewContentModeScaleAspectFill;
        _iconimgv.layer.masksToBounds = YES;
        [self addSubview:_iconimgv];
    }
    return _iconimgv;
}

-(UIButton *)delBtn {
    
    if (!_delBtn) {
        
        _delBtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE(@"发贴-图片删除") andTarget:self andAction:@selector(delAction) andType:UIButtonTypeCustom];
        [self addSubview:_delBtn];
    }
    return _delBtn;
}

-(void)delAction {
    
    if (self.delegate) {
        
        [self.delegate delegeimageWithindex:self.index With:self];
    }
}

-(void)layoutSubviews {
    
    [self.iconimgv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(5, 0, 0, 5));
    }];
    
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.top.equalTo(self);
    }];
}
@end
