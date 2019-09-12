//
//  KatoKaCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/6.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "KatoKaCtrl.h"

@interface KatoKaCtrl ()

@property (weak, nonatomic) IBOutlet UILabel *endtimelab;
@property (weak, nonatomic) IBOutlet UILabel *accountlab;
@property (weak, nonatomic) IBOutlet UILabel *banknamelab;
@property (weak, nonatomic) IBOutlet UILabel *bankaccountlab;
@property (weak, nonatomic) IBOutlet UILabel *pricelab;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UILabel *desclab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *desclab_height;

@property (copy, nonatomic) NSNumber *accountId;



@end

@implementation KatoKaCtrl

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"充值";
    NSString *desc = @"1、复制“附言内容”粘贴到转账的附言内，否则充 值无法到账。\n2、充值附言随机生成，一个附言只能充值一次，重复使用充值将无法到账。\n3、收款账号将会不定时更换，请在获取最新信息后充值，否则充值将无法到账。 \n4、平台填写金额应当与汇款金额完全一致，否则充值将无法到账。\n5、充值申请提交成功，请在24小时内完成支付。\n6、支付成功后，请点击我已支付按钮。";
    self.desclab.text = desc;
    self.desclab_height.constant = [Tools createLableHighWithString:desc andfontsize:14 andwithwidth:SCREEN_WIDTH - 24] + 50;
    
    [self initData];
}

-(void)initData {
    @weakify(self)
    [WebTools postWithURL:@"/payment/offline/getPaymentAccount" params:@{@"channelId":self.channelId} success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"] || [data.data isEqual:@""]) {
            return;
        }
        @strongify(self)
        self.accountId = [data.data valueForKey:@"accountId"];
        self.accountlab.text = [data.data valueForKey:@"name"];
        self.banknamelab.text = [data.data valueForKey:@"skf"];
        self.bankaccountlab.text = [data.data valueForKey:@"account"];
        self.pricelab.text = self.price;
        self.remark.text = [[data.data valueForKey:@"fuyan"]stringValue];
        
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)copyClick:(UIButton *)sender {
    
    UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
    
    switch (sender.tag) {
        case 100:
        {
            pastboard.string = self.accountlab.text;
        }
            break;
        case 101:
        {
            pastboard.string = self.banknamelab.text;
        }
            break;
        case 102:
        {
            pastboard.string = self.bankaccountlab.text;
        }
            break;
        case 103:
        {
            pastboard.string = self.pricelab.text;
        }
            break;
        case 104:
        {
            pastboard.string = self.remark.text;
        }
            break;
        default:
            break;
    }
    
    [MBProgressHUD showSuccess:@"已复制到剪贴板"];
}
- (IBAction)payResultClick:(id)sender {
    
    @weakify(self)
    [WebTools postWithURL:@"/payment/offline/paySubmit" params:@{@"accountId":self.accountId,@"amount":self.price,@"fuyan":self.remark.text} success:^(BaseData *data) {

        [MBProgressHUD showError:@"信息已提交，请等待" finish:^{
            @strongify(self)

            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
    } failure:^(NSError *error) {
        
    }];
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
