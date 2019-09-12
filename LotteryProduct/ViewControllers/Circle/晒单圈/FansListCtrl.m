//
//  FansListCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/17.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "FansListCtrl.h"
#import "FansCell.h"
#import "FansModel.h"
@interface FansListCtrl ()

@end

@implementation FansListCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titlestring = self.type == 1 ? @"我的粉丝" : @"我的关注";
    
    [self.tableView registerClass:[FansCell class] forCellReuseIdentifier:RJCellIdentifier];
    self.tableView.rowHeight = 68;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT, 0, 0, 0));
    }];
    
    self.page = 1;
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        
        [self initData];
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page ++;
        
        [self initData];
    }];
    
    [self initData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FansCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    cell.model = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/getFansOrFocus" params:@{@"pageNum":@(self.page),@"pageSize":pageSize,@"type":@(self.type)} success:^(BaseData *data) {
        @strongify(self)
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }
        
        NSArray *array = [FansModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.dataSource addObjectsFromArray:array];
        
        [self endRefresh:self.tableView WithdataArr:array];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self endRefresh:self.tableView WithdataArr:nil];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
