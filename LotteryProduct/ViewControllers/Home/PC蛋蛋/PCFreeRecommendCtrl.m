//
//  PCFreeRecommendCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PCFreeRecommendCtrl.h"
#import "RecommendCell.h"
#import "PCRecommendHeadView.h"
#import "PCFreeRecommendModel.h"
@interface PCFreeRecommendCtrl ()

@property (nonatomic, strong)PCRecommendHeadView *headView;

@property (nonatomic, strong)PCFreeRecommendModel *freemodel;

@end

@implementation PCFreeRecommendCtrl

-(PCRecommendHeadView *)headView {
    
    if (!_headView) {
        
        _headView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([PCRecommendHeadView class]) owner:self options:nil]firstObject];
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 148);
    }
    return _headView;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"免费推荐";
    
    @weakify(self)
    [self buildTimeViewWithType:5 With:nil With:^{
        @strongify(self)
        [self refresh];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, NAV_HEIGHT + 34, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 34);
    self.tableView.tableHeaderView = self.headView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.page = 1;
    
    [self initData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)

        [self refresh];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)

        self.page ++ ;
        
        [self initData];
    }];
    
    //投注按钮
    [self buildBettingBtn];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self addnotification];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self removenotification];
}
-(void)addnotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_pcegg" object:nil];
    
}

-(void)refresh {
    
    self.page = 1;
    
    [self initData];
}

-(void)removenotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_pcegg" object:nil];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    v.backgroundColor = [UIColor colorWithHex:@"dddddd"];
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
    [v addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(v);
    }];
    
    List *list = [self.dataSource objectAtIndex:section];
    
    PceggLotterySg *sg = list.pceggLotterySg;
    
    lab.text = [NSString stringWithFormat:@"%@ %@期 开奖结果：%@",[sg.time componentsSeparatedByString:@" "].firstObject,sg.issue,sg.number];
    
    return v;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    for (UILabel *label in cell.contentView.subviews) {
        
        label.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
        
    }

    cell.titlelab.text = indexPath.row == 0 ? @"第一区" : indexPath.row == 1 ? @"第二区" : @"第三区";
    
    List *list = [self.dataSource objectAtIndex:indexPath.section];
    PceggRecommend *model = list.pceggRecommend;
    
    NSString *number = indexPath.row == 0 ? model.regionOneNumber : indexPath.row == 1 ? model.regionTwoNumber : model.regionThreeNumber;
    NSString *single = indexPath.row == 0 ? model.regionOneSingle : indexPath.row == 1 ? model.regionTwoSingle : model.regionThreeSingle;
    NSString *region = indexPath.row == 0 ? model.regionOneSize : indexPath.row == 1 ? model.regionTwoSize : model.regionThreeSize;
    
    PceggLotterySg *sg = list.pceggLotterySg;
    
    NSArray *numbers = [sg.number componentsSeparatedByString:@","];
    
    NSString *num = @"0";
    
    if (numbers.count == 3) {
        
        num = numbers[indexPath.row];
    }
    
    if ((num.integerValue % 2 == 0 && [single isEqualToString:@"双"]) ||(num.integerValue %2 == 1 &&[single isEqualToString:@"单"])) {
        
        cell.singleordoublelab.textColor = [UIColor redColor];
        
        cell.singleordoublelab.text = [single stringByAppendingString:@"(赢)"];
    }
    else{
        cell.singleordoublelab.textColor = YAHEI;
        cell.singleordoublelab.text = single;
    }
    if ((num.integerValue < 5 && [region isEqualToString:@"小"]) || (num.integerValue > 4 && [region isEqualToString:@"大"])) {
        
        cell.bigorsmalllab.textColor = [UIColor redColor];
        
        cell.bigorsmalllab.text = [region stringByAppendingString:@"(赢)"];
    }
    else{
        cell.bigorsmalllab.textColor = YAHEI;
        cell.bigorsmalllab.text = region;
    }
    NSRange range = [number rangeOfString:num];
    
    if (range.location != NSNotFound) {
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[number stringByAppendingString:@"(赢)"]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(AttributedStr.length-3, 3)];
        cell.numberlab.attributedText = AttributedStr;
    }
    else{
        cell.numberlab.text = number;
    }
 
    return cell;
}

-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/pceggSg/getPceggRecommends.json" params:@{@"pageNum":@(self.page),@"pageSize":pageSize} success:^(BaseData *data) {
        
        @strongify(self)
        self.freemodel = [PCFreeRecommendModel mj_objectWithKeyValues:data.data];
        
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }else if (self.freemodel.list.count == 0){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        self.headView.model = self.freemodel;
        
        [self.dataSource addObjectsFromArray:self.freemodel.list];
        
        
        [self endRefresh:self.tableView WithdataArr:self.freemodel.list];
        
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
