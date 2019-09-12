//
//  ForgetPsdalertView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/4/23.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "ForgetPsdalertView.h"
#import "LoginTextFeilds.h"
@interface ForgetPsdalertView ()
@property (weak, nonatomic) IBOutlet UIImageView *mainBackImageView;

@property (weak, nonatomic) IBOutlet UIImageView *closeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *numberBackViews;

@property (weak, nonatomic) IBOutlet LoginTextFeilds *codeTextfield;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet LoginTextFeilds *psdTextfield;
@property (weak, nonatomic) IBOutlet LoginTextFeilds *psdAgainTextfield;
@property (weak, nonatomic) IBOutlet UILabel *forgetPsdLbl;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIImageView *accountImage;
@property (weak, nonatomic) IBOutlet UIImageView *codeImage;
@property (weak, nonatomic) IBOutlet UIImageView *mimaImage;
@property (weak, nonatomic) IBOutlet UIImageView *sencondMimaImage;
@property (weak, nonatomic) IBOutlet UIImageView *closeImage;

@end

@implementation ForgetPsdalertView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
    

    self.accountTextfield.textColor = self.codeTextfield.textColor =  self.psdTextfield.textColor =  self.psdAgainTextfield.textColor = [[CPTThemeConfig shareManager] LoginTextColor];
    
    self.accountImage.image = IMAGE([[CPTThemeConfig shareManager] AccountEye]);
    self.codeImage.image = IMAGE([[CPTThemeConfig shareManager] CodeEye]);
    self.mimaImage.image = IMAGE([[CPTThemeConfig shareManager] MimaEye]);
    self.sencondMimaImage.image = IMAGE([[CPTThemeConfig shareManager] MimaEye]);
    self.backImageView.image = IMAGE([[CPTThemeConfig shareManager] ForgetPsdWhiteBackArrow]);
    self.closeImage.image = IMAGE([[CPTThemeConfig shareManager] LoginWhiteClose]);
    NSString *imageName = [[CPTThemeConfig shareManager] ForgetPsdBackgroundImage];
    self.mainBackImageView.image = IMAGE(imageName); 
    [self.backImageView setUserInteractionEnabled:YES];
    [self.closeImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
    [self.backImageView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
    [self.closeImageView addGestureRecognizer:closeTap];
    self.forgetPsdLbl.textColor = [[CPTThemeConfig shareManager] ForgetPsdTitleTextColor];
    [self.registerBtn setTitleColor:[[CPTThemeConfig shareManager] LoginTextColor] forState:UIControlStateNormal];
    
    for (UIView *view in self.numberBackViews) {
        view.layer.cornerRadius = view.height/2;
        view.layer.masksToBounds = YES;
        view.layer.borderColor = [[CPTThemeConfig shareManager] LoginBoardColor].CGColor;
        view.layer.borderWidth = 1;
    }
    [self.confirmBtn setTitleColor:[[CPTThemeConfig shareManager] LoginSureBtnTextColor] forState:UIControlStateNormal];
    self.confirmBtn.backgroundColor = [[CPTThemeConfig shareManager] LoginBtnBackgroundcolor];
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = self.confirmBtn.height/2;
    self.line.backgroundColor = [[CPTThemeConfig shareManager] LoginLinebBackgroundColor];
    [self.getCodeBtn setTitleColor:[[CPTThemeConfig shareManager] LoginForgetPsdTextColor] forState:UIControlStateNormal];
    
    NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:@"请输入手机号码" attributes:
                                       @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                         NSFontAttributeName:self.accountTextfield.font
                                         }];
    self.accountTextfield.attributedPlaceholder = attrString1;
    
    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:
                                       @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                         NSFontAttributeName:self.accountTextfield.font
                                         }];
    self.codeTextfield.attributedPlaceholder = attrString2;
    
    NSAttributedString *attrString3 = [[NSAttributedString alloc] initWithString:@"请输入新密码" attributes:
                                       @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                         NSFontAttributeName:self.accountTextfield.font
                                         }];
    self.psdTextfield.attributedPlaceholder = attrString3;
    
    NSAttributedString *attrString4 = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:
                                       @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                         NSFontAttributeName:self.accountTextfield.font
                                         }];
    self.psdAgainTextfield.attributedPlaceholder = attrString4;
    NSAttributedString *attrString5 = [[NSAttributedString alloc] initWithString:@"请重复密码" attributes:
                                       @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                         NSFontAttributeName:self.accountTextfield.font
                                         }];
    self.psdAgainTextfield.attributedPlaceholder = attrString5;
    
}

- (void)removeSelf{
    [self removeFromSuperview];
}

- (IBAction)getCode:(Timebtn *)sender {
    
    if ([Tools validateMobile:self.accountTextfield.text] == NO) {
        
        [MBProgressHUD showError:@"请输入正确手机号"];
        
        return;
    }
    
    sender.enabled = NO;
    
    @weakify(self)
    [WebTools postWithURL:@"/login/getCaptcha" params:@{@"phone":self.accountTextfield.text,@"captchaType":@2} success:^(BaseData *data) {
        @strongify(self)
        
        [MBProgressHUD showSuccess:@"验证码发送成功"];
        self.codeTextfield.text = data.data;
        
        [sender startTime];
        
    } failure:^(NSError *error) {
        
        sender.enabled = YES;
        if (error) {
//            [MBProgressHUD showError:@"验证码发送失败"];
        }
    } showHUD:YES];
}

- (IBAction)confirm:(UIButton *)sender {
    
    if ([Tools validateMobile:self.accountTextfield.text] == NO) {
        
        [MBProgressHUD showError:@"请输入正确手机号码"];
        
        return;
    }
    
    if ([Tools validatePassword:self.psdTextfield.text] == NO || (self.psdTextfield.text.length < 6 || self.psdTextfield.text.length > 12)) {
        [MBProgressHUD showError:@"请输入6-12位数字字母或者下划线组合密码"];
        return;
    }
    
    
    if ([Tools isEmptyOrNull:self.codeTextfield.text]) {
        
        [MBProgressHUD showError:@"请输入验证码"];
        
        return;
    }
    
    if ([Tools validatePassword:self.psdTextfield.text] == NO) {
        
        [MBProgressHUD showError:@"请输入新密码"];
        
        return;
    }
    if ([self.psdTextfield.text isEqualToString:self.psdAgainTextfield.text] == NO) {
        
        [MBProgressHUD showError:@"两次密码不一致，请重新确认"];
        
        return;
    }
    
    [self resignFirstResponder];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:self.accountTextfield.text forKey:@"phone"];
    [dic setValue:self.codeTextfield.text forKey:@"captcha"];
    
    NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.psdTextfield.text] MD5];
    [dic setValue:password forKey:@"password"];
    
    @weakify(self)
    [WebTools postWithURL:@"/login/resetPassword" params:dic success:^(BaseData *data) {
        @strongify(self)
        
        [MBProgressHUD showSuccess:@"修改成功!"];
        
        [self removeFromSuperview];
    } failure:^(NSError *error) {
        
    }];
}

- (void)closeView{
    [self removeFromSuperview];
}
- (IBAction)skipToRegiuster:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(skipToRegisterVc)]) {
        [self.delegate skipToRegisterVc];
    }
    
}
@end
