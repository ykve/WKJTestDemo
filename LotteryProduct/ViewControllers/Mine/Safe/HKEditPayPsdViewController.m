//
//  HKEditPayPsdViewController.m
//  
//
//  Created by 研发中心 on 2019/3/8.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "HKEditPayPsdViewController.h"

@interface HKEditPayPsdViewController ()

@property (weak, nonatomic) IBOutlet UITextField *setPsdTextfield;

@property (weak, nonatomic) IBOutlet UITextField *confirmTextfield;
@property (weak, nonatomic) IBOutlet UIButton *setBtn;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *numberSeperators;


@end

@implementation HKEditPayPsdViewController

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置支付密码";
    
    if ([Tools isEmptyOrNull:[Person person].payPassword]) {

    }
    for (UIView *view in self.numberSeperators) {
        view.backgroundColor = [UIColor colorWithHex:@"dddddd"];
    }
    self.setBtn.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_NativeViewBack];
    self.setBtn.layer.masksToBounds = YES;
    self.setBtn.layer.cornerRadius = 18;
    self.setPsdTextfield.secureTextEntry = YES;
    self.confirmTextfield.secureTextEntry = YES;
//    self.view.backgroundColor = [[CPTThemeConfig shareManager] ChangePsdViewBackgroundcolor];

}

- (IBAction)setPsdClick:(UIButton *)sender {
    
    
    if ([Tools isEmptyOrNull:[Person person].payPassword]) {
        
        
        if ([Tools isEmptyOrNull:self.setPsdTextfield.text]) {
            
            [MBProgressHUD showError:@"请输入密码"];
            
            return;
        }
        else if ([Tools isEmptyOrNull:self.confirmTextfield.text]) {
            
            [MBProgressHUD showError:@"请确认密码"];
            
            return;
        }
        
        if ([Tools validatePassword:self.setPsdTextfield.text] == NO || (self.setPsdTextfield.text.length < 6 || self.setPsdTextfield.text.length > 12)) {
            
            [MBProgressHUD showError:@"请输入6-12位数字字母组合密码"];
            
            return;
        }
        if ([self.setPsdTextfield.text isEqualToString:self.confirmTextfield.text] == NO) {
            
            [MBProgressHUD showError:@"两次密码不一致，请重新确认"];
            
            return;
        }
        
        NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.setPsdTextfield.text] MD5];
        @weakify(self)
        [WebTools postWithURL:@"/login/updatePayPwd" params:@{@"payPassword":password} success:^(BaseData *data) {

            [Person person].payPassword = self.confirmTextfield.text;
            
            [MBProgressHUD showSuccess:data.info finish:^{
                @strongify(self)

                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        } failure:^(NSError *error) {
            
        }];
    }
    else {
        
        
        if ([Tools isEmptyOrNull:self.setPsdTextfield.text]) {
            
            [MBProgressHUD showError:@"请输入密码"];
            
            return;
        }
        else if ([Tools isEmptyOrNull:self.confirmTextfield.text]) {
            
            [MBProgressHUD showError:@"请确认密码"];
            
            return;
        }
        
        if ([Tools validatePassword:self.setPsdTextfield.text] == NO || (self.setPsdTextfield.text.length < 6 || self.setPsdTextfield.text.length > 12)) {
            
            [MBProgressHUD showError:@"请输入6-12位数字字母组合密码"];
            
            return;
        }
        if ([self.setPsdTextfield.text isEqualToString:self.confirmTextfield.text] == NO) {
            
            [MBProgressHUD showError:@"两次密码不一致，请重新确认"];
            
            return;
        }

        NSString *nowpassword = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.setPsdTextfield.text] MD5];

        NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.setPsdTextfield.text] MD5];
        @weakify(self)
        [WebTools postWithURL:@"/login/updatePayPwd" params:@{@"payPassword":nowpassword,@"oldPayPassword":password} success:^(BaseData *data) {
            [Person person].payPassword = self.confirmTextfield.text;
            [MBProgressHUD showSuccess:data.info finish:^{
                @strongify(self)

                [self.navigationController popViewControllerAnimated:YES];
            }];

        } failure:^(NSError *error) {
             MBLog(@"1");
        }];
        
    }
}


@end
