//
//  LoadHistoryCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "LoadHistoryCtrl.h"
#import "LoadHistoryModel.h"
@interface LoadHistoryCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)int page;
@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation LoadHistoryCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录历史";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 70;
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
    
    self.page = 1;
    
    [self initData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        
        [self initData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page ++ ;
        
        [self initData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RJCellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    LoadHistoryModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.textLabel.text = model.client;
    
    NSString *sub = [NSString stringWithFormat:@"%@ 于 %@ 登录",model.loginTime, model.address];
    
    cell.detailTextLabel.text = sub;
    cell.detailTextLabel.textColor = [UIColor colorWithHex:@"999999"];
    
    UILabel *lab = [Tools createLableWithFrame:CGRectMake(0, 0, 80, 30) andTitle:model.state andfont:FONT(14) andTitleColor:[[CPTThemeConfig shareManager] loginHistoryTextColor] andBackgroundColor:CLEAR andTextAlignment:2];
    if([lab.text isEqualToString:@"正常"]){
        lab.textColor = [UIColor colorWithHex:@"369BFB"];
    }else if ([lab.text isEqualToString:@"异常"]){
        lab.textColor = [UIColor colorWithHex:@"F63B3B"];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 69.5, SCREEN_WIDTH-30, 0.5)];
    line.backgroundColor = [UIColor colorWithHex:@"E6E6E6"];
    [cell.contentView addSubview:line];
    cell.accessoryView = lab;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

-(void)initData {
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/pageLoginLog.json" params:@{@"pageNum":@(self.page),@"pageSize":pageSize} success:^(BaseData *data) {
        @strongify(self)
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (self.page == 1) {
            [self.dataSource removeAllObjects];
        }
        if(data.data){
            if ([[data.data objectForKey:@"list"] count]) {
                NSArray *array = [LoadHistoryModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                [self.dataSource addObjectsFromArray:array];
            } else {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
//                self.tableView.mj_footer = nil;
            }
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } showHUD:NO];
}

-(NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
