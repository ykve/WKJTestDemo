//
//  FootBallPlanCtrl.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/23.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "FootBallPlanCtrl.h"
#import "FootPlanCell.h"
#import "FootballPlan_FocusCell.h"
#import "FootballDetailCtrl.h"
#import "FootballRemarkListModel.h"
#import "BallTool.h"
#import "SixSearchView.h"
#import "LoginAlertViewController.h"
@interface FootBallPlanCtrl ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,SixSearchViewDelegate>
{
    NSMutableArray *_titleBtnArr;
    UIScrollView *_scrollView;
    NSMutableArray *_tableViewArr;
    NSInteger _page1;
    NSInteger _page2;
    NSInteger _page3;
    NSMutableArray *_dataArr1;
    NSMutableArray *_dataArr2;
    NSMutableArray *_dataArr3;
    UITableView *_tableView1;
    UITableView *_tableView2;
    UITableView *_tableView3;
    SixSearchView *_searchView;
    NSString *_searchStr;
    NSInteger _currentIndex;//0，1，2
}
@end

@implementation FootBallPlanCtrl


- (void)viewDidLoad {
    [super viewDidLoad];
    _searchStr = @"";
    _dataArr1 = [NSMutableArray array];
    _dataArr2 = [NSMutableArray array];
    _dataArr3 = [NSMutableArray array];
    _page1 = 1;
    _page2 = 1;
    _page3 = 1;
    _currentIndex = 0;
    _tableViewArr = [NSMutableArray array];
    _titleBtnArr = [NSMutableArray array];
    [_titleBtnArr addObject:_btn1];
    [_titleBtnArr addObject:_btn2];
    [_titleBtnArr addObject:_btn3];
    self.titlestring = self.isHistory?@"历史":@"足彩方案";
    @weakify(self)
    
    [self rigBtn:@"" Withimage:[[CPTThemeConfig shareManager] XSTJSearchImage] With:^(UIButton *sender) {
        @strongify(self)
        if(self.titleToTopHeight.constant == 44){
            [UIView animateWithDuration:0.2 animations:^{
                CGFloat titleViewHeight = self.isHistory?0:44;
                self.titleToTopHeight.constant = 84;
                self->_scrollView.frame = CGRectMake(0, NAV_HEIGHT+titleViewHeight+40, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-titleViewHeight-30);
                self->_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, _scrollView.frame.size.height);
            }];
        }else{
            [self.view endEditing:YES];
            [UIView animateWithDuration:0.2 animations:^{
                CGFloat titleViewHeight = self.isHistory?0:44;
                self.titleToTopHeight.constant = 44;
                self->_scrollView.frame = CGRectMake(0, NAV_HEIGHT+titleViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-titleViewHeight);
                self->_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, _scrollView.frame.size.height);
                self->_searchStr = @"";
            }];
        }
        
    }];
    
    self.view.backgroundColor = WHITE;
    CGFloat titleViewHeight = self.isHistory?0:44;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT+titleViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-titleViewHeight)];
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, _scrollView.frame.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    for(int i=0;i<3;i++){
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, _scrollView.frame.size.height)];
        tableView.tag = i;
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.estimatedRowHeight =0;
        tableView.estimatedSectionHeaderHeight =0;
        tableView.estimatedSectionFooterHeight =0;
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_tableViewArr addObject:tableView];
        @weakify(self)
        switch (tableView.tag) {
            case 0:
            {
                _tableView1 = tableView;
                tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    @strongify(self)
                    self->_page1 = 1;
                    [self getData1];
                }];
                tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    @strongify(self)
                    MBLog(@"===___");
                    self->_page1++;
                    [self getData1];
                }];
            }break;
            case 1:
            {
                _tableView2 = tableView;
                tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    @strongify(self)
                    self->_page2 = 1;
                    [self getData2];
                }];
                tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    @strongify(self)
                    self->_page2++;
                    [self getData2];
                }];
            }break;
            case 2:
            {
                _tableView3 = tableView;
                tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    @strongify(self)
                    self->_page3 = 1;
                    [self getData3];
                }];
                tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    @strongify(self)
                    self->_page3++;
                    [self getData3];
                }];
            }break;
            default:
                break;
        }
        [_scrollView addSubview:tableView];
    }
    [self getData1];
    if(!self.isHistory){
        [self getData2];
        [self getData3];
    }
    [self buildSearchView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateFocusList) name:@"focus_update" object:nil];
    [self titleClick:_btn1];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"focus_update" object:nil];
}
- (void)updateFocusList{
    _page3 = 1;
    [self getData3];
}
- (void)getData1{
    [self.view endEditing:YES];
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    [mDic setObject:@(_page1) forKey:@"pageNum"];
    [mDic setObject:@(10) forKey:@"pageSize"];
//    [mDic setObject:@(0) forKey:@"isHead"];
    [mDic setObject:_searchStr forKey:@"search"];
    if(self.isHistory){
        [mDic setObject:@(_hostID) forKey:@"id"];
    }
    @weakify(self)
    [WebTools postWithURL:@"/football/recommendShowList.json" params:mDic success:^(BaseData *data) {
        @strongify(self);
        if(data.status.integerValue == 1){
            if(self->_page1 == 1||self->_searchStr.length>0){
                [self->_dataArr1 removeAllObjects];
                [self->_tableView1.mj_footer endRefreshing];
            }
            NSArray *array = data.data;
            if(array.count != 0){
                for (NSDictionary *dic in data.data) {
                    FootballRemarkListModel *model = [FootballRemarkListModel mj_objectWithKeyValues:dic];
                    [self->_dataArr1 addObject:model];
                }
//                [self->_tableView1 reloadData];
                [self->_tableView1.mj_footer endRefreshing];
            }else{
                if(self->_page1>1){
                    self->_page1--;
                }
                
                [self->_tableView1.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self->_tableView1 reloadData];
        [self->_tableView1.mj_header endRefreshing];
        self->_searchStr = @"";
    } failure:^(NSError *error) {
        @strongify(self);
        [self->_tableView1.mj_footer endRefreshing];
        [self->_tableView1.mj_header endRefreshing];
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.isHistory){
        _scrollView.scrollEnabled = NO;
        _titleViewHeight.constant = 0;
    }
}
- (void)buildSearchView{
    _searchView = [[SixSearchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [_searchView.searchBar layoutIfNeeded];
    _searchView.delegate = self;
    _searchView.placehold = @"搜索: 人名、标题";
    [_searchBgView addSubview:_searchView];
}
- (void)getData2{
    [self.view endEditing:YES];
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    [mDic setObject:@(_page2) forKey:@"pageNum"];
    [mDic setObject:@(10) forKey:@"pageSize"];
    [mDic setObject:@(1) forKey:@"isHead"];
    [mDic setObject:_searchStr forKey:@"search"];
    @weakify(self)
    [WebTools postWithURL:@"/football/recommendShowList.json" params:mDic success:^(BaseData *data) {
        @strongify(self)
        if(data.status.integerValue == 1){
            if(self->_page2 == 1){
                [self->_dataArr2 removeAllObjects];
                [self->_tableView2.mj_footer endRefreshing];
            }
            id array = data.data;
            if([array isKindOfClass:[NSArray class]]){
                NSArray *arr = (NSArray *)array;
                if(arr.count !=0){
                    for (NSDictionary *dic in arr) {
                        FootballRemarkListModel *model = [FootballRemarkListModel mj_objectWithKeyValues:dic];
                        [self->_dataArr2 addObject:model];
                    }
                    [self->_tableView2 reloadData];
                }else{
                    if(self->_page2>1){
                        self->_page2--;
                    }
                    [self->_tableView2 reloadData];
                    [self->_tableView2.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                [self->_tableView2.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self->_tableView2.mj_header endRefreshing];
    } failure:^(NSError *error) {
        @strongify(self);
        [self->_tableView2.mj_footer endRefreshing];
        [self->_tableView2.mj_header endRefreshing];
    }];
}
- (void)getData3{
    [self.view endEditing:YES];
    if ([Person person].uid == nil) {
        return;
    }
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    [mDic setObject:@(_page3) forKey:@"pageNum"];
    [mDic setObject:@(10) forKey:@"pageSize"];
    [mDic setObject:_searchStr forKey:@"nickname"];
    @weakify(self)
    [WebTools postWithURL:@"/football/recommendFollowList.json" params:mDic success:^(BaseData *data) {
        @strongify(self)
        if(data.status.integerValue == 1){
            if(self->_page3 == 1){
                [self->_dataArr3 removeAllObjects];
                [self->_tableView3.mj_footer endRefreshing];
            }
            id array = data.data;
            if([array isKindOfClass:[NSArray class]]){
                NSArray *arr = (NSArray *)array;
                if(arr.count !=0){
                    for (NSDictionary *dic in arr) {
                        FootballRemarkListModel *model = [FootballRemarkListModel mj_objectWithKeyValues:dic];
                        [self->_dataArr3 addObject:model];
                    }
                    [self->_tableView3 reloadData];
                }else{
                    if(self->_page3>1){
                        self->_page3--;
                        [self->_tableView3.mj_footer endRefreshingWithNoMoreData];
                    }
                    [self->_tableView3 reloadData];
                }
            }
        }
        [self->_tableView3.mj_header endRefreshing];
    } failure:^(NSError *error) {
        @strongify(self);
        [self->_tableView3.mj_footer endRefreshing];
        [self->_tableView3.mj_header endRefreshing];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView == _scrollView){
        NSInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
        if(index == 2){
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self presentViewController:login animated:YES completion:nil];
                @weakify(self)
                login.loginBlock = ^(BOOL result) {
                    @strongify(self)
                    [self getData3];
                };
                [UIView animateWithDuration:0.2 animations:^{
                    scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
                }];
            }else{
                UIButton *btn = _titleBtnArr[index];
                [self titleClick:btn];
            }
        }else{
            UIButton *btn = _titleBtnArr[index];
            [self titleClick:btn];
        }
    }
}
- (IBAction)titleClick:(UIButton *)sender {
    if(sender.selected == NO){
        if(sender.tag == 2){
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self presentViewController:login animated:YES completion:nil];
                @weakify(self)
                login.loginBlock = ^(BOOL result) {
                    @strongify(self)
                    [self getData3];
                };
                return;
            }
            _searchView.placehold = @"搜索: 昵称";
        }else{
            _searchView.placehold = @"搜索: 人名、标题";
        }
        for (UIButton *btn in _titleBtnArr) {
            btn.selected = btn==sender?YES:NO;
        }
        _currentIndex = sender.tag;
        [UIView animateWithDuration:0.2 animations:^{
            _moveLine.frame = CGRectMake(sender.frame.origin.x+sender.frame.size.width/2-25, 42, 50, 2);
            _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*sender.tag, 0);
        }];
    }
}
#pragma mark TabelViewDelegate&datesource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag) {
        case 0:
        {
            return _dataArr1.count;
        }break;
        case 1:
        {
            return _dataArr2.count;
        }break;
        case 2:
        {
            return _dataArr3.count;
        }break;
            
        default:
            break;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 0:
        {
            FootballRemarkListModel *model = _dataArr1[indexPath.row];
            CGFloat height = [BallTool heightWithFont:15 limitWidth:SCREEN_WIDTH-30 string:model.title];
            return 160+height;
        }break;
        case 1:
        {
            FootballRemarkListModel *model = _dataArr2[indexPath.row];
            CGFloat height = [BallTool heightWithFont:15 limitWidth:SCREEN_WIDTH-30 string:model.title];
            return 160+height;
        }break;
        case 2:
        {
            return 80;
        }break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 0:
        {
            static NSString *cellId = @"FootPlanCell";
            FootPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if(cell == nil){
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FootPlanCell" owner:nil options:nil]lastObject];
            }
            FootballRemarkListModel *model = _dataArr1[indexPath.row];
            [cell setDataWithModel:model];
            return cell;
        }break;
        case 1:
        {
            static NSString *cellId = @"FootPlanCell";
            FootPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if(cell == nil){
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FootPlanCell" owner:nil options:nil]lastObject];
            }
            FootballRemarkListModel *model = _dataArr2[indexPath.row];
            [cell setDataWithModel:model];
            return cell;
            
        }break;
        case 2:
        {
            static NSString *cellId = @"FootballPlan_FocusCell";
            FootballPlan_FocusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if(cell == nil){
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FootballPlan_FocusCell" owner:nil options:nil]lastObject];
            }
            FootballRemarkListModel *model = _dataArr3[indexPath.row];
            [cell setDataWithModel:model];
            return cell;
        }break;
        default:
            break;
    }
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 0:
        {
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self presentViewController:login animated:YES completion:nil];
                @weakify(self)
                login.loginBlock = ^(BOOL result) {
                    @strongify(self)
                    [self getData3];
                };
                return;
            }
            FootballRemarkListModel *model = _dataArr1[indexPath.row];
            FootballDetailCtrl *detailVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"FootballDetailCtrl"];
            detailVc.dataModel = model;
            if(self.isHistory){
                detailVc.isHistory = YES;
            }
            PUSH(detailVc);
        }break;
        case 1:
        {
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self presentViewController:login animated:YES completion:nil];
                @weakify(self)
                login.loginBlock = ^(BOOL result) {
                    @strongify(self)
                    [self getData3];
                };
                return;
            }
            FootballRemarkListModel *model = _dataArr2[indexPath.row];
            FootballDetailCtrl *detailVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"FootballDetailCtrl"];
            detailVc.dataModel = model;
            PUSH(detailVc);
        }break;
        case 2:
        {
            FootballRemarkListModel *model = _dataArr3[indexPath.row];
//            FootballDetailCtrl *detailVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"FootballDetailCtrl"];
//            detailVc.dataModel = model;
//            PUSH(detailVc);
            FootBallPlanCtrl *footVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"FootBallPlanCtrl"];
            footVc.isHistory = YES;
            footVc.hostID = model.referrerId;
            PUSH(footVc);
        }break;
            
        default:
            break;
    }
}
- (void)searchArticles:(NSString *)content{
    MBLog(@"%@",content);
    _searchStr = content?content:@"";
//    if(_searchStr.length==0){
//        [self showHint:@"请输入搜索内容"];
//        return;
//    }
    [self.view endEditing:YES];
    switch (_currentIndex) {
        case 0:
        {
            [self getData1];
        }break;
        case 1:
        {
            [self getData2];
        }break;
        case 2:
        {
            [self getData3];
        }break;
        default:
            break;
    }
    
}
@end
