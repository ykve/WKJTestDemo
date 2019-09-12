//
//  ChangeNicknameView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/4/24.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "ChangeNicknameView.h"
#import "AppDelegate.h"
#import "NSString+HDValid.h"

@interface ChangeNicknameView()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *noticeLbl;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (nonatomic, assign)BOOL checkSuccess;
@property (weak, nonatomic) IBOutlet UIImageView *accountImage;
@property (weak, nonatomic) IBOutlet UIButton *backImage;

@property (weak, nonatomic) IBOutlet UIImageView *mainBackImageView;


@end

@implementation ChangeNicknameView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
    self.nickTextfield.textColor = [[CPTThemeConfig shareManager] LoginTextColor];
    [self.backImage setImage:IMAGE([[CPTThemeConfig shareManager] ForgetPsdWhiteBackArrow]) forState:UIControlStateNormal];
    self.titleLbl.textColor = [[CPTThemeConfig shareManager] LoginSureBtnTextColor];
    self.mainBackImageView.image = IMAGE([[CPTThemeConfig shareManager] xxncImageName]);
    self.accountImage.image =  IMAGE([[CPTThemeConfig shareManager] AccountEye]);
    [self.accountImage setImage:IMAGE([[CPTThemeConfig shareManager] AccountEye])];
    self.noticeLbl.textColor = [[CPTThemeConfig shareManager] RegistNoticeTextColor];
    self.titleLbl.textColor = [[CPTThemeConfig shareManager] ForgetPsdTitleTextColor];
    self.backView.layer.borderColor = [[CPTThemeConfig shareManager] LoginBoardColor].CGColor;
    self.backView.layer.borderWidth = 1;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = self.backView.height/2;
    [self.checkBtn setTitle:@"检测" forState:UIControlStateNormal];
    self.checkBtn.layer.masksToBounds = YES;
    self.checkBtn.layer.cornerRadius = self.checkBtn.height/2;
    self.checkBtn.backgroundColor = [[CPTThemeConfig shareManager] xxncCheckBtnBackgroundColor];
    [self.checkBtn setTitleColor:[[CPTThemeConfig shareManager] LoginSureBtnTextColor] forState:UIControlStateNormal];
    self.confirmBtn.backgroundColor = [[CPTThemeConfig shareManager] LoginBtnBackgroundcolor];
    [self.confirmBtn setTitleColor:[[CPTThemeConfig shareManager] LoginSureBtnTextColor] forState:UIControlStateNormal];
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = self.confirmBtn.height/2;
    NSAttributedString *attrString = [[NSAttributedString alloc]
                                      initWithString:@"请输入您要修改的昵称" attributes:
                                      @{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] LoginNamePsdPlaceHoldColor],
                                        NSFontAttributeName:self. nickTextfield.font
                                        }];
    self.nickTextfield.attributedPlaceholder = attrString;  
}

- (IBAction)backToHome:(UIButton *)sender {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                             message:@"退出同时将退出登录"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    @weakify(self)
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        @strongify(self)
        
        [[Person person]deleteCore];
        
//        [[ChatHelp shareHelper]logout];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"LOGINOUT" object:nil];
        
        [self removeFromSuperview];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [[AppDelegate currentViewController] presentViewController:alertController animated:YES completion:nil];
    
}


- (IBAction)confirm:(UIButton *)sender {
    
//    if ((self.nickTextfield.text.length < 2 || self.nickTextfield.text.length > 12)) {
//
//        [MBProgressHUD showError:@"输入昵称（10个字符/6个汉字以内)"];
//
//        return;
//    }
    
    if ([Tools validateNickname:self.nickTextfield.text] == NO){
        
        [MBProgressHUD showError:@"不可输入特殊符号"];
        
        return;
        
    }else if (((self.nickTextfield.text.length < 1 && self.nickTextfield.text.isChinese) || (self.nickTextfield.text.length < 2 && !self.nickTextfield.text.isChinese) || self.nickTextfield.text.length > 12) || (self.nickTextfield.text.length > 6 && self.nickTextfield.text.isChinese)){
        [MBProgressHUD showError:kRegisterNicknamePromptMessage];
        return;
    }
    
    [self resignFirstResponder];

    [WebTools postWithURL:@"/memberInfo/updateAccountInfo.json" params:@{@"nickname" : self.nickTextfield.text} success:^(BaseData *data) {
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        [MBProgressHUD showSuccess:@"修改成功"];
        
        [[AppDelegate currentViewController] dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {

    }];
}
- (IBAction)checkNickname:(id)sender {
    
    [WebTools postWithURL:@"/memberInfo/updateAccountInfo.json" params:@{@"nickname" : self.nickTextfield.text} success:^(BaseData *data) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
