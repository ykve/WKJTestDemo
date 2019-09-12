//
//  RechargeableCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/6.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RechargeableCtrl.h"

@interface RechargeableCtrl ()
@property (weak, nonatomic) IBOutlet UITextField *cardnumberField;

@end

@implementation RechargeableCtrl

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"充值卡充值";
}

- (IBAction)publishClick:(UIButton *)sender {
    
    if ([Tools isEmptyOrNull:self.cardnumberField.text]) {
        
        [MBProgressHUD showError:@"请输入充值卡号"];
        
        return;
    }
    @weakify(self)
    [WebTools postWithURL:@"/payment/offline/payForTopUpCard" params:@{@"number":self.cardnumberField.text} success:^(BaseData *data) {

        [MBProgressHUD showSuccess:@"充值成功" finish:^{
            @strongify(self)

            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
    } failure:^(NSError *error) {
        
    }];
}


@end
