//
//  LiuHeBangDanListViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/22.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiuHeBangDanListViewController.h"
#import "LiuHeBangDanListTableViewCell.h"
#import "SixSearchView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "DashenListModel.h"
#import "NSString+IsBlankString.h"
#import "SixArticleDetailViewController.h"
#import "SixPhotosCtrl.h"

@interface LiuHeBangDanListViewController ()<SixSearchViewDelegate>

@property (nonatomic, strong) SixSearchView *searchVeiw;

@property (nonatomic, strong) NSMutableArray *listModels;

@property (nonatomic, copy) NSString *searchStr;



@end

@implementation LiuHeBangDanListViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    self.titlestring = self.model.name;
    
    self.searchStr = @"";
    
    [self initdata];
    
}

- (void)initdata{
    
    NSDictionary *dict = @{@"pageSize" : pageSize, @"pageNum":@(self.page), @"id": self.model.ID, @"name":self.searchStr ? self.searchStr : @""};
    
    @weakify(self)
    [WebTools postWithURL:@"/lottery/queryGodRaingByGodType.json" params:dict success:^(BaseData *data) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        [self.listModels removeAllObjects];
        
        self.listModels = [DashenListModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)downloadMoreData{
    
    NSDictionary *dict = @{@"pageSize" : pageSize, @"pageNum":@(self.page), @"id": self.model.ID, @"name":self.searchStr ? self.searchStr : @""};
    
    @weakify(self)
    [WebTools postWithURL:@"/lottery/queryGodRaingByGodType.json" params:dict success:^(BaseData *data) {
        
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        NSArray *array = [DashenListModel mj_objectArrayWithKeyValuesArray:data.data];
        if (array.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
        [self.tableView.mj_footer endRefreshing];
        
        [self.listModels addObjectsFromArray:array];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        self.page -= 1;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark setupUI
- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LiuHeBangDanListTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LiuHeBangDanListTableViewCellID"];
    
    self.page = 1;
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        [self initdata];
    } ];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page += 1;
        [self downloadMoreData];
    }];
    
    self.tableView.frame = CGRectMake(0, NAV_HEIGHT + self.searchVeiw.height, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - self.searchVeiw.height);
    
    [self.view addSubview:self.searchVeiw];
    [self.view addSubview:self.tableView];
    
    [self rigBtn:@"返回首页" Withimage:nil With:^(UIButton *sender) {
        @strongify(self)
        [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
        
    }];
    
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DashenListModel *model = self.listModels[indexPath.row];
    LiuHeBangDanListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiuHeBangDanListTableViewCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.listModel = model;
    
    if ([model.sort isEqualToString:@"1"]) {
        
        [cell.rangeNumBtn setTitle:nil forState:UIControlStateNormal];
        cell.rangeNumBtn.hidden = YES;
        cell.iconImageView.hidden = NO;
        cell.iconImageView.image = IMAGE(@"icon_top_one");
        
    }else if ([model.sort isEqualToString:@"2"]){
        
        cell.rangeNumBtn.hidden = YES;
        cell.iconImageView.hidden = NO;
        cell.iconImageView.image = IMAGE(@"icon_top_two");
        
    }else if ([model.sort isEqualToString:@"3"]){
        
        cell.rangeNumBtn.hidden = YES;
        cell.iconImageView.hidden = NO;
        cell.iconImageView.image = IMAGE(@"icon_top_three");
    }else{
        cell.rangeNumBtn.hidden = NO;
        cell.iconImageView.hidden = YES;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    
    DashenListModel *model = self.listModels[indexPath.row];
    
    SixArticleDetailViewController *detailArticleVc = [[SixArticleDetailViewController alloc] init];
    
    detailArticleVc.ID = [model.cicleId integerValue];
    
    detailArticleVc.titleStr = [NSString stringWithFormat:@"%@详情", self.model.name];
    detailArticleVc.lottery_oldID = 4;
    
//    detailArticleVc.isAttention = model.;
    
    detailArticleVc.isShowHistoryBtn = YES;
    
    PUSH(detailArticleVc);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark SixSearchViewDelegate
- (void)searchArticles:(NSString *)content{
    
    [self.view endEditing:YES];
    
    self.searchStr = content;
    
//    [self initdata];
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark 懒加载

- (SixSearchView *)searchVeiw{
    if (!_searchVeiw) {
        _searchVeiw = [[SixSearchView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 50)];
        
        _searchVeiw.delegate = self;
        _searchVeiw.placehold = @"搜索:人名";
        
    }
    
    return _searchVeiw;
}

- (NSMutableArray *)listModels{
    if (!_listModels) {
        _listModels = [NSMutableArray arrayWithCapacity:5];
    }
    return _listModels;
}
@end
