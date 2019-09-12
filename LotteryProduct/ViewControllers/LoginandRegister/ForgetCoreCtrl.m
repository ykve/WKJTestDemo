//
//  ForgetCoreCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ForgetCoreCtrl.h"

@interface ForgetCoreCtrl ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topconst;
@property (weak, nonatomic) IBOutlet UITextField *corefield;
@property (weak, nonatomic) IBOutlet UITextField *recoredfield;
@property (weak, nonatomic) IBOutlet UITextField *phonefield;
@property (weak, nonatomic) IBOutlet UITextField *testcorefield;
@property (weak, nonatomic) IBOutlet UIView *testcoreView;
@property (weak, nonatomic) IBOutlet Timebtn *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation ForgetCoreCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topconst.constant = NAV_HEIGHT + 20;
    
    self.titlestring = @"忘记密码";
    
    [self.confirmBtn setBackgroundColor:[[CPTThemeConfig shareManager] Login_LogoinBtn_BackgroundC]];
    [self.confirmBtn setTitleColor:[[CPTThemeConfig shareManager] Login_LogoinBtn_TitleC] forState:UIControlStateNormal];
    
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
    
    @weakify(self)
    [WebTools postWithURL:@"/login/getCaptcha" params:@{@"phone":self.phonefield.text,@"captchaType":@2} success:^(BaseData *data) {
        @strongify(self)
        self.testcorefield.text = data.data;
        
        [sender startTime];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

- (IBAction)sureClick:(id)sender {
    
    if ([Tools validateMobile:self.phonefield.text] == NO) {
        
        [MBProgressHUD showError:@"请输入正确手机号码"];
        
        return;
    }
    
    if ([Tools validatePassword:self.corefield.text] == NO || (self.corefield.text.length < 6 || self.corefield.text.length > 12)) {
        
        [MBProgressHUD showError:@"请输入6-12位数字字母或者下划线组合密码"];
        
        return;
        
    }
    
    if ([Tools isEmptyOrNull:self.testcorefield.text]) {
        
        [MBProgressHUD showError:@"请输入验证码"];
        
        return;
    }
    if ([Tools validatePassword:self.corefield.text] == NO) {
        
        [MBProgressHUD showError:@"请输入新密码"];
        
        return;
    }
    if ([self.corefield.text isEqualToString:self.recoredfield.text] == NO) {
        
        [MBProgressHUD showError:@"两次密码不一致，请重新确认"];
        
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:self.phonefield.text forKey:@"phone"];
    [dic setValue:self.testcorefield.text forKey:@"captcha"];
    
    NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.corefield.text] MD5];
    [dic setValue:password forKey:@"password"];
    
    @weakify(self)
    [WebTools postWithURL:@"/login/resetPassword" params:dic success:^(BaseData *data) {
        @strongify(self)
        
        [MBProgressHUD showSuccess:@"修改成功!"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];
}


-(void)viewDidLayoutSubviews {
    
    [self.testcoreView layoutIfNeeded];
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
    [self.testcoreView setBorderWithCornerRadius:5 borderWidth:1 borderColor:kColor(204, 204, 204) type:corners];
    
    UIRectCorner corners2 = UIRectCornerTopRight | UIRectCornerBottomRight;
    [self.timeBtn setBorderWithCornerRadius:5 borderWidth:1 borderColor:CLEAR type:corners2];
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
