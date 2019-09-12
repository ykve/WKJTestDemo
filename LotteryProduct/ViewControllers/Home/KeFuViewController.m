//
//  KeFuViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/6/5.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "KeFuViewController.h"
#import "LoginAlertViewController.h"
#import "UIColor+Hex.h"
#import "CPTInfoManager.h"
#import <MeiQiaSDK/MQManager.h>
#import "MQChatViewManager.h"

@interface KeFuViewController ()
@property(nonatomic, strong)    NSString *qq1S;
@property(nonatomic, strong)    NSString *qq2S;


@end

@implementation KeFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignWindowClick) name:@"resignWindow" object:nil];

    [self setupUI];
    @weakify(self)
    [[CPTInfoManager shareManager] checkModelCallBack:^(CPTInfoModel * _Nonnull model, BOOL isSuccess) {
        if(isSuccess){
            @strongify(self)
            self.qq1S = model.serviceQq1;
            self.qq2S = model.serviceQq2;
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//self.navigationController
}


- (void)setupUI{
    self.titlestring = @"联系客服";
        self.view.backgroundColor = [UIColor colorWithHex:@"EFEFEF"];

   UIImageView *topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, NAV_HEIGHT + 15, SCREEN_WIDTH - 40, (31 * SCREEN_WIDTH)/66)];
    topImgView.image = IMAGE([[CPTThemeConfig shareManager] KeFuTopImageName]);
    topImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:topImgView];
    
    UIButton *QQ1Btn = [[UIButton alloc] initWithFrame:CGRectMake(topImgView.x, CGRectGetMaxY(topImgView.frame) + 20, topImgView.width, 60)];
    [QQ1Btn setTitleColor:[UIColor colorWithHex:@"1C1B1B"] forState:UIControlStateNormal];
    [QQ1Btn setImage:IMAGE(@"dsf_QQkf") forState:UIControlStateNormal];
    QQ1Btn.tag = 1;
    [self setupBtn:QQ1Btn title:@"QQ客服1"];
    
    UIButton *QQ2Btn = [[UIButton alloc] initWithFrame:CGRectMake(topImgView.x, CGRectGetMaxY(QQ1Btn.frame) + 10, topImgView.width, QQ1Btn.height)];
    [QQ2Btn setTitleColor:[UIColor colorWithHex:@"1C1B1B"] forState:UIControlStateNormal];
    [self setupBtn:QQ2Btn title:@"QQ客服2"];
    [QQ2Btn setImage:IMAGE(@"dsf_QQkf") forState:UIControlStateNormal];
    QQ2Btn.tag = 2;

    
    UIButton *onlineBtn = [[UIButton alloc] initWithFrame:CGRectMake(topImgView.x, CGRectGetMaxY(QQ2Btn.frame) + 10, topImgView.width, QQ1Btn.height)];
    [onlineBtn setTitleColor:WHITE forState:UIControlStateNormal];
    [self setupBtn:onlineBtn title:@"在线客服"];
     onlineBtn.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_ThemeColorTwe];
    [onlineBtn setImage:IMAGE([[CPTThemeConfig shareManager] OnlineBtnImage]) forState:UIControlStateNormal];
    onlineBtn.tag = 3;
}


- (void)setupBtn:(UIButton *)btn title:(NSString *)title{
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    btn.titleLabel.font = FONT(17);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = WHITE;
    btn.layer.cornerRadius = 10;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(ckickKeFuBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)ckickKeFuBtn:(UIButton *)btn{
    
    
    if (btn.tag == 1) {//QQ1
        if([AppDelegate shareapp].wkjScheme == Scheme_LotterHK){
            [self getQQChat:@"38818185"];
        }else if([AppDelegate shareapp].wkjScheme == Scheme_LotterEight){
            [self getQQChat:@"97850081"];
        }else{
            [self getQQChat:self.qq1S?self.qq1S: @"97613000"];
        }
    }else if(btn.tag == 2){//QQ2
        if([AppDelegate shareapp].wkjScheme == Scheme_LotterHK){
            [self getQQChat:@"503088888"];
        }else if([AppDelegate shareapp].wkjScheme == Scheme_LotterEight){
            [self getQQChat:@"97830087"];
        }else{
            [self getQQChat:self.qq2S?self.qq2S: @"97613111"];
        }
    }else{//在线客服

        [self resignWindowClick];

    }
}

- (void)resignWindowClick{
#pragma mark  最简单的集成方法: 全部使用meiqia的,  不做任何自定义UI.
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
        MQChatViewStyle *aStyle = [chatViewManager chatViewStyle];
        [aStyle setEnableRoundAvatar:YES];
    [aStyle setNavBarTintColor:WHITE];
    [aStyle setStatusBarStyle:UIStatusBarStyleLightContent];

    if([[Person person] uid] == nil){

    }else{
        [chatViewManager setClientInfo:@{@"name":[[Person person] nickname],@"avatar":[[Person person] heads]} override:YES];
        [chatViewManager setLoginCustomizedId:[[Person person] uid]];
    }

    [chatViewManager pushMQChatViewControllerInViewController:self];


}

- (void)getQQChat:(NSString *)QQNum{
    //是否安装QQ
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
    {
        //用来接收临时消息的客服QQ号码(注意此QQ号需开通QQ推广功能,否则陌生人向他发送消息会失败)
        //调用QQ客户端,发起QQ临时会话
        NSString *url = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",QQNum];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else{
        [MBProgressHUD showMessage:@"请先安装QQ"];
    }
}
@end
