//
//  ShowMessageViewController.m
//  LotteryProduct
//
//  Created by pt c on 2019/6/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//
#import "KeFuViewController.h"
#import "ShowMessageViewController.h"

@interface ShowMessageViewController ()

@end

@implementation ShowMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.superview.superview.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
    if(_code == 1){
        self.label.text = @"您的账号出现异常登陆,已被迫下线!";
    }else if (_code == 2){
        self.label.text = @"对不起，您的账号因有违规操作的行为,已被封停账号.";
    }
    
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        _bgImgView.image = IMAGE(@"tw_login_tishi");
        _btn1.backgroundColor = [UIColor colorWithHex:@"FFE38C"];
        _btn2.backgroundColor = [UIColor colorWithHex:@"FFFFFF"];
        [_btn1 setTitleColor:[UIColor colorWithHex:@"756046"] forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor colorWithHex:@"756046"] forState:UIControlStateNormal];
    }else if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_Dark){
        _bgImgView.image = IMAGE(@"td_login_tishi");
        _btn1.backgroundColor = [UIColor colorWithHex:@"565965"];
        _btn2.backgroundColor = [UIColor colorWithHex:@"9E2D32"];
        [_btn1 setTitleColor:WHITE forState:UIControlStateNormal];
        [_btn2 setTitleColor:WHITE forState:UIControlStateNormal];
    }
        
}
//客服
- (IBAction)btn1Click:(UIButton *)sender {
        // 进入会话页面
        KeFuViewController *chatVC = [[KeFuViewController alloc] init]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
        PUSH(chatVC);
}
//完jb成
- (IBAction)btn2Click:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
