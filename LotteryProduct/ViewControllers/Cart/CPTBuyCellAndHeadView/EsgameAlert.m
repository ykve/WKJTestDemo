//
//  ListNoticeView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "EsgameAlert.h"

@interface EsgameAlert()

@property (strong, nonatomic) UIControl *overlayView;
@end

@implementation EsgameAlert

- (void)dealloc{
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = CLEAR;


}

-(void)showInView:(UIView *)view{
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, self.frame.origin.y, SCREEN_WIDTH, CGRectGetHeight(self.frame))];
    _overlayView.backgroundColor =[UIColor colorWithHex:@"000000" Withalpha:0.7];
    self.alpha = 0.7;

    [view addSubview:self.overlayView];
    [view addSubview:self];


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

- (IBAction)okbtn:(UIButton *)sender {
    if(self.clickOKBtn){
        self.clickOKBtn();
    }
}

//- (void)showInView:(UIView *)view{
//    self.alpha = 0.7;
//    [view addSubview:self];
//    [UIView animateWithDuration:0.35 animations:^{
//        self.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        
//    }];
//}

@end
