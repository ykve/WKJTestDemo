//
//  ListNoticeView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ChatHongbaoGetAlert.h"
#import "AppDelegate.h"

@interface ChatHongbaoGetAlert()

@property (strong, nonatomic) UIControl *overlayView;
@end

@implementation ChatHongbaoGetAlert

-(void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = CLEAR;
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overlayView.backgroundColor =[UIColor colorWithHex:@"000000" Withalpha:0.7];
}

-(void)showInView:(UIView *)view name:(NSString *)name money:(NSString *)money count:(NSString *)count{
    self.alpha = 0.7;
    self.titleLabel.text = name;
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@元",money];
    self.subTitle2Label.text = [NSString stringWithFormat:@"%@个随机红包",count];
    [view addSubview:self];


    [UIView animateWithDuration:0.35 animations:^{

        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:3.0];
    }];
}

-(void)dismiss{

    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {

        [self removeFromSuperview];
    }];
}


@end
