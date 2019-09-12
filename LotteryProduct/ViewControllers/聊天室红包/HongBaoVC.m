//
//  HongBaoVC.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/15.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "HongBaoVC.h"
#import "HongbaoReceivedCell.h"
#import "HongbaoSentCell.h"
#import "HongbaoReceivedHeader.h"
@interface HongBaoVC ()
@property(strong,nonatomic)NSDictionary *receiveInfo;
@property(strong,nonatomic)NSDictionary *sendInfo;

@property(strong,nonatomic)NSDictionary *chatPackInfo;

@end



@implementation HongBaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navView.hidden = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HongbaoReceivedCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HongbaoReceivedCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HongbaoSentCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HongbaoSentCell"];


    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT-40);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.page = 1;
    
    [self loadData];
    
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        [self loadData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page = self.page+1;
        [self loadData];
    }];
    
    
}
- (void)loadData{
    if(self.type ==1){
        [self iniReceiveInfoList];
    }else{
        [self initSendInfoList];

    }
}

- (void)configHeader{
    if(self.type == 1){
        HongbaoReceivedHeader * header = [[[NSBundle mainBundle]loadNibNamed:@"HongbaoReceivedHeader" owner:self options:nil]firstObject];
        header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 98);
        header.titleLabel.text = [NSString stringWithFormat:@"我总共收到%ld个红包",(long)[self.receiveInfo[@"totalNumber"] integerValue]];
        header.moneyLabel.text = [NSString stringWithFormat:@"%.2f",[self.receiveInfo[@"totalMoney"] floatValue]];
        
        [self.tableView setTableHeaderView:header];

    }else{
        HongbaoReceivedHeader* header = [[[NSBundle mainBundle]loadNibNamed:@"HongbaoReceivedHeader" owner:self options:nil]firstObject];
        header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 98);
        header.titleLabel.text = [NSString stringWithFormat:@"我总共发出%ld个红包",(long)[self.sendInfo[@"totalNumber"] integerValue]];
        header.moneyLabel.text = [NSString stringWithFormat:@"%.2f",[self.sendInfo[@"totalMoney"] floatValue]];
        [self.tableView setTableHeaderView:header];
    }
}

-(void)refresh {
    self.page = 1;
//    [self initData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.type==1){
        return 50;

    }else{
        return 55;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * dic = self.dataSource[indexPath.row];
    if(self.type==1){
        HongbaoReceivedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HongbaoReceivedCell"];
        [cell.headImageV sd_setImageWithURL:[NSURL URLWithString:dic[@"head"]] placeholderImage:IMAGE(@"头像")];
        cell.titlelab1.text = dic[@"nickName"];
        cell.moneyLab.text = [NSString stringWithFormat:@"%.2f",[dic[@"money"] floatValue]];
        NSString *time = [NSString stringWithFormat:@"%@",dic[@"createTime"]] ;
        cell.subTitleLab.text = [Tools chuototimedian2:[time doubleValue]/1000];
        return cell;
    }else{
        HongbaoSentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HongbaoSentCell"];
        cell.titleLab.text = [NSString stringWithFormat:@"%ld个随机红包",(long)[dic[@"sendNumber"] integerValue]];
        cell.moneyLab.text = [NSString stringWithFormat:@"%.2f",[dic[@"money"] floatValue]];
        NSString *time = [NSString stringWithFormat:@"%@",dic[@"createTime"]] ;
        cell.timeLab.text = [Tools chuototimedian2:[time doubleValue]/1000];
        
        float receiveMoney = [dic[@"receiveMoney"] floatValue];
        double endtime = [dic[@"endTime"] doubleValue];
        NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
        NSTimeInterval time1=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
        if(time1<endtime){
            if(receiveMoney >0.00){
                cell.stateLab.text = @"剩余";
                cell.money2Lab.hidden =  cell.money3Lab.hidden = NO;
                cell.money2Lab.text =  [NSString stringWithFormat:@"%.2f",receiveMoney];
            }else {
                cell.stateLab.text = @"已领完";
                cell.money2Lab.hidden =  cell.money3Lab.hidden = YES;
            }
        }else{
            if(receiveMoney >0.00){
                cell.stateLab.text = @"未领取";
                cell.money2Lab.hidden =  cell.money3Lab.hidden = NO;
                cell.money2Lab.text =  [NSString stringWithFormat:@"%.2f",receiveMoney];
            }else {
                cell.stateLab.text = @"已领取";
                cell.money2Lab.hidden =  cell.money3Lab.hidden = YES;
            }
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ActivityDetailVC * vc = [[ActivityDetailVC alloc] initWithNibName:@"ActivityDetailVC" bundle:nil];
//    NSDictionary * dic = self.dataSource[indexPath.row];
//
//    vc.dic = dic;
//    PUSH(vc);
}

-(void)iniReceiveInfoList {
    
    @weakify(self)
    [WebTools postWithURL:@"/chatPack/receiveInfoList.json" params:@{@"pageNum":@(self.page),@"pageSize":@(10)} success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return;
        }
        @strongify(self)
        NSArray * ar = data.data;
        if([ar isKindOfClass: [NSString class]]){
            [self endRefresh:self.tableView WithdataArr:nil];
            return;
        }
        if (self.page == 1) {
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:ar];
        if (self.page == 1 &&(!ar || ar.count ==0)) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self.tableView.mj_footer setHidden:YES];
            [self showNoDataImageView];
        }else{
            [self hiddenNoDataImageView];
            [self.tableView.mj_footer setHidden:NO];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self.tableView reloadData];
            [self endRefresh:self.tableView WithdataArr:nil];
        }
        if (!ar || ar.count ==0) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self initReceiveInfo];

    } failure:^(NSError *error) {
        @strongify(self)
        [self endRefresh:self.tableView WithdataArr:nil];
    }];
}

-(void)initSendInfoList {
    
    @weakify(self)
    [WebTools postWithURL:@"/chatPack/sendInfoList.json" params:@{@"pageNum":@(self.page),@"pageSize":@(10)} success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return;
        }
        @strongify(self)
        NSArray * ar = data.data;
        if([ar isKindOfClass: [NSString class]]){
            [self endRefresh:self.tableView WithdataArr:nil];
            return;
        }
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:ar];
        
        if (self.page == 1 &&(!ar || ar.count ==0)) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self.tableView.mj_footer setHidden:YES];
            [self showNoDataImageView];
        }else{
            [self hiddenNoDataImageView];
            [self.tableView.mj_footer setHidden:NO];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self.tableView reloadData];
            [self endRefresh:self.tableView WithdataArr:nil];
        }
        if (!ar || ar.count ==0) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self initSendInfo];

    } failure:^(NSError *error) {
        @strongify(self)
        [self endRefresh:self.tableView WithdataArr:nil];
    }];
}


-(void)initReceiveInfo {//领取统计
    
    @weakify(self)
    [WebTools postWithURL:@"/chatPack/receiveInfo.json" params:nil success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return;
        }
        @strongify(self)
        NSDictionary * dic = data.data;
        if([dic isKindOfClass: [NSString class]]){
            return;
        }
        self.receiveInfo = [NSMutableDictionary dictionaryWithDictionary:dic];
        [self configHeader];
    } failure:^(NSError *error) {
    }];
}

-(void)initSendInfo {//发出红包统计
    
    @weakify(self)
    [WebTools postWithURL:@"/chatPack/sendInfo.json" params:nil success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return;
        }
        @strongify(self)
        NSDictionary * dic = data.data;
        if([dic isKindOfClass: [NSString class]]){
            return;
        }
        self.sendInfo = [NSMutableDictionary dictionaryWithDictionary:dic];
        [self configHeader];

    } failure:^(NSError *error) {
    }];
}

-(void)getChatPackInfo {//获取红包
    
    @weakify(self)
    [WebTools postWithURL:@"/chatPack/chatPackInfo.json" params:nil success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return;
        }
        @strongify(self)
        NSDictionary * dic = data.data;
        if([dic isKindOfClass: [NSString class]]){
            return;
        }
        self.chatPackInfo = [NSMutableDictionary dictionaryWithDictionary:dic];
        
    } failure:^(NSError *error) {
    }];
}




@end
