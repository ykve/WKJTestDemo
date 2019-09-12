//
//  PK10FirstandSecondCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
// 冠亚和龙虎

#import "PK10FirstandSecondCtrl.h"
#import "PK10FirstandSecondCell.h"
#import "PK10HistoryModel.h"
@interface PK10FirstandSecondCtrl ()

@property (nonatomic,copy) NSString *time;

@end

@implementation PK10FirstandSecondCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hiddenavView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PK10FirstandSecondCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 30;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
    
    [self initDataWithtime:[Tools getlocaletime]];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    view.backgroundColor = [UIColor colorWithHex:@"dddddd"];
    
    NSArray *arr = @[@"期数",@"时间",@"冠亚和",@"1~5龙虎"];
    
    for (int i = 0 ;i< arr.count ; i++) {
        
        UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:arr[i] andfont:FONT(14) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:1];
        if (i == 0) {
            
            lab.frame = CGRectMake(0, 0, SCREEN_WIDTH/6, 30);
        }
        else if (i == 1) {
            
            lab.frame = CGRectMake(SCREEN_WIDTH/6, 0, SCREEN_WIDTH/6, 30);
        }
        else if (i == 2) {
            
            lab.frame = CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 30);
        }
        else {
            lab.frame = CGRectMake(SCREEN_WIDTH *2/3, 0, SCREEN_WIDTH/3, 30);
        }
        [view addSubview:lab];
    }
    
    
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PK10FirstandSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    int i = 0;
    
    PK10HistoryModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.versionlab.text = model.issue.length > 8 ? [model.issue substringFromIndex:8] : model.issue;
    
    cell.timelab.text = model.time;
    
    cell.sumlab.text = model.total;
    
    cell.bigorsmalllab.text = model.bigorsmall;
    
    cell.singleanddoublelab.text = model.signleordouble;
    
    for (Drawlab *lab in cell.Chartslabs) {
        
        NSString *str = model.longhuArray[i];
        
        lab.text = str;
        lab.textColor = WHITE;
        lab.bgColor = [str isEqualToString:@"龙"] == YES ? LINECOLOR : kColor(140, 152, 183);
        lab.showbg = YES;
        [lab setNeedsDisplay];
        i++;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = indexPath.row %2 == 0 ? WHITE : [UIColor groupTableViewBackgroundColor];
    return cell;
}

-(void)initDataWithtime:(NSString *)time {
    
    self.time = time;
    NSString *url = nil;
    if (self.lottery_type == 6) {
        
        url = @"/bjpksSg/historySg.json";
    }
    else if (self.lottery_type == 7) {
        url = @"/xyftSg/historySg.json";
    }
    else if (self.lottery_type == 11) {
        url = @"/azPrixSg/historySg.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@"301",@"date":time,@"pageNum":@(1),@"pageSize":@1000} success:^(BaseData *data) {
        
        @strongify(self)
        NSArray *array = [PK10HistoryModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.dataSource removeAllObjects];
        
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
