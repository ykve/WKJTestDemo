//
//  ZhangBianRecordViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ZhangBianRecordViewController.h"
#import "RecordModel.h"
#import "RecordCell.h"
#import "SelectTypeView.h"
#import "TypeModel.h"
@interface ZhangBianRecordViewController ()<UITableViewDelegate, UITableViewDataSource>
    
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UIView *typeView;

@property (strong, nonatomic) NSArray *typeArray;

@property (copy, nonatomic) NSString *date;
@end

@implementation ZhangBianRecordViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"开奖日历") style:UIBarButtonItemStylePlain target:self action:@selector(selectdate)];
    
    self.page = 1;
    
    [self initData];
    
    [self initTypeData];
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)

        self.page = 1;
        
        [self initData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)

        self.page++;
        
        [self initData];
    }];
    
    [self.typeView tapHandle:^{
        @strongify(self)

        SelectTypeView *typeview = [[SelectTypeView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT + 30, SCREEN_WIDTH, 0)];
        typeview.array = self.typeArray;
        typeview.dismissBlock = ^{
            
            self.page = 1;
            [self initData];
        };
        [typeview show:self.view];
        
    }];
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 47;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    RecordModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    NSString *time = [model.createTime substringToIndex:10];
    cell.timelab.text = [Tools returnchuototime:time];
    
    cell.typelab.text = model.type;
    cell.pricelab.text = [NSString stringWithFormat:@"%.2f",model.money];
    cell.banlancelab.text = [NSString stringWithFormat:@"%.2f",model.balance];
    
    return cell;
}

-(void)initData {
    
    NSMutableArray *types = [[NSMutableArray alloc]init];
    for (TypeModel *model in self.typeArray) {
        
        if (model.selected) {
            
            [types addObject:@(model.type)];
        }
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@(self.page) forKey:@"pageNum"];
    [dic setValue:pageSize forKey:@"pageSize"];
    [dic setValue:types.count == 0 ? nil : types forKey:@"types"];
    [dic setValue:self.date forKey:@"startDate"];
    [dic setValue:self.date forKey:@"endDate"];
    
    @weakify(self)
    [WebTools postWithURL:@"/memberFund/changeRecord.json" params:dic success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"] || [data.data isEqual:@""]) {
            return;
        }
        if (self.page == 1) {
            [self.dataSource removeAllObjects];
        }
        
        NSArray *array = [RecordModel mj_objectArrayWithKeyValuesArray:data.data];
        if (self.page >= 1 &&(!array || array.count ==0)) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            if (self.page == 1) {
                [self showNoDataImageView];
            }
            [self.tableView.mj_footer setHidden:YES];
            
        }else{
            [self hiddenNoDataImageView];
            [self.tableView.mj_footer setHidden:NO];

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

-(void)initTypeData {
    
    @weakify(self)
    [WebTools postWithURL:@"/memberFund/balanceChangeTypes.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        self.typeArray = [TypeModel mj_objectArrayWithKeyValuesArray:data.data];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(void)selectdate {
    
    ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
    @weakify(self)
    [alert builddateView:^(NSString *date) {
        @strongify(self)

        self.date = date;
        self.page = 1;
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
