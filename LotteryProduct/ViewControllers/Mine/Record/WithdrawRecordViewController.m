//
//  WithdrawRecordViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "WithdrawRecordViewController.h"
#import "RecordModel.h"
#import "TopUpRecordCell.h"
#import "WithdrawMoneyOrderStatusVC.h"
@interface WithdrawRecordViewController ()<UITableViewDelegate, UITableViewDataSource>
    
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) NSInteger pageNum;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (copy, nonatomic) NSString *date;

@end

@implementation WithdrawRecordViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"开奖日历") style:UIBarButtonItemStylePlain target:self action:@selector(selectdate)];
    
    [self initData];
    [self initTableView];
    
}

- (void)initTableView {
    self.pageNum = 1;
    
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.pageNum = 1;
        
        [self initData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.pageNum++;
        
        [self initData];
    }];
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TopUpRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    RecordModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    NSString *time = [model.createTime substringToIndex:10];
    cell.timelab.text = [Tools returnchuototime:time];
    
    cell.pricelab.text = [NSString stringWithFormat:@"%.2f",model.amount];
    cell.statuslab.text = [self statusString:model.status];
    cell.remarklab.text = model.remark;
    
    return cell;
}

/**
 /// 提现状态 1.待处理2.处理中3.拒绝4.成功
 
 @param status  status
 @return text
 */
- (NSString *)statusString:(NSInteger)status {
    NSString *text = nil;
    switch (status) {
        case 1:
            text = @"待处理";
            break;
        case 2:
            text = @"处理中";
            break;
        case 3:
            text = @"拒绝";
            break;
        case 4:
            text = @"成功";
            break;
        default:
            break;
    }
    return text;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WithdrawMoneyOrderStatusVC *vc = [[WithdrawMoneyOrderStatusVC alloc] init];
    vc.titlestring = @"提现订单详情";
    RecordModel *model = [self.dataSource objectAtIndex:indexPath.row];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)initData {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@(self.pageNum) forKey:@"pageNum"];
    [dic setValue:pageSize forKey:@"pageSize"];
//    [dic setValue:self.date forKey:@"startDate"];
//    [dic setValue:self.date forKey:@"endDate"];

     [dic setValue:self.date forKey:@"date"];
    
    @weakify(self)
    [WebTools postWithURL:@"/payList/queryWithdrawPickList.json" params:dic success:^(BaseData *data) {
        
        if (![data.status isEqualToString:@"1"] || [data.data isEqual:@""]) {
            return;
        }
        @strongify(self)
        if (self.pageNum == 1) {
            [self.dataSource removeAllObjects];
        }
        
        NSArray *array = [RecordModel mj_objectArrayWithKeyValuesArray:data.data];
        if (self.pageNum >= 1 && (!array || array.count ==0)) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            if (self.pageNum == 1) {
                [self showNoDataImageView];
            }
            self.tableView.mj_footer = nil;
            return ;
        }else{
            [self hiddenNoDataImageView];
        }
        [self.dataSource addObjectsFromArray:array];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        @strongify(self)

        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)selectdate {
    @weakify(self)
    ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
    [alert builddateView:^(NSString *date) {
        @strongify(self)

        self.date = date;
        self.pageNum = 1;
        [self initData];
    }];
    [alert show];
}

-(NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

@end
