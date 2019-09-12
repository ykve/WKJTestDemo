//
//  EsgameViewController.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/27.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "EsgameViewController.h"
#import <WebKit/WebKit.h>
#import "EsgameAlert.h"
#import "LoginAlertViewController.h"


@interface EsgameViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) EsgameAlert *esgameAlert;

@end

@implementation EsgameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.hidden = YES;
    self.esgameAlert = [[[NSBundle mainBundle]loadNibNamed:@"EsgameAlert" owner:self options:nil]firstObject];

    CGFloat tmpTop = 64.0;
    
    if(IS_IPHONEX){
        tmpTop = tmpTop + 24.;
    }
//    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    //允许转成横屏
//    appDelegate.allowRotation = YES;
//    //调用横屏代码
//    //    [UIDevice switchNewOrientation:UIInterfaceOrientationLandscapeRight];

    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.view.frame))];//CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT-100)
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    [self.view sendSubviewToBack:self.webView];

    self.view.backgroundColor = [UIColor blackColor];
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 2)];
    self.progressView.progressTintColor = [UIColor greenColor];
    [self.view addSubview:self.progressView];
    
     //给webview添加监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.bzgame.vip"]]];
    

}

- (void)changeWebViewHeight:(CGFloat)h{
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[EsgameAlert class]]){
            return;
        }
    }
    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, h);
    self.esgameAlert.frame = CGRectMake(0, 0, SCREEN_WIDTH, h);
    [self.esgameAlert showInView:self.view];
    @weakify(self)
    [self.esgameAlert setClickOKBtn:^{
        @strongify(self)
        
        [self loadEsgameData];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //禁用侧滑手势方法
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
//    //切换到竖屏
//    [UIDevice switchNewOrientation:UIInterfaceOrientationPortrait];
//    //禁用侧滑手势方法
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//        [self outAGGame];
}
- (void)loadEsgameData{
    if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该游戏暂未开放" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if ([Person person].uid == nil) {
        @weakify(self)
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];
        login.loginBlock = ^(BOOL result) {
            @strongify(self)
            [self loadEsgameData];
        };
        return;
    }
    
    NSDictionary *dic = @{@"userId":[Person person].uid,@"account":[Person person].account};
    @weakify(self)
    [WebTools postWithURL:@"/esgame/go.json" params:dic success:^(BaseData *data) {
        @strongify(self)
        if(data.status.integerValue == 1){
            MBLog(@"%@",data.data);
            NSString *url = data.data;
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
            [self.esgameAlert dismiss];

        }else{
            [MBProgressHUD showError:data.info];
        }
    } failure:^(NSError *error) {
    }];
}

- (void)outAGGame{

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


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    // 判断横竖屏
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        MBLog(@"屏幕将旋转 为 竖屏");
        //        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navView.hidden = NO;
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.allowRotation = YES;
//        CGFloat tmpTop = 64.0;
//        if(IS_IPHONEX){
//            tmpTop = tmpTop + 24.;
//        }
//        self.webView.frame = CGRectMake(0, tmpTop,SCREEN_HEIGHT , SCREEN_WIDTH-tmpTop);
//        self.progressView.frame = CGRectMake(0, tmpTop, SCREEN_HEIGHT, 2);
//        MBLog(@"%f-%f",SCREEN_WIDTH,SCREEN_HEIGHT);
    }else{
        MBLog(@"屏幕将旋转 为 横屏");
        //        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.navView.hidden = YES;
//        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        appDelegate.allowRotation = NO;
//        self.webView.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
//        self.progressView.frame = CGRectMake(0, 0, SCREEN_HEIGHT, 2);
    }
}

@end
