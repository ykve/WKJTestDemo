//
//  LoginCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "LoginCtrl.h"
#import "RegisterCtrl.h"
#import "ForgetCoreCtrl.h"
#import "MainTabbarCtrl.h"
#import "NavigationVCViewController.h"
#import "AppDelegate.h"
#import <UMMobClick/MobClick.h>
#import <UMSocialCore/UMSocialCore.h>
#import "BandingPhoneCtrl.h"

@interface LoginCtrl ()

@property (weak, nonatomic) IBOutlet UIImageView *logoIcon;

@property (weak, nonatomic) IBOutlet UIImageView *loginBgImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topconst;
@property (weak, nonatomic) IBOutlet UITextField *namefield;
@property (weak, nonatomic) IBOutlet UITextField *corefield;

@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
@property (weak, nonatomic) IBOutlet UILabel *thirdlab;
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *coreView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *sBtn;
@property (weak, nonatomic) IBOutlet UIButton *fBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coreViewTopConst;

@property (weak, nonatomic) IBOutlet UIButton *hiddenBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameViewTopconst;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;

@property (weak, nonatomic) IBOutlet UIView *nameLine;
@property (weak, nonatomic) IBOutlet UIView *psdLine;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *numberLines;

@property (weak, nonatomic) IBOutlet UIImageView *phoneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *psdImageView;

@property (nonatomic, assign)NSInteger tapCount;

@end

@implementation LoginCtrl

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.tapCount += 1;
    if (self.tapCount == 8) {
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tapCount = 0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVersion)];
    
    tap.numberOfTapsRequired = 5;
    
    
    [self.view addGestureRecognizer:tap];
    
    for (UIView *view in self.numberLines) {
        view.backgroundColor = [[CPTThemeConfig shareManager] loginSeperatorLineColor];
    }
    
    [self.loginBtn setBackgroundImage:IMAGE(@"loginbutton") forState:UIControlStateNormal];
    self.thirdlab.textColor = [[CPTThemeConfig shareManager] loginSeperatorLineColor];
    self.navView.backgroundColor = WHITE;
    self.coreView.backgroundColor = WHITE;
    self.topMargin.constant = 130;
    self.loginBgImage.image = [[CPTThemeConfig shareManager] loginVcBgImage];
    self.logoIcon.image = [[CPTThemeConfig shareManager] logoIconImage];
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = self.loginBtn.height/2;
    [self.qqBtn setImage:[[CPTThemeConfig shareManager] loginVcQQimage] forState:UIControlStateNormal];
    [self.wechatBtn setImage:[[CPTThemeConfig shareManager] loginVcWechatimage] forState:UIControlStateNormal];
    self.phoneImageView.image = [[CPTThemeConfig shareManager] LoginVcPhoneImage];
    self.psdImageView.image = IMAGE([[CPTThemeConfig shareManager] MimaEye]);
    [self.hiddenBtn setImage:[[CPTThemeConfig shareManager] LoginVcHiddenImage] forState:UIControlStateNormal];
    [self.hiddenBtn setImage:[[CPTThemeConfig shareManager] LoginVcHiddenSelectImage] forState:UIControlStateSelected];



    [self hiddenavView];
    self.coreViewTopConst.constant = self.coreViewTopConst.constant+15.f;
    [self.loginBtn setBackgroundColor:[[CPTThemeConfig shareManager] Login_LogoinBtn_BackgroundC]];
    [self.loginBtn setTitleColor:[[CPTThemeConfig shareManager] Login_LogoinBtn_TitleC] forState:UIControlStateNormal];
    self.fBtn.layer.cornerRadius = 2.;

    [self.sBtn setTitleColor:[[CPTThemeConfig shareManager] Login_ForgetSigUpBtn_TitleC] forState:UIControlStateNormal];
    [self.fBtn setTitleColor:[[CPTThemeConfig shareManager] Login_ForgetSigUpBtn_TitleC] forState:UIControlStateNormal];
    self.nameViewTopconst.constant = self.nameViewTopconst.constant-30;
        NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:
                                           @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                             NSFontAttributeName:self.namefield.font
                                             }];
        self.namefield.attributedPlaceholder = attrString1;
        
        NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:
                                           @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                             NSFontAttributeName:self.corefield.font
                                             }];
        self.corefield.attributedPlaceholder = attrString2;

        self.nameView.backgroundColor = self.coreView.backgroundColor = [[CPTThemeConfig shareManager] Login_NamePasswordView_BackgroundC];
    self.namefield.textColor = [[CPTThemeConfig shareManager] LoginNamePsdTextColor];
    self.corefield.textColor = [[CPTThemeConfig shareManager] LoginNamePsdTextColor];
        @weakify(self)
        [self.coreView mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.nameView.mas_bottom).offset(10.);
        }];

}


- (void)showVersion{
    
    [AlertViewTool alertShowTestInfo:self];
}

- (IBAction)cancelClick:(id)sender {
    
    if (self.loginBlock) {
        
        self.loginBlock(NO);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginClick:(id)sender {
    
    if ([Tools isEmptyOrNull:self.namefield.text]) {
        [MBProgressHUD showError:@"请输入手机号或账号"];
        return;
    }
    if ([Tools isEmptyOrNull:self.corefield.text]) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    [self.view endEditing:YES];
    NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.corefield.text] MD5];
    @weakify(self)
    [WebTools postWithURL:@"/login/appLogin" params:@{@"phone":self.namefield.text,@"password":password,@"loginType":@4,@"equipment":[UIDevice currentDevice].name} success:^(BaseData *data) {
        
        @strongify(self)
        [self loginsuccess:data];
        
    } failure:^(NSError *error) {
        
    } showHUD:YES];
   
}
- (IBAction)hiddenPClick:(UITextField*)sender {
    //避免明文/密文切换后光标位置偏移
    self.corefield.enabled = NO;
    self.corefield.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
    self.corefield.enabled = YES;// the second one;
    [self.corefield becomeFirstResponder];// the third one

}
- (IBAction)forgetClick:(id)sender {
    
    ForgetCoreCtrl *forget = [[ForgetCoreCtrl alloc]initWithNibName:NSStringFromClass([ForgetCoreCtrl class]) bundle:[NSBundle mainBundle]];
    
    PUSH(forget);
}
- (IBAction)registerClick:(id)sender {
    
    RegisterCtrl *ctrl = [[RegisterCtrl alloc]initWithNibName:NSStringFromClass([RegisterCtrl class]) bundle:[NSBundle mainBundle]];
    
    PUSH(ctrl);
}
- (IBAction)loginWeChatClick:(id)sender {
    @weakify(self)
    [[UMSocialManager defaultManager]getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        @strongify(self)

        if (error == nil) {
            
            UMSocialUserInfoResponse *resp = result;
            
            if([Tools isEmptyOrNull:resp.uid]){
                
                [MBProgressHUD ShowWDMessage:@"授权失败"];
                
                [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_WechatSession completion:^(id result, NSError *error) {
                    
                    NSLog(@"%@",result);
                }];
                
            }
            else{
                @strongify(self)
                [self loginWiththirdPath:resp Withtype:2];
            }
        }
        else {
            
            [MBProgressHUD ShowWDMessage:@"授权失败"];
        }
    }];
}
- (IBAction)loginQQClick:(id)sender {
    
    @weakify(self)
    [[UMSocialManager defaultManager]getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:self completion:^(id result, NSError *error) {
        @strongify(self)

        if (error == nil) {
            
            UMSocialUserInfoResponse *resp = result;
            
            if([Tools isEmptyOrNull:resp.uid]){
                
                [MBProgressHUD ShowWDMessage:@"授权失败"];
                
                [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_QQ completion:^(id result, NSError *error) {
                    
                    NSLog(@"%@",result);
                }];
                
            }
            else{

                [self loginWiththirdPath:resp Withtype:1];
            }
        }
        else {
            
            [MBProgressHUD ShowWDMessage:@"授权失败"];
        }
    }];
}
#pragma mark - type 登录类型，1：QQ, 2: 微信, 3：微博, 4：手机号，5：账号
-(void)loginWiththirdPath:(UMSocialUserInfoResponse *)resp Withtype:(NSInteger)type {
    
    @weakify(self)
    /// 验证是否第一次第三方登录
    [WebTools postWithURL:@"/login/thirdLoginIsFirst" params:@{@"openid":resp.openid} success:^(BaseData *data) {
        @strongify(self)
        
        if ([data.data[@"thirdLoginIsFirst"]integerValue] == 1) {
            
            BandingPhoneCtrl *band = [[BandingPhoneCtrl alloc]initWithNibName:NSStringFromClass([BandingPhoneCtrl class]) bundle:[NSBundle mainBundle]];
            
            band.resp = resp;
            
            band.type = type;
            band.isfromThird = YES;
            band.loginBlock = ^(BOOL result, BaseData *banddata) {
                
                [self loginsuccess:banddata];
            };

            PUSH(band);
        }else {
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setValue:@(type) forKey:@"loginType"];
            [dic setValue:resp.openid forKey:@"openid"];
            [dic setValue:resp.name forKey:@"nickname"];
            [dic setValue:resp.iconurl forKey:@"headerImg"];
            [dic setValue:[UIDevice currentDevice].name forKey:@"equipment"];
            [dic setValue:resp.accessToken forKey:@"access_token"];
            
            MBLog(@"%@", dic);
            [WebTools postWithURL:@"/login/appLogin" params:dic success:^(BaseData *data) {
                @strongify(self)
                [self loginsuccess:data];
                
            } failure:^(NSError *error) {
                
                if (self.loginBlock) {
                    
                    self.loginBlock(NO);
                }
            }];
        }
        
    } failure:^(NSError *error) {
        
        
    } showHUD:YES];
 
}

-(void)loginsuccess:(BaseData *)data {
    
    [[Person person] setupWithDic:data.data];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:data.data forKey:PERSONKEY];
    
    [userDefault synchronize];
    
    if (self.loginBlock) {
        
        self.loginBlock(YES);
    }
    
//    [[ChatHelp shareHelper]login];
    
    [JPUSHService setAlias:[Person person].uid completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
        
        
    } seq:2];
    
    if (self.presentingViewController) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        
        MainTabbarCtrl *tab = [[MainTabbarCtrl alloc]init];
        
        NavigationVCViewController *nav = [[NavigationVCViewController alloc]initWithRootViewController:tab];
        
        nav.navigationBar.hidden = YES;
        
        [AppDelegate shareapp].window.rootViewController = nav;
        
//        [[AppDelegate shareapp].window makeKeyAndVisible];
    }
    
    if ([Person person].checkRename) {
//        [self renameNickname];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
