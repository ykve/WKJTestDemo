//
//  HiddenPepoleCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HiddenPepoleCtrl.h"
#import "HiddenPeopleCell.h"
@interface HiddenPepoleCtrl ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (assign, nonatomic) int page;
@end

@implementation HiddenPepoleCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"屏蔽用户";
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.page = 1;
    
    [self initData];
    
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        
        [self initData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page ++;
        
        [self initData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HiddenPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.namelab.text = dic[@"nickname"];
    
    cell.open.on = [dic[@"onOff"]boolValue];
    
    @weakify(self)
    cell.onOffBlock = ^(BOOL onoff) {
        @strongify(self)
        [self onoff:onoff Withshieldid:dic[@"shieldId"]];
    };
    return cell;
}

-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/getShieldUserList" params:@{@"pageNum":@(self.page),@"pageSize":pageSize} success:^(BaseData *data) {
        
        @strongify(self)
        NSArray *array = data.data;
        
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }
        
        [self.dataSource addObjectsFromArray:array];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView.mj_footer endRefreshing];
        
        if (array.count == 0) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)onoff:(BOOL)onoff Withshieldid:(NSNumber *)shielId {
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/shieldUserListSetting" params:@{@"shieldId":shielId,@"onOff":@(onoff == YES ? 1 : 0)} success:^(BaseData *data) {
        
        @strongify(self)
        [MBProgressHUD showSuccess:data.info finish:^{
            @strongify(self)
            self.page = 1;
            
            [self initData];
        }];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}


@end
