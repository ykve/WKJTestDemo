//
//  WebViewController.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/11.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface WebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation WebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKPreferences *Preces = [[WKPreferences alloc]init];
    [Preces setJavaScriptCanOpenWindowsAutomatically:YES];
    [Preces setJavaScriptEnabled:YES];
    Preces.minimumFontSize = 40.0;
    WKWebViewConfiguration *Config = [[WKWebViewConfiguration alloc]init];
    Config.preferences = Preces;
  
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:Config];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    NSString *urlstring = [NSString stringWithFormat:@"%@%@?uid=%@&token=%@&paytype=%@&money=%@",WEBIP,@"/payment/paymentRequestbyMember.html",[Person person].uid,[Person person].token,self.paytype,self.money];
//    NSString *urlstring = @"https://www.baidu.com";
    NSURL *url = [NSURL URLWithString: urlstring];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [self.webView loadRequest: request];
    [self.view addSubview:self.webView];
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 2)];
    self.progressView.progressTintColor = [UIColor greenColor];
    self.progressView.trackTintColor = WHITE;
    [self.view addSubview:self.progressView];
    
    // 给webview添加监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

// 监听事件处理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress  >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:YES];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
 
    
    
    
    
}
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
