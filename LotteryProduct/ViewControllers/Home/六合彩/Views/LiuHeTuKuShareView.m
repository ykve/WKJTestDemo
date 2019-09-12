//
//  LiuHeTuKuShareView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/18.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiuHeTuKuShareView.h"
#import "LoginAlertViewController.h"
#import "AppDelegate.h"

@interface LiuHeTuKuShareView ()
@property (weak, nonatomic) IBOutlet UIView *topline;


@end

@implementation LiuHeTuKuShareView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.topline.backgroundColor = [UIColor colorWithHex:@"EFEEF3"];
    
}



- (IBAction)share:(UIButton *)sender {//tag 10 QQ 20微信 30 朋友圈
    
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [[AppDelegate currentViewController] presentViewController:login animated:YES completion:nil];
        login.loginBlock = ^(BOOL result) {
            
        };
        return;
    }
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"xinshuiRecommentShare" object:sender];
    
}




@end
