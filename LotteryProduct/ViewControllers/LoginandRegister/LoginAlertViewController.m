//
//  LoginAlertViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/4/22.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LoginAlertViewController.h"
#import "MainTabbarCtrl.h"
#import "AppDelegate.h"
#import "NavigationVCViewController.h"
#import "RegisterAlertView.h"
#import "ForgetPsdalertView.h"
#import "ChangeNicknameView.h"
#import "LoginTextFeilds.h"
//#import "BandingPhoneCtrl.h"
#import "ZGQActionSheetView.h"
#import "ServiceModel.h"
#import "RequestIPAddress.h"

@interface LoginAlertViewController ()<RegisterAlertViewdelegate, ForgetPsdalertViewDelegate>

@property (weak, nonatomic) IBOutlet LoginTextFeilds *accountTextfield;
@property (weak, nonatomic) IBOutlet LoginTextFeilds *psdTextfield;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIImageView *closeImage;
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UIView *psdView;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (nonatomic, strong)RegisterAlertView *registerView;
@property (nonatomic, strong)ForgetPsdalertView *forgetPsdView;
@property (nonatomic, strong)ChangeNicknameView *changeNicknameView;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (weak, nonatomic) IBOutlet UIImageView *accountImage;

@property (weak, nonatomic) IBOutlet UIImageView *mimaImage;

@property (weak, nonatomic) IBOutlet UILabel *otherLoginLabel;
@property (weak, nonatomic) IBOutlet UIView *leftLine;
@property (weak, nonatomic) IBOutlet UIView *rightLine;

@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;

@property (nonatomic, assign)NSInteger type;


@end

@implementation LoginAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
    
    self.closeImage.image = IMAGE([[CPTThemeConfig shareManager] LoginWhiteClose]);
    NSString *imageName = [[CPTThemeConfig shareManager] LoginBackgroundImage];
    
    self.mainImageView.image = IMAGE(imageName);
    self.accountImage.image = IMAGE([[CPTThemeConfig shareManager] AccountEye]);
    self.mimaImage.image = IMAGE([[CPTThemeConfig shareManager] MimaEye]);
    [self.registerBtn setTitleColor:[[CPTThemeConfig shareManager] LoginTextColor] forState:UIControlStateNormal];
    self.line.backgroundColor = [[CPTThemeConfig shareManager] LoginLinebBackgroundColor];
    [self.forgetBtn setTitleColor:[[CPTThemeConfig shareManager] LoginForgetPsdTextColor] forState:UIControlStateNormal];
    

    self.accountView.layer.cornerRadius = self.accountView.height/2;
    self.accountView.layer.masksToBounds = YES;
    self.accountView.layer.borderColor = [[CPTThemeConfig shareManager] LoginBoardColor].CGColor;
    self.accountView.layer.borderWidth = 1;
    
    self.psdView.layer.cornerRadius = self.accountView.height/2;
    self.psdView.layer.masksToBounds = YES;
    self.psdView.layer.borderColor = [[CPTThemeConfig shareManager] LoginBoardColor].CGColor;
    self.psdView.layer.borderWidth = 1;
    
    [self.loginBtn setTitleColor:[[CPTThemeConfig shareManager] LoginSureBtnTextColor] forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = [[CPTThemeConfig shareManager] LoginBtnBackgroundcolor];
    self.loginBtn.layer.cornerRadius = self.loginBtn.height/2;
    self.loginBtn.layer.masksToBounds = YES;
    
    
    self.accountTextfield.textColor = [[CPTThemeConfig shareManager] LoginTextColor];
    self.psdTextfield.textColor = [[CPTThemeConfig shareManager] LoginTextColor];
    self.otherLoginLabel.textColor = [[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor];
    self.leftLine.backgroundColor = [[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor];
    self.rightLine.backgroundColor = [[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor];
    [self.qqBtn setImage:IMAGE([[CPTThemeConfig shareManager] QQLoginImageName]) forState:UIControlStateNormal];
    [self.wechatBtn setImage:IMAGE([[CPTThemeConfig shareManager] WechatLoginImageName]) forState:UIControlStateNormal];

    [self.closeImage setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.closeImage addGestureRecognizer:tap];
    
    NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:
                                       @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                         NSFontAttributeName:self.accountTextfield.font
                                         }];
    self.accountTextfield.attributedPlaceholder = attrString1;
    
    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:
                                       @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                         NSFontAttributeName:self.accountTextfield.font
                                         }];
    self. psdTextfield.attributedPlaceholder = attrString2;
    
}

#pragma mark - type 登录类型，1：QQ, 2: 微信, 3：微博, 4：手机号，5：账号
-(void)loginWiththirdPath:(UMSocialUserInfoResponse *)resp Withtype:(NSInteger)type {
    
    @weakify(self)
    self.type = type;
    
    self.registerView.type = self.type;
    self.registerView.openid = resp.openid;
    /// 验证是否第一次第三方登录
    [WebTools postWithURL:@"/login/thirdLoginIsFirst" params:@{@"openid":resp.openid} success:^(BaseData *data) {
        @strongify(self)
        
        if ([data.data[@"thirdLoginIsFirst"]integerValue] == 1) {
            
//            BandingPhoneCtrl *band = [[BandingPhoneCtrl alloc]initWithNibName:NSStringFromClass([BandingPhoneCtrl class]) bundle:[NSBundle mainBundle]];
//
//            band.resp = resp;
//
//            band.type = type;
//            band.isfromThird = YES;
//            band.loginBlock = ^(BOOL result, BaseData *banddata) {
//
//                [self loginsuccess:banddata];
//            };
//            PUSH(band);
            
            [self.view addSubview:self.registerView];
        }else {
           
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setValue:@(type) forKey:@"loginType"];
            [dic setValue:resp.openid forKey:@"openid"];
            [dic setValue:resp.name forKey:@"nickname"];
            [dic setValue:resp.iconurl forKey:@"headerImg"];
            [dic setValue:[UIDevice currentDevice].name forKey:@"equipment"];
            [dic setValue:resp.accessToken forKey:@"access_token"];

            MBLog(@"%@", dic);
            @weakify(self)
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

- (IBAction)thirdPartLogin:(UIButton *)sender {
    if (sender.tag == 10) {//qq
        
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
        
    }else{//微信
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
}

//注册
- (IBAction)clickRegister:(UIButton *)sender {
    
    self.type = 4;
    self.registerView.type = self.type;
    [self.view addSubview:self.registerView];
    
    [self.registerView.nickTextField becomeFirstResponder];
    
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    
}
//登录
- (IBAction)login:(UIButton *)sender {
    
    if([self.accountTextfield.text isEqualToString:@"88899966610"]){
        [self accountSwitch];
        return;
    }
    
    if ([Tools isEmptyOrNull:self.accountTextfield.text]) {
        [MBProgressHUD showError:@"请输入手机号或账号"];
        return;
    }
    
    if ([Tools isEmptyOrNull:self.psdTextfield.text]) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    NSString *ip = [RequestIPAddress getIPAddress:YES];
    
    [self.view endEditing:YES];
    NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.psdTextfield.text] MD5];
    @weakify(self)
    [WebTools postWithURL:@"/login/appLogin" params:@{@"loginIp":ip,@"phone":self.accountTextfield.text,@"password":password,@"loginType":@4,@"equipment":[UIDevice currentDevice].name} success:^(BaseData *data) {
        
        @strongify(self)
        
        if (![data.status isEqualToString:@"1"]) {
            return;
        }
        [self loginsuccess:data];
        
    } failure:^(NSError *error) {
        
    } showHUD:YES];
    
}
//关闭
- (void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//注册成功
- (void)registersuccess{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//注册->登录
- (void)registerToLogin{
    [self.forgetPsdView removeFromSuperview];
    [self.registerView removeFromSuperview];
}
//忘记密码跳到注册
- (void)skipToRegisterVc{
    self.type = 4;
    self.registerView.type = self.type;
    [self.view addSubview:self.registerView];
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (IBAction)forgetPsd:(UIButton *)sender {
    [self.view addSubview:self.forgetPsdView];

    [self.forgetPsdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)saveData:(BaseData *)data {
    [[Person person] setupWithDic:data.data];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:data.data forKey:PERSONKEY];
    
    [userDefault synchronize];
}

-(void)loginsuccess:(BaseData *)data {
    
    [self saveData:data];
    
    if (self.loginBlock) {
        self.loginBlock(YES);
    }
    //    [[ChatHelp shareHelper]login];
    
    [JPUSHService setAlias:[Person person].uid completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:2];
    
    if (self.presentingViewController) {
        
        if ([Person person].checkRename) {
            [self renameNickname];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    } else {
        
        MainTabbarCtrl *tab = [[MainTabbarCtrl alloc]init];
        
        NavigationVCViewController *nav = [[NavigationVCViewController alloc]initWithRootViewController:tab];
        
        nav.navigationBar.hidden = YES;
        
        [AppDelegate shareapp].window.rootViewController = nav;
        
//        [[AppDelegate shareapp].window makeKeyAndVisible];
    }
    
} 

- (void)renameNickname{
    
    [self.view addSubview:self.changeNicknameView];
    self.changeNicknameView.nickTextfield.text = [Person person].nickname ? [Person person].nickname : @"";
    [self.changeNicknameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (RegisterAlertView *)registerView{
    if (!_registerView) {
        _registerView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([RegisterAlertView class]) owner:self options:nil]firstObject];
        _registerView.delegate = self;
    }
    return _registerView;
}

- (ForgetPsdalertView *)forgetPsdView{
    if (!_forgetPsdView) {
        _forgetPsdView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ForgetPsdalertView class]) owner:self options:nil]firstObject];
        _forgetPsdView.delegate = self;
    }
    
    return _forgetPsdView;
}
- (ChangeNicknameView *)changeNicknameView{
    if (!_changeNicknameView) {
        _changeNicknameView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ChangeNicknameView class]) owner:self options:nil]firstObject];
    }
    return _changeNicknameView;
}

- (void)accountSwitch {
    [self.view endEditing:YES];
    NSArray *ipArrayTemp = [[ServiceModel sharedInstance] ipArray];
    
    NSMutableArray *newArr = [NSMutableArray array];
    for (NSDictionary *dic in ipArrayTemp) {
        NSString *bankName = dic[@"url"];
        [newArr addObject:bankName];
    }

    
    NSArray *optionArray = @[@"发送给朋友",@"收藏",@"保存图片",@"编辑"];
    ZGQActionSheetView *sheetView = [[ZGQActionSheetView alloc] initWithOptions:newArr completion:^(NSInteger index) {
        NSLog(@"%@",optionArray[index]);
        
        if(index > ipArrayTemp.count) {
            return;
        }
        if(index == ipArrayTemp.count){
//            AddIpViewController *vc = [[AddIpViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:@(index) forKey:@"serverIndex"];
            [ud synchronize];
            [MBProgressHUD showError:@"切换成功，重启生效"];
            [self performSelector:@selector(exitApp) withObject:nil afterDelay:1.0];
        }
        
    } cancel:^{
        NSLog(@"取消");
    }];
    [sheetView show];
}

- (void)exitApp {
    exit(0);
}



@end
