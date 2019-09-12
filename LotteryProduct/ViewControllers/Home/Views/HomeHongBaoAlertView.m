//
//  ListNoticeView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomeHongBaoAlertView.h"
#import "AppDelegate.h"

@interface HomeHongBaoAlertView()

@property (strong, nonatomic) UIControl *overlayView;
@end

@implementation HomeHongBaoAlertView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = CLEAR;
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overlayView.backgroundColor =[UIColor colorWithHex:@"000000" Withalpha:0.7];
}

-(void)show{
    UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
    self.alpha = 0.7;

    [keywindw addSubview:self.overlayView];
    [keywindw addSubview:self];


    [UIView animateWithDuration:0.35 animations:^{

        self.alpha = 1.0;
    } completion:^(BOOL finished) {

    }];
}

-(void)dismiss{

    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {

        [self removeFromSuperview];
        [self.overlayView removeFromSuperview];
    }];
}

- (IBAction)cancel:(UIButton *)sender {
    
    [self dismiss];
}

- (IBAction)clickOkBtn:(UIButton *)sender {
    [self dismiss];

    if(self.clickOKBtn){
        self.clickOKBtn();
    }
}

@end
