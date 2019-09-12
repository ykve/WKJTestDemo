//
//  CartChongqinTypeView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/31.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartChongqinTypeView.h"

@implementation CartChongqinTypeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(TagView *)playView {
    
    if (!_playView) {
        
        _playView = [[TagView alloc]initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 80, 0)];
        _playView.delegate = self;
        [self addSubview:_playView];
        
        UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:@"玩法" andfont:FONT(15) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
        [self addSubview:lab];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_playView).offset(20);
            make.left.equalTo(self);
            make.right.equalTo(_playView.mas_left);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self);
            make.bottom.equalTo(_playView);
            make.height.equalTo(@1);
        }];
    }
    return _playView;
}

-(TagView *)type1View {
    
    if (!_type1View) {
        
        _type1View = [[TagView alloc]initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 80, 0)];
        _type1View.delegate = self;
        [self addSubview:_type1View];
        
        _type1lab = [Tools createLableWithFrame:CGRectZero andTitle:@"直选" andfont:FONT(15) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
        [self addSubview:_type1lab];
        
        [_type1lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_type1View).offset(20);
            make.left.equalTo(self);
            make.right.equalTo(_type1View.mas_left);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self);
            make.bottom.equalTo(_type1View);
            make.height.equalTo(@1);
        }];
    }
    return _type1View;
}

-(TagView *)type2View {
    
    if (!_type2View) {
        
        _type2View = [[TagView alloc]initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 80, 0)];
        _type2View.delegate = self;
        [self addSubview:_type2View];
        
        _type2lab = [Tools createLableWithFrame:CGRectZero andTitle:@"组选" andfont:FONT(15) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
        [self addSubview:_type2lab];
        
        [_type2lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_type2View).offset(20);
            make.left.equalTo(self);
            make.right.equalTo(_type2View.mas_left);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self);
            make.bottom.equalTo(_type2View);
            make.height.equalTo(@1);
        }];
    }
    return _type2View;
}

-(UIView *)sureBtnView {
    
    if (!_sureBtnView) {
        
        _sureBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 85)];
        _sureBtnView.backgroundColor = WHITE;
        [self addSubview:_sureBtnView];
        
        UIButton *sureBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"确定" andTitleColor:WHITE andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(sureClick) andType:UIButtonTypeCustom];
        sureBtn.layer.cornerRadius = 5;
        sureBtn.backgroundColor = BUTTONCOLOR;
        [_sureBtnView addSubview:sureBtn];
        
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(_sureBtnView).with.insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
    }
    
    return _sureBtnView;
}

-(UIControl *)overlayView {
    
    if (!_overlayView) {
        
        _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, self.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _overlayView.backgroundColor = [UIColor blackColor];
        _overlayView.alpha = 0.3;
    }
    return _overlayView;
}

-(void)layoutSubviews {
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.playView.frame = CGRectMake(80, 0, SCREEN_WIDTH - 80, self.playView.bounds.size.height);
        
        self.type1View.frame = CGRectMake(80, self.playView.height, SCREEN_WIDTH - 80, self.type1View.bounds.size.height);
        
        self.type2View.frame = CGRectMake(80, self.type1View.y+self.type1View.height, SCREEN_WIDTH - 80, self.type2View.bounds.size.height);
        
        
        self.sureBtnView.frame = CGRectMake(0, self.type2View.y+self.type2View.height, SCREEN_WIDTH, 85);
        
        self.frame = CGRectMake(0, self.frame.origin.y, SCREEN_WIDTH, self.sureBtnView.y + self.sureBtnView.height);
    }];
    
}

@end
