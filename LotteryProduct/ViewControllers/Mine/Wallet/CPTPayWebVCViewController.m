
//
//  CPTPayWebVCViewController.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/5/20.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTPayWebVCViewController.h"
#import <WebKit/WebKit.h>
#import "ShareViewController.h"
#import "AppDelegate.h"
@interface CPTPayWebVCViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation CPTPayWebVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat tmpTop = 64.0;
    
    if(IS_IPHONEX){
        tmpTop = tmpTop + 24.;
    }
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //允许转成横屏
    appDelegate.allowRotation = YES;
    //调用横屏代码
    //    [UIDevice switchNewOrientation:UIInterfaceOrientationLandscapeRight];
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT)];//CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT-100)
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    if(self.sfURL){
        [self.webView loadFileURL:self.sfURL allowingReadAccessToURL:self.sfURL];
//        [self.webView loadRequest:[NSURLRequest requestWithURL:self.sfURL]];
    }else{
        [self.webView loadHTMLString:self.urlStr baseURL:nil];
    }
    [self.view addSubview:self.webView];
    [self.view sendSubviewToBack:self.webView];
    @weakify(self)
    [self rigBtn:@"分享" Withimage:@"" With:^(UIButton *sender) {
        @strongify(self)
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ShareViewController" bundle:nil];
        
        ShareViewController *shareVc = [storyBoard instantiateInitialViewController];
        
        [self.navigationController pushViewController:shareVc animated:YES];
        
    }];
    self.view.backgroundColor = [UIColor blackColor];
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 2)];
    self.progressView.progressTintColor = [UIColor greenColor];
    [self.view addSubview:self.progressView];
    
    // 给webview添加监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
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

