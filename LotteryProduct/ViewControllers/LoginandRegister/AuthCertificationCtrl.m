//
//  AuthCertificationCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "AuthCertificationCtrl.h"

@interface AuthCertificationCtrl ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topconst;
@property (weak, nonatomic) IBOutlet UITextField *namefield;
@property (weak, nonatomic) IBOutlet UITextField *IDCardfield;
@end

@implementation AuthCertificationCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.topconst.constant = NAV_HEIGHT + 20;
    
    self.titlestring = @"个人身份信息";
}
- (IBAction)publishClick:(id)sender {
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
