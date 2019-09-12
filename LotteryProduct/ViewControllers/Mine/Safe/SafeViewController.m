//
//  SafeViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SafeViewController.h"
#import "EditPwdViewController.h"
#import "EditPayPwdViewController.h"
#import "WalletViewController.h"
#import "LoadHistoryCtrl.h"
#import "HKEditPwdViewController.h"
#import "HKEditPayPsdViewController.h"

@interface SafeViewController ()


@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (weak, nonatomic) IBOutlet UIImageView *iconimage;

@property (weak, nonatomic) IBOutlet UILabel *iconlab;
@property (weak, nonatomic) IBOutlet UIImageView *safeCenterTopImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SafeViewController

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.safeCenterTopImageView.image = [[CPTThemeConfig shareManager] safeCenterTopImage];
    self.titleLabel.textColor = [[CPTThemeConfig shareManager] CO_Me_TopLabelTitle];
//    if ([Person person].Information) {
//        
//        self.stackView.hidden = YES;
//        self.iconlab.text = @"登录历史";

//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

// 0 修改密码 1 支付密码 2 我的银行卡 3 登录历史
- (IBAction)btnAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        EditPwdViewController *editPwdVC = [[EditPwdViewController alloc] init];
        [self.navigationController pushViewController:editPwdVC animated:YES];
        
    } else if (sender.tag == 1) {
        
        if ([Person person].payPassword.length > 1) {
            
            EditPayPwdViewController *editPwdVC = [[EditPayPwdViewController alloc] init];
            
            [self.navigationController pushViewController:editPwdVC animated:YES];
        }else{
            
            HKEditPayPsdViewController *editPwdVC = [[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"HKEditPayPsdViewController"];

            [self.navigationController pushViewController:editPwdVC animated:YES];
        }
            
        
    } else if (sender.tag == 2) {
        
        WalletViewController *vc = [[WalletViewController alloc] init];
        vc.banklist = YES;
        vc.title = @"银行卡列表";
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (sender.tag == 3) {
        
        LoadHistoryCtrl *loadhistory = [[LoadHistoryCtrl alloc]init];
        
        [self.navigationController pushViewController:loadhistory animated:YES];
    }
}

@end
