//
//  ListNoticeView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ChatSentHongbaoView.h"
#import "AppDelegate.h"

@interface ChatSentHongbaoView()

@property (strong, nonatomic) UIControl *overlayView;
@end

@implementation ChatSentHongbaoView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = CLEAR;
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overlayView.backgroundColor =[UIColor colorWithHex:@"000000" Withalpha:0.7];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
   self.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-keyBoardRect.size.height/2);
    
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    self.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);

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

- (IBAction)cancel:(UIButton *)sender {
    
    [self dismiss];
}

- (IBAction)clickOkBtn:(UIButton *)sender {
    if(self.clickOKBtn){
        self.clickOKBtn([self.moneyTF.text integerValue],[self.numberTF.text integerValue]);
    }
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
