//
//  PrizeMessageViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PrizeMessageViewController.h"
#import "MessageModel.h"
#import "MineMessageCell.h"

@interface PrizeMessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation PrizeMessageViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.rowHeight = UITableViewAutomaticDimension; // 自适应单元格高度
//    self.tableView.estimatedRowHeight = 50; //先估计一个高度
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
    
    cell.timelab.text = [NSString stringWithFormat:@"有效时间:%@--%@",model.startDate,model.endDate];
    
    NSString *today = [Tools getlocaletime];
    
    NSInteger status1 = [self compareDate:model.startDate withDate:today];
    
    NSInteger status2 = [self compareDate:model.endDate withDate:today];
    
    cell.contentlab.textColor = [[CPTThemeConfig shareManager] PrizeMessageTopbackViewTextColor];

    if (status1 == -1) {
        cell.statuslab.text = @"未开始"; 
        cell.topBackView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_Gonggao_TopBackViewStatus1];
        cell.statuslab.textColor = [UIColor lightGrayColor];
    }
    else if (status2 == 1) {
        cell.statuslab.text = @"已结束";
        cell.topBackView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_Gonggao_TopBackViewStatus1];
        cell.statuslab.textColor = [UIColor lightGrayColor];
    }
    else {
        cell.statuslab.text = @"未结束";
        cell.topBackView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_Gonggao_TopBackViewStatus2];
        cell.statuslab.textColor = [UIColor colorWithHex:@"C48936"];
    }
    return cell;
}

-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/listNotice.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        
        self.dataArray = [MessageModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)

        [self.tableView.mj_header endRefreshing];
        
    }];
}

//比较两个日期的大小  日期格式为2016-08-14
- (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    int ci;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    
    if(result==NSOrderedAscending){
        
        //bDate比aDate大
        ci=1;
    }
    else if (result==NSOrderedDescending){
        //bDate比aDate小
        ci = -1;
    }
    else {
        //aDate=bDate
        ci = 0;
    }
    
    return ci;
    
}

@end
