//
//  FreeRecommendCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "FreeRecommendCtrl.h"
#import "RecommendCell.h"
#import "FreeRecommendView.h"
#import "ChongqinFreeModel.h"

@interface FreeRecommendCtrl ()

@property (nonatomic, strong)FreeRecommendView *headView;

@property (nonatomic, strong)ChongqinFreeModel *model;

@end

@implementation FreeRecommendCtrl

-(FreeRecommendView *)headView {
    
    if (!_headView) {
        
        _headView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([FreeRecommendView class]) owner:self options:nil]firstObject];
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 162);
    }
    return _headView;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titlestring = @"免费推荐";
    @weakify(self)
    [self buildTimeViewWithType:self.lottery_type With:nil With:^{
        @strongify(self)
        [self refresh];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, NAV_HEIGHT + 34, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 34);
    self.tableView.tableHeaderView = self.headView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.model = [[ChongqinFreeModel alloc]init];
  
    self.page = 1;
    
    [self initData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        
        [self initData];
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
    
    switch (self.lottery_type) {
        case 1:
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_cqssc" object:nil];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_xjssc" object:nil];
            break;
        case 3:
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_txffc" object:nil];
            break;
        default:
            
            break;
    }
}

-(void)refresh {
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)removenotification {
    
    switch (self.lottery_type) {
        case 1:
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_cqssc" object:nil];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xjssc" object:nil];
            break;
        case 3:
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_txffc" object:nil];
            break;
        default:
            
            break;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.model.list.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    ChongqinFreeListModel *model = self.model.list[section];
    
    return model.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    for (UILabel *label in cell.contentView.subviews) {
        
        label.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
    }
    
    ChongqinFreeListModel *model = self.model.list[indexPath.section];
    
    NSDictionary *dic = model.array[indexPath.row];
    
    cell.titlelab.text = dic[@"title"];
    
    NSArray *numbers = [model.openNumber componentsSeparatedByString:@","];
    
    NSString *num = @"0";
    
    if (numbers.count == model.array.count) {
        
        num = numbers[indexPath.row];
    }
    
    
    if ((num.integerValue % 2 == 0 && [dic[@"2"] isEqualToString:@"双"]) ||(num.integerValue %2 == 1 &&[dic[@"2"] isEqualToString:@"单"])) {
        
        cell.singleordoublelab.textColor = [UIColor redColor];
        
        cell.singleordoublelab.text = [dic[@"2"] stringByAppendingString:@"(赢)"];
    }
    else{
        cell.singleordoublelab.textColor = YAHEI;
        cell.singleordoublelab.text = dic[@"2"];
    }
    if ((num.integerValue < 5 && [dic[@"3"] isEqualToString:@"小"]) || (num.integerValue > 4 && [dic[@"3"] isEqualToString:@"大"])) {
        
        cell.bigorsmalllab.textColor = [UIColor redColor];
        
        cell.bigorsmalllab.text = [dic[@"3"] stringByAppendingString:@"(赢)"];
    }
    else{
        cell.bigorsmalllab.textColor = YAHEI;
        cell.bigorsmalllab.text = dic[@"3"];
    }
    NSRange range = [dic[@"1"] rangeOfString:num];
    
    if (range.location != NSNotFound) {
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[dic[@"1"] stringByAppendingString:@"(赢)"]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(AttributedStr.length-3, 3)];
        cell.numberlab.attributedText = AttributedStr;
    }
    else{
        cell.numberlab.text = dic[@"1"];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 25;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    
    v.backgroundColor = [UIColor colorWithHex:@"dddddd"];
    
    ChongqinFreeListModel *model = self.model.list[section];
    
    NSString *str = [NSString stringWithFormat:@"%@ %@期 开奖结果%@",model.createTime,[model.issue substringFromIndex:self.lottery_type == 3 ? 9 : 8],model.openNumber];
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:str andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
    
    [v addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(v);
    }];
    
    return v;
}


-(void)initData {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscRecommends.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscRecommends.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcRecommends.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"pageNum":@(self.page),@"pageSize":pageSize} success:^(BaseData *data) {
        
        @strongify(self)
        NSDictionary *dic = data.data;
        
        if (self.page == 1) {
            
            [self.model.list removeAllObjects];
            
            self.model = nil;
        }
        
        if (self.model == nil) {
            
            self.model = [ChongqinFreeModel mj_objectWithKeyValues:dic[@"lastSg"]];
        }
        
        
        for (NSDictionary *listdic in dic[@"list"]) {
            
            ChongqinFreeListModel *model = [[ChongqinFreeListModel alloc]init];
            model.issue = listdic[@"issue"];
            model.createTime = [listdic[@"createTime"] componentsSeparatedByString:@" "].firstObject;
            model.openNumber = listdic[@"openNumber"];
            ChongqinFreeListInfoModel *infomodel = [ChongqinFreeListInfoModel mj_objectWithKeyValues:listdic];
            model.model = infomodel;
            
            [self.model.list addObject:model];
        }
    
        if ([Tools isEmptyOrNull:self.model.list.firstObject.openNumber]) {
            
            self.model.infomodel = self.model.list.firstObject;
            
            [self.model.list removeObjectAtIndex:0];
            
            self.headView.recommendversionslab.text = [NSString stringWithFormat:@"%@ %@期投注参考",self.model.infomodel.createTime,[self.model.infomodel.issue substringFromIndex:8]];
            
            
            for (int i = 0; i< self.headView.numerlabs.count; i++) {
                
                UILabel *lab = self.headView.numerlabs[i];
                NSDictionary *dic = self.model.infomodel.array[i];
                lab.text = [NSString stringWithFormat:@"%@ %@ %@",dic[@"1"],dic[@"2"],dic[@"3"]];
                
            }
        
        }
        
        [self endRefresh:self.tableView WithdataArr:dic[@"list"]];
        
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

@end
