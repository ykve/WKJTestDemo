//
//  ActivityVC.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/10.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "ActivityVC.h"
#import "ActivityCell.h"
#import "ActivityDetailVC.h"

@interface ActivityVC ()

@end

@implementation ActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"活动";

    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActivityCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor hexStringToColor:@"f0f2f5"];

    self.page = 1;
    
    [self initData];
    
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self initData];
    }];

}

-(void)refresh {
    self.page = 1;
    [self initData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    NSDictionary * dic = self.dataSource[indexPath.row];
    [cell.imgv sd_setImageWithURL:[NSURL URLWithString:dic[@"actOutBanner"]]];
    NSString *time = dic[@"actEndTime"];
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time1=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    if(time1<[time doubleValue]){
        cell.titlelab.text = [Tools chuototimedian2:[time doubleValue]/1000];
        cell.stateLable.text = @"截止时间：";

    }else{
        cell.titlelab.text = @"";
        cell.stateLable.text = @"活动已结束";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityDetailVC * vc = [[ActivityDetailVC alloc] initWithNibName:@"ActivityDetailVC" bundle:nil];
    NSDictionary * dic = self.dataSource[indexPath.row];

    vc.dic = dic;
    PUSH(vc);
}

-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/activity/list.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        NSArray * ar = data.data[@"data"];
        if([ar isKindOfClass:[NSString class]]){
            return ;
        }
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:ar];
        [self.tableView reloadData];
        [self endRefresh:self.tableView WithdataArr:nil];

    } failure:^(NSError *error) {
        @strongify(self)
        [self endRefresh:self.tableView WithdataArr:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
