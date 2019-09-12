//
//  CPTWebViewController.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTWebViewController.h"
#import <WebKit/WebKit.h>
//#import "ShareViewController.h"
#import "HKShareViewViewController.h"
#import "AppDelegate.h"
@interface CPTWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation CPTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat tmpTop = 64.0;
    self.navView.hidden = !self.isAD;
    if(IS_IPHONEX){
        tmpTop = tmpTop + 24.;
    }
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //允许转成横屏
    appDelegate.allowRotation = !self.isAD;
    //调用横屏代码
//    [UIDevice switchNewOrientation:UIInterfaceOrientationLandscapeRight];
    tmpTop = self.isAD?NAV_HEIGHT:0;
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, tmpTop, SCREEN_WIDTH, SCREEN_HEIGHT-tmpTop)];//CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT-100)
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    [self.view sendSubviewToBack:self.webView];
    @weakify(self)
    [self rigBtn:@"分享" Withimage:@"" With:^(UIButton *sender) {
        @strongify(self)

        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"HKShareViewViewController" bundle:nil];
        
        HKShareViewViewController *shareVc = [storyBoard instantiateInitialViewController];
        
        [self.navigationController pushViewController:shareVc animated:YES];
        
    }];
    self.view.backgroundColor = [UIColor blackColor];
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, tmpTop, CGRectGetWidth(self.view.frame), 2)];
    self.progressView.progressTintColor = [UIColor greenColor];
    [self.view addSubview:self.progressView];
    
    // 给webview添加监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    if(!self.isFromBuy){
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    }
    if(self.isAD){
        return;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"askdjf;asdjf" forState:UIControlStateNormal];
    [btn setImage:IMAGE(@"cptGoBack") forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(44);
        make.left.offset(0);
        make.width.offset(222/5);
        make.height.offset(272/5);
    }];
    [btn addTarget:self action:@selector(goBackToCpt) forControlEvents:UIControlEventTouchUpInside];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    
                                                    initWithTarget:self
                                                    
                                                    action:@selector(handlePan:)];
    
    [btn addGestureRecognizer:panGestureRecognizer];
    
}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer

{
    
    CGPoint translation = [recognizer translationInView:self.view];
    
    CGFloat centerX=recognizer.view.center.x+ translation.x;
    CGFloat centerY=recognizer.view.center.y+ translation.y;
    CGFloat thecenterX=0;
    CGFloat thecenterY=0;
    recognizer.view.center=CGPointMake(centerX,
                                       
                                       recognizer.view.center.y+ translation.y);
    
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if(recognizer.state==UIGestureRecognizerStateEnded|| recognizer.state==UIGestureRecognizerStateCancelled) {
        
        if(centerX>SCREEN_WIDTH/2) {
            
            thecenterX=SCREEN_WIDTH-50/2;
            
        }else{
            
            thecenterX=50/2;
            
        }
        if (centerY>SCREEN_HEIGHT-NAV_HEIGHT) {
            
            thecenterY=SCREEN_HEIGHT-NAV_HEIGHT;
        }
        else if (centerY<NAV_HEIGHT) {
            
            thecenterY=NAV_HEIGHT;
        }
        else{
            thecenterY = recognizer.view.center.y+ translation.y;
        }
        [UIView animateWithDuration:0.3 animations:^{
            
            recognizer.view.center=CGPointMake(thecenterX,thecenterY);
            
        }];
        
    }
}

- (void)goBackToCpt{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //禁用侧滑手势方法
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
    //切换到竖屏
    [UIDevice switchNewOrientation:UIInterfaceOrientationPortrait];
    //禁用侧滑手势方法
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    if(self.isAG){
        [self outAGGame];
    }
}
- (void)outAGGame{
    [[Person person] checkIsNeedRMoney:^(double money) {
        
    }isNeedHUD:NO];
}
// 监听事件处理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    @weakify(self)
    if ([keyPath isEqual:@"estimatedProgress"] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress  >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                @strongify(self)

                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                @strongify(self)

                [self.progressView setProgress:0.0f animated:YES];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
}

//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
//{
//    return YES;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIDeviceOrientationPortrait;
//}
//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//
//    return UIInterfaceOrientationMaskAll;
//}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    // 判断横竖屏
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        MBLog(@"屏幕将旋转 为 竖屏");
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navView.hidden = NO;
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.allowRotation = YES;
        CGFloat tmpTop = 64.0;
        if(IS_IPHONEX){
            tmpTop = tmpTop + 24.;
        }
        tmpTop = 0;
        self.webView.frame = CGRectMake(0, tmpTop,SCREEN_HEIGHT , SCREEN_WIDTH-tmpTop);
        self.progressView.frame = CGRectMake(0, tmpTop, SCREEN_HEIGHT, 2);
        MBLog(@"%f-%f",SCREEN_WIDTH,SCREEN_HEIGHT);
    }else{
        MBLog(@"屏幕将旋转 为 横屏");
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.navView.hidden = YES;
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.allowRotation = NO;
        self.webView.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
        self.progressView.frame = CGRectMake(0, 0, SCREEN_HEIGHT, 2);
    }
}

@end
