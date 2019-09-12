//
//  ListNoticeView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ChatHongbaoReciviced.h"

@interface ChatHongbaoReciviced()

@property (strong, nonatomic) UIControl *overlayView;
@end

@implementation ChatHongbaoReciviced

- (void)dealloc{
}

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
        [AppDelegate shareapp].chatSentHongbaoView = nil;
    }];
}

- (IBAction)okbtn:(UIButton *)sender {
    if(self.clickOKBtn){
        self.clickOKBtn();
    }
    [self dismiss];
}

- (void)showInView:(UIView *)view{
    self.alpha = 0.7;
    [view addSubview:self];
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

@end
