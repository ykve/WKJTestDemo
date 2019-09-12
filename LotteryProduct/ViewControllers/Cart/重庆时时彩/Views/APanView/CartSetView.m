//
//  CartSetView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartSetView.h"

@implementation CartSetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, SCREEN_HEIGHT + SAFE_HEIGHT, SCREEN_WIDTH, 185+SAFE_HEIGHT);
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overlayView.backgroundColor = [UIColor blackColor];
    _overlayView.alpha = 0.3;
}

- (IBAction)dismissClick:(UIButton *)sender {
    
    [self dismiss];
}

- (IBAction)sureClick:(UIButton *)sender {
    
    if (self.SureCartSetBlock) {
        
        self.SureCartSetBlock(self.pricetype, self.countlab.text.integerValue);
    }
    
    [self dismiss];
}


- (IBAction)typeClick:(UIButton *)sender {
    
    for (UIButton *btn in self.typeBtns) {
        
        btn.backgroundColor = CLEAR;
        [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    }
    
    sender.backgroundColor = kColor(188, 153, 94);
    [sender setTitleColor:WHITE forState:UIControlStateNormal];
    
    self.pricetype = sender.tag - 100;
}
- (IBAction)countdiss:(UIButton *)sender {
    
    NSInteger num = self.countlab.text.integerValue;
    
    if (num == 1) {
        
        return;
    }
    else {
        
        self.countlab.text = [NSString stringWithFormat:@"%ld",--num];
    }
}
- (IBAction)countadd:(UIButton *)sender {
    
    NSInteger num = self.countlab.text.integerValue;
    
    if (num == 200) {
        
        return;
    }
    else {
        
        self.countlab.text = [NSString stringWithFormat:@"%ld",++num];
    }
}

-(void)showWithtype:(NSInteger)pricetype Withtimes:(NSInteger)times {
    
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    self.pricetype = pricetype;
    
    CGRect frame = self.frame;
    
    frame.origin.y = frame.origin.y - frame.size.height;
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.frame = frame;
    } completion:^(BOOL finished) {
        
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn = [self.typeBtns objectAtIndex:pricetype];
        
        self.countlab.text = INTTOSTRING(times);
        
        [self typeClick:btn];
    }];
}

-(void)dismiss{
    
    CGRect frame = self.frame;
    
    frame.origin.y = SCREEN_HEIGHT + SAFE_HEIGHT;
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [_overlayView removeFromSuperview];
        
        [self removeFromSuperview];
    }];
}

@end
