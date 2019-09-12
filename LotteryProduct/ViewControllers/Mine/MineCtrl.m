//
//  MineCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "MineCtrl.h"
#import "MineCell.h"
#import "MineheaderView.h"
#import "TopUpViewController.h"
#import "PersonStatementsViewController.h"
#import "BettingRecordViewController.h"
#import "FollowNumRecordViewController.h"
#import "MessageCenterViewController.h"
#import "MyCircleViewController.h"
#import "SettingViewController.h"
#import "GetOutViewController.h"
#import "AccountOpenCtrl.h"
#import "ShareViewController.h"
#import "AppDelegate.h"
#import "MainTabbarCtrl.h"
//#import "HDChatViewController.h"
#import "HKShareViewViewController.h"
#import "LoginAlertViewController.h"
#import "UIImage+color.h"
#import "KeFuViewController.h"
#import "WalletViewController.h"

@interface MineCtrl ()
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;

@property (weak, nonatomic) IBOutlet UIScrollView *mainscrollView;

@property (weak, nonatomic) IBOutlet UIImageView *headimgv;
@property (weak, nonatomic) IBOutlet UIView *middleBackView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace;

@property (weak, nonatomic) IBOutlet UIView *InfoView;

@property (weak, nonatomic) IBOutlet UIView *inviteView;

@property (weak, nonatomic) IBOutlet UIView *priceView;

@property (weak, nonatomic) IBOutlet UIView *setView;

@property (weak, nonatomic) IBOutlet UIView *setContentView;

@property (weak, nonatomic) IBOutlet UIView *seperatorLine;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *Btns;

@property (weak, nonatomic) IBOutlet UILabel *invitelab;
/// 余额
@property (weak, nonatomic) IBOutlet UILabel *pricelab;

@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UIButton *inviteCodeBtn;
@property (weak, nonatomic) IBOutlet UILabel *yuELbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnsTopH;

@property (weak, nonatomic) IBOutlet UIImageView *topBackImageView;

@property (weak, nonatomic) IBOutlet UIButton *chargeBtn;
@property (weak, nonatomic) IBOutlet UIButton *getMoneyBtn;
@property (weak, nonatomic) IBOutlet UIButton *moneyDetailBtn;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberSubTitles;
//账户信息
@property (weak, nonatomic) IBOutlet UIButton *accountInfoBtn;
//安全中心
@property (weak, nonatomic) IBOutlet UIButton *securityBtn;
//我的报表
@property (weak, nonatomic) IBOutlet UIButton *myTable;
//投注记录
@property (weak, nonatomic) IBOutlet UIButton *buyHistoryBtn;
//消息中心
@property (weak, nonatomic) IBOutlet UIButton *messageCenterBtn;
//设置中心
@property (weak, nonatomic) IBOutlet UIButton *setCnter;

//分享
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
//我的钱包
@property (weak, nonatomic) IBOutlet UIButton *myWalletBtn;
@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;

@property (nonatomic, copy) NSString *payLevelId;
@end

@implementation MineCtrl

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
 

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    if ([Person person].uid == nil) {
        [self loginoutNoti];
    }
    
    if ([Person person].uid == nil) {
        
        [self presentLogin];
    }
    
    [self initData];
    
    [self setmenuBtn:[[CPTThemeConfig shareManager] IC_Nav_SideImageStr]];
    
    SKinThemeType sKinThemeType = [[AppDelegate shareapp] sKinThemeType];
    
    if (IS_IPHONEX) {
        if(sKinThemeType == SKinType_Theme_White){
            self.scrollViewHeight.constant = SAFE_HEIGHT + IS_IPHONE_Xs_Max ? 385 : 340 ;
        }else{
            self.scrollViewHeight.constant = 296;
        }
    }else{
        if(sKinThemeType == SKinType_Theme_White){
            self.scrollViewHeight.constant = 320;
        }else{
            self.scrollViewHeight.constant = 296;
        }
    }
}



- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)updateBalance {
    self.pricelab.text = [NSString stringWithFormat:@"￥%.2f",[Person person].balance];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.topSpace.constant = NAV_HEIGHT;
    self.view.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];
    
    [self setNavUI];
    
    [self setUI];

    @weakify(self)
    [self.headimgv tapHandle:^{
        @strongify(self)
        [self personInfoClick:nil];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:kLoginSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"RefreshMineData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBalance) name:@"updateBalance" object:nil];
}

- (void)setNavUI {
    self.navView.backgroundColor = CLEAR;
    [self.view bringSubviewToFront:self.navView];
    
    @weakify(self)
    if ([AppDelegate shareapp].wkjScheme == Scheme_LotterProduct) {
        NSString * titleName =@"td_nav_mine_icon";
        NSString * kefuName =@"td_nav_kefu_icon";
        if([[AppDelegate shareapp] sKinThemeType]== SKinType_Theme_White){
            titleName = @"tw_nav_me_center";
            kefuName = @"tw_kefu_icon";
        }
        
        [self rigBtnImage:kefuName With:^(UIButton *sender) {
             @strongify(self)
            [self goto_kefu];
        }];
        
        
        UIImageView *imgv = [[UIImageView alloc]initWithImage:IMAGE(titleName)];
        [self.navView addSubview:imgv];
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.rightBtn);
            make.centerX.equalTo(self.navView);
            make.size.mas_equalTo(CGSizeMake(imgv.image.size.width, imgv.image.size.height));
        }];
    } else {
        self.titlestring = @"我的";
        
        [self rigBtn:@" 客服" Withimage:[[CPTThemeConfig shareManager] IC_Nav_Kefu_Text] With:^(UIButton *sender) {
            @strongify(self)
            [self goto_kefu];
        }];
    }
}

- (void)goto_kefu {
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    KeFuViewController *kefuVc = [[KeFuViewController alloc] init];
    PUSH(kefuVc);
}

- (void)setUI {
    self.inviteCodeBtn.backgroundColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.6];
    self.navView.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];
    self.navView.layer.shadowColor = CLEAR.CGColor;
    
    [Tools roundSide:1 view:self.inviteCodeBtn];
    self.pricelab.textColor = [[CPTThemeConfig shareManager] Mine_priceTextColor];
    self.topBackImageView.image = [[CPTThemeConfig shareManager] IM_topBackImageView];
    self.yuELbl.textColor = [[CPTThemeConfig shareManager] CO_Me_YuEText];
    
    [self.refreshBtn setImage:[[CPTThemeConfig shareManager] IM_Me_MoneyRefreshBtn] forState:UIControlStateNormal];
    [self.chargeBtn setImage:[[CPTThemeConfig shareManager] IM_Me_ChargeImage] forState:UIControlStateNormal];
    [self.getMoneyBtn setImage:[[CPTThemeConfig shareManager] IM_Me_GetMoneyImage] forState:UIControlStateNormal];
    [self.moneyDetailBtn setImage:[[CPTThemeConfig shareManager] IM_Me_MoneyDetailImage] forState:UIControlStateNormal];
    
    if(SCREEN_WIDTH <= 321){
        if([[AppDelegate shareapp] wkjScheme] == Scheme_LotterHK){
            self.btnsTopH.constant = -20;
        }else{
            self.btnsTopH.constant = 0;
        }
    }
   
    [self.myWalletBtn setImage:[[CPTThemeConfig shareManager] IM_Me_MyWalletImage] forState:UIControlStateNormal];
    [self.accountInfoBtn setImage:[[CPTThemeConfig shareManager] IM_Me_MyAccountImage] forState:UIControlStateNormal];
    [self.securityBtn setImage:[[CPTThemeConfig shareManager] IM_Me_SecurityCnterImage] forState:UIControlStateNormal];
    [self.myTable setImage:[[CPTThemeConfig shareManager] IM_Me_MyTableImage] forState:UIControlStateNormal];
    [self.buyHistoryBtn setImage:[[CPTThemeConfig shareManager] IM_Me_buyHistoryImage] forState:UIControlStateNormal];
    [self.messageCenterBtn setImage:[[CPTThemeConfig shareManager] IM_Me_MessageCenterImage] forState:UIControlStateNormal];
    [self.setCnter setImage:[[CPTThemeConfig shareManager] IM_Me_setCenterImage] forState:UIControlStateNormal];
    [self.shareBtn setImage:[[CPTThemeConfig shareManager] IM_Me_shareImage] forState:UIControlStateNormal];
    
    
    for (UILabel *lbl in self.numberSubTitles) {
        lbl.textColor = [[CPTThemeConfig shareManager] CO_Me_SubTitleText];
    }
    
    self.namelab.textColor = [[CPTThemeConfig shareManager] CO_Me_NicknameLabel];
    self.seperatorLine.backgroundColor = [[CPTThemeConfig shareManager] mine_seperatorLineColor];
    
    self.InfoView.hidden = YES;
    self.middleBackView.backgroundColor = [UIColor whiteColor];
    for (UIButton *btn in self.Btns) {
        [btn setTitleColor:[[CPTThemeConfig shareManager] CO_Me_ItemTextcolor] forState:UIControlStateNormal];
        [btn setImagePosition:WPGraphicBtnTypeTop spacing:5];
    }
    
    
    if (@available(iOS 11.0, *)) {
        self.mainscrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    
    self.mainscrollView.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];
    self.setContentView.backgroundColor = [[CPTThemeConfig shareManager] CO_Mine_setContentViewBackgroundColor];

}

- (void)presentLogin {
    
    LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
    login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:login animated:YES completion:nil];
    @weakify(self)

    login.loginBlock = ^(BOOL result) {
        @strongify(self)
        [self initData];
    };
    
}

#pragma mark 分享
- (IBAction)LetteryBuyshare:(UIButton *)sender {

    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"HKShareViewViewController" bundle:nil];
    HKShareViewViewController *shareVc = [storyBoard instantiateInitialViewController];
    [self.navigationController pushViewController:shareVc animated:YES];
    
}



- (IBAction)personInfoClick:(UIButton *)sender {
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"UserInfoViewController"] animated:YES];
}

- (IBAction)kefuClick:(UIButton *)sender {
    
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    
//    if ([[ChatHelp shareHelper]login]) {
//
//        // 进入会话页面
//        HDChatViewController *chatVC = [[HDChatViewController alloc] initWithConversationChatter:HX_IM]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
//        [self.navigationController pushViewController:chatVC animated:YES];
//    }
    KeFuViewController *kefuVc = [[KeFuViewController alloc] init];
    
    PUSH(kefuVc);
    
}

- (IBAction)safeClick:(UIButton *)sender {
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SafeViewController"] animated:YES];
}

- (IBAction)messageClick:(UIButton *)sender {
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    MessageCenterViewController *messageCenter = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageCenterViewController"];
    
    [self.navigationController pushViewController:messageCenter animated:YES];
}

#pragma mark 分享事件
- (IBAction)clickShareBtn:(UIButton *)sender {
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ShareViewController" bundle:nil];
    
    ShareViewController *shareVc = [storyBoard instantiateInitialViewController];

    [self.navigationController pushViewController:shareVc animated:YES];
}

- (IBAction)moneyRefClick:(UIButton *)sender {
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    @weakify(self)
    [[Person person] checkIsNeedRMoney:^(double money) {
        @strongify(self)
        self.pricelab.text = [NSString stringWithFormat:@"￥%.2f",money];
    }isNeedHUD:YES];

}

- (IBAction)setClick:(UIButton *)sender {
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    SettingViewController *setting = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateInitialViewController];
    
    [self.navigationController pushViewController:setting animated:YES];
}

- (IBAction)uppriceClick:(UIButton *)sender {
    if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该功能暂未开放" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    
    if ([Person person].payLevelId.length == 0) {
        [MBProgressHUD showError:@"无用户层级, 暂无法充值"];
        return;
    }
    TopUpViewController *recVC = [[TopUpViewController alloc] init];
    [self.navigationController pushViewController:recVC animated:YES];
}

- (IBAction)downpriceClick:(UIButton *)sender {
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    GetOutViewController *getoutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GetOutViewController"];
    
    [self.navigationController pushViewController:getoutVC animated:YES];
}

- (IBAction)priceInfoClick:(UIButton *)sender {
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"PriceDetailViewController"] animated:YES];
}

- (IBAction)waliteClick:(UIButton *)sender {
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    // 我的钱包 WalletViewController
    WalletViewController *vc = [[WalletViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)mylistClick:(UIButton *)sender {
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    PersonStatementsViewController *person = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonStatementsViewController"];
    
    [self.navigationController pushViewController:person animated:YES];
}

- (IBAction)publishhistoryClick:(UIButton *)sender {
    if ([Person person].uid == nil) {
        [self presentLogin];
        return;
    }
    BettingRecordViewController *bettingRecordVC = [[BettingRecordViewController alloc]init];
    
    [self.navigationController pushViewController:bettingRecordVC animated:YES];
}


- (void)loginoutNoti{
    self.namelab.text = @" ";
    self.vipImageView.image = IMAGE(@"");
    self.pricelab.text = @"";
    self.invitelab.text = @"邀请码: ";
}

-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/myAccount.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        [[Person person] setupWithDic:data.data];
        id dddd = data.data[@"payLevelId"];
        if([dddd isKindOfClass:[NSString class]]){
            self.payLevelId = dddd;

        }else{
            self.payLevelId = [dddd stringValue];
        }
        self.invitelab.text = [NSString stringWithFormat:@"邀请码:%@", [Person person].promotionCode ];
        self.invitelab.textColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.6];
        self.invitelab.textColor = [[CPTThemeConfig shareManager] mineInviteTextCiolor];
        [self.inviteCodeBtn setTitle:[NSString stringWithFormat:@"邀请码:%@", [Person person].promotionCode ] forState:UIControlStateNormal];
        
        self.pricelab.text = [NSString stringWithFormat:@"￥%.2f",[Person person].balance];
        
        self.namelab.text = [Person person].nickname.length > 0 ? [Person person].nickname : [Person person].account;
        
        [self.headimgv sd_setImageWithURL:IMAGEPATH([Person person].heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
        
        self.vipImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"me_%@", [Person person].vip]];
        [[Person person] checkIsNeedRMoney:^(double money) {
            @strongify(self)
            self.pricelab.text = [NSString stringWithFormat:@"￥%.2f",money];
        }isNeedHUD:NO];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}


@end
