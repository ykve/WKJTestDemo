//
//  MineInfoViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/3/6.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "MineInfoViewController.h"
#import "AppDelegate.h"
#import "ShareViewController.h"
#import "MessageCenterViewController.h"
#import "GetOutViewController.h"
#import "SettingViewController.h"
#import "TopUpViewController.h"
#import "PersonStatementsViewController.h"
#import "BettingRecordViewController.h"
#import "KeFuViewController.h"

@interface MineInfoViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;

@property (weak, nonatomic) IBOutlet UIImageView *headimgv;

@property (weak, nonatomic) IBOutlet UIView *middleView;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *Btns;

@property (weak, nonatomic) IBOutlet UIButton *inviteBtn;


@property (weak, nonatomic) IBOutlet UILabel *namelab;

@property (weak, nonatomic) IBOutlet UIImageView *topBackImageView;

@end

@implementation MineInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.headimgv.layer.masksToBounds = YES;
    self.headimgv.layer.cornerRadius = self.headimgv.width/2;
    self.titlestring = @"我的";
    self.topMargin.constant = NAV_HEIGHT;
    
    self.namelab.textColor = [UIColor blackColor];
    
    [Tools roundSide:1 view:self.inviteBtn];
    
    self.inviteBtn.backgroundColor = [UIColor colorWithHex:@"bc8b72"];
    
//    self.navView.backgroundColor = CLEAR;
    
//    [self rigBtn:@"切换皮肤" Withimage:@"" With:^(UIButton *sender) {
//
//        BOOL isDark = [[[NSUserDefaults standardUserDefaults] valueForKey:WKJTheme_ThemeType] boolValue];
//
//        sender.selected = isDark;
//
//        if(!sender.selected){
//            [[CPTThemeConfig shareManager] darkTheme];
//        }else{
//            [[CPTThemeConfig shareManager] lightTheme];
//        }
//
//        sender.selected = sender.selected ? NO : YES;
//        [[NSUserDefaults standardUserDefaults] setValue:@(sender.selected) forKey:WKJTheme_ThemeType];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//
//        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isChangeSkin"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        [[AppDelegate shareapp] clearRootVC];
//        [[AppDelegate shareapp] setmainroot];
//
//        [[AppDelegate shareapp].tab setSelectedIndex:3];
//
//    }];

    
    
        @weakify(self)
        [self rigBtn:@" 客服" Withimage:[[CPTThemeConfig shareManager] IC_Nav_Kefu_Text] With:^(UIButton *sender) {
            KeFuViewController *chatVC = [[KeFuViewController alloc] init]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
            @strongify(self)

            PUSH(chatVC);
        }];
    
    
    //    self.view.backgroundColor = [[CPTThemeConfig shareManager] RootVC_ViewBackgroundC];//[UIColor colorWithHex:@"303136"];
    //    self.middleBackView.backgroundColor = [UIColor colorWithHex:@"303136"];
//    self.view.backgroundColor = [[CPTThemeConfig shareManager] mianThemeColorOne];
    [self setmenuBtn:[[CPTThemeConfig shareManager] IC_Nav_SideImageStr]];

    self.middleView.backgroundColor = [UIColor whiteColor];
    for (UIButton *btn in self.Btns) {
        [btn setTitleColor:[[CPTThemeConfig shareManager] grayColor999] forState:UIControlStateNormal];
        [btn setImagePosition:WPGraphicBtnTypeTop spacing:5];
    }
    
    [self.view bringSubviewToFront:self.navView];
    
    [self.headimgv tapHandle:^{
        @strongify(self)

        [self personInfoClick:nil];
    }];
    
}

#pragma mark 分享
- (IBAction)LetteryBuyshare:(UIButton *)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ShareViewController" bundle:nil];
    
    ShareViewController *shareVc = [storyBoard instantiateInitialViewController];
    
    [self.navigationController pushViewController:shareVc animated:YES];
    
}

- (IBAction)copyInviteCode:(UIButton *)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [self.inviteBtn.currentTitle substringFromIndex:4];
    [MBProgressHUD showSuccess:@"邀请码已复制"];

}

- (IBAction)personInfoClick:(UIButton *)sender {
    
//    [self addChildViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"MineCtrl"] title:@"我的" image:[UIImage imageNamed:@"tab5_1"] selectedImage:[UIImage imageNamed:@"tab5_2"]];
    
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"UserInfoViewController"] animated:YES];
}

- (IBAction)kefuClick:(UIButton *)sender {
    
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
    
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"SafeViewController"] animated:YES];

//    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SafeViewController"] animated:YES];
}

- (IBAction)messageClick:(UIButton *)sender {
    
//    MessageCenterViewController *messageCenter = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageCenterViewController"];
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"MessageCenterViewController"] animated:YES];

}

#pragma mark 分享事件

- (IBAction)clickShareBtn:(UIButton *)sender {
    MBLog(@"分享");
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ShareViewController" bundle:nil];
    
    ShareViewController *shareVc = [storyBoard instantiateInitialViewController];
    
    [self.navigationController pushViewController:shareVc animated:YES];
}


- (IBAction)setClick:(UIButton *)sender {
    
//    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingViewController"] animated:YES];
    
    SettingViewController *setting = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateInitialViewController];

    [self.navigationController pushViewController:setting animated:YES];
}


- (IBAction)uppriceClick:(UIButton *)sender {
    
    if ([Person person].payLevelId.length == 0) {
        [MBProgressHUD showError:@"无用户层级, 暂无法充值"];
        return;
    }
    TopUpViewController *topUpVC = [[TopUpViewController alloc] init];
    [self.navigationController pushViewController:topUpVC animated:YES];

}

- (IBAction)downpriceClick:(UIButton *)sender {
    
    GetOutViewController *getoutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GetOutViewController"];
    
    [self.navigationController pushViewController:getoutVC animated:YES];
}

-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/myAccount.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        [[Person person] setupWithDic:data.data];
        
        [self.inviteBtn setTitle:[NSString stringWithFormat:@"邀请码:%@", [Person person].promotionCode ] forState:UIControlStateNormal];
        [self.inviteBtn setTitleColor:[UIColor colorWithHex:@"FFFFFF" Withalpha:0.6] forState:UIControlStateNormal];
        
        self.namelab.text = [Person person].nickname.length > 0 ? [Person person].nickname : [Person person].account;
        
        [self.headimgv sd_setImageWithURL:IMAGEPATH([Person person].heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
        
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}
@end
