//
//  OpenPrizeViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "OpenPrizeViewController.h"
#import "MessageModel.h"
#import "MineMessageCell.h"

@interface OpenPrizeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation OpenPrizeViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MineMessageCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineMessageCell"];
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self initData];
    }];
    
    [self initData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    CGFloat h = [Tools createLableHighWithString:model.message andfontsize:14 andwithwidth:SCREEN_WIDTH - 36];
    
    return 180 + h;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MineMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineMessageCell"];
    
    MessageModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.titlelab.text = model.title;

    cell.contentlab.text = model.message;
    cell.timelab.textColor =[UIColor colorWithHex:@"C48936"];
    cell.timelab.text = [NSString stringWithFormat:@"发布时间:%@",model.createTime];

    cell.statuslab.hidden = YES;
//
//    cell.delBlock = ^{
//
//        [self delmessage:model];
//    };
    
    return cell;
}

-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/listInstationMessage.json" params:nil success:^(BaseData *data) {
        
        @strongify(self)
        
        [self.tableView.mj_header endRefreshing];
        self.dataArray = [MessageModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)

        [self.tableView.mj_header endRefreshing];
        
    }];
}

-(void)delmessage:(MessageModel *)model {
    
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/deleteInstationMessage.json" params:@{@"messageIdList":@[@(model.ID)]} success:^(BaseData *data) {
        
        @strongify(self)
        [self initData];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

@end
