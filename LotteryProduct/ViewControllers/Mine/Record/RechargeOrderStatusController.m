//
//  RechargeOrderStatusController.m
//  LotteryProduct
//
//  Created by pt c on 2019/7/20.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RechargeOrderStatusController.h"
#import "OrderStatusTableViewCell.h"
#import "OrderStatusModel.h"
#import "TopUpViewController.h"
#import "KeFuViewController.h"

static NSString *const kOrderStatusTableViewCellId = @"OrderStatusTableViewCell";

@interface RechargeOrderStatusController ()

/// 实际充值金额
@property (nonatomic, strong) UILabel *titleLabel;
/// 实际充值金额
@property (nonatomic, strong) UILabel *payAmountLabel;

@property (nonatomic, strong) UILabel *processingLabel;
@property (nonatomic, strong) UILabel *successLabel;
@property (nonatomic, strong) UILabel *dateTopLabel;
@property (nonatomic, strong) UILabel *dateMidLabel;
@property (nonatomic, strong) UILabel *dateBottomLabel;
@property (nonatomic, strong) UIImageView *statusImageView;



@property (nonatomic, strong) UIView *successheadView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *payAmountView;

/// 失败
//@property (nonatomic, strong) UIImageView *failureImageView;
@property (nonatomic, strong) UILabel *failureLabel;

@end

@implementation RechargeOrderStatusController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    
    @weakify(self)
    [self rigBtn:@"联系客服" Withimage:@"" With:^(UIButton *sender) {
        @strongify(self)
        [self customerServiceBtnBtn];
    }];
    
    [self setupTableViewUI];
    
}

- (void)initData {
    self.dataSource = [NSMutableArray array];
}

- (void)setupTableViewUI {
    
    
    self.tableView.rowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT, 0, 0, 0));
    }];
    
    [self.tableView registerClass:[OrderStatusTableViewCell class] forCellReuseIdentifier:kOrderStatusTableViewCellId];
    
    [self tableFooterView];
}


- (void)setModel:(RecordModel *)model {
    _model = model;
    if (model.status == 2) {
        [self failureTableHeaderView];
    } else {
        [self tableHeaderView];
    }
    [self getData];
}

#pragma mark -  获取订单详情数据
- (void)getData {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:self.model.ID forKey:@"id"];
    
    @weakify(self)
    [WebTools postWithURL:@"/payList/queryPaymentSummaryDetails.json" params:dic success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"] || [data.data isEqual:@""]) {
            return;
        }
        if([data.data isKindOfClass:[NSDictionary class]]){
            OrderStatusModel *model = [OrderStatusModel mj_objectWithKeyValues:data.data];
            
            if (model.status == 2) {
                [self setFailureValues:model];
            } else {
                [self setValues:model];
            }
        }
    } failure:^(NSError *error) {
        //        @strongify(self)
    }];
}

- (void)setValues:(OrderStatusModel *)model {
    
    if (model.status == 1 && model.actualAmount != model.amount) {
        self.successheadView.frame  = CGRectMake(0, 0, kSCREEN_WIDTH, 360);
        self.payAmountView.hidden = NO;
        self.payAmountLabel.hidden = NO;
        
        [self.statusImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.payAmountView.mas_bottom).offset(30);
            make.left.mas_equalTo(self.backView.mas_left).offset(80);
            make.size.mas_equalTo(CGSizeMake(24, 173));
        }];
        self.tableView.tableHeaderView = self.successheadView;
    }
    
    
    
    //    self.processingLabel.text = [NSString stringWithFormat:@"%2.f", model.amout];
    
    NSString *startTime = [[model.timeList objectForKey:@"startTime"] stringValue];
    if (startTime.length >= 10) {
        NSString *time = [startTime substringToIndex:10];
        self.dateTopLabel.text = [Tools returnchuototime:time];
    }
    NSString *estimateTime = [[model.timeList objectForKey:@"estimateTime"] stringValue];
    if (estimateTime.length >= 10) {
        NSString *time = [estimateTime substringToIndex:10];
        self.dateMidLabel.text = [NSString stringWithFormat:@"预计%@到账", [Tools returnchuototime:time]];
    }
    
    
    if (model.status == 1) { // 成功
        self.titleLabel.text = [NSString stringWithFormat:@"￥%2.f", model.actualAmount];
        self.payAmountLabel.text = [NSString stringWithFormat:@"实际转账金额为 ￥%2.f", model.actualAmount];
        self.statusImageView.image = [UIImage imageNamed:@"cz_lc2"];
        self.processingLabel.textColor = [UIColor colorWithHex:@"#999999"];
        
        //        NSString *time = [model.createTime substringToIndex:10];
        //        self.dateMidLabel.text = [Tools returnchuototime:time];
        
        self.successLabel.textColor = [UIColor colorWithHex:@"#333333"];
        
        
        NSString *endTime = [[model.timeList objectForKey:@"endTime"] stringValue];
        if (endTime.length >= 10) {
            NSString *time = [endTime substringToIndex:10];
            self.dateBottomLabel.text = [Tools returnchuototime:time];
        }
        
    } else if (model.status == 3) {  // 等待支付
        self.titleLabel.text = [NSString stringWithFormat:@"￥%2.f", model.amount];
        
        self.processingLabel.textColor = [UIColor colorWithHex:@"#333333"];
        
        self.successLabel.textColor = [UIColor colorWithHex:@"#999999"];
        self.dateBottomLabel.hidden = YES;
        
        [self.successLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.statusImageView.mas_bottom);
        }];
    }
    
    [self.dataSource addObjectsFromArray:@[
                                           @{@"title":@"附言", @"text": [NSString stringWithFormat:@"%ld", model.postScript]},
                                           @{@"title":@"订单金额", @"text": [NSString stringWithFormat:@"￥%2.f", model.amount]},
                                           @{@"title":@"支付方式", @"text": [self typeString:model.type]},
                                           @{@"title":@"订单编号", @"text": model.orderNo}
                                           ]];
    
    [self.tableView reloadData];
}


/**
 失败数据
 
 @param model model
 */
- (void)setFailureValues:(OrderStatusModel *)model {
    
    NSString *startTime = [[model.timeList objectForKey:@"startTime"] stringValue];
    NSString *date = nil;
    if (startTime.length >= 10) {
        NSString *time = [startTime substringToIndex:10];
        date = [Tools returnchuototime:time];
    }
    
    [self.dataSource addObjectsFromArray:@[
                                           
                                           @{@"title":@"充值金额", @"text": [NSString stringWithFormat:@"%2.f",model.amount]},
                                           @{@"title":@"充值方式", @"text": [self typeString:model.type]},
                                           @{@"title":@"$$$", @"text": @""},
                                           @{@"title":@"附言", @"text": [NSString stringWithFormat:@"%ld", model.postScript]},
                                           @{@"title":@"订单金额", @"text": [NSString stringWithFormat:@"￥%2.f", model.amount]},
                                           @{@"title":@"发起时间", @"text": date},
                                           @{@"title":@"订单编号", @"text": model.orderNo}
                                           ]];
    
    [self.tableView reloadData];
}


/**
 /// 支付方式 1：支付宝转银行卡；2：微信转银行卡；3：银行卡转银行卡 4 线上充值
 
 @param type  type
 @return text
 */
- (NSString *)typeString:(NSInteger)type {
    NSString *text = nil;
    switch (type) {
        case 1:
            text = @"支付宝转银行卡";
            break;
        case 2:
            text = @"微信转银行卡";
            break;
        case 3:
            text = @"银行卡转银行卡";
            break;
        case 4:
            text = @"线上充值";
            break;
        case 5:
            text = @"人工";
            break;
        default:
            text = @"";
            break;
    }
    return text;
}



- (void)tableHeaderView {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 330)];
    headView.backgroundColor = [UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1.000];
    _successheadView = headView;
    
    UIView *backView = [[UIView alloc] init];
    backView.layer.cornerRadius = 10;
    backView.layer.masksToBounds = YES;
    backView.layer.borderWidth = 1;
    backView.layer.borderColor = [UIColor colorWithHex:@"#DDDDDD"].CGColor;
    backView.backgroundColor = [UIColor whiteColor];
    [headView addSubview: backView];
    _backView = backView;
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.right.equalTo(headView.mas_right).offset(-15);
        make.bottom.equalTo(headView.mas_bottom).offset(-10);
    }];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor colorWithHex:@"#E0BD7B"];
    [backView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(@(60));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"-";
    titleLabel.font = [UIFont systemFontOfSize:25];
    titleLabel.textColor = [UIColor colorWithHex:@"#6C4E16"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.centerX.equalTo(topView.mas_centerX);
    }];
    
    
    // *** 支付金额 和 充值金额 不一致时 显示 ***
    UIView *payAmountView = [[UIView alloc] init];
    payAmountView.backgroundColor = [UIColor colorWithHex:@"#f3e5cb"];
    [backView addSubview:payAmountView];
    payAmountView.hidden = YES;
    _payAmountView = payAmountView;
    
    [payAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.height.mas_equalTo(@(30));
    }];
    
    UILabel *payAmountLabel = [[UILabel alloc] init];
    payAmountLabel.text = @"-";
    payAmountLabel.font = [UIFont systemFontOfSize:14];
    payAmountLabel.textColor = [UIColor colorWithHex:@"#6C4E16"];
    payAmountLabel.textAlignment = NSTextAlignmentCenter;
    [payAmountView addSubview:payAmountLabel];
    payAmountLabel.hidden = YES;
    _payAmountLabel = payAmountLabel;
    
    [payAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(payAmountView.mas_centerY);
        make.centerX.equalTo(payAmountView.mas_centerX);
    }];
    
    
    // *************************
    
    
    
    UIImageView *statusImageView = [[UIImageView alloc] init];
    statusImageView.image = [UIImage imageNamed:@"cz_lc1"];
    [backView addSubview:statusImageView];
    _statusImageView = statusImageView;
    
    [statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(30);
        make.left.equalTo(backView.mas_left).offset(80);
        make.size.mas_equalTo(CGSizeMake(24, 173));
    }];
    
    
    
    
    UILabel *tiLabel = [[UILabel alloc] init];
    tiLabel.text = @"发起充值";
    tiLabel.font = [UIFont systemFontOfSize:15];
    tiLabel.textColor = [UIColor colorWithHex:@"#999999"];
    tiLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:tiLabel];
    
    [tiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(statusImageView.mas_top);
        make.left.equalTo(statusImageView.mas_right).offset(15);
    }];
    
    UILabel *dateTopLabel = [[UILabel alloc] init];
    dateTopLabel.text = @"-";
    dateTopLabel.font = [UIFont systemFontOfSize:12];
    dateTopLabel.textColor = [UIColor colorWithHex:@"#999999"];
    dateTopLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:dateTopLabel];
    _dateTopLabel = dateTopLabel;
    
    [dateTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tiLabel.mas_bottom).offset(5);
        make.left.equalTo(tiLabel.mas_left);
    }];
    
    
    UILabel *processingLabel = [[UILabel alloc] init];
    processingLabel.text = @"处理中";
    processingLabel.font = [UIFont systemFontOfSize:15];
    processingLabel.textColor = [UIColor colorWithHex:@"#999999"];
    processingLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:processingLabel];
    _processingLabel = processingLabel;
    
    [processingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(statusImageView.mas_centerY);
        make.left.equalTo(tiLabel.mas_left);
    }];
    
    UILabel *dateMidLabel = [[UILabel alloc] init];
    dateMidLabel.text = @"-";
    dateMidLabel.font = [UIFont systemFontOfSize:12];
    dateMidLabel.textColor = [UIColor colorWithHex:@"#999999"];
    dateMidLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:dateMidLabel];
    _dateMidLabel = dateMidLabel;
    
    [dateMidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(processingLabel.mas_bottom).offset(5);
        make.left.equalTo(tiLabel.mas_left);
    }];
    
    
    UILabel *successLabel = [[UILabel alloc] init];
    successLabel.text = @"充值成功";
    successLabel.font = [UIFont systemFontOfSize:15];
    successLabel.textColor = [UIColor colorWithHex:@"#999999"];
    successLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:successLabel];
    _successLabel = successLabel;
    
    [successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(statusImageView.mas_bottom).offset(-10);
        make.left.equalTo(tiLabel.mas_left);
    }];
    
    UILabel *dateBottomLabel = [[UILabel alloc] init];
    dateBottomLabel.text = @"-";
    dateBottomLabel.font = [UIFont systemFontOfSize:12];
    dateBottomLabel.textColor = [UIColor colorWithHex:@"#999999"];
    dateBottomLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:dateBottomLabel];
    _dateBottomLabel = dateBottomLabel;
    
    [dateBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(successLabel.mas_bottom).offset(5);
        make.left.equalTo(tiLabel.mas_left);
    }];
    
    self.tableView.tableHeaderView = headView;
}

- (void)failureTableHeaderView {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 200)];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *failureImageView = [[UIImageView alloc] init];
    failureImageView.image = [UIImage imageNamed:@"cz_sbicon"];
    [headView addSubview:failureImageView];
    
    [failureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_top).offset(18);
        make.centerX.equalTo(headView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    UILabel *failureLabel = [[UILabel alloc] init];
    failureLabel.text = @"充值失败";
    failureLabel.font = [UIFont systemFontOfSize:15];
    failureLabel.textColor = [UIColor colorWithHex:@"#AC1E2D"];
    failureLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:failureLabel];
    
    [failureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(failureImageView.mas_bottom).offset(10);
        make.centerX.equalTo(headView.mas_centerX);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithHex:@"#EEEEEE"];
    bottomView.layer.cornerRadius = 5;
    [headView addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(failureLabel.mas_bottom).offset(16);
        make.left.equalTo(headView.mas_left).offset(15);
        make.right.equalTo(headView.mas_right).offset(-15);
        make.bottom.equalTo(headView.mas_bottom);
    }];
    
    UILabel *failureTitleLabel = [[UILabel alloc] init];
    failureTitleLabel.text = @"收款人的银行卡号与姓名不一致";
    failureTitleLabel.font = [UIFont systemFontOfSize:15];
    failureTitleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    failureTitleLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:failureTitleLabel];
    //    _failureTitleLabel = failureTitleLabel;
    
    [failureTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.centerX.equalTo(bottomView.mas_centerX);
    }];
    
    self.tableView.tableHeaderView = headView;
}

- (void)tableFooterView {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 100)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *continueBtn = [[UIButton alloc] init];
    [continueBtn setTitle:@"继续充值" forState:UIControlStateNormal];
    [continueBtn addTarget:self action:@selector(continueBtn:) forControlEvents:UIControlEventTouchUpInside];
    continueBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [continueBtn setTitleColor:[UIColor colorWithHex:@"#FFFFFF"] forState:UIControlStateNormal];
    continueBtn.backgroundColor = [UIColor colorWithHex:@"#AC1E2D"];
    continueBtn.layer.cornerRadius = 30/2;
    [footerView addSubview:continueBtn];
    
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footerView.mas_centerX);
        make.top.equalTo(footerView.mas_top).offset(35);
        make.size.mas_equalTo(CGSizeMake(160, 30));
    }];
    
    
    UILabel *dateBottomLabel = [[UILabel alloc] init];
    dateBottomLabel.text = @"充值遇到问题？";
    dateBottomLabel.font = [UIFont systemFontOfSize:14];
    dateBottomLabel.textColor = [UIColor colorWithHex:@"#999999"];
    dateBottomLabel.textAlignment = NSTextAlignmentLeft;
    [footerView addSubview:dateBottomLabel];
    
    [dateBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(continueBtn.mas_bottom).offset(20);
        make.left.equalTo(continueBtn.mas_left);
    }];
    
    
    UIButton *customerServiceBtn = [[UIButton alloc] init];
    [customerServiceBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    [customerServiceBtn addTarget:self action:@selector(customerServiceBtnBtn) forControlEvents:UIControlEventTouchUpInside];
    [customerServiceBtn setTitleColor:[UIColor colorWithHex:@"#2B9AF9"] forState:UIControlStateNormal];
    customerServiceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [footerView addSubview:customerServiceBtn];
    
    [customerServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateBottomLabel.mas_centerY);
        make.left.equalTo(dateBottomLabel.mas_right).offset(2);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    self.tableView.tableFooterView = footerView;
}


- (void)continueBtn:(UIButton *)sender {
    if ([Person person].payLevelId.length == 0) {
        [MBProgressHUD showError:@"无用户层级, 暂无法充值"];
        return;
    }
    TopUpViewController *vc = [[TopUpViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)customerServiceBtnBtn {
    KeFuViewController *vc = [[KeFuViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = self.dataSource[indexPath.row];
    if ([dict[@"title"] isEqualToString:@"$$$"]) {
        return 10;
    } else {
        return 40;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = self.dataSource[indexPath.row];
    if ([dict[@"title"] isEqualToString:@"$$$"]) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor colorWithHex:@"#F7F7F7"];
        return cell;
    } else {
        OrderStatusTableViewCell *cell = [OrderStatusTableViewCell cellWithTableView:tableView reusableId:kOrderStatusTableViewCellId];
        
        if (self.dataSource.count > (indexPath.row + 1)) {
            NSDictionary *dict = self.dataSource[indexPath.row + 1];
            if ([dict[@"title"] isEqualToString:@"$$$"]) {
                cell.lineView.hidden = YES;
            }
        }
        cell.model = self.dataSource[indexPath.row];
        return cell;
    }
}

@end
