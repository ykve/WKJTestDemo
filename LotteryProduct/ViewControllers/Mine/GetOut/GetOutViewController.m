//
//  GetOutViewController.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "GetOutViewController.h"
#import "BankModel.h"
#import "WalletViewController.h"
#import "BanklistView.h"
#import "AddBanksteponeCtrl.h"
#import "EditPayPwdViewController.h"
@interface GetOutViewController ()

@property (weak, nonatomic) IBOutlet UIButton *bankBtn;

@property (weak, nonatomic) IBOutlet UITextField *pricefield;

@property (weak, nonatomic) IBOutlet UILabel *enablepricelab;

@property (weak, nonatomic) IBOutlet UITextField *pswordfield;

@property (weak, nonatomic) IBOutlet UILabel *minpricelab;

@property (weak, nonatomic) IBOutlet UILabel *maxpricelab;

@property (strong, nonatomic) NSArray *banklist;

@property (strong, nonatomic) BankModel *bankModel;
@property (weak, nonatomic) IBOutlet UIButton *getAllOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;


@end

@implementation GetOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提现说明" style:UIBarButtonItemStylePlain target:self action:@selector(getoutInfoClick)];
    
    
    self.pricefield.clearButtonMode = UITextFieldViewModeAlways;
    self.pricefield.font = [UIFont boldSystemFontOfSize:23.0];
    
    self.getAllOutBtn.backgroundColor = WHITE;
    self.getAllOutBtn.layer.borderColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack].CGColor;
    self.getAllOutBtn.layer.borderWidth = 1;
    [self.getAllOutBtn setTitleColor:[[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack] forState:UIControlStateNormal];
    
    self.confirmBtn.backgroundColor = [[CPTThemeConfig shareManager] confirmBtnBackgroundColor];
    [self.confirmBtn setTitleColor:[[CPTThemeConfig shareManager] confirmBtnTextColor] forState:UIControlStateNormal];

    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = self.confirmBtn.height/2;
    
    
    [self getmaxminprice];
    
    self.enablepricelab.text = [NSString stringWithFormat:@"%.2f",[Person person].withdrawalAmount];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getbanklist) name:kUpdateAddBankNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self getbanklist];

}

- (IBAction)selectbankClick:(UIButton *)sender {
    
    if (self.banklist.count == 0) {
        
//        AddBanksteponeCtrl *steponeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddBanksteponeCtrl"];
//        
//        [self.navigationController pushViewController:steponeVC animated:YES];
        
        AddBanksteponeCtrl *steponeVC = [[AddBanksteponeCtrl alloc] init];
        [self.navigationController pushViewController:steponeVC animated:YES];
    }
    else {
        
        BanklistView *list = [[BanklistView alloc]initWithFrame:CGRectMake(0, sender.y + sender.height + NAV_HEIGHT, SCREEN_WIDTH, 0)];
        @weakify(self)
        list.selectbankBlock = ^(BankModel *bankmodel) {
            @strongify(self)

            self.bankModel = bankmodel;
            
            [self.bankBtn setTitle:[NSString stringWithFormat:@"%@%@",self.bankModel.bank,[self.bankModel.cardNumber stringByReplacingOccurrencesOfString:[self.bankModel.cardNumber substringToIndex:self.bankModel.cardNumber.length-4] withString:@"*** **** ***"]] forState:UIControlStateNormal];
        };
        [list show:self.banklist];
    }
}

- (IBAction)clearClick:(UIButton *)sender {
    
    self.pricefield.text = nil;
}

- (IBAction)getoutallClick:(UIButton *)sender {
    
    self.pricefield.text = self.enablepricelab.text;
}

- (IBAction)sureClick:(UIButton *)sender {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该功能暂未开放" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }];
//    [alert addAction:defaultAction];
//    [self presentViewController:alert animated:YES completion:nil];
//    return;
    
    if ([Tools isEmptyOrNull:self.pricefield.text]) {
        [MBProgressHUD showError:@"请输入提现金额"];
        return;
    }
    
//    if (self.pricefield.text.floatValue > self.maxpricelab.text.floatValue || self.pricefield.text.floatValue < self.minpricelab.text.floatValue) {
//        [MBProgressHUD showError:@"请输入提现额度范围内的金额"];
//        return;
//    }
    
    if (self.bankModel == nil) {
        [MBProgressHUD showError:@"请选择绑定的银行卡"];
        return;
    }
    
    if ([Tools isEmptyOrNull:[Person person].payPassword]) { //
        
        EditPayPwdViewController *editPwdVC = [[EditPayPwdViewController alloc] init];
        [self.navigationController pushViewController:editPwdVC animated:YES];
        
        return;
    }
    
    if ([Tools isEmptyOrNull:self.pswordfield.text]) {
        [MBProgressHUD showError:@"请输入支付密码"];
        return;
    }
    
    NSString *password = [[NSString stringWithFormat:@"%@%@",MD5KEY,self.pswordfield.text] MD5];

    __weak __typeof(self)weakSelf = self;
   
    [WebTools postWithURL:@"/withdraw/userWithdraw.json" params:@{@"money":self.pricefield.text,@"bank":@(self.bankModel.ID),@"psword":password} success:^(BaseData *data) {
         __strong __typeof(weakSelf)strongSelf = weakSelf;
        [MBProgressHUD showSuccess:data.info];
        
        strongSelf.pricefield.text = nil;
        strongSelf.pswordfield.text = nil;
    } failure:^(NSError *error) {
        
    }];
    
}


-(void)getbanklist {
    
    @weakify(self)
    [WebTools postWithURL:@"/withdraw/finduserBankcard.json" params:nil success:^(BaseData *data) {
    
        @strongify(self)
        self.banklist = [BankModel mj_objectArrayWithKeyValuesArray:data.data];
        
        self.bankModel = self.banklist.firstObject;
        
        if (self.bankModel) {
            
            [self.bankBtn setTitle:[NSString stringWithFormat:@"%@%@",self.bankModel.bank,[self.bankModel.cardNumber stringByReplacingOccurrencesOfString:[self.bankModel.cardNumber substringToIndex:self.bankModel.cardNumber.length-4] withString:@"*** **** ***"]] forState:UIControlStateNormal];
        }
        else {
            
            [self.bankBtn setTitle:@"选择银行卡" forState:UIControlStateNormal];
        }
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(void)getmaxminprice {
    
    @weakify(self)
    [WebTools postWithURL:@"/withdraw/queryWithdrawDeposit.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        self.minpricelab.text = data.data[@"min"];
        self.maxpricelab.text = data.data[@"max"];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)getoutInfoClick {
    ShowAlertView *show = [[ShowAlertView alloc]initWithFrame:CGRectZero];
    NSString *str =      @"温馨提示：\n1、可提现额度=充值额按2*有效投注额的转化+中奖彩金+活动礼金；\n2、当期投   注开奖后，平台自动更新可提额度；\n3、您每天最多只能提现3次，提现一般在发起申请后2小时内到账；\n4、平台休息时间为2:30-8:00，在这期间将无法发起提现申请；";
    [show buildGetOutPriceWithtext:str];
    [show show];
}
-(void)dealloc {
    
    MBLog(@"%s dealloc",object_getClassName(self));

    [[NSNotificationCenter defaultCenter]removeObserver:self name:kUpdateAddBankNotification object:nil];
}


@end
