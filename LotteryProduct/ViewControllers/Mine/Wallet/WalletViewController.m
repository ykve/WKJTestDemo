//
//  WalletViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "WalletViewController.h"
#import "AddBanksteponeCtrl.h"
#import "BankModel.h"
#import "BanklistCell.h"
#import "MyReportModel.h"

@interface WalletViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIImageView *topBgImageView;
@property (strong, nonatomic)  UIImageView *bankIconImageView;

/// 余额整形部分
@property (strong, nonatomic)  UILabel *moneyLabel;
@property (strong, nonatomic)  UILabel *moneyBottomLabel;

/// 中奖金额
@property (strong, nonatomic)  UILabel *winMoneyLabel;
@property (strong, nonatomic)  UILabel *winMoneyBottomLabel;

/// 个人盈亏
@property (strong, nonatomic)  UILabel *loseMoneyLabel;
@property (strong, nonatomic)  UILabel *loseMoneyBottomLbl;

@property (strong, nonatomic) UITableView *tableView;


@property (strong, nonatomic) NSArray *bankArray;
/// 最大银行卡张数
@property (nonatomic, assign) NSInteger maxBankAmount;


@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName: [[CPTThemeConfig shareManager] CO_NavigationBar_TintColor]}];
    
    [self setupUI];
    [self initTableView];
    
    [self setSystemConfiguration];
    
    [self getCardNum];
    [self getBankCarListData];
    [self getpriceData];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getBankCarListData) name:kUpdateAddBankNotification object:nil];
}

- (void)setSystemConfiguration {
    self.topBgImageView.image = [[CPTThemeConfig shareManager] MyWalletTopImage];
    self.bankIconImageView.image = [[CPTThemeConfig shareManager] MyWalletBankCartImage];

    self.moneyLabel.textColor = [[CPTThemeConfig shareManager] CO_Me_MyWallerBalance_MoneyText];
    self.winMoneyLabel.textColor = [[CPTThemeConfig shareManager] CO_Me_MyWallerBalanceText];
    self.loseMoneyLabel.textColor = [[CPTThemeConfig shareManager] CO_Me_MyWallerBalanceText];
    
    self.moneyBottomLabel.textColor = [[CPTThemeConfig shareManager] CO_Me_MyWallerTitle];
    self.winMoneyBottomLabel.textColor = [[CPTThemeConfig shareManager] CO_Me_MyWallerTitle];
    self.loseMoneyBottomLbl.textColor = [[CPTThemeConfig shareManager] CO_Me_MyWallerTitle];
}


#pragma mark - initTableView
- (void)initTableView {
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.rowHeight = SCREEN_WIDTH * 0.197;
    // 去除横线
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [UIView new];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankIconImageView.mas_bottom).offset(15);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    
    [self.tableView registerClass:[BanklistCell class] forCellReuseIdentifier:RJCellIdentifier];
}

- (void)setupUI {
    UIImageView *topBgImageView = [[UIImageView alloc] init];
    topBgImageView.image = [UIImage imageNamed:@"-"];
    [self.view addSubview:topBgImageView];
    _topBgImageView = topBgImageView;
    
    [topBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(160));
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.text = @"-";
    moneyLabel.font = [UIFont systemFontOfSize:20];
    moneyLabel.textColor = [UIColor colorWithHex:@"#FFEA00"];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:moneyLabel];
    _moneyLabel = moneyLabel;
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(topBgImageView.mas_centerX);
        make.top.mas_equalTo(topBgImageView.mas_top).offset(25);
    }];
    
    
    UILabel *moneyBottomLabel = [[UILabel alloc] init];
    moneyBottomLabel.text = @"余额(元)";
    moneyBottomLabel.font = [UIFont systemFontOfSize:15];
    moneyBottomLabel.textColor = [UIColor colorWithHex:@"#E9E9E9"];
    moneyBottomLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:moneyBottomLabel];
    _moneyBottomLabel = moneyBottomLabel;
    
    [moneyBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(moneyLabel.mas_centerX);
        make.top.mas_equalTo(moneyLabel.mas_bottom).offset(5);
    }];
    
    /// 中奖金额
    UILabel *winMoneyBottomLabel = [[UILabel alloc] init];
    winMoneyBottomLabel.text = @"中奖金额(元)";
    winMoneyBottomLabel.font = [UIFont systemFontOfSize:15];
    winMoneyBottomLabel.textColor = [UIColor colorWithHex:@"#E9E9E9"];
    winMoneyBottomLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:winMoneyBottomLabel];
    _winMoneyBottomLabel = winMoneyBottomLabel;
    
    [winMoneyBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(topBgImageView.mas_centerX).multipliedBy(0.5);
        make.bottom.mas_equalTo(topBgImageView.mas_bottom).offset(-20);
    }];
    
    
    UILabel *winMoneyLabel = [[UILabel alloc] init];
    winMoneyLabel.text = @"-";
    winMoneyLabel.font = [UIFont systemFontOfSize:17];
    winMoneyLabel.textColor = [UIColor colorWithHex:@"#FFEA00"];
    winMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:winMoneyLabel];
    _winMoneyLabel = winMoneyLabel;
    
    [winMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(winMoneyBottomLabel.mas_centerX);
        make.bottom.mas_equalTo(winMoneyBottomLabel.mas_top).offset(-5);
    }];
    
    /// 个人盈亏
    UILabel *loseMoneyBottomLbl = [[UILabel alloc] init];
    loseMoneyBottomLbl.text = @"个人盈亏(元)";
    loseMoneyBottomLbl.font = [UIFont systemFontOfSize:15];
    loseMoneyBottomLbl.textColor = [UIColor colorWithHex:@"#E9E9E9"];
    loseMoneyBottomLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loseMoneyBottomLbl];
    _loseMoneyBottomLbl = loseMoneyBottomLbl;
    
    [loseMoneyBottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(winMoneyBottomLabel.mas_centerY);
        make.centerX.mas_equalTo(topBgImageView.mas_centerX).multipliedBy(1.5);
    }];
    
    UILabel *loseMoneyLabel = [[UILabel alloc] init];
    loseMoneyLabel.text = @"-";
    loseMoneyLabel.font = [UIFont systemFontOfSize:17];
    loseMoneyLabel.textColor = [UIColor colorWithHex:@"#FFEA00"];
    loseMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loseMoneyLabel];
    _loseMoneyLabel = loseMoneyLabel;
    
    [loseMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(loseMoneyBottomLbl.mas_centerX);
        make.bottom.mas_equalTo(loseMoneyBottomLbl.mas_top).offset(-5);
    }];
    
    
    // 我的银行卡 title
    UIImageView *bankIconImageView = [[UIImageView alloc] init];
    bankIconImageView.image = [UIImage imageNamed:@"-"];
    [self.view addSubview:bankIconImageView];
    _bankIconImageView = bankIconImageView;
    
    [bankIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topBgImageView.mas_bottom).offset(15);
        make.left.mas_equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(23, 21));
    }];
    
    UILabel *bankTitleLabel = [[UILabel alloc] init];
    bankTitleLabel.text = @"我的银行卡";
    bankTitleLabel.font = [UIFont systemFontOfSize:15];
    bankTitleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    bankTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bankTitleLabel];
    //    _bankTitleLabel = bankTitleLabel;
    
    [bankTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bankIconImageView.mas_centerY);
        make.left.mas_equalTo(bankIconImageView.mas_right).offset(10);
    }];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.bankArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SCREEN_WIDTH * 0.197;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return self.bankArray.count >= self.maxBankAmount ? 0 : SCREEN_WIDTH * 0.197;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BanklistCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    BankModel *model = [self.bankArray objectAtIndex:indexPath.row];
    
    cell.backimgv.image = indexPath.row%2 == 0 ? IMAGE(@"wallet_bank_list_bg2") : IMAGE(@"wallet_bank_list_bg1");
    
    [cell.iconimgv sd_setImageWithURL:IMAGEPATH(model.icon) placeholderImage:IMAGE(@"wallet_card_icon") options:SDWebImageRefreshCached];
    
    cell.banknamelab.text = model.bank;
    
    cell.banktypelab.text = model.banktype;
    
    cell.bankcardlab.text = [model.cardNumber stringByReplacingOccurrencesOfString:[model.cardNumber substringToIndex:model.cardNumber.length-4] withString:@"*** **** ***"];
    
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.197)];
    
    UIButton *_addCardBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"     添加银行卡" andTitleColor:[[CPTThemeConfig shareManager] grayColor999] andBackgroundImage:IMAGE(@"wallet_bank_list_add_bg") andImage:IMAGE(@"wallet_bank_list_add") andTarget:self andAction:@selector(addCardAction) andType:UIButtonTypeCustom];
    _addCardBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _addCardBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [foot addSubview:_addCardBtn];
    [_addCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(foot).with.insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    return foot;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark -  添加银行卡
-(void)addCardAction {

    AddBanksteponeCtrl *steponeVC = [[AddBanksteponeCtrl alloc] init];
    [self.navigationController pushViewController:steponeVC animated:YES];
}

#pragma mark -  查询用户绑定的银行号列表
-(void)getBankCarListData {
    
    @weakify(self)
    [WebTools postWithURL:@"/withdraw/finduserBankcard.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"] || [data.data isEqual:@""]) {
            return;
        }
        self.bankArray = [BankModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -  获取银行卡数量
- (void)getCardNum{
    
    NSDictionary *dic = @{@"names" : @"BIND_BANK_CARD_AMOUNT"};
    
    [WebTools postWithURL:@"/app/sys/querySystemInfoByNames.json" params:dic success:^(BaseData *data) {
        MBLog(@"%@", data);
        
        if (![data.status isEqualToString:@"1"] || [data.data isEqual:@""]) {
            return;
        }
        self.maxBankAmount = [data.data[@"BIND_BANK_CARD_AMOUNT"] intValue];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -  我的报表
-(void)getpriceData {
    
    @weakify(self)
    [WebTools postWithURL:@"/memberFund/reportForms.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"] || [data.data isEqual:@""]) {
            return;
        }
        MyReportModel *model = [MyReportModel mj_objectWithKeyValues:data.data];
        [self setValueModel:model];
    } failure:^(NSError *error) {
        
    }];
}

- (void)setValueModel:(MyReportModel *)model {
    NSString *price = [NSString stringWithFormat:@"%.2f",[Person person].balance];
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",price];
    
    self.winMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",model.winAmount];
    self.loseMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f", model.profitAmount];
}

-(void)dealloc {
    
    MBLog(@"%s dealloc",object_getClassName(self));
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kUpdateAddBankNotification object:nil];
}

@end
