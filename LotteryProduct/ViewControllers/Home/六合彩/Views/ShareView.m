//
//  ShareView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/7.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self.weichatBtn setImagePosition:WPGraphicBtnTypeTop spacing:6];
    [self.friendBtn setImagePosition:WPGraphicBtnTypeTop spacing:6];
    [self.qqBtn setImagePosition:WPGraphicBtnTypeTop spacing:6];
    
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overlayView.backgroundColor = [UIColor blackColor];
    _overlayView.alpha = 0.3;
}

+(ShareView *)share {
    
    ShareView *sharev = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ShareView class]) owner:self options:nil]firstObject];
    
    sharev.frame = CGRectMake(0, SCREEN_HEIGHT + SAFE_HEIGHT, SCREEN_WIDTH, 220);
    
    return sharev;
}

- (IBAction)shareClick:(UIButton *)sender {
    
    [self dismiss];
}

- (IBAction)cancelClick:(UIButton *)sender {
    
    [self dismiss];
}

-(void)show {
    
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    CGRect frame = self.frame;
    
    frame.origin.y = SCREEN_HEIGHT - 220;
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }];
}

-(void)dismiss {
    
    CGRect frame = self.frame;
    
    frame.origin.y = SCREEN_HEIGHT + SAFE_HEIGHT;
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [_overlayView removeFromSuperview];
    }];
}

@end
