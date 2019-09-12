//
//  ActivityRecordViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ActivityRecordViewController.h"
#import "RecordModel.h"
#import "ActivityRecordCell.h"
@interface ActivityRecordViewController ()<UITableViewDelegate, UITableViewDataSource>
    
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *reasepricelab;

@property (weak, nonatomic) IBOutlet UILabel *backpricelab;

@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (copy, nonatomic) NSString *date;

@end

@implementation ActivityRecordViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"开奖日历") style:UIBarButtonItemStylePlain target:self action:@selector(selectdate)];
    
    self.page = 1;
    
    [self initData];
    
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
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    RecordModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.timelab.text = model.createTime;
    
    cell.pricelab.text = [NSString stringWithFormat:@"%.2f",model.amount/100];
    
    return cell;
}

-(void)initData {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@(self.page) forKey:@"pageNum"];
    [dic setValue:pageSize forKey:@"pageSize"];
    [dic setValue:self.date forKey:@"startDate"];
    [dic setValue:self.date forKey:@"endDate"];
    
    @weakify(self)
    [WebTools postWithURL:@"/withdraw/pageFirstGiftRecord.json" params:dic success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"] || [data.data isEqual:@""]) {
            return;
        }
        self.reasepricelab.text = [[data.data valueForKey:@"remanentMoney"]stringValue];
        self.backpricelab.text = [[data.data valueForKey:@"gotMoney"]stringValue];
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }
        
        NSArray *array = [data.data valueForKey:@"data"];
        if (self.page >= 1 &&(!array || array.count ==0)) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (self.page == 1) {
                [self showNoDataImageView];
            }
            self.tableView.mj_footer = nil;
            return ;
        }else{
            [self hiddenNoDataImageView];
        }
        if ([array isKindOfClass:[NSArray class]]) {
            
            NSArray *marray = [RecordModel mj_objectArrayWithKeyValuesArray:array];
            
            [self.dataSource addObjectsFromArray:marray];
        }
        
        
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
