//
//  RegisterCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RegisterCtrl.h"
#import "MainTabbarCtrl.h"
#import "NavigationVCViewController.h"
#import "AppDelegate.h"
#import <sys/utsname.h>


@interface RegisterCtrl ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topconst;

@property (weak, nonatomic) IBOutlet UITextField *corefield;
@property (weak, nonatomic) IBOutlet UITextField *recoredfield;

@property (weak, nonatomic) IBOutlet UITextField *phonefield;
@property (weak, nonatomic) IBOutlet UITextField *testcorefield;
@property (weak, nonatomic) IBOutlet UIView *testcoreView;
@property (weak, nonatomic) IBOutlet Timebtn *timeBtn;
@property (weak, nonatomic) IBOutlet UITextField *invitefield;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *numberLines;

@property (weak, nonatomic) IBOutlet UIImageView *phoneImage;

@property (weak, nonatomic) IBOutlet UIImageView *codeImage;
@property (weak, nonatomic) IBOutlet UIImageView *psdImage;
@property (weak, nonatomic) IBOutlet UIImageView *psdImageAgain;
@property (weak, nonatomic) IBOutlet UIImageView *inviteImage;

@end

@implementation RegisterCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    self.registerBtn.backgroundColor = [UIColor colorWithHex:@"ac1e2d"];
    [self.registerBtn setTitleColor:WHITE forState:UIControlStateNormal];
    [self.registerBtn setBackgroundImage:IMAGE(@"loginbutton") forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:BASECOLOR forState:UIControlStateHighlighted];
    
    self.registerBtn.backgroundColor = [[CPTThemeConfig shareManager] registerVcRegisterBtnBckgroundColor];
    [self.registerBtn setTitleColor:[[CPTThemeConfig shareManager] registerVcRegisterBtnBTextColor] forState:UIControlStateNormal];
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.cornerRadius = self.registerBtn.height/2;
    self.phoneImage.image = [[CPTThemeConfig shareManager] registerVcPhotoImage];
    self.codeImage.image = [[CPTThemeConfig shareManager] registerVcCodeImage];
    self.psdImage.image = [[CPTThemeConfig shareManager] registerVcPSDImage];
    self.psdImageAgain.image = [[CPTThemeConfig shareManager] registerVcPSDAgainImage];
    self.inviteImage.image = [[CPTThemeConfig shareManager] registerVcInviteImage];
    
    for (UIView *view in self.numberLines) {
        view.backgroundColor = [UIColor colorWithHex:@"eeeeee"];
    }
    self.topconst.constant = NAV_HEIGHT;
    
    self.titlestring = @"注册";
    
    @weakify(self)
    [self leftBtn:nil Withimage:@"tw_nav_return" With:^(UIButton *sender) {
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}
- (IBAction)gettestcoreClick:(Timebtn *)sender {
    
    if ([Tools validateMobile:self.phonefield.text] == NO) {
        
        [MBProgressHUD showError:@"请输入正确手机号"];
        
        return;
    }
    
    sender.enabled = NO;
    
    @weakify(self)
    [WebTools postWithURL:@"/login/getCaptcha" params:@{@"phone":self.phonefield.text,@"captchaType":@1} success:^(BaseData *data) {
        @strongify(self)
        
        [MBProgressHUD showSuccess:@"验证码发送成功"];
        self.testcorefield.text = data.data;
        
        [sender startTime];
        
    } failure:^(NSError *error) {
        
        sender.enabled = YES;
        if (error) {
            [MBProgressHUD showError:@"验证码发送失败"];
        }
    } showHUD:YES];
}

- (IBAction)sureClick:(id)sender {
    
//    if (!self.checkSuccess) {
//        [MBProgressHUD showError:@"请先验证昵称是否可用"];
//        return;
//    }
    
    if ([Tools validatePassword:self.corefield.text] == NO || (self.corefield.text.length < 6 || self.corefield.text.length > 12)) {
        
        [MBProgressHUD showError:@"请输入6-12位数字字母或者下划线组合密码"];

        return;
        
    }
    
    if ([Tools validateNickname:self.phonefield.text] == NO || (self.phonefield.text.length < 2 || self.phonefield.text.length > 10)) {
        
        [MBProgressHUD showError:kRegisterNicknamePromptMessage];
        
        return;
    }
    
    if ([self.corefield.text isEqualToString:self.recoredfield.text] == NO) {
        
        [MBProgressHUD showError:@"两次密码不一致，请重新确认"];
        
        return;
    }
    if ([Tools validateMobile:self.phonefield.text] == NO) {
        
        [MBProgressHUD showError:@"请输入正确手机号"];
        
        return;
    }
    if ([Tools isEmptyOrNull:self.testcorefield.text]) {
        
        [MBProgressHUD showError:@"请输入验证码"];
        
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    struct utsname systemInfo;uname(&systemInfo);
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.corefield.text] MD5];
    [dic setValue:self.phonefield.text forKey:@"account"];
    [dic setValue:password forKey:@"password"];
    [dic setValue:self.phonefield.text forKey:@"phone"];
    [dic setValue:self.testcorefield.text forKey:@"captcha"];
    [dic setValue:self.invitefield.text forKey:@"code"];
    [dic setValue:@4 forKey:@"loginType"];
    [dic setValue:platform forKey:@"equipment"];
    
    @weakify(self)
    [WebTools postWithURL:@"/login/appEnroll" params:dic success:^(BaseData *data) {
        @strongify(self)
        if ([data.status isEqualToString:@"1"]) {
            
            [MBProgressHUD showSuccess:@"注册成功" finish:^{
                if ([data.data isKindOfClass:[NSString class]]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                [self autoLogin];
            }];
        }
        
    } failure:^(NSError *error) {
    } showHUD:YES];
}

- (void)autoLogin{
    
    [self.view endEditing:YES];

    NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.corefield.text] MD5];
    @weakify(self)
    [WebTools postWithURL:@"/login/appLogin" params:@{@"phone":self.phonefield.text,@"password":password,@"loginType":@4,@"equipment":[UIDevice currentDevice].name} success:^(BaseData *data) {
        
        @strongify(self)
        [self loginsuccess:data];
        
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
}

- (IBAction)serviceClick:(id)sender {
}
- (IBAction)privacyClick:(id)sender {
}

-(void)viewDidLayoutSubviews {
    
    [self.testcoreView layoutIfNeeded];
    //    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
    //    [self.testcoreView setBorderWithCornerRadius:5 borderWidth:1 borderColor:kColor(204, 204, 204) type:corners];
    
    
    UIRectCorner corners2 = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    [self.timeBtn setBorderWithCornerRadius:self.timeBtn.width/2 borderWidth:0 borderColor:CLEAR type:corners2];
    self.timeBtn.backgroundColor = [[CPTThemeConfig shareManager] getCodeBtnvBackgroundcolor];//[UIColor colorWithHex:@"bde0ff"];
    [self.timeBtn setTitleColor:[[CPTThemeConfig shareManager]getCodeBtnvTitlecolor] forState:UIControlStateNormal];
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
