//
//  ListNoticeView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomeActivityAlertView.h"
#import "AppDelegate.h"
#import "MessageModel.h"
#import "LoginAlertViewController.h"
@interface HomeActivityAlertView()
@property(weak,nonatomic)IBOutlet UIImageView* imageView;
@property(weak,nonatomic)IBOutlet UIView* backView;
@property(assign,nonatomic) NSInteger index;
@property(weak,nonatomic)IBOutlet UIButton* okBtn;
@property(weak,nonatomic)IBOutlet NSLayoutConstraint* cannelTop;
@property(weak,nonatomic)IBOutlet UIImageView* goldImageV;
@property(weak,nonatomic)IBOutlet UIImageView* sunImageV;
@property(weak,nonatomic)IBOutlet UIButton* cannelBtn;

@property(weak,nonatomic)IBOutlet UIView* line1V;
@property(weak,nonatomic)IBOutlet UIView* line2V;
@property(weak,nonatomic)IBOutlet UIImageView* bImageV;
@property(weak,nonatomic)IBOutlet UIView* hongbaoV;



@property (strong, nonatomic) UIControl *overlayView;
@property (assign, nonatomic) NSInteger count;

@end

@implementation HomeActivityAlertView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = CLEAR;
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overlayView.backgroundColor =[UIColor colorWithHex:@"000000" Withalpha:0.7];
    self.imageView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    self.bImageV.transform = CGAffineTransformMakeScale(0.3, 0.3);
    self.line1V.alpha = self.line2V.alpha = self.titleL.alpha = 0.0;
    self.okBtn.transform = CGAffineTransformMakeScale(0.7, 0.7);
    self.okBtn.hidden = self.bImageV.hidden = YES;
    self.count = 1;
}

- (void)stop{
    self.count = 9;
}

-(void)show{
    UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
    self.alpha = 0.7;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stop)];
    [self.hongbaoV addGestureRecognizer:tap];
    [keywindw addSubview:self.overlayView];
    [keywindw addSubview:self];
    self.hongbaoV.hidden = NO;
    self.afterV.hidden = YES;
    @weakify(self)
    [UIView animateWithDuration:0.35 animations:^{
        @strongify(self)
        self.alpha = 1.0;
        self.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        @strongify(self)
        self.bImageV.hidden = NO;
        [UIView animateWithDuration:0.35 animations:^{
            @strongify(self)
            self.line1V.alpha = self.line2V.alpha = self.titleL.alpha = 1.0;
            self.bImageV.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            @strongify(self)
            self.okBtn.hidden = NO;
            [self vvvv];
        }];
    }];
}

- (void)vvvv {
    @weakify(self)
    if(self.count>=5){
        [UIView animateWithDuration:0.35 animations:^{
            @strongify(self)
            self.okBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
        }];
        return;
    }
    self.count = self.count+1;
    [UIView animateWithDuration:0.35 animations:^{
        @strongify(self)
        self.okBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        @strongify(self)
        [UIView animateWithDuration:0.35 animations:^{
            @strongify(self)
            self.okBtn.transform = CGAffineTransformMakeScale(0.70, 0.70);
        } completion:^(BOOL finished) {
            @strongify(self)
            [self vvvv];
        }];
    }];
}

-(void)dismiss{
    @weakify(self)

    [UIView animateWithDuration:0.35 animations:^{
        @strongify(self)

        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        @strongify(self)

        [self removeFromSuperview];
        [self.overlayView removeFromSuperview];
    }];
}

- (IBAction)cancel:(UIButton *)sender {
    [self dismiss];
}

- (IBAction)clickOkBtn:(UIButton *)sender {
    if(self.isFromHome){
        [self dismiss];
        if(self.clickOKBtn){
            self.clickOKBtn();
        }
    }else{
        [self checkIsHadHongbao];
    }
}

-(void)checkIsHadHongbao {
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;

        [keywindw.rootViewController presentViewController:login animated:YES completion:^{
        }];
        @weakify(self)

        [UIView animateWithDuration:0.35 animations:^{
            @strongify(self)
            self.alpha = 0.0;
            [self.overlayView removeFromSuperview];

        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
        login.loginBlock = ^(BOOL result) {
            @strongify(self)
            [UIView animateWithDuration:0.35 animations:^{
                @strongify(self)
                self.hidden = NO;
                self.alpha = 1.0;
            } completion:^(BOOL finished) {
                
            }];
        };
        return ;
    }
    @weakify(self)
    [WebTools postWithURL:@"/activity/lotteryDraw.json" params:@{@"actId":self.actID,@"uid":[[Person person] uid] == nil ?@"":[[Person person] uid]} success:^(BaseData *data) {
        @strongify(self)
        id some = data.data;
        if([some isKindOfClass:[NSString class]]){
            [MBProgressHUD showError:@"您已领取该红包！"];
        }else if ([some isKindOfClass:[NSNumber class]]){
            self.okBtn.hidden = YES;
            self.cannelTop.constant = -150;
            NSNumber * money = (NSNumber *)some;
            CGFloat mon = [money floatValue];
            [self.imageView setImage:IMAGE(@"红包背景")];
            self.moneyLab.text = [NSString stringWithFormat:@"%.2f",mon];
            self.moneyLab.hidden = self.yuanLab.hidden = NO;
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            [user setObject:@"9" forKey:[NSString stringWithFormat:@"%@",self.actID]];
            [user synchronize];
        }
    } failure:^(NSError *error) {
        //        @strongify(self)
    } showHUD:YES];
}

- (void)showView:(UIView *)view some:(NSNumber *)money{
    
    UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
    self.alpha = 0.7;
    
    [keywindw addSubview:self.overlayView];
    [keywindw addSubview:self];
    self.hongbaoV.hidden = YES;
    self.afterV.hidden = NO;
  self.cannelBtn.hidden =  self.okBtn.hidden = YES;
    self.cannelTop.constant = -150;
    CGFloat mon = [money floatValue];
//    [self.imageView setImage:IMAGE(@"红包背景")];
    self.moneyLab.text = [NSString stringWithFormat:@"%.2f",mon];

    self.imageView.hidden = YES;

    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setObject:@"9" forKey:[NSString stringWithFormat:@"%@",self.actID]];
    [user synchronize];
    
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1.0;
        self.afterV.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.35 animations:^{
            self.goldImageV.center = CGPointMake(self.goldImageV.center.x, self.goldImageV.center.y-95);
            self.afterMoneyV.hidden = NO;
            self.afterMoneyV.alpha = 1.0;
        } completion:^(BOOL finished) {
            [self rotateView:self.sunImageV];

        }];
    }];
}

- (void)rotateView:(UIImageView *)view
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 5;
    rotationAnimation.repeatCount = HUGE_VALF;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
