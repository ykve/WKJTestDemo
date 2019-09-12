//
//  HKEditPwdViewController.m
//  
//
//  Created by 研发中心 on 2019/3/8.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "HKEditPwdViewController.h"

@interface HKEditPwdViewController ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *numberSeperators;

@property (weak, nonatomic) IBOutlet UITextField *sourcePsdTextField;

@property (weak, nonatomic) IBOutlet UITextField *NewpsdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPsdTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
- (IBAction)confirmBtn:(id)sender;

@end

@implementation HKEditPwdViewController

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));

}

- (void)viewDidLoad {
    [super viewDidLoad];

    for (UIView *view in self.numberSeperators) {
        view.backgroundColor = [UIColor colorWithHex:@"dddddd"];
    }
    
    self.confirmBtn.backgroundColor = [[CPTThemeConfig shareManager] confirmBtnBackgroundColor];
    [self.confirmBtn setTitleColor:[[CPTThemeConfig shareManager] confirmBtnTextColor] forState:UIControlStateNormal];

    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = self.confirmBtn.height/2;
    self.view.backgroundColor = [[CPTThemeConfig shareManager] ChangePsdViewBackgroundcolor];
}

//确认修改
- (IBAction)confirmChangePsd:(UIButton *)sender {
    if ([Tools isEmptyOrNull:self.sourcePsdTextField.text]) {
        
        [MBProgressHUD showError:@"请输入原密码"];
        
        return;
    }
    else if ([Tools isEmptyOrNull:self.NewpsdTextField.text]) {
        
        [MBProgressHUD showError:@"请输入新密码"];
        
        return;
    }
    else if ([Tools isEmptyOrNull:self.confirmPsdTextField.text]) {
        
        [MBProgressHUD showError:@"请确认新密码"];
        
        return;
    }
    
    if ([Tools validatePassword:self.NewpsdTextField.text] == NO || (self.NewpsdTextField.text.length < 6 || self.NewpsdTextField.text.length > 12)) {
        
        [MBProgressHUD showError:@"请输入6-12位数字字母组合密码"];
        
        return;
    }
    if ([self.NewpsdTextField.text isEqualToString:self.confirmPsdTextField.text] == NO) {
        
        [MBProgressHUD showError:@"两次密码不一致，请重新确认"];
        
        return;
    }
    
    NSString *nowpassword = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.NewpsdTextField.text] MD5];
    
    NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.sourcePsdTextField.text] MD5];
    @weakify(self)
    [WebTools postWithURL:@"/login/updatePwd" params:@{@"oldPassword":password,@"password":nowpassword} success:^(BaseData *data) {
        [MBProgressHUD showSuccess:@"修改成功" finish:^{
            @strongify(self)

            [[Person person]deleteCore];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"LOGINOUT" object:nil];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
        
    } failure:^(NSError *error) {
        
    }];
}


- (IBAction)confirmBtn:(id)sender {
}
@end
