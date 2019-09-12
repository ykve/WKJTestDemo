//
//  SixInfoBaseCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/12.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixInfoBaseCtrl.h"

@interface SixInfoBaseCtrl ()

@end

@implementation SixInfoBaseCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    [self rigBtn:@"100" Withimage:nil With:^(UIButton *sender) {
        
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        
        [alert buildsixversionsView];
        
        alert.showalertBlock = ^(NSString *version) {
            @strongify(self)
            [self.rightBtn setTitle:version forState:UIControlStateNormal];
            
            self.versionnumber = version;
        };
        
        [alert show];
    }];
    self.rightBtn.layer.cornerRadius = 5;
    self.rightBtn.backgroundColor = WHITE;
    [self.rightBtn setTitleColor:YAHEI forState:UIControlStateNormal];
    [self.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.navView).offset(-8);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.centerY.equalTo(self.leftBtn);
    }];
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:@"期数" andfont:FONT(14) andTitleColor:WHITE andBackgroundColor:CLEAR andTextAlignment:2];
    [self.navView addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.rightBtn);
        make.right.equalTo(self.rightBtn.mas_left).offset(-8);
    }];
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
