//
//  UserEditNicknameViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "UserEditNicknameViewController.h"
#import "NSString+HDValid.h"

@interface UserEditNicknameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *remarklab;

@property (weak, nonatomic) IBOutlet UITextField *namefield;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end

@implementation UserEditNicknameViewController

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.title isEqualToString:@"真实姓名"]) {
        
        self.namefield.text = [Person person].realName;
        
        self.namefield.placeholder = @"请输入您的真实姓名";
    }
    else {
        self.namefield.text = [Person person].nickname;
        
        self.remarklab.hidden = NO;
    }
    self.confirmBtn.backgroundColor = [[CPTThemeConfig shareManager] confirmBtnBackgroundColor];
    [self.confirmBtn setTitleColor:[[CPTThemeConfig shareManager] confirmBtnTextColor] forState:UIControlStateNormal];

    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = self.confirmBtn.height/2;
}


- (IBAction)sureClick:(id)sender {
    
    if ([Tools isEmptyOrNull:self.namefield.text]) {
        
        if ([self.title isEqualToString:@"真实姓名"]) {
            [MBProgressHUD showError:@"请输入真实姓名"];
        }
        else {
             [MBProgressHUD showError:@"请输入昵称"];
        }
       
        return;
    }else{
        if ([self.title isEqualToString:@"真实姓名"]) {
            if(![self.namefield.text isChinese]){
                [MBProgressHUD showError:@"请输入真实姓名"];
                return;
            }
        }
    }
    if ([self.title isEqualToString:@"真实姓名"]) {
        
        [AlertViewTool alertViewToolShowTitle:@"提示" message:@"姓名保存后不能修改，您确定保存吗？" cancelTitle:@"取消" confiormTitle:@"确定" fromController:self handler:^(NSInteger index) {
            
            if (index == 1) {
                @weakify(self)
                [WebTools postWithURL:@"/memberInfo/updateAccountInfo.json" params:@{@"realName":self.namefield.text} success:^(BaseData *data) {

                    [MBProgressHUD showSuccess:data.info finish:^{
                        @strongify(self)

                        [Person person].realName = self.namefield.text;
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    
                } failure:^(NSError *error) {
                    
                } showHUD:NO];
            }
        }];
        
        
    }
    else {
        
        [AlertViewTool alertViewToolShowTitle:@"提示" message:@"昵称保存后不能修改，您确定保存吗？" cancelTitle:@"取消" confiormTitle:@"确定" fromController:self handler:^(NSInteger index) {
            
            if (index == 1) {
                @weakify(self)
                [WebTools postWithURL:@"/memberInfo/updateAccountInfo.json" params:@{@"nickname":self.namefield.text} success:^(BaseData *data) {

                    [MBProgressHUD showSuccess:data.info finish:^{
                        @strongify(self)

                        [Person person].nickname = self.namefield.text;
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    
                } failure:^(NSError *error) {
                    
                } showHUD:NO];
            }
        }];
        
        
    }
    
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
