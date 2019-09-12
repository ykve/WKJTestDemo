//
//  RegisterAlertView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/4/23.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RegisterAlertView.h"
#import <sys/utsname.h>
#import "LoginTextFeilds.h"
#import "NSString+HDValid.h"
#import <VerifyCode/NTESVerifyCodeManager.h>
 #import "RequestIPAddress.h"

@interface RegisterAlertView()<NTESVerifyCodeManagerDelegate>

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *numberBackViews;
@property (weak, nonatomic) IBOutlet UILabel *registerLbl;

@property (weak, nonatomic) IBOutlet UILabel *noticeLbl;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet LoginTextFeilds *accountTextfield;
@property (weak, nonatomic) IBOutlet LoginTextFeilds *psdTextfield;

@property (weak, nonatomic) IBOutlet LoginTextFeilds *codeTextfield;
@property (weak, nonatomic) IBOutlet LoginTextFeilds *psdAgainTextfield;
@property (weak, nonatomic) IBOutlet LoginTextFeilds *inviteTextfield;
@property (weak, nonatomic) IBOutlet UIImageView *closeImgeView;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *getInviteBtn;

@property (weak, nonatomic) IBOutlet UILabel *optionLbl;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIImageView *mainBackGroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *nicknameImage;
@property (weak, nonatomic) IBOutlet UIImageView *accountImage;
@property (weak, nonatomic) IBOutlet UIImageView *codeImage;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UIImageView *inviteImage;

@property (nonatomic, assign)BOOL checkSuccess;
@property(nonatomic,strong)NTESVerifyCodeManager *manager;
@property(weak,nonatomic)IBOutlet Timebtn * timerBtn;

@end

@implementation RegisterAlertView


- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
    
    self.closeImgeView.image = IMAGE([[CPTThemeConfig shareManager] LoginWhiteClose]);

    NSString *imageName = [[CPTThemeConfig shareManager] RegistBackgroundImage];
    
    self.mainBackGroundImageView.image = IMAGE(imageName);
    
    self.nicknameImage.image = IMAGE([[CPTThemeConfig shareManager] NicknameEye]);
    self.accountImage.image = IMAGE([[CPTThemeConfig shareManager] AccountEye]);
    self.codeImage.image = IMAGE([[CPTThemeConfig shareManager] CodeEye]);
    self.firstImage.image = IMAGE([[CPTThemeConfig shareManager] MimaEye]);
    self.secondImage.image = IMAGE([[CPTThemeConfig shareManager] MimaEye]);
    self.inviteImage.image = IMAGE([[CPTThemeConfig shareManager] InviteCodeEye]);
    
    for (UIView *view in self.numberBackViews) {
        view.layer.cornerRadius = view.height/2;
        view.layer.masksToBounds = YES;
        view.layer.borderColor = [[CPTThemeConfig shareManager] LoginBoardColor].CGColor;
        view.layer.borderWidth = 1;
    }
    
    self.checkSuccess = NO;
   
    
   self.nickTextField.textColor =  self.accountTextfield.textColor = self.codeTextfield.textColor =  self.psdTextfield.textColor =  self.psdAgainTextfield.textColor =  self.inviteTextfield.textColor = [[CPTThemeConfig shareManager] LoginTextColor];

    [self.sureBtn setTitleColor:[[CPTThemeConfig shareManager] LoginForgetPsdTextColor] forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[[CPTThemeConfig shareManager] LoginSureBtnTextColor] forState:UIControlStateNormal];
    self.confirmBtn.backgroundColor = [[CPTThemeConfig shareManager] LoginBtnBackgroundcolor];

    [self.loginBtn setTitleColor:[[CPTThemeConfig shareManager] LoginTextColor] forState:UIControlStateNormal];
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = self.confirmBtn.height/2;
    self.line.backgroundColor = [[CPTThemeConfig shareManager] LoginLinebBackgroundColor];
    [self.getInviteBtn setTitleColor:[[CPTThemeConfig shareManager] LoginForgetPsdTextColor] forState:UIControlStateNormal];
    self.optionLbl.textColor = [[CPTThemeConfig shareManager] LoginForgetPsdTextColor];
    self.noticeLbl.textColor = [[CPTThemeConfig shareManager] RegistNoticeTextColor];
    
    NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:@"请输入昵称" attributes:
                                       @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                         NSFontAttributeName:self.accountTextfield.font
                                         }];
    self.nickTextField.attributedPlaceholder = attrString1;
    
    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:@"请输入手机号码" attributes:
                                       @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                         NSFontAttributeName:self.accountTextfield.font
                                         }];
    self.accountTextfield.attributedPlaceholder = attrString2;
    
    NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:
                                       @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                         NSFontAttributeName:self.accountTextfield.font
                                         }];
    self.codeTextfield.attributedPlaceholder = attrString3;
    
    NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:
                                       @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                         NSFontAttributeName:self.accountTextfield.font
                                         }];
    self.psdTextfield.attributedPlaceholder = attrString4;
    NSAttributedString *attrString5 = [[NSAttributedString alloc] initWithString:@"请再次输入密码" attributes:
                                       @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                         NSFontAttributeName:self.accountTextfield.font
                                         }];
    self.psdAgainTextfield.attributedPlaceholder = attrString5;
    NSAttributedString *attrString6 = [[NSAttributedString alloc] initWithString:@"请输入邀请码" attributes:
                                       @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                         NSFontAttributeName:self.accountTextfield.font
                                         }];
    self.inviteTextfield.attributedPlaceholder = attrString6;
    
    [self.closeImgeView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.closeImgeView addGestureRecognizer:tap];

}

- (void)close{
    
    [self removeFromSuperview];
}

- (void)gettttt{
    
    self.manager =  [NTESVerifyCodeManager sharedInstance];
    if (self.manager) {
        
        // 如果需要了解组件的执行情况,则实现回调
        self.manager.delegate = self;
        
        // captchaid的值是每个产品从后台生成的,比如 @"a05f036b70ab447b87cc788af9a60974"
        
        // 传统验证码
//                NSString *captchaid = @"b78ba5655e894b0b918a406554ebb18a";
        //        self.manager.mode = NTESVerifyCodeNormal;
        
        // 无感知验证码
        NSString *captchaid = @"b78ba5655e894b0b918a406554ebb18a";
        self.manager.mode = NTESVerifyCodeNormal;
        
        [self.manager configureVerifyCode:captchaid timeout:10.0];
        
        // 设置语言
        self.manager.lang = NTESVerifyCodeLangCN;
        
        // 设置透明度
        self.manager.alpha = 0.3;
        
        // 设置颜色
        self.manager.color = [UIColor blackColor];
        
        // 设置frame
        self.manager.frame = CGRectNull;
        
        // 是否开启降级方案
        self.manager.openFallBack = YES;
        self.manager.fallBackCount = 20;
        
        // 显示验证码
        [self.manager openVerifyCodeView:nil];
    }
}

//获取验证码
- (IBAction)getCode:(Timebtn *)sender {
    
    if ([Tools validateMobile:self.accountTextfield.text] == NO) {
        
        [MBProgressHUD showError:@"请输入正确手机号"];
        
        return;
    }
    
    [self gettttt];

}

- (void)verifyCodeOk:(NSString *)validate {
    @weakify(self)
    self.timerBtn.enabled = NO;
    
    NSMutableDictionary *dictPar = [[NSMutableDictionary alloc]init];
    [dictPar setValue:self.accountTextfield.text forKey:@"phone"];
    [dictPar setValue:@1 forKey:@"captchaType"];
    [dictPar setValue:validate forKey:@"validate"];

    [WebTools postWithURL:@"/login/getCaptcha" params:dictPar success:^(BaseData *data) {
        @strongify(self)
        
        [MBProgressHUD showSuccess:@"验证码发送成功"];
        self.codeTextfield.text = data.data;
        
       [self.timerBtn startTime];
        
    } failure:^(NSError *error) {
        
        self.timerBtn.enabled = YES;
        if (error) {
            [MBProgressHUD showError:@"验证码发送失败"];
        }
    } showHUD:YES];
}

//确认
- (IBAction)checkNIckname:(id)sender {
    
    if ([Tools validateNickname:self.nickTextField.text] == NO || (self.nickTextField.text.length < 2 || self.nickTextField.text.length > 12)) {
        
        [MBProgressHUD showError:kRegisterNicknamePromptMessage];
        
        return;
        
    }
}

//完成
- (IBAction)confirm:(UIButton *)sender {
    
    
//    if (!self.checkSuccess) {
//        [MBProgressHUD showError:@"请先验证昵称是否可用"];
//        return;
//    }
    
    if ([Tools validatePassword:self.psdTextfield.text] == NO || (self.psdTextfield.text.length < 6 || self.psdTextfield.text.length > 12)) {
        
        [MBProgressHUD showError:@"请输入6-12位数字字母的密码"];
        
        return;
    }

    if ([Tools validateNickname:self.nickTextField.text] == NO){
        
        [MBProgressHUD showError:@"不可输入特殊符号"];
        
        return;
        
    }else if (((self.nickTextField.text.length < 1 && self.nickTextField.text.isChinese) || (self.nickTextField.text.length < 2 && !self.nickTextField.text.isChinese) || self.nickTextField.text.length > 12) || (self.nickTextField.text.length > 6 && self.nickTextField.text.isChinese)){
        [MBProgressHUD showError:kRegisterNicknamePromptMessage];
        return;
    }
    
    if ([self.psdAgainTextfield.text isEqualToString:self.psdTextfield.text] == NO) {
        
        [MBProgressHUD showError:@"两次密码不一致，请重新确认"];
        
        return;
    }
    if ([Tools validateMobile:self.accountTextfield.text] == NO) {
        
        [MBProgressHUD showError:@"请输入正确手机号"];
        
        return;
    }
    if ([Tools isEmptyOrNull:self.codeTextfield.text]) {
        
        [MBProgressHUD showError:@"请输入验证码"];
        
        return;
    }

    [self resignFirstResponder];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    struct utsname systemInfo;uname(&systemInfo);

    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.psdTextfield.text] MD5];
    [dic setValue:self.accountTextfield.text forKey:@"account"];
    [dic setValue:password forKey:@"password"];
    [dic setValue:self.accountTextfield.text forKey:@"phone"];
    [dic setValue:self.codeTextfield.text forKey:@"captcha"];
    [dic setValue:self.inviteTextfield.text forKey:@"code"];
    [dic setValue:@(self.type) forKey:@"loginType"];
    [dic setValue:platform forKey:@"equipment"];
    [dic setValue:self.openid ? self.openid : @"" forKey:@"openid"];
    [dic setValue:self.nickTextField.text forKey:@"nickname"];
    NSString *ip = [RequestIPAddress getIPAddress:YES];
    [dic setValue:ip forKey:@"loginIp"];
    
    @weakify(self)
    [WebTools postWithURL:@"/login/appEnroll" params:dic success:^(BaseData *data) {
        @strongify(self)
        if ([data.status isEqualToString:@"1"]) {
            
            [MBProgressHUD showSuccess:@"注册成功" finish:^{
                if ([data.data isKindOfClass:[NSString class]]) {
                    return;
                }
//                [self autoLogin];
                [self loginsuccess:data];
            }];
        }
        
    } failure:^(NSError *error) {
        
    } showHUD:YES];
}
- (IBAction)skipToLoginVc:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(registerToLogin)]) {
        [self.delegate registerToLogin];
    };
}


- (void)autoLogin{
    
    [self endEditing:YES];
    NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.psdTextfield.text] MD5];
    @weakify(self)
    [WebTools postWithURL:@"/login/appLogin" params:@{@"phone":self.accountTextfield.text,@"password":password,@"loginType":@4,@"equipment":[UIDevice currentDevice].name} success:^(BaseData *data) {
        
        @strongify(self)
        if ([self.delegate respondsToSelector:@selector(registersuccess)]) {
            [self.delegate registersuccess];
        }
        [self loginsuccess:data];
        
    } failure:^(NSError *error) {
        [self removeFromSuperview];
    } showHUD:YES];
    
}

-(void)loginsuccess:(BaseData *)data {
    
    [[Person person] setupWithDic:data.data];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:data.data forKey:PERSONKEY];
    
    [userDefault synchronize];
    
    if ([self.delegate respondsToSelector:@selector(registersuccess)]) {
        [self.delegate registersuccess];
    }
    
    if (self.loginBlock) {
        
        self.loginBlock(YES);
    }
    
    //    [[ChatHelp shareHelper]login];
    
    [JPUSHService setAlias:[Person person].uid completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {

    } seq:2];
    
//    if (self.presentingViewController) {
//
//        [self dismissViewControllerAnimated:YES completion:nil];
//
//    } else {
//
//        MainTabbarCtrl *tab = [[MainTabbarCtrl alloc]init];
//
//        NavigationVCViewController *nav = [[NavigationVCViewController alloc]initWithRootViewController:tab];
//
//        nav.navigationBar.hidden = YES;
//
//        [AppDelegate shareapp].window.rootViewController = nav;
//
//        [[AppDelegate shareapp].window makeKeyAndVisible];
//    }
    
}

#pragma mark - NTESVerifyCodeManagerDelegate
/**
 * 验证码组件初始化完成
 */
- (void)verifyCodeInitFinish{
    MBLog(@"收到初始化完成的回调");
}

/**
 * 验证码组件初始化出错
 *
 * @param message 错误信息
 */
- (void)verifyCodeInitFailed:(NSString *)message{
    MBLog(@"收到初始化失败的回调:%@",message);
}

/**
 * 完成验证之后的回调
 *
 * @param result 验证结果 BOOL:YES/NO
 * @param validate 二次校验数据，如果验证结果为false，validate返回空
 * @param message 结果描述信息
 *
 */
- (void)verifyCodeValidateFinish:(BOOL)result validate:(NSString *)validate message:(NSString *)message{
    MBLog(@"收到验证结果的回调:(%d,%@,%@)", result, validate, message);
    if(result){
        [self verifyCodeOk:validate];
    }
}

/**
 * 关闭验证码窗口后的回调
 */
- (void)verifyCodeCloseWindow{
    //用户关闭验证后执行的方法
    MBLog(@"收到关闭验证码视图的回调");
}

/**
 * 网络错误
 *
 * @param error 网络错误信息
 */
- (void)verifyCodeNetError:(NSError *)error{
    //用户关闭验证后执行的方法
    MBLog(@"收到网络错误的回调:%@(%ld)", [error localizedDescription], (long)error.code);
}
@end
