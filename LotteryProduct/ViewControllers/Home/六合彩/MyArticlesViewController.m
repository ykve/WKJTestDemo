//
//  MyArticlesViewController.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/4.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import "MyArticlesViewController.h"
#import "HistoryArticleTableViewCell.h"
#import "RecommendlistModel.h"
#import "PublishArticleViewController.h"
#import "SixSearchView.h"
#import "NSString+IsBlankString.h"
//#import "SixRecommendDetailCtrl.h"
#import "NoDataView.h"
#import "FollowModel.h"
#import "SixArticleDetailViewController.h"
#import "MyArticleTableViewCell.h"



@interface MyArticlesViewController ()<UITableViewDelegate,UITableViewDataSource,HistoryArticleTableViewCellDelegate,SixSearchViewDelegate, MyArticleTableViewCellDelegate>

@property (nonatomic, strong) UIButton *publishBtn;

@property (nonatomic, strong) SixSearchView *searchVeiw;

@property (nonatomic, copy) NSString *downloadType;

@property (nonatomic, copy) NSString *searchStr;

@property (nonatomic, assign)BOOL isOpen;

/** 缓存cell高度的数组 */
@property (nonatomic, strong) NSMutableArray *heightArray;


@end

@implementation MyArticlesViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    self.page = 1;
    self.downloadType = @"1";
    self.searchStr = @"";
    [self initdata];

}

- (void)initdata{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if ([self.downloadType isEqualToString:@"2"]) {//搜索
        if(self.followModel){
            NSString *referrerId = [NSString stringWithFormat:@"%ld", (long)self.followModel.referrerId] ;//self.followModel.referrerId ? self.followModel.referrerId : @"";
            
            NSString *parentMemberId =  [NSString stringWithFormat:@"%ld", (long)self.followModel.parentMemberId];
            
            if (![referrerId isEqualToString:@""] || ![parentMemberId isEqualToString:@""]) {//关注列表跳进去
                
                NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr, @"isOwn":@"0", @"referrerId":referrerId,@"parentMemberId":parentMemberId};
                dict = (NSMutableDictionary *)dic;
                
            }else{
                NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr, @"isOwn":@"1", @"referrerId":referrerId};
                dict = (NSMutableDictionary *)dic;
            }
        }else{
            NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr};
            dict = (NSMutableDictionary *)dic;
        }


    }else if([self.downloadType isEqualToString:@"1"]){//正常刷新

//        NSString *referrerId = [NSString stringWithFormat:@"%ld", (long)self.followModel.referrerId];//self.followModel.referrerId ? self.followModel.referrerId : @"";
//
//        NSString *parentMemberId = [NSString stringWithFormat:@"%ld", (long)self.followModel.parentMemberId];//self.followModel.parentMemberId ? self.followModel.parentMemberId : @"";
//
//        if (![referrerId isEqualToString:@""] || ![parentMemberId isEqualToString:@""]) {//关注列表跳进去
//
//            NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr, @"isOwn":@"0", @"referrerId":referrerId,@"parentMemberId":parentMemberId};
//            dict = (NSMutableDictionary *)dic;
//
//        }else{
//            NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr, @"isOwn":@"1"};
//            dict = (NSMutableDictionary *)dic;
//        }
        
        NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr, @"isOwn":@"1"};
        dict = (NSMutableDictionary *)dic;

    }
    
//
//    NSDictionary *dic = @{@"isOwn":@"1",@"parentMemberId":self.followModel.parentMemberId ? self.followModel.parentMemberId : @"", @"referrerId":self.followModel.referrerId ? self.followModel.referrerId : @"" , @"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr};
//
//    dict = (NSMutableDictionary *)dic;

    @weakify(self)
//
    [WebTools postWithURL:@"/xsTj/getSelfHistoryLhcXsPost.json" params:dict success:^(BaseData *data) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSMutableArray *dataArr = [NSMutableArray arrayWithArray:self.dataArray];
        [dataArr removeAllObjects];
        dataArr = [RecommendlistModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
        
        NoDataView *nodataView = [[NoDataView alloc] initWithFrame:CGRectMake(0, self.tableView.y, SCREEN_WIDTH, 100)];
        
        if ( dataArr.count == 0) {
            
            [self.view addSubview:nodataView];
            [self.tableView removeFromSuperview];
            
            return ;
        }else{
            [nodataView removeFromSuperview];
            [self.view addSubview:self.tableView];
        }
        
        self.dataArray = [NSArray arrayWithArray:dataArr];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark 加载更多列表
- (void)downloadMoreData{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if ([self.downloadType isEqualToString:@"2"]) {//搜索
//        NSString *referrerId = [NSString stringWithFormat:@"%ld", (long)self.followModel.referrerId];//self.followModel.referrerId ? self.followModel.referrerId : @"";
//
//        NSString *parentMemberId = [NSString stringWithFormat:@"%ld", (long)self.followModel.parentMemberId];//self.followModel.parentMemberId ? self.followModel.parentMemberId : @"";
//
//        if (![referrerId isEqualToString:@""] || ![parentMemberId isEqualToString:@""]) {//关注列表跳进去
//
//            NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr, @"isOwn":@"0", @"referrerId":referrerId,@"parentMemberId":parentMemberId};
//            dict = (NSMutableDictionary *)dic;
//
//        }else{
//            NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr, @"isOwn":@"1", @"referrerId":referrerId,@"parentMemberId":parentMemberId};
//            dict = (NSMutableDictionary *)dic;
//        }
        if(self.followModel){
            NSString *referrerId = [NSString stringWithFormat:@"%ld", (long)self.followModel.referrerId] ;//self.followModel.referrerId ? self.followModel.referrerId : @"";
            
            NSString *parentMemberId =  [NSString stringWithFormat:@"%ld", (long)self.followModel.parentMemberId];
            
            if (![referrerId isEqualToString:@""] || ![parentMemberId isEqualToString:@""]) {//关注列表跳进去
                
                NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr, @"isOwn":@"0", @"referrerId":referrerId,@"parentMemberId":parentMemberId};
                dict = (NSMutableDictionary *)dic;
                
            }else{
                NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr, @"isOwn":@"1", @"referrerId":referrerId};
                dict = (NSMutableDictionary *)dic;
            }
        }else{
            NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr};
            dict = (NSMutableDictionary *)dic;
        }
        
    }else if([self.downloadType isEqualToString:@"1"]){//正常请求
        NSString *referrerId = [NSString stringWithFormat:@"%ld", (long)self.followModel.referrerId];//self.followModel.referrerId ? self.followModel.referrerId : @"";
        
        NSString *parentMemberId = [NSString stringWithFormat:@"%ld", (long)self.followModel.parentMemberId];//self.followModel.parentMemberId ? self.followModel.parentMemberId : @"";
        
        if (![referrerId isEqualToString:@""] || ![parentMemberId isEqualToString:@""]) {//关注列表跳进去
            
            NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr, @"isOwn":@"0", @"referrerId":referrerId,@"parentMemberId":parentMemberId};
            dict = (NSMutableDictionary *)dic;
            
        }else{
            NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr, @"isOwn":@"1"};
            dict = (NSMutableDictionary *)dic;
        }

    }else  if([self.downloadType isEqualToString:@"3"]){//点赞排序
        
        NSString *referrerId = [NSString stringWithFormat:@"%ld", (long)self.followModel.referrerId];//self.followModel.referrerId ? self.followModel.referrerId : @"";
        
        NSString *parentMemberId = [NSString stringWithFormat:@"%ld", (long)self.followModel.parentMemberId];//self.followModel.parentMemberId ? self.followModel.parentMemberId : @"";
        
        if (referrerId) {//关注列表跳进去
            
            NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr, @"isOwn":@"0", @"referrerId":referrerId,@"parentMemberId":parentMemberId};
            dict = (NSMutableDictionary *)dic;
            
        }else{
            NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr, @"isOwn":@"1", @"referrerId":referrerId,@"parentMemberId":parentMemberId};
            dict = (NSMutableDictionary *)dic;
        }

    }
    
    @weakify(self)
    [WebTools postWithURL:@"/xsTj/getSelfHistoryLhcXsPost.json" params:dict success:^(BaseData *data) {
        
        @strongify(self)
        NSArray *newArray = [RecommendlistModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
        
        if (newArray.count == 0 ) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        [self.tableView.mj_footer endRefreshing];
        
        NSMutableArray *dataArr = [NSMutableArray arrayWithArray:self.dataArray];
        
        [dataArr addObjectsFromArray:newArray];
        
        self.dataArray = [NSArray arrayWithArray:dataArr];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark tableviewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyArticleTableViewCellID];
    
    RecommendlistModel *model = [self.dataArray objectAtIndex:indexPath.section];
    
    cell.model = model;
    
    cell.editBtn.tag = indexPath.section;
    
    cell.zanBtn.tag = indexPath.section;
    
    [cell.zanBtn setUserInteractionEnabled:NO];
    
//    if ([self.followModel.ID isEqualToString: [Person person].uid] || !self.followModel) {
//        
//        cell.editBtn.hidden = NO;
//    }else{
//        cell.editBtn.hidden = YES;
//
//    }
    
    
    if ([model.alreadyAdmire isEqualToString: @"0"]) {
        
        cell.zanBtn.selected = NO;
        
    }else{
        
        cell.zanBtn.selected = YES;
        
    }

    
    cell.delegate = self;

//    if ([model.locked isEqualToString:@"0"] && self.isShowEditBtn) {
//
//        cell.editBtn.hidden = NO;
//    }else{
//        cell.editBtn.hidden = YES;
//    }
    
    return cell;
}


#pragma mark uitableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RecommendlistModel *model = [self.dataArray objectAtIndex:indexPath.section];
    
    SixArticleDetailViewController *detail = [[SixArticleDetailViewController alloc]init];
    
    detail.ID = model.ID;
    
    detail.isAttention = model.alreadyFllow;
    
    detail.isShowHistoryBtn = YES;
    
    PUSH(detail);
}



#pragma mark 发帖
- (void)publishArticle{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PublishArticleViewController" bundle:nil];
    PublishArticleViewController *publishVc = [storyboard instantiateInitialViewController];
    publishVc.controlerName = @"new";
    [self.navigationController pushViewController:publishVc animated:YES];

}

#pragma mark HistoryArticleTableViewCellDelegate

- (void)clickZanBtn:(nonnull UIButton *)btn {
    
    //    // deleted点赞的时候传0 取消点赞传1
    //    NSString *isZanStr = @"";
    //    if (btn.selected) {
    //        isZanStr = @"1";
    //    }else{
    //        isZanStr = @"0";
    //    }
    
    
    [btn setUserInteractionEnabled:NO];
    
    RecommendlistModel *model = [self.dataArray objectAtIndex:btn.tag];
    
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/addRecommendAdmire.json" params:@{@"recommendId":[NSString stringWithFormat:@"%ld", (long)model.ID], @"deleted" : @"0"} success:^(BaseData *data) {
        
        @strongify(self)
        [btn setUserInteractionEnabled:YES];
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        RecommendlistModel *model = [self.dataArray objectAtIndex:btn.tag];
        
        //        if ([model.alreadyAdmire isEqualToString:@"0"]) {
        model.alreadyAdmire = @"1";
        model.totalAdmire += 1;
        //            btn.selected = NO;
        //        }
        //        else{
        //            btn.selected = YES;
        //            model.alreadyAdmire = @"0";
        //            model.totalAdmire -= 1;
        //        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:btn.tag];
        
        HistoryArticleTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        cell.zanNumLbl.text = [NSString stringWithFormat:@"%ld", (long)model.totalAdmire];
        
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
        
    } failure:^(NSError *error) {
        [btn setUserInteractionEnabled:YES];
        //        [MBProgressHUD showMessage:@"点赞失败"];
    }showHUD:NO];
    
}

- (void)editArticle:(UIButton *)btn{

    RecommendlistModel *model = [self.dataArray objectAtIndex:btn.tag];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PublishArticleViewController" bundle:nil];
    PublishArticleViewController *publishVc = [storyboard instantiateInitialViewController];
//    publishVc.model = model;
    publishVc.content = model.content;
    publishVc.ID = model.ID;
    publishVc.controlerName = @"edit";
    
    [self.navigationController pushViewController:publishVc animated:YES];
    
}

#pragma mark SixSearchViewDelegate
- (void)searchArticles:(NSString *)content{
    
    self.downloadType = @"2";
    if ([NSString isBlankString:content]) {
        content = @"";
    }
    self.searchStr = content;
    self.page = 1;
    self.downloadType = @"2";
    [self initdata];
}


#pragma mark 设置 UI
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.followModel) {
        self.titlestring = [NSString stringWithFormat:@"%@的心水", self.followModel.nickname];
    }else{
        self.titlestring = @"我的心水";
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.publishBtn];
    
    [self setupTableView];
    [self setupNav];
    
}


- (void)setupNav{
    
    @weakify(self)
    
    [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] XSTJSearchImage] With:^(UIButton *sender) {

        @strongify(self)
        sender.selected = sender.selected ? NO : YES;

//        [self.tableView reloadData];
        
        if (sender.selected) {
            
            self.searchVeiw.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 50);
            self.searchVeiw.hidden = NO;
            
            self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.searchVeiw.frame), SCREEN_WIDTH, SCREEN_HEIGHT - self.publishBtn.height - CGRectGetMaxY(self.searchVeiw.frame));
            
        }else{
            
            self.searchVeiw.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 0);
            self.searchVeiw.hidden = YES;
            
            self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.searchVeiw.frame), SCREEN_WIDTH, SCREEN_HEIGHT - self.publishBtn.height - CGRectGetMaxY(self.searchVeiw.frame));
            
            [self.view endEditing:YES];
        }

    }];
    
    [self.view addSubview:self.searchVeiw];

    
}

- (void)setupTableView{
    
    if (IS_IPHONEX){
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.searchVeiw.frame), SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaBottomHeight - 105);
    }else{
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.searchVeiw.frame), SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaBottomHeight - 80);
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyArticleTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MyArticleTableViewCellID];
    
    self.tableView.estimatedRowHeight = 148;
    @weakify(self)
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page ++;
        [self downloadMoreData];
    }];
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        self.downloadType = @"1";
        [self initdata];
    }] ;
    
//    self.searchVeiw = [[SixSearchView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 0)];
//    self.searchVeiw.hidden = YES;
//    
//    self.searchVeiw.delegate = self;
//    
//    [self.view addSubview:self.searchVeiw];
    
//    self.tableView.tableHeaderView = self.searchVeiw;
}


#pragma mark 懒加载

- (SixSearchView *)searchVeiw{
    if (!_searchVeiw) {
        _searchVeiw = [[SixSearchView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 0)];
        _searchVeiw.hidden = YES;
        _searchVeiw.placehold = @"搜索: 人名、标题";
        _searchVeiw.delegate = self;
        
    }
    
    return _searchVeiw;
}


- (UIButton *)publishBtn{
    
    if (!_publishBtn) {
        _publishBtn = [[UIButton alloc] init];
        
        if (IS_IPHONEX) {
            _publishBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 80);
        }else {
            _publishBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
        }
        [_publishBtn setTitleColor:[[CPTThemeConfig shareManager] xinshuiBottomViewTitleColor] forState:UIControlStateNormal];
        [_publishBtn setTitle:@"发 帖" forState:UIControlStateNormal];
        if (IS_IPHONEX) {
            _publishBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 30, 0);
        }
        [_publishBtn addTarget:self action:@selector(publishArticle) forControlEvents:UIControlEventTouchUpInside];
        _publishBtn.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];
        _publishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _publishBtn;
}

- (NSMutableArray *)heightArray{
    if (_heightArray == nil) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}
@end
