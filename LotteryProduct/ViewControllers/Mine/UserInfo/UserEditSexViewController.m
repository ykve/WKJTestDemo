
//
//  UserEditSexViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "UserEditSexViewController.h"

@interface UserEditSexViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *manSelectedImageView;

@property (weak, nonatomic) IBOutlet UIImageView *womanSelectedImageView;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation UserEditSexViewController

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manSelectedImageView.hidden = [Person person].sex.integerValue == 1 ? NO : YES;
    self.womanSelectedImageView.hidden = [Person person].sex.integerValue == 1 ? YES : NO;

    self.confirmBtn.backgroundColor = [[CPTThemeConfig shareManager] confirmBtnBackgroundColor];
    [self.confirmBtn setTitleColor:[[CPTThemeConfig shareManager] confirmBtnTextColor] forState:UIControlStateNormal];
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = self.confirmBtn.height/2;

}

- (IBAction)selectedSexAction:(UIButton *)sender {
    UIImageView *showImageView = sender.tag == 0 ? self.manSelectedImageView : self.womanSelectedImageView;
    UIImageView *hiddenImageView = sender.tag == 1 ? self.manSelectedImageView : self.womanSelectedImageView;
    
    showImageView.hidden = NO;
    
    hiddenImageView.hidden = YES;
    
    
}

- (IBAction)sureClick:(id)sender {
    
    NSString *sex = self.manSelectedImageView.hidden == YES ? @"0" : @"1";
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/updateAccountInfo.json" params:@{@"sex":sex} success:^(BaseData *data) {

        [MBProgressHUD showSuccess:data.info finish:^{
            @strongify(self)

            [Person person].sex = sex;
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}


@end
