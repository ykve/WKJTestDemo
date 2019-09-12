//
//  TransferController.m
//  LotteryProduct
//
//  Created by pt c on 2019/7/19.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "TransferController.h"

static const float WKJTransferControllerFontOfSize = 15;

@interface TransferController ()

/// 订单号
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIImageView *payIconImg;

@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *bankLabel;

/// 转账人姓名
@property (nonatomic, strong) UITextField *transferNametextField;

/// 收款账号id
@property (nonatomic, copy) NSString *accountId;


@end

@implementation TransferController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.payModel.wayName;
    
    [self getPaymentAccountInfo];
    [self setupUI];
    
    [self setUIValue];
    
}

- (void)setUIValue {
    if (self.payModel.receiveType == 1) {
        self.typeLabel.text = @"银行卡";
        self.payIconImg.image = [UIImage imageNamed:@"cz_yhk"];
    } else if (self.payModel.receiveType == 2) {
        self.typeLabel.text = @"微信";
        self.payIconImg.image = [UIImage imageNamed:@"cz_wx"];
    } else if (self.payModel.receiveType == 3) {
        self.typeLabel.text = @"支付宝";
        self.payIconImg.image = [UIImage imageNamed:@"cz_zfb"];
    }
}

-(void)getPaymentAccountInfo {
    @weakify(self)
    [WebTools postWithURL:@"/recharge/account/get" params:@{@"rechargeAccountId": @(self.payModel.wayId)} success:^(BaseData *data) {
        
        if (![data.status isEqualToString:@"1"] || [data.data isEqual:@""]) {
            return;
        }
        @strongify(self)
        self.accountId = [data.data valueForKey:@"id"];
        //        self.orderNumLabel.text = [NSString stringWithFormat:@"订单号: %@", [data.data valueForKey:@"receiveCardNo"]];
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%@", self.rechargeMoney];
        self.nameLabel.text = [data.data valueForKey:@"receiveName"];
        self.numLabel.text = [data.data valueForKey:@"receiveCardNo"];
        self.bankLabel.text = [data.data valueForKey:@"receiveBank"];
        
    } failure:^(NSError *error) {
        NSLog(@"1");
    }];
}

#pragma mark -  提交
- (void)submitBtnAction:(UIButton *)sender {
    
    if (self.transferNametextField.text.length == 0) {
        [MBProgressHUD showError:@"请填写转账人姓名"];
        return;
    }
    __weak __typeof(self)weakSelf = self;
    NSDictionary *dic = @{@"accountId": self.accountId,@"amount":self.rechargeMoney,@"transferSign": self.transferNametextField.text};
    [WebTools  postWithURL:@"/payment/offline/paySubmit" params:dic success:^(BaseData *data) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (![data.status isEqualToString:@"1"] || [data.data isEqual:@""]) {
            return ;
        }
        
        if([data.data isEqual:@(1)]) {
            [strongSelf alertView];
        }
    } failure:^(NSError *error) {
        //        [MBProgressHUD showError:@"提交失败"];
        NSLog(@"1");
    } showHUD:YES];
}

- (void)alertView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"充值成功,等待审核"
                                                                             message:@"*充值完成后,重新进入APP查看余额"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    // 2.创建并添加按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回【我的】" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"继续充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}




- (void)setPayModel:(CPTPayModel *)payModel {
    _payModel = payModel;
}


- (void)setupUI {
    //    UIView *topView = [[UIView alloc] init];
    //    topView.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:topView];
    //
    //    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.left.right.mas_equalTo(self.view);
    //        make.height.mas_equalTo(45);
    //    }];
    //
    //    UILabel *orderNumLabel = [[UILabel alloc] init];
    //    orderNumLabel.text = @"订单号:-";
    //    orderNumLabel.font = [UIFont systemFontOfSize:15];
    //    orderNumLabel.textColor = [UIColor colorWithHex:@"#333333"];
    //    orderNumLabel.textAlignment = NSTextAlignmentCenter;
    //    [topView addSubview:orderNumLabel];
    //    _orderNumLabel = orderNumLabel;
    //
    //    [orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerY.mas_equalTo(topView.mas_centerY);
    //        make.centerX.mas_equalTo(topView.mas_centerX);
    //    }];
    //
    //
    //    UIView *spacingView = [[UIView alloc] init];
    //    spacingView.backgroundColor = [UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1.000];
    //    [self.view addSubview:spacingView];
    //
    //    [spacingView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(topView.mas_bottom);
    //        make.left.mas_equalTo(self.view);
    //        make.right.mas_equalTo(self.view);
    //        make.height.mas_equalTo(12);
    //    }];
    
    
    // *** 1 ***
    UILabel *a1Label = [[UILabel alloc] init];
    a1Label.text = @"1.打开 “";
    a1Label.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    a1Label.textColor = [UIColor colorWithHex:@"#333333"];
    [self.view addSubview:a1Label];
    
    [a1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
    }];
    
    UILabel *typeLabel = [[UILabel alloc] init];
    typeLabel.text = @"-";
    typeLabel.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    typeLabel.textColor = kDarkRedColor;
    [self.view addSubview:typeLabel];
    _typeLabel = typeLabel;
    
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(a1Label.mas_centerY);
        make.left.mas_equalTo(a1Label.mas_right);
    }];
    
    UILabel *a2Label = [[UILabel alloc] init];
    a2Label.text = @"” ";
    a2Label.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    a2Label.textColor = [UIColor colorWithHex:@"#333333"];
    [self.view addSubview:a2Label];
    
    [a2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(a1Label.mas_centerY);
        make.left.mas_equalTo(typeLabel.mas_right);
    }];
    
    
    UIImageView *payIconImg = [[UIImageView alloc] init];
    payIconImg.image = [UIImage imageNamed:@"cz_yhk"];
    [self.view addSubview:payIconImg];
    _payIconImg = payIconImg;
    
    [payIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(a1Label.mas_centerY);
        make.left.mas_equalTo(a2Label.mas_right);
        make.size.mas_equalTo(@(15));
    }];
    
    
    UILabel *a3Label = [[UILabel alloc] init];
    a3Label.text = @" 点击 ”";
    a3Label.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    a3Label.textColor = [UIColor colorWithHex:@"#333333"];
    [self.view addSubview:a3Label];
    
    [a3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(a1Label.mas_centerY);
        make.left.mas_equalTo(payIconImg.mas_right);
    }];
    
    UILabel *a4Label = [[UILabel alloc] init];
    a4Label.text = @"转账";
    a4Label.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    a4Label.textColor = kDarkRedColor;
    [self.view addSubview:a4Label];
    
    [a4Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(a1Label.mas_centerY);
        make.left.mas_equalTo(a3Label.mas_right);
    }];
    
    UILabel *a5Label = [[UILabel alloc] init];
    a5Label.text = @"” ";
    a5Label.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    a5Label.textColor = [UIColor colorWithHex:@"#333333"];
    [self.view addSubview:a5Label];
    
    [a5Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(a1Label.mas_centerY);
        make.left.mas_equalTo(a4Label.mas_right);
    }];
    
    UIImageView *lastIconImg = [[UIImageView alloc] init];
    lastIconImg.image = [UIImage imageNamed:@"cz_zziocn"];
    [self.view addSubview:lastIconImg];
    
    [lastIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(a1Label.mas_centerY);
        make.left.mas_equalTo(a5Label.mas_right);
        make.size.mas_equalTo(@(15));
    }];
    
    
    
    // *** 2 ***
    UILabel *bbLabel = [[UILabel alloc] init];
    bbLabel.text = @"2.收款人信息:";
    bbLabel.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    bbLabel.textColor = [UIColor colorWithHex:@"#333333"];
    [self.view addSubview:bbLabel];
    
    [bbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(a1Label.mas_bottom).offset(15);
        make.left.mas_equalTo(a1Label.mas_left);
    }];
    
    UIView *backBBView = [[UIView alloc] init];
    backBBView.layer.cornerRadius = 10;
    backBBView.layer.borderWidth = 1;
    backBBView.layer.borderColor = [UIColor colorWithRed:0.871 green:0.722 blue:0.514 alpha:1.000].CGColor;
    backBBView.backgroundColor = [UIColor colorWithRed:0.957 green:0.847 blue:0.671 alpha:1.000];
    backBBView.layer.shadowColor = [UIColor blackColor].CGColor;
    backBBView.layer.shadowOpacity = 0.2f;
    backBBView.layer.shadowOffset = CGSizeMake(1,2);
    [self.view addSubview:backBBView];
    
    
    [backBBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bbLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(self.view.mas_left).offset(18);
        make.right.mas_equalTo(self.view.mas_right).offset(-18);
        make.height.mas_equalTo(155);
    }];
    
    
    UILabel *b1Label = [[UILabel alloc] init];
    b1Label.text = @"金额";
    b1Label.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    b1Label.textColor = [UIColor colorWithHex:@"#956E1D"];
    [backBBView addSubview:b1Label];
    
    [b1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backBBView.mas_top).offset(18);
        make.left.mas_equalTo(backBBView.mas_left).offset(15);
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.text = @"-";
    moneyLabel.font = [UIFont boldSystemFontOfSize:16];
    moneyLabel.textColor = kDarkRedColor;
    [backBBView addSubview:moneyLabel];
    _moneyLabel = moneyLabel;
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(b1Label.mas_centerY);
        make.left.mas_equalTo(b1Label.mas_right).offset(15);
    }];
    
    
    
    UILabel *b2Label = [[UILabel alloc] init];
    b2Label.text = @"姓名";
    b2Label.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    b2Label.textColor = [UIColor colorWithHex:@"#956E1D"];
    [backBBView addSubview:b2Label];
    
    [b2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(b1Label.mas_bottom).offset(15);
        make.left.mas_equalTo(b1Label.mas_left);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"-";
    nameLabel.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    nameLabel.textColor = [UIColor colorWithHex:@"#5E4E36"];
    [backBBView addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(b2Label.mas_centerY);
        make.left.mas_equalTo(moneyLabel.mas_left);
    }];
    
    UIButton *copyNameBtn = [[UIButton alloc] init];
    [copyNameBtn setTitle:@"复制" forState:UIControlStateNormal];
    [copyNameBtn setTintColor:[UIColor whiteColor]];
    copyNameBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [copyNameBtn addTarget:self action:@selector(copyAction:) forControlEvents:UIControlEventTouchUpInside];
    copyNameBtn.backgroundColor = [UIColor colorWithRed:0.639 green:0.514 blue:0.325 alpha:1.000];
    copyNameBtn.layer.cornerRadius = 20/2;
    copyNameBtn.tag = 1000;
    [backBBView addSubview:copyNameBtn];
    
    [copyNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(b2Label.mas_centerY);
        make.right.mas_equalTo(backBBView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    UILabel *b3Label = [[UILabel alloc] init];
    b3Label.text = @"卡号";
    b3Label.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    b3Label.textColor = [UIColor colorWithHex:@"#956E1D"];
    [backBBView addSubview:b3Label];
    
    [b3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(b2Label.mas_bottom).offset(15);
        make.left.mas_equalTo(b1Label.mas_left);
    }];
    
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.text = @"-";
    numLabel.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    numLabel.textColor = [UIColor colorWithHex:@"#5E4E36"];
    [backBBView addSubview:numLabel];
    _numLabel = numLabel;
    
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(b3Label.mas_centerY);
        make.left.mas_equalTo(moneyLabel.mas_left);
    }];
    
    
    UIButton *copyNumBtn = [[UIButton alloc] init];
    [copyNumBtn setTitle:@"复制" forState:UIControlStateNormal];
    [copyNumBtn setTintColor:[UIColor whiteColor]];
    copyNumBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [copyNumBtn addTarget:self action:@selector(copyAction:) forControlEvents:UIControlEventTouchUpInside];
    copyNumBtn.backgroundColor = [UIColor colorWithRed:0.639 green:0.514 blue:0.325 alpha:1.000];
    copyNumBtn.layer.cornerRadius = 20/2;
    copyNumBtn.tag = 1001;
    [backBBView addSubview:copyNumBtn];
    
    [copyNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(b3Label.mas_centerY);
        make.right.mas_equalTo(backBBView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    
    UILabel *b4Label = [[UILabel alloc] init];
    b4Label.text = @"银行";
    b4Label.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    b4Label.textColor = [UIColor colorWithHex:@"#956E1D"];
    [backBBView addSubview:b4Label];
    
    [b4Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(b3Label.mas_bottom).offset(15);
        make.left.mas_equalTo(b1Label.mas_left);
    }];
    
    UILabel *bankLabel = [[UILabel alloc] init];
    bankLabel.text = @"-";
    bankLabel.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    bankLabel.textColor = [UIColor colorWithHex:@"#5E4E36"];
    [backBBView addSubview:bankLabel];
    _bankLabel = bankLabel;
    
    [bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(b4Label.mas_centerY);
        make.left.mas_equalTo(moneyLabel.mas_left);
    }];
    
    UIButton *copyBankBtn = [[UIButton alloc] init];
    [copyBankBtn setTitle:@"复制" forState:UIControlStateNormal];
    [copyBankBtn setTintColor:[UIColor whiteColor]];
    copyBankBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [copyBankBtn addTarget:self action:@selector(copyAction:) forControlEvents:UIControlEventTouchUpInside];
    copyBankBtn.backgroundColor = [UIColor colorWithRed:0.639 green:0.514 blue:0.325 alpha:1.000];
    copyBankBtn.layer.cornerRadius = 20/2;
    copyBankBtn.tag = 1002;
    [backBBView addSubview:copyBankBtn];
    
    [copyBankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(b4Label.mas_centerY);
        make.right.mas_equalTo(backBBView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    // *** 3 ***
    UILabel *ccLabel = [[UILabel alloc] init];
    ccLabel.text = @"3.确认转账信息:";
    ccLabel.font = [UIFont boldSystemFontOfSize:WKJTransferControllerFontOfSize];
    ccLabel.textColor = [UIColor colorWithHex:@"#333333"];
    [self.view addSubview:ccLabel];
    
    [ccLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backBBView.mas_bottom).offset(20);
        make.left.mas_equalTo(a1Label.mas_left);
    }];
    
    
    UITextField *transferNametextField = [[UITextField alloc] init];
    transferNametextField.borderStyle = UITextBorderStyleRoundedRect;
    transferNametextField.font = [UIFont boldSystemFontOfSize:14.0];
    transferNametextField.textColor = [UIColor colorWithHex:@"#333333"];
    transferNametextField.placeholder = @"填写转账人姓名";
    transferNametextField.clearButtonMode = UITextFieldViewModeAlways;
    //    transferNametextField.delegate = self;
    //textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    transferNametextField.keyboardType = UIKeyboardTypeEmailAddress;
    transferNametextField.returnKeyType = UIReturnKeyGo;
    transferNametextField.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.000];
    [self.view addSubview:transferNametextField];
    _transferNametextField = transferNametextField;
    
    [transferNametextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(ccLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(230, 35));
    }];
    
    
    UILabel *ttLabel = [[UILabel alloc] init];
    ttLabel.text = @"与绑定身份证姓名相同";
    ttLabel.font = [UIFont systemFontOfSize:13];
    ttLabel.textColor = kDarkRedColor;
    [self.view addSubview:ttLabel];
    
    [ttLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(transferNametextField.mas_bottom).offset(5);
        make.left.mas_equalTo(transferNametextField.mas_left);
    }];
    
    
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.backgroundColor = kDarkRedColor;
    submitBtn.layer.cornerRadius = 38/2;
    [self.view addSubview:submitBtn];
    
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(transferNametextField.mas_bottom).offset(35);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(180, 38));
    }];
    
    
    UILabel *wwLabel = [[UILabel alloc] init];
    wwLabel.text = @"*充值完成后，重新进入APP查看余额";
    wwLabel.font = [UIFont boldSystemFontOfSize:13];
    wwLabel.textColor = [UIColor colorWithRed:0.659 green:0.659 blue:0.659 alpha:1.000];
    [self.view addSubview:wwLabel];
    
    [wwLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(submitBtn.mas_bottom).offset(16);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
}




- (void)copyAction:(UIButton *)sender {
    sender.backgroundColor = [UIColor colorWithRed:0.686 green:0.576 blue:0.412 alpha:1.000];
    [sender setTitleColor:[UIColor colorWithRed:0.443 green:0.357 blue:0.224 alpha:1.000] forState:UIControlStateNormal];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    if (sender.tag == 1000) {
        pasteboard.string = self.nameLabel.text;
    } else if (sender.tag == 1001) {
        pasteboard.string = self.numLabel.text;
    } if (sender.tag == 1002) {
        pasteboard.string = self.bankLabel.text;
    }
    
    [MBProgressHUD showSuccess:@"复制成功"];
}


@end
