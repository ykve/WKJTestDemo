//
//  HistoryLotteryCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/31.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HistoryLotteryCtrl.h"
#import "RightTableViewCell.h"
#define LeftTableViewWidth 100
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "SelectTypeView.h"

@interface HistoryLotteryCtrl ()

@property (nonatomic, strong) UITableView *leftTableView, *rightTableView;

@property (nonatomic, strong) NSArray *rightTitles;

@property (nonatomic, strong) UIScrollView *buttomScrollView;

@property (nonatomic,assign) NSInteger index , sort;
@property (nonatomic,copy) NSString *lastDate;

@end

@implementation HistoryLotteryCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"历史开奖";
    self.page = 1;
//    [self buildNavView];
    
//    [self buildTimeViewWithType:self.lottery_type With:nil With:^{
//
//        [self initData];
//    }];
    
    self.rightTitles = @[@"开奖号码",@"十位",@"个位",@"后三"];
    
    [self loadLeftTableView];
    [self loadRightTableView];
    
    self.index = 0;
    self.sort = 0;
    
    //投注按钮
    [self buildBettingBtn];
    if(!self.lastDate){
        self.lastDate = [Tools getlocaletime];
    }
    
    @weakify(self)
    [self buildTimeViewWithType:self.lottery_type With:^(UIButton *sender) {
        @strongify(self)
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        
        alert.lastDate = self.lastDate;
        
        [alert builddateView:^(NSString *date) {
            @strongify(self)
//            self.date = date;
            [self.dataSource removeAllObjects];
            self.page=1;
            [sender setTitle:date forState:UIControlStateNormal];
            self.lastDate = date;
//            [self refresh];
            [self initDataIsFirst:NO];
        }];
        [alert show];
    }With:^{
//        [self refresh];
    }];
    [self initDataIsFirst:YES];

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
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"kj_cqssc" object:nil];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"kj_xjssc" object:nil];
            break;
        case 3:
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"kj_txffc" object:nil];
            break;
        default:
            
            break;
    }
    
    
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

#pragma mark - 导航栏
-(void)buildNavView {
   
//    [self rigBtn:nil Withimage:@"玩法说明" With:^(UIButton *sender) {
//
//        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
//        [alert buildexplainView];
//        [alert show];
//    }];
    
    @weakify(self)
    [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] IC_Nav_Setting_Gear] With:^(UIButton *sender) {
        @strongify(self)

        [self setClick];
    }];
    
//    UIButton *setBtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE(@"设置") andTarget:self andAction:@selector(setClick) andType:UIButtonTypeCustom];
//    [self.navView addSubview:setBtn];
//    
//    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.right.equalTo(self.rightBtn.mas_left).offset(-8);
//        make.size.mas_equalTo(CGSizeMake(43, 43));
//        make.centerY.equalTo(self.rightBtn);
//    }];
}

//设置分割线顶格
- (void)viewDidLayoutSubviews{
    [self.leftTableView setLayoutMargins:UIEdgeInsetsZero];
    [self.rightTableView setLayoutMargins:UIEdgeInsetsZero];
}

- (void)loadLeftTableView{
    //    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LeftTableViewWidth, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.leftTableView = [[UITableView alloc] init];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTableView.rowHeight = 40;
    [self.view addSubview:self.leftTableView];
    @weakify(self)
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.view);
        make.width.equalTo(@(LeftTableViewWidth));
        make.top.equalTo(@(NAV_HEIGHT + 34));
        make.bottom.equalTo(self.view).offset(-SAFE_HEIGHT);
    }];
}

- (void)loadRightTableView{
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - LeftTableViewWidth, SCREEN_HEIGHT - NAV_HEIGHT - 34) style:UITableViewStylePlain];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.rowHeight = 40;
    @weakify(self)
    self.rightTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self initDataIsFirst:NO];
    }];
    
    self.buttomScrollView = [[UIScrollView alloc] init];
    
    self.buttomScrollView.contentSize = CGSizeMake(self.rightTableView.bounds.size.width, 0);
    self.buttomScrollView.backgroundColor = CLEAR;
    self.buttomScrollView.bounces = NO;
    self.buttomScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.buttomScrollView addSubview:self.rightTableView];
    [self.view addSubview:self.buttomScrollView];
    
    [self.buttomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.view);
        make.left.equalTo(self.leftTableView.mas_right);
        make.top.equalTo(@(NAV_HEIGHT + 34));
        make.bottom.equalTo(self.view).offset(SAFE_HEIGHT);
    }];
}

#pragma mark - table view dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (self.dataSource.count == 0) {
//        return 1;
//    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        static NSString *reuseIdentifer = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifer];
            [self resetSeparatorInsetForCell:cell];
        }
        
        NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%03ld期",[dic[@"issue"]integerValue]];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = FONT(15);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
        return cell;
    }else{
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.rightTitles.count Withsize:CGSizeMake((SCREEN_WIDTH-100)/self.rightTitles.count, 40)];
        //这里先使用假数据
        NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        NSArray *array = dic[@"list"];
        int i = 0;
        UIView *view = [cell.contentView viewWithTag:100];
        for (UILabel *label in view.subviews) {
            
            NSString *str = array[i];
            label.text = nil;
            label.textColor = [UIColor darkGrayColor];
            label.text = str;
            label.font = FONT(15);
            label.adjustsFontSizeToFitWidth = YES;
            i ++;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
        return cell;
    }
}
//设置cell分割线顶格
- (void)resetSeparatorInsetForCell:(UITableViewCell *)cell {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark -- 设置左右两个table View的自定义头部View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTableView) {
        UIView *rightHeaderView = [UIView viewWithLabelNumber:self.rightTitles.count Withlabelwidth:CGSizeMake((SCREEN_WIDTH-100)/self.rightTitles.count, 40)];
        int i = 0;
        for (UILabel *label in rightHeaderView.subviews) {
            label.text = self.rightTitles[i++];
            label.font = FONT(13);
            label.textColor = [UIColor darkGrayColor];
        }
        rightHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return rightHeaderView;
    }else{
        
        UILabel *lab = [Tools createLableWithFrame:CGRectMake(0, 0, 80, 40) andTitle:@"期号" andfont:FONT(13) andTitleColor:[UIColor darkGrayColor] andBackgroundColor:[UIColor groupTableViewBackgroundColor] andTextAlignment:1];
        return lab;
        
//        UIButton *btn = [Tools createButtonWithFrame:CGRectMake(0, 0, 80, 40) andTitle:@"期号" andTitleColor:[UIColor darkGrayColor] andBackgroundImage:nil andImage:IMAGE(@"期号排序降") andTarget:self andAction:@selector(sortClick:) andType:UIButtonTypeCustom];
//        btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        [btn setImage:IMAGE(@"期号排序升") forState:UIControlStateSelected];
//        [btn setImagePosition:WPGraphicBtnTypeRight spacing:2];
//        btn.titleLabel.font = FONT(13);
//        return btn;
        
    }
}
//必须实现以下方法才可以使用自定义头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.rightTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - 两个tableView联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.leftTableView) {
        [self tableView:self.rightTableView scrollFollowTheOther:self.leftTableView];
    }else{
        [self tableView:self.leftTableView scrollFollowTheOther:self.rightTableView];
    }
}

- (void)tableView:(UITableView *)tableView scrollFollowTheOther:(UITableView *)other{
    
    CGFloat offsetY= other.contentOffset.y;
    CGPoint offset=tableView.contentOffset;
    offset.y=offsetY;
    tableView.contentOffset=offset;
}

-(void)sortClick {
    
    NSArray *reversedArray = [[self.dataSource reverseObjectEnumerator] allObjects];
    
    [self.dataSource removeAllObjects];
    
    [self.dataSource addObjectsFromArray:reversedArray];
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

-(void)initDataIsFirst:(BOOL)isfirst {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        url = @"/cqsscSg/todayData.json";
//        url = @"/cqsscSg/lishiA.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/todayData.json";
//        url = @"/xjsscSg/lishiA.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/todayData.json";
//        url = @"/txffcSg/lishiA.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@(131),@"date":self.lastDate ?self.lastDate:@"",@"pageNum":@(self.page),@"pageSize":@30} success:^(BaseData *data) {
        @strongify(self)
        self.page++;
        NSArray *array = data.data;
        if(array.count==0){
            [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
//            [MBProgressHUD showMessage:@"没有该天数据"];
        }
//        [self.dataSource removeAllObjects];
        
        [self.dataSource addObjectsFromArray:array];
        
        NSDictionary *dic = array.firstObject;
        
        NSString *issue = [NSString stringWithFormat:@"%03ld",[dic[@"issue"]integerValue] + 1];
        
        NSString * now = [Tools getlocaletime];
        
        if(isfirst &&self.lastDate && [now isEqualToString:self.lastDate]){
            NSArray *list = @[@"等待开奖",@"",@"",@""];
            [self.dataSource insertObject:@{@"issue":issue,@"list":list} atIndex:0];
        }
        
   
        [self.rightTableView.mj_footer endRefreshing];
        if (self.sort == 0) {
            
            [self.leftTableView reloadData];
            
            [self.rightTableView reloadData];
        }
        else{
            [self sortClick];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}


-(void)initData {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/lishiA.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/lishiA.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/lishiA.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@(101),@"issue":self.index == 0 ? @30 : self.index == 1 ? @50 : self.index == 2 ? @100 : @120} success:^(BaseData *data) {
        
        @strongify(self)
        NSArray *array = data.data;
        
        [self.dataSource removeAllObjects];
        
        [self.dataSource addObjectsFromArray:array];
        
        NSDictionary *dic = array.firstObject;
        
        NSString *issue = [NSString stringWithFormat:@"%03ld",[dic[@"issue"]integerValue] + 1];
        
        NSArray *list = @[@"等待开奖",@"",@"",@""];
        
        [self.dataSource insertObject:@{@"issue":issue,@"list":list} atIndex:0];
        
        if (self.sort == 0) {
            
            [self.leftTableView reloadData];
            
            [self.rightTableView reloadData];
        }
        else{
            [self sortClick];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)setClick {
    
    @weakify(self)
    ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
    alert.lastDate = self.lastDate;
    [alert builddateView:^(NSString *date) {
        @strongify(self)
        self.lastDate = date;
    }];
/*去掉期数 改为按照日期查询
    [alert buildsetView:self.index Withsort:self.sort With:^(NSInteger index, NSInteger sort) {
        
        self.index = index;
        
        self.sort = sort;
        
        [self initData];
    }];
*/
    [alert show];
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
