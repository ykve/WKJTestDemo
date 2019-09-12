//
//  AddBanksteponeCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "AddBanksteponeCtrl.h"
#import "AddBanksteptwoCtrl.h"

@interface AddBanksteponeCtrl ()<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *namefield;

@property (strong, nonatomic) UITextField *cardfield;

@property (strong, nonatomic) UIButton *nextBtn;


@end

@implementation AddBanksteponeCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F2F5"];
    self.titlestring = @"添加银行卡";
    
    [self refreshnextBtn];
    
    [self setupUI];
    [self.namefield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.cardfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    if ([Tools isEmptyOrNull:[Person person].realName] == NO) {
        self.namefield.text = [Person person].realName;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}





- (void)remarkClick:(UIButton *)sender {
    [AlertViewTool alertViewToolShowTitle:@"持卡人说明" message:@"为保证账户资金安全，只能绑定认证用户本人的银行卡。" fromController:self handler:^{
        
        
    }];
}

- (void)alertView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                             message:@"*您还未设置真实姓名,请先到我的账户信息设置您的真实姓名"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)nextClick:(UIButton *)sender {
    
//    if ([Person person].realName.length <= 0) {
//        [self alertView];
//        return;
//    }
    
    
    if ([Tools isEmptyOrNull:self.cardfield.text]) {
        [MBProgressHUD showError:@"请输入卡号"];
        return;
    }
    
    @weakify(self)
    [AlertViewTool alertViewToolShowTitle:@"提示" message:@"该持卡人姓名将同步保存为账户的真实姓名，是否确认为您本人？" cancelTitle:@"否" confiormTitle:@"是" fromController:self handler:^(NSInteger index) {
        @strongify(self)
        if (index == 1) {
            
            [self changerealname];
            
            
        }
    }];
    
}

-(void)nextAction {
    //    [WebTools postWithURL:@"/withdraw/adduserBankcard.json" params:@{@"cardNumber":self.cardnum} success:^(BaseData *data) {
    
    @weakify(self)
    [WebTools postWithURL:@"/withdraw/adduserBankcard.json" params:@{@"cardNumber":self.cardfield.text} success:^(BaseData *data) {
        //        @strongify(self)
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        [MBProgressHUD showSuccess:@"绑定成功"];
        
        if (self.addBankBlock) {
            self.addBankBlock(YES);
        }
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kUpdateAddBankNotification object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        //        AddBanksteptwoCtrl *steptwoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddBanksteptwoCtrl"];
        //
        //        steptwoVC.name = self.namefield.text;
        //        steptwoVC.cardnum = self.cardfield.text;
        //        steptwoVC.cardname = [data.data valueForKey:@"bankname"];
        //
        //        [self.navigationController pushViewController:steptwoVC animated:YES];
        
    } failure:^(NSError *error) {
        @strongify(self)
        if (self.addBankBlock) {
            self.addBankBlock(NO);
        }
        MBLog(@"1");
    } showHUD:NO];
}

#pragma mark -  修改账户信息，如真实姓名，昵称，性别，生日, 头像，qq
-(void)changerealname {
    
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/updateAccountInfo.json" params:@{@"realName":self.namefield.text} success:^(BaseData *data) {
        @strongify(self)
        [Person person].realName = self.namefield.text;
        [self nextAction];
        
        
    } failure:^(NSError *error) {
        MBLog(@"1");
    } showHUD:NO];
}

-(void)textFieldDidChange :(UITextField *)theTextField {
    NSLog( @"text changed: %@", theTextField.text);
    
    [self refreshnextBtn];
}



-(void)refreshnextBtn {
    
    if ([Tools isEmptyOrNull:self.namefield.text] || [Tools isEmptyOrNull:self.cardfield.text]) {
        
        self.nextBtn.enabled = NO;
        self.nextBtn.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
    }
    else {
        self.nextBtn.enabled = YES;
        self.nextBtn.backgroundColor = [[CPTThemeConfig shareManager] confirmBtnBackgroundColor];
        [self.nextBtn setTitleColor:[[CPTThemeConfig shareManager] confirmBtnTextColor] forState:UIControlStateNormal];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)setupUI {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"请绑定账号真实姓名本人的银行卡";
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor colorWithHex:@"666666"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(Height_NavBar + 7);
        make.left.equalTo(self.view.mas_left).offset(10);
    }];
    
    UIView *backView1 = [[UIView alloc] init];
    backView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView1];
    
    [backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(7);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(50);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_LineViewColor];
    [self.view addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView1.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *backView2 = [[UIView alloc] init];
    backView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView2];
    
    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(50);
    }];
    
    
    UILabel *titLabel = [[UILabel alloc] init];
    titLabel.text = @"持卡人";
    titLabel.font = [UIFont systemFontOfSize:13];
    titLabel.textColor = [UIColor colorWithHex:@"333333"];
    titLabel.textAlignment = NSTextAlignmentLeft;
    [backView1 addSubview:titLabel];
    
    [titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backView1.mas_centerY);
        make.left.equalTo(backView1.mas_left).offset(10);
        make.width.mas_equalTo(40);
    }];
    
    
    
    
    UITextField *namefield = [[UITextField alloc] init];
    namefield.tag = 1000;
    namefield.backgroundColor = [UIColor whiteColor];
    namefield.borderStyle = UITextBorderStyleNone;
    namefield.font = [UIFont boldSystemFontOfSize:14.0];
    namefield.textColor = [UIColor colorWithHex:@"#333333"];
    namefield.delegate = self;
    namefield.keyboardType = UIKeyboardTypeDefault;
    namefield.returnKeyType = UIReturnKeyGo;
    [backView1 addSubview:namefield];
    
    _namefield = namefield;
    [namefield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView1.mas_centerY);
        make.left.equalTo(titLabel.mas_right).offset(10);
        make.right.equalTo(backView1.mas_right).offset(-50);
        make.height.mas_equalTo(@(40));
    }];
    
    
    UIButton *iconBtn = [[UIButton alloc] init];
    [iconBtn addTarget:self action:@selector(remarkClick:) forControlEvents:UIControlEventTouchUpInside];
    [iconBtn setImage:[UIImage imageNamed:@"addbankremark"] forState:UIControlStateNormal];
    [backView1 addSubview:iconBtn];
    
    [iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backView1.mas_centerY);
        make.right.equalTo(backView1.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(30, 40));
    }];
    
    
    
    
    UILabel *carNumTitLabel = [[UILabel alloc] init];
    carNumTitLabel.text = @"卡号";
    carNumTitLabel.font = [UIFont systemFontOfSize:13];
    carNumTitLabel.textColor = [UIColor colorWithHex:@"333333"];
    carNumTitLabel.textAlignment = NSTextAlignmentCenter;
    [backView2 addSubview:carNumTitLabel];
    
    [carNumTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backView2.mas_centerY);
        make.left.mas_equalTo(backView2.mas_left).offset(10);
    }];
    
    
    UITextField *cardfield = [[UITextField alloc] init];
    cardfield.tag = 1001;
    cardfield.backgroundColor = [UIColor whiteColor];
    cardfield.borderStyle = UITextBorderStyleNone;
    cardfield.font = [UIFont systemFontOfSize:13.0];
    cardfield.textColor = [UIColor colorWithHex:@"333333"];
    cardfield.placeholder = @"无需网银/免手续费";
    cardfield.clearButtonMode = UITextFieldViewModeAlways;
    cardfield.delegate = self;
    cardfield.keyboardType = UIKeyboardTypeNumberPad;
    cardfield.returnKeyType = UIReturnKeyGo;
    [backView2 addSubview:cardfield];
    _cardfield = cardfield;
    [cardfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backView2.mas_centerY);
        make.left.mas_equalTo(carNumTitLabel.mas_right).offset(20);
        make.right.mas_equalTo(backView2.mas_right).offset(-20);
        make.height.mas_equalTo(@(40));
    }];
    
    
    UIButton *nextBtn = [[UIButton alloc] init];
    [nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    nextBtn.backgroundColor = [UIColor colorWithHex:@"#DDDDDD"];
    nextBtn.layer.cornerRadius = 5;
    nextBtn.enabled = NO;
    [self.view addSubview:nextBtn];
    _nextBtn = nextBtn;
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView2.mas_bottom).offset(40);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    
    
    UILabel *iimLabel = [[UILabel alloc] init];
    iimLabel.text = @"账户安全保险中";
    iimLabel.font = [UIFont systemFontOfSize:12];
    iimLabel.textColor = [UIColor colorWithHex:@"333333"];
    iimLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:iimLabel];
    
    [iimLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nextBtn.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UIButton *imBtn = [[UIButton alloc] init];
    [imBtn addTarget:self action:@selector(remarkClick:) forControlEvents:UIControlEventTouchUpInside];
    [imBtn setImage:[UIImage imageNamed:@"anquanbaozhang"] forState:UIControlStateNormal];
    [self.view addSubview:imBtn];
    
    [imBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(iimLabel.mas_centerY);
        make.right.equalTo(iimLabel.mas_left).offset(-8);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    
}
@end
