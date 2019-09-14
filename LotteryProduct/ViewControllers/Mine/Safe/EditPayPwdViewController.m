//
//  EditPayPwdViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/21.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "EditPayPwdViewController.h"

static const float spwidht = 15;

@interface EditPayPwdViewController ()

@property (strong, nonatomic) UIView *line1View;
@property (strong, nonatomic) UILabel *tit1Label;
/// 原密码
@property (strong, nonatomic) UITextField *pwdTextField;

@property (strong, nonatomic) UIView *line2View;
@property (strong, nonatomic) UILabel *tit2Label;
/// 新密码
@property (strong, nonatomic) UITextField *nowPwdTextField;

@property (strong, nonatomic) UILabel *tit3Label;
/// 确认新的密码
@property (strong, nonatomic) UITextField *sureNowPwdTextField;

@property (strong, nonatomic) UIButton *sureBtn;

@end

@implementation EditPayPwdViewController

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
     [self setupUI];
    
    if ([Tools isEmptyOrNull:[Person person].payPassword]) {
        self.title = @"设置支付密码";
        self.pwdTextField.hidden = YES;
        self.tit2Label.text = @"设置密码";
        self.tit3Label.text = @"确认密码";
        [self.sureBtn setTitle:@"请设置支付密码" forState:UIControlStateNormal];
        
        self.line1View.hidden = YES;
        self.tit1Label.hidden = YES;
        self.pwdTextField.hidden = YES;
        
        [self.line2View mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(44);
            make.left.equalTo(self.view.mas_left).offset(spwidht);
            make.right.equalTo(self.view.mas_right).offset(-spwidht);
            make.height.mas_equalTo(0.5);
        }];
    } else {
        self.title = @"修改支付密码";
        [self.sureBtn setTitle:@"确认修改支付密码" forState:UIControlStateNormal];
    }
    
    self.sureBtn.backgroundColor = [[CPTThemeConfig shareManager] confirmBtnBackgroundColor];
    [self.sureBtn setTitleColor:[[CPTThemeConfig shareManager] confirmBtnTextColor] forState:UIControlStateNormal];
    
}

- (void)sureAction:(UIButton *)sender {
        
    if ([Tools isEmptyOrNull:[Person person].payPassword]) {
        
        
        if ([Tools isEmptyOrNull:self.nowPwdTextField.text]) {
            
            [MBProgressHUD showError:@"请输入密码"];
            
            return;
        }
        if ([Tools validatePassword:self.nowPwdTextField.text] == NO || (self.nowPwdTextField.text.length < 6 || self.nowPwdTextField.text.length > 12)) {
            
            [MBProgressHUD showError:@"请输入6-12位数字字母组合密码"];
            
            return;
        }
        
        else if ([Tools isEmptyOrNull:self.sureNowPwdTextField.text]) {
            
            [MBProgressHUD showError:@"请确认密码"];
            return;
        }
        
        if ([self.nowPwdTextField.text isEqualToString:self.sureNowPwdTextField.text] == NO) {
            
            [MBProgressHUD showError:@"两次密码不一致，请重新确认"];
            return;
        }
        
        NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.nowPwdTextField.text] MD5];
        @weakify(self)
        [WebTools postWithURL:@"/login/updatePayPwd" params:@{@"payPassword":password} success:^(BaseData *data) {
            [Person person].payPassword = self.sureNowPwdTextField.text;
            
            [MBProgressHUD showSuccess:data.info finish:^{
                @strongify(self)
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        } failure:^(NSError *error) {
            
        }];
    } else {
        
        if ([Tools isEmptyOrNull:self.pwdTextField.text]) {
            
            [MBProgressHUD showError:@"请输入原密码"];
            return;
        }
        
        if ([Tools isEmptyOrNull:self.nowPwdTextField.text]) {
            [MBProgressHUD showError:@"请输入新密码"];
            return;
        }
        if ([Tools validatePassword:self.nowPwdTextField.text] == NO || (self.nowPwdTextField.text.length < 6 || self.nowPwdTextField.text.length > 12)) {
            [MBProgressHUD showError:@"请输入6-12位数字字母组合密码"];
            return;
        }
        
        if ([Tools isEmptyOrNull:self.sureNowPwdTextField.text]) {
            [MBProgressHUD showError:@"请确认新密码"];
            return;
        }
        
        
        if ([self.nowPwdTextField.text isEqualToString:self.sureNowPwdTextField.text] == NO) {
            
            [MBProgressHUD showError:@"两次密码不一致，请重新确认"];
            return;
        }
        
        NSString *nowpassword = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.nowPwdTextField.text] MD5];
        
        NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.pwdTextField.text] MD5];
        @weakify(self)
        [WebTools postWithURL:@"/login/updatePayPwd" params:@{@"payPassword":nowpassword,@"oldPayPassword":password} success:^(BaseData *data) {
            [Person person].payPassword = self.sureNowPwdTextField.text;
            [MBProgressHUD showSuccess:data.info finish:^{
                @strongify(self)
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        } failure:^(NSError *error) {
            MBLog(@"1");
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    
    UIView *line1View = [[UIView alloc] init];
    line1View.backgroundColor = [UIColor colorWithHex:@"#DDDDDD"];
    [self.view addSubview:line1View];
    _line1View = line1View;
    
    [line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(44);
        make.left.equalTo(self.view.mas_left).offset(spwidht);
        make.right.equalTo(self.view.mas_right).offset(-spwidht);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *line2View = [[UIView alloc] init];
    line2View.backgroundColor = [UIColor colorWithHex:@"#DDDDDD"];
    [self.view addSubview:line2View];
    _line2View = line2View;
    
    [line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1View.mas_bottom).offset(44);
        make.left.equalTo(self.view.mas_left).offset(spwidht);
        make.right.equalTo(self.view.mas_right).offset(-spwidht);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *line3View = [[UIView alloc] init];
    line3View.backgroundColor = [UIColor colorWithHex:@"#DDDDDD"];
    [self.view addSubview:line3View];
    
    [line3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2View.mas_bottom).offset(44);
        make.left.equalTo(self.view.mas_left).offset(spwidht);
        make.right.equalTo(self.view.mas_right).offset(-spwidht);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UILabel *tit1Label = [[UILabel alloc] init];
    tit1Label.text = @"输入原始密码";
    tit1Label.font = [UIFont systemFontOfSize:15];
    tit1Label.textColor = [UIColor colorWithHex:@"#333333"];
    tit1Label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tit1Label];
    _tit1Label = tit1Label;
    
    [tit1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line1View.mas_bottom).offset(-spwidht);
        make.left.equalTo(self.view.mas_left).offset(spwidht);
        make.width.mas_equalTo(95);
    }];
    
    UITextField *pwdTextField = [[UITextField alloc] init];
    pwdTextField.tag = 1000;
    pwdTextField.backgroundColor = [UIColor whiteColor];  // 更改背景颜色
    pwdTextField.borderStyle = UITextBorderStyleNone;  //边框类型
    pwdTextField.font = [UIFont systemFontOfSize:14.0];  // 字体
    pwdTextField.textColor = [UIColor blueColor];  // 字体颜色
    pwdTextField.placeholder = @"请输入原始密码"; // 占位文字
    pwdTextField.clearButtonMode = UITextFieldViewModeAlways; // 清空按钮
    //    pwdTextField.delegate = self;
    pwdTextField.keyboardType = UIKeyboardTypeEmailAddress; // 键盘类型
    pwdTextField.returnKeyType = UIReturnKeyGo;
    pwdTextField.secureTextEntry = YES; // 密码
    [self.view addSubview:pwdTextField];
    _pwdTextField = pwdTextField;
    
    [pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tit1Label.mas_centerY);
        make.left.equalTo(tit1Label.mas_right).offset(spwidht);
        make.right.mas_equalTo(self.view.mas_right).offset(-spwidht);
        make.height.mas_equalTo(@(30));
    }];
    
    
    UILabel *tit2Label = [[UILabel alloc] init];
    tit2Label.text = @"输入新的密码";
    tit2Label.font = [UIFont systemFontOfSize:15];
    tit2Label.textColor = [UIColor colorWithHex:@"#333333"];
    tit2Label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tit2Label];
    _tit2Label = tit2Label;
    
    [tit2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line2View.mas_bottom).offset(-spwidht);
        make.left.equalTo(self.view.mas_left).offset(spwidht);
        make.width.mas_equalTo(95);
    }];
    
    UITextField *nowPwdTextField = [[UITextField alloc] init];
    nowPwdTextField.tag = 1001;
    nowPwdTextField.backgroundColor = [UIColor whiteColor];  // 更改背景颜色
    nowPwdTextField.borderStyle = UITextBorderStyleNone;  //边框类型
    nowPwdTextField.font = [UIFont systemFontOfSize:14.0];  // 字体
    nowPwdTextField.textColor = [UIColor blueColor];  // 字体颜色
    nowPwdTextField.placeholder = @"请输入6~16位数字字母组合密码"; // 占位文字
    nowPwdTextField.clearButtonMode = UITextFieldViewModeAlways; // 清空按钮
    //    nowPwdTextField.delegate = self;
    nowPwdTextField.keyboardType = UIKeyboardTypeEmailAddress; // 键盘类型
    nowPwdTextField.returnKeyType = UIReturnKeyGo;
    nowPwdTextField.secureTextEntry = YES; // 密码
    [self.view addSubview:nowPwdTextField];
    _nowPwdTextField = nowPwdTextField;
    
    [nowPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tit2Label.mas_centerY);
        make.left.equalTo(tit2Label.mas_right).offset(spwidht);
        make.right.equalTo(self.view.mas_right).offset(-spwidht);
        make.height.mas_equalTo(@(30));
    }];
    
    
    
    UILabel *tit3Label = [[UILabel alloc] init];
    tit3Label.text = @"重复新的密码";
    tit3Label.font = [UIFont systemFontOfSize:15];
    tit3Label.textColor = [UIColor colorWithHex:@"#333333"];
    tit3Label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tit3Label];
    _tit3Label = tit3Label;
    
    [tit3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line3View.mas_bottom).offset(-spwidht);
        make.left.equalTo(self.view.mas_left).offset(spwidht);
        make.width.mas_equalTo(95);
    }];
    
    UITextField *sureNowPwdTextField = [[UITextField alloc] init];
    sureNowPwdTextField.tag = 1002;
    sureNowPwdTextField.backgroundColor = [UIColor whiteColor];  // 更改背景颜色
    sureNowPwdTextField.borderStyle = UITextBorderStyleNone;  //边框类型
    sureNowPwdTextField.font = [UIFont systemFontOfSize:14.0];  // 字体
    sureNowPwdTextField.textColor = [UIColor blueColor];  // 字体颜色
    sureNowPwdTextField.placeholder = @"请再次输入密码"; // 占位文字
    sureNowPwdTextField.clearButtonMode = UITextFieldViewModeAlways; // 清空按钮
    //    sureNowPwdTextField.delegate = self;
    sureNowPwdTextField.keyboardType = UIKeyboardTypeEmailAddress; // 键盘类型
    sureNowPwdTextField.returnKeyType = UIReturnKeyGo;
    sureNowPwdTextField.secureTextEntry = YES; // 密码
    [self.view addSubview:sureNowPwdTextField];
    _sureNowPwdTextField = sureNowPwdTextField;
    
    [sureNowPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tit3Label.mas_centerY);
        make.left.equalTo(tit3Label.mas_right).offset(spwidht);
        make.right.mas_equalTo(self.view.mas_right).offset(-spwidht);
        make.height.mas_equalTo(@(30));
    }];
    
    
    UIButton *confirmBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"-" andTitleColor:[[CPTThemeConfig shareManager] ApplyExpertConfirmBtnTextColor] andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(sureAction:) andType:UIButtonTypeCustom];
    confirmBtn.backgroundColor = [[CPTThemeConfig shareManager] CO_Account_Info_BtnBack];
    confirmBtn.layer.cornerRadius = 20;
    confirmBtn.layer.masksToBounds = YES;
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:confirmBtn];
    _sureBtn = confirmBtn;
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(line3View.mas_bottom).offset(50);
        make.height.mas_equalTo(@40);
    }];
    
}

@end