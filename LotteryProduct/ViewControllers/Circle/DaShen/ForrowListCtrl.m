//
//  ForrowListCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ForrowListCtrl.h"
#import "RightTableViewCell.h"
#import "ForrowModel.h"
#import "SelectShowView.h"
#import "TDHistoryCell.h"
#import "LoginAlertViewController.h"
#import "ApplyExpertCtrl.h"
#import "ExpertListCell.h"
#import "ExpertInfoCtrl.h"
#import "GendanDetailVC.h"


@interface ForrowListCtrl ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CJScroViewBar *BarView;

@property (strong, nonatomic)  UILabel *lotteryNameLabel;
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UIView *noZJView;

@property (nonatomic, strong) NSMutableArray *dataSource;

/// 跟单历史
@property (nonatomic, strong) NSMutableArray *orderHistoryArray;
/// 我的推单
@property (nonatomic, strong) NSMutableArray *pushOrderArray;
/// 我的关注
@property (nonatomic, strong) NSMutableArray *myAttentionArray;


@property (nonatomic,assign) NSInteger page;
@property (nonatomic,copy) NSString *currentLotteryId;


@property (nonatomic, strong) NSMutableArray *pageNumArray;
@property (nonatomic, strong) NSMutableArray *isHiddenFooterArray;

///
@property (nonatomic, assign) NSInteger lottery_id;
/// 0跟单历史，1我的推单，2我的关注
@property (nonatomic, assign) NSInteger currentType;
///
@property (nonatomic, strong) SelectShowView *showView;


@end

@implementation ForrowListCtrl


//选择彩种
- (void)onChoseLotteryClick:(UIButton *)sender {
    
    _showView = [[[NSBundle mainBundle] loadNibNamed:@"SelectShowView" owner:nil options:nil]lastObject];
    _showView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _showView.alpha = 0;
    [self.navigationController.view addSubview:_showView];
    [UIView animateWithDuration:0.2 animations:^{
        _showView.alpha = 1;
    }];
    @weakify(self)
    _showView.clickClose = ^{
        @strongify(self)
        [self tapBgView];
    };
    _showView.clickOK = ^(NSString * lottertId,NSString *name) {
        @strongify(self)
        self.lotteryNameLabel.text = name;
        self.currentLotteryId = lottertId;
        [self initData1];
        [self tapBgView];
    };
}
- (void)tapBgView{
    [UIView animateWithDuration:0.2 animations:^{
        _showView.alpha = 0;
    }completion:^(BOOL finished) {
        [_showView removeFromSuperview];
        _showView = nil;
    }];
}

// AFan<<<
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"跟单列表";
    self.page = 1;
    _currentType = 0;
    
    [self buildScrollBar];
    [self setupUI];
    [self setTableView];
}

- (void)setTableView {
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[ExpertListCell class] forCellReuseIdentifier:RJCellIdentifier];
    
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        if(self->_currentType == 0){
            [self initData1];
        }else  if(self->_currentType == 1){
            [self getMyTuidanData];
        }else  if(self->_currentType == 2){
            [self getMyFollow];
        }
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page++;
        if(self->_currentType == 0){
            [self initData1];
        }else  if(self->_currentType == 1){
            [self getMyTuidanData];
        }else  if(self->_currentType == 2){
            [self getMyFollow];
        }
        
    }];
}

#pragma mark -  跟单历史
-(void)initData1 {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@(10) forKey:@"pageSize"];
    [dic setObject:@(self.page) forKey:@"pageNum"];
    if(self.currentLotteryId.integerValue){
        [dic setObject:self.currentLotteryId forKey:@"lotteryId"];
    }
    @weakify(self)
    [WebTools postWithURL:@"/circle/god/pushHistoryList.json" params:dic success:^(BaseData *data) {
        @strongify(self)
        NSInteger pageNum = [self.pageNumArray[self.currentType] integerValue];
        if (pageNum == 1) {
            [self.orderHistoryArray removeAllObjects];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSArray *array = [ForrowModel mj_objectArrayWithKeyValuesArray:data.data];
        if ((!array || array.count == 0) || array.count < [pageSize integerValue]) {
            if (array.count > 0) {
                //                 [self hiddenNoDataImageView];
                [self.orderHistoryArray addObjectsFromArray:array];
            }
            if (pageNum == 1 || (!array || array.count == 0)) {
                //                [self showNoDataImageView];
            }
            self.isHiddenFooterArray[self.currentType] = @(YES);
            [self.tableView.mj_footer setHidden:YES];
        } else {
            //            [self hiddenNoDataImageView];
            [self.orderHistoryArray addObjectsFromArray:array];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark -  我的推单
/**
 自己是否是专家
 */
- (void)getMyTuidanData {
    
    [WebTools postWithURL:@"/circle/god/isGod.json" params:nil success:^(BaseData *data) {
        MBLog(@"%@",data.data);
        NSDictionary *dic = data.data;
        if([dic.allKeys containsObject:@"isGod"]){
            NSString *ret = [dic objectForKey:@"isGod"];
            ret = [NSString stringWithFormat:@"%@",ret];
            if(ret.integerValue == 1){
                self.noZJView.hidden = YES;
                [self getTuidanData];
            }else{
                self.noZJView.hidden = NO;
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


/**
 获取我的推单数据
 */
- (void)getTuidanData {
    
}

#pragma mark -  我的关注
//我的关注
- (void)getMyFollow {
    NSMutableDictionary *dictPar = [[NSMutableDictionary alloc]init];
    [dictPar setValue:@(4) forKey:@"type"]; // （必须）1盈利率排序2胜率排序3连中排序4我的关注
    if (self.lottery_id) {
        [dictPar setValue:@(self.lottery_id) forKey:@"lotteryId"];  // （必须）彩种ID 不传则全部 传则彩种分类
    }
    [dictPar setValue:self.pageNumArray[self.currentType] forKey:@"pageNum"];  // 页码
    [dictPar setValue:pageSize forKey:@"pageSize"];   // 数量
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/god/godLotteryList.json" params:dictPar success:^(BaseData *data) {
        MBLog(@"%@",data.data);
        @strongify(self)
        NSInteger pageNum = [self.pageNumArray[self.currentType] integerValue];
        if (pageNum == 1) {
            [self.myAttentionArray removeAllObjects];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSArray *array = [ExpertModel mj_objectArrayWithKeyValuesArray:data.data];
        if ((!array || array.count == 0) || array.count < [pageSize integerValue]) {
            if (array.count > 0) {
                //                 [self hiddenNoDataImageView];
                [self.myAttentionArray addObjectsFromArray:array];
            }
            if (pageNum == 1 || (!array || array.count == 0)) {
                //                [self showNoDataImageView];
            }
            self.isHiddenFooterArray[self.currentType] = @(YES);
            [self.tableView.mj_footer setHidden:YES];
        } else {
            //            [self hiddenNoDataImageView];
            [self.myAttentionArray addObjectsFromArray:array];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -  申请专家
- (void)onSubmitBtnClick:(UIButton *)sender {
    [self applyClick];
}


-(void)applyClick {
    
    if ([Person person].uid == nil) {
        
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:login animated:YES completion:nil];
        //        LoginCtrl *login = [[LoginCtrl alloc]initWithNibName:NSStringFromClass([LoginCtrl class]) bundle:[NSBundle mainBundle]];
        //        @weakify(self)
        //        login.loginBlock = ^(BOOL result) {
        //            if (result) {
        //                ApplyExpertCtrl *apply = [[ApplyExpertCtrl alloc]init];
        //                @strongify(self)
        //                [self.navigationController pushViewController:apply animated:YES];
        //            }
        //        };
        //        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
        //
        //        nav.navigationBar.hidden = YES;
        //
        //        [self presentViewController:nav animated:YES completion:nil];
    }
    else{
        ApplyExpertCtrl *apply = [[ApplyExpertCtrl alloc]init];
        
        [self.navigationController pushViewController:apply animated:YES];
    }
}

#pragma mark - 关注/取消关注大神
-(void)attentionClick:(UIButton *)sender Withid:(ExpertModel *)model {
    
    [WebTools postWithURL:@"/circle/god/focusOrCancle.json" params:@{@"godId":@(model.godId),@"type":sender.selected == YES ? @2 : @1} success:^(BaseData *data) {
        
        __weak __typeof(self)weakSelf = self;
        [MBProgressHUD showSuccess:data.info finish:^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            sender.selected = !sender.selected;
            model.isFocus = sender.selected;
            [strongSelf.myAttentionArray removeObject:model];
            [strongSelf.tableView reloadData];
        }];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}





////设置分割线顶格
//- (void)viewDidLayoutSubviews{
//
//    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
//}

- (void)loadTableView{
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_currentType == 0){
        return self.orderHistoryArray.count;
    }else if (_currentType == 1){
        return self.pushOrderArray.count;
    }else if (_currentType == 2){
        return self.myAttentionArray.count;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_currentType == 0){
        return 200;
    }else if (_currentType == 1){
        return 200;
    }else if (_currentType == 2){
        return 80;
    }
    return 200;
}
-  (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(_currentType == 0){
        TDHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TDHistoryCell"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TDHistoryCell" owner:nil options:nil]lastObject];
        }
        return cell;
    }else if (_currentType == 1){
        TDHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TDHistoryCell"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TDHistoryCell" owner:nil options:nil]lastObject];
        }
        return cell;
    }else if (_currentType == 2) { 

        ExpertListCell *cell = [ExpertListCell cellWithTableView:tableView reusableId:RJCellIdentifier];
        ExpertModel *model = [self.myAttentionArray objectAtIndex:indexPath.row];
        cell.nameType = 4;
        cell.model = model;
//        [cell setDataWithModel:model];
        
        @weakify(self)
        cell.attentionBlock = ^(UIButton *sender) {
            @strongify(self)
            [self attentionClick:sender Withid:model];
        };
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_currentType == 0){
        
    }else if (_currentType == 1){
        GendanDetailVC *dVc = [[GendanDetailVC alloc] init];
//        PushOrderModel *model = [self.dataSource objectAtIndex:indexPath.row];
//        dVc.trackId = model.pushOrderId;
        PUSH(dVc);
    }else if (_currentType == 2){
        ExpertModel *model = [self.myAttentionArray objectAtIndex:indexPath.row];
        
        ExpertInfoCtrl *info = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertInfoCtrl"];
        info.godId = model.godId;
        PUSH(info);
    }
}



#pragma mark - vvUITableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40 + 35, kSCREEN_WIDTH, kSCREEN_HEIGHT - Height_NavBar -40 - 35) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //        self.tableView.tableHeaderView = self.headView;
        
//        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        // 去除横线
        _tableView.separatorStyle = UITableViewCellAccessoryNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}



-(void)buildScrollBar {
    
    NSArray *titles = @[@"跟单历史",@"我的推单",@"我的关注"];
    
    self.BarView = [[CJScroViewBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.BarView.lineColor = [[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor];
    self.BarView.backgroundColor = [[CPTThemeConfig shareManager] pushDanSubbarBackgroundcolor];
    self.BarView.isEqualTextWidth = YES;
    [self.view addSubview:self.BarView];
    
    [self.BarView layoutIfNeeded];
    
    [self.BarView setData:titles NormalColor:[[CPTThemeConfig shareManager] pushDanSubBarNormalTitleColor] SelectColor:[[CPTThemeConfig shareManager]pushDanSubBarSelectTextColor] Font:[UIFont systemFontOfSize:14]];
    
    __weak __typeof(self)weakSelf = self;
    [self.BarView getViewIndex:^(NSString *title, NSInteger index) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        [strongSelf onTitleClickBtn:index];
    }];
    
    [self.BarView setViewIndex:0];
}


#pragma mark -  选择 Title
- (void)onTitleClickBtn:(NSInteger)index {
    _currentType = index;
    self.noZJView.hidden = YES;
    
    if(_currentType == 0){
        [self initData1];
    } else if(_currentType == 1){
        [self getMyTuidanData];
    } else if (_currentType == 2){
        [self getMyFollow];
    }
}


- (void)setupUI {
    
    UIView *noZJView = [[UIView alloc] init];
    noZJView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:noZJView];
    _noZJView = noZJView;
    
    [noZJView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.BarView.mas_bottom).offset(35);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.image = [UIImage imageNamed:@"nhbszj"];
    [noZJView addSubview:backImageView];
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(noZJView.mas_top).offset(60);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(158, 140));
    }];
    
    UILabel *lotteryNameLabel = [[UILabel alloc] init];
    lotteryNameLabel.text = @"您还不是专家";
    lotteryNameLabel.font = [UIFont systemFontOfSize:18];
    lotteryNameLabel.textColor = [UIColor colorWithHex:@"#999999"];
    lotteryNameLabel.textAlignment = NSTextAlignmentCenter;
    [noZJView addSubview:lotteryNameLabel];
    _lotteryNameLabel = lotteryNameLabel;
    
    [lotteryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(noZJView.mas_centerX);
    }];
    
    
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn setTitle:@"申请专家" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor colorWithHex:@"#FFFFFF"] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [submitBtn addTarget:self action:@selector(onSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    submitBtn.backgroundColor = kDarkRedColor;
    submitBtn.layer.cornerRadius = 37/2;
    [noZJView addSubview:submitBtn];
    
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lotteryNameLabel.mas_bottom).offset(60);
        make.centerX.mas_equalTo(noZJView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(210, 37));
    }];
    
    
    // 搜索
    UIView *searchView = [[UIView alloc] init];
    searchView.backgroundColor = [UIColor colorWithHex:@"#f7f7f7"];
    //    searchView.layer.cornerRadius = 5;
    [self.view addSubview:searchView];
    
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.BarView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(25);
    }];
    
    UIButton *nnBtn = [[UIButton alloc] init];
    [nnBtn addTarget:self action:@selector(onChoseLotteryClick:) forControlEvents:UIControlEventTouchUpInside];
    nnBtn.backgroundColor = [UIColor clearColor];
    [searchView addSubview:nnBtn];
    [nnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(searchView);
    }];
    
    UILabel *tiLabel = [[UILabel alloc] init];
    tiLabel.text = @"全部";
    tiLabel.font = [UIFont systemFontOfSize:14];
    tiLabel.textColor = [UIColor colorWithHex:@"#666666"];
    tiLabel.textAlignment = NSTextAlignmentLeft;
    [searchView addSubview:tiLabel];
    
    [tiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(searchView.mas_left).offset(10);
        make.centerY.mas_equalTo(searchView.mas_centerY);
    }];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"cartdown2"];
    [searchView addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(searchView.mas_right).offset(-10);
        make.centerY.mas_equalTo(searchView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

-(NSMutableArray *)orderHistoryArray {
    if (!_orderHistoryArray) {
        _orderHistoryArray = [[NSMutableArray alloc]init];
    }
    return _orderHistoryArray;
}
-(NSMutableArray *)pushOrderArray {
    if (!_pushOrderArray) {
        _pushOrderArray = [[NSMutableArray alloc]init];
    }
    return _pushOrderArray;
}
-(NSMutableArray *)myAttentionArray {
    if (!_myAttentionArray) {
        _myAttentionArray = [[NSMutableArray alloc]init];
    }
    return _myAttentionArray;
}

-(NSMutableArray *)pageNumArray {
    
    if (!_pageNumArray) {
        
        _pageNumArray = [NSMutableArray arrayWithArray: @[@(1),@(1),@(1)]];
    }
    return _pageNumArray;
}

-(NSMutableArray *)isHiddenFooterArray {
    
    if (!_isHiddenFooterArray) {
        
        _isHiddenFooterArray = [NSMutableArray arrayWithArray: @[@(NO),@(NO),@(NO)]];
    }
    return _isHiddenFooterArray;
}

@end
