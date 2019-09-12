//
//  ProtocolViewController.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/11/13.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ProtocolViewController.h"
#import "CPTInfoManager.h"
@interface ProtocolViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ProtocolViewController

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * url = @"https://caipiao-file.oss-cn-hongkong.aliyuncs.com/html/protocol.html";
    if([AppDelegate shareapp].wkjScheme == Scheme_LotterEight){
        url = @"https://caipiao-file.oss-cn-hongkong.aliyuncs.com/html/protocol.html";
    }else{
        url = @"https://caipiao-file.oss-cn-hongkong.aliyuncs.com/html/protocol.html";
    }
    @weakify(self)
    [[CPTInfoManager shareManager] checkModelCallBack:^(CPTInfoModel * _Nonnull model, BOOL isSuccess) {
        if(isSuccess){
            @strongify(self)
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.serviceContract? model.serviceContract:url]];
            [self.webView loadRequest:request];
        }
    }];
    

 
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
