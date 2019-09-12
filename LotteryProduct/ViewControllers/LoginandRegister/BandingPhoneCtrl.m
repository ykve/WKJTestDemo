//
//  BandingPhoneCtrl.m
//  TwiKerProduct
//
//  Created by vsskyblue on 2018/4/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "BandingPhoneCtrl.h"
#import "Timebtn.h"
@interface BandingPhoneCtrl ()

@property (weak, nonatomic) IBOutlet UILabel *bandingtitlelab;

@property (weak, nonatomic) IBOutlet UIImageView *imgv_1;

@property (weak, nonatomic) IBOutlet UITextField *textfield_1;

@property (weak, nonatomic) IBOutlet UIImageView *imgv_2;

@property (weak, nonatomic) IBOutlet UITextField *textfield_2;

@property (weak, nonatomic) IBOutlet Timebtn *timeBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeBtn_width;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nav_height;

@property (assign, nonatomic)  BOOL isSuccess;



@end

@implementation BandingPhoneCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isSuccess = NO;
    [self hiddenavView];
    
    self.nav_height.constant = NAV_HEIGHT;
    
    if (self.next) {
        
        self.bandingtitlelab.hidden = YES;
        self.imgv_1.image = IMAGE(@"castle");
        self.imgv_2.image = IMAGE(@"castle");
        self.textfield_1.placeholder = @"密码";
        self.textfield_1.secureTextEntry = YES;
        self.textfield_2.placeholder = @"确认密码";
        self.textfield_2.secureTextEntry = YES;
        self.timeBtn_width.constant = 0;
        self.timeBtn.hidden = YES;
        [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    else {
        
        self.textfield_1.keyboardType = UIKeyboardTypeNumberPad;
        self.textfield_2.keyboardType = UIKeyboardTypeNumberPad;
    }
}

- (IBAction)gettimeClick:(Timebtn *)sender {
    
    if ([Tools validateMobile:self.textfield_1.text]==NO) {
        
        [MBProgressHUD showError:@"请输入正确手机号"];
        
        return;
    }
    sender.enabled = NO;
    @weakify(self)
    [WebTools postWithURL:@"/login/getCaptcha" params:@{@"phone":self.textfield_1.text,@"captchaType":@1} success:^(BaseData *data) {
        @strongify(self)
        [MBProgressHUD showSuccess:@"验证码发送成功"];
        [sender startTime];
        
        [self.textfield_2 becomeFirstResponder];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"验证码发送失败"];
        sender.enabled = YES;
        
    } showHUD:YES];
}

- (IBAction)finishClick:(id)sender {
    
    if (self.next) {
        
        if ([Tools isEmptyOrNull:self.textfield_1.text]) {
            
            [MBProgressHUD showError:@"请输入密码"];
            
            return;
        }
        if ([Tools validatePassword:self.textfield_1.text] == NO || (self.textfield_1.text.length < 6 || self.textfield_1.text.length > 12)) {
            
            [MBProgressHUD showError:@"请输入6-12位数字字母组合密码"];
            
            return;
        }
        if ([Tools isEmptyOrNull:self.textfield_2.text]) {
            
            [MBProgressHUD showError:@"请确认密码"];
            
            return;
        }
        
        [self login];
    }
    else {
        
        if ([Tools validateMobile:self.textfield_1.text]==NO) {
            
            [MBProgressHUD showError:@"请输入正确手机号"];
            
            return;
        }
        if ([Tools isEmptyOrNull:self.textfield_2.text]) {
            
            [MBProgressHUD showError:@"请输入验证码"];
            
            return;
        }
        
        @weakify(self)
        [WebTools postWithURL:@"/login/thirdLoginNext" params:@{@"phone":self.textfield_1.text,@"captcha":self.textfield_2.text} success:^(BaseData *data) {
            @strongify(self)
            BandingPhoneCtrl *band = [[BandingPhoneCtrl alloc]initWithNibName:NSStringFromClass([BandingPhoneCtrl class]) bundle:[NSBundle mainBundle]];
            
            band.next = YES;
            
            band.phone = self.textfield_1.text;
            
            band.testcore = self.textfield_2.text;
            
            band.resp = self.resp;
            
            band.type = self.type;
           
            band.loginBlock = self.loginBlock;
            
            PUSH(band);
            
            
        } failure:^(NSError *error) {
            
           
        } showHUD:NO];
        
    }
    
}

-(void)login {

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@(self.type) forKey:@"loginType"];
    [dic setValue:self.resp.openid forKey:@"openid"];
    [dic setValue:self.resp.name forKey:@"nickname"];
    [dic setValue:self.resp.iconurl forKey:@"headerImg"];
    [dic setValue:[UIDevice currentDevice].name forKey:@"equipment"];
    [dic setValue:self.resp.accessToken forKey:@"access_token"];
    [dic setValue:self.phone forKey:@"phone"];

    if (self.next) {
        NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.textfield_1.text] MD5];
        [dic setValue:password forKey:@"password"];
    }
    
    @weakify(self)
    [WebTools postWithURL:@"/login/appLogin" params:dic success:^(BaseData *data) {
        @strongify(self)
        if (self.loginBlock) {
            self.isSuccess = YES;
            self.loginBlock(YES, data);
        }
        [self popIndex:2];
        
    } failure:^(NSError *error) {
        @strongify(self)

        if (self.loginBlock) {
            
            self.loginBlock(NO,nil);
        }
    }];
}

- (IBAction)backClick:(id)sender {
    if(self.isSuccess){
        [self popback];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
