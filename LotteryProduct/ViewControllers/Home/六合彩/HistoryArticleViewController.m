//
//  HistoryArticleViewController.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/11/26.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import "HistoryArticleViewController.h"
#import "HistoryArticleTableViewCell.h"
#import "RecommendlistModel.h"
#import <MJRefresh.h>
#import "SixArticleDetailViewController.h"
#import "NoDataView.h"
#import "SixRecommendCtrl.h"

@interface HistoryArticleViewController ()<HistoryArticleTableViewCellDelegate>

@property (nonatomic, strong) UIButton *backToHomeBtn;

@property (nonatomic, assign)BOOL isOpen;
@property (nonatomic, strong) NSMutableArray *historyArray;

@end

@implementation HistoryArticleViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.historyArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titlestring = @"历史帖子";
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.backToHomeBtn];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HistoryArticleTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"historyArticleCell"];
    
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.backToHomeBtn.mas_top);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(NAV_HEIGHT);
    }];
    self.tableView.estimatedRowHeight = 111;
    
    self.tableView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - 150);
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)

        self.page = 1;
        
        [self initData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)

        [self downloadMoreData];
    }];
    
    self.page = 1;
    
    
    [self initData];
    
}

-(void)initData {
    
    NSMutableDictionary *dict;
    NSDictionary *dic;
//    if (self.isHistoryVc) {
    if(self.followModel.referrerId.length>0){
        dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize,  @"referrerId":self.followModel.referrerId,@"parentMemberId":@""};
    }else{
        dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize,  @"referrerId":@"",@"parentMemberId":@(self.followModel.parentMemberId)};
    }
    dict = (NSMutableDictionary *)dic;
        
//    }else{
//        NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize,@"id" : [NSString stringWithFormat:@"%ld",(long)self.idNum]};
//
//        dict = (NSMutableDictionary *)dic;
//    }
//{"data":{"pageNum":1,"pageSize":10,"parentMemberId":null,"referrerId":3113},"apisign":"d45e1240d05af9865a8e6ce6dd236938"}
    //getUserHistoryLhcXsPost.json getSelfHistoryLhcXsPost.json
    @weakify(self)
    [WebTools postWithURL:@"/xsTj/getUserHistoryLhcXsPost.json" params:dict success:^(BaseData *data) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];

        NSMutableArray *tmpArray = [RecommendlistModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
        for(NSInteger i =0 ;i<tmpArray.count;i++){
            RecommendlistModel *model = [tmpArray objectAtIndex:i];
            NSMutableAttributedString *titleStr=  [[NSMutableAttributedString alloc] initWithData:[model.title dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f] range:NSMakeRange(0, titleStr.length)];
            [paragraphStyle setLineSpacing:12];
            [titleStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, titleStr.length)];
            model.htmlTitle = titleStr;
            [self.historyArray addObject:model];
        }
        //        NoDataView *nodataView = [[NoDataView alloc] initWithFrame:CGRectMake(0, self.tableView.y, SCREEN_WIDTH, 100)];
        //
        //        if ( dataArr.count == 0) {
        //
        //            [self.view addSubview:nodataView];
        //
        //            return ;
        //        }else{
        //            [nodataView removeFromSuperview];
        //        }
        
        
        self.historyArray = tmpArray;
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)

        [self.tableView.mj_header endRefreshing];
        
    }];
}

#pragma mark 加载更多列表
- (void)downloadMoreData{
    
    self.page ++ ;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (self.isHistoryVc) {
        NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : @"", @"isOwn":@"0", @"referrerId":self.followModel.referrerId,@"parentMemberId":@(self.followModel.parentMemberId)};
        dict = (NSMutableDictionary *)dic;
        
    }else{
        NSDictionary *dic = @{@"pageNum": @(self.page), @"pageSize" : pageSize, @"id" : [NSString stringWithFormat:@"%ld",(long)self.idNum]};
        
        dict = (NSMutableDictionary *)dic;
    }
    
    @weakify(self)
    [WebTools postWithURL:@"/xsTj/getSelfHistoryLhcXsPost.json" params:dict success:^(BaseData *data) {
        @strongify(self)
//        NSArray *newArray = [RecommendlistModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
//
//        if (newArray.count == 0 ) {
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//            return ;
//        }
//        [self.tableView.mj_footer endRefreshing];
//
//        NSMutableArray *dataArr = [NSMutableArray arrayWithArray:self.historyArray];
//
//        [dataArr addObjectsFromArray:newArray];
//
//        self.historyArray = [NSArray arrayWithArray:dataArr];
//
//        [self.tableView reloadData];
        
        NSMutableArray *tmpArray = [RecommendlistModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
        NSMutableArray *newArray = [NSMutableArray array];
        for(NSInteger i =0 ;i<tmpArray.count;i++){
            RecommendlistModel *model = [tmpArray objectAtIndex:i];
            NSMutableAttributedString *titleStr=  [[NSMutableAttributedString alloc] initWithData:[model.title dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f] range:NSMakeRange(0, titleStr.length)];
            [paragraphStyle setLineSpacing:12];
            [titleStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, titleStr.length)];
            model.htmlTitle = titleStr;
            [newArray addObject:model];
        }
        if (newArray.count == 0 ) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        [self.tableView.mj_footer endRefreshing];
        
        [self.historyArray addObjectsFromArray:newArray];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)

        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark 回到首页
- (void)backToHomeVc{
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.historyArray.count;
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendlistModel *model = self.historyArray[indexPath.section];
    
    HistoryArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyArticleCell" forIndexPath:indexPath];
    
    cell.delegate = self;
    
    cell.zanBtn.tag = indexPath.section;
    
    cell.editBtn.hidden = YES;
    
    cell.model = model;
    
    if ([model.alreadyAdmire isEqualToString: @"0"]) {
        
        cell.zanBtn.selected = NO;
        
    }else{
        cell.zanBtn.selected = YES;;
    }
    
    return cell;
    
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    RecommendlistModel *model = [self.historyArray objectAtIndex:indexPath.section];
    //
    //    return [model heightForRowWithisShow:model];
    
    return UITableViewAutomaticDimension;
    
}
#pragma mark 展开/收起
- (void)clickUnfoldBtn:(UIButton *)btn{
    
//    RecommendlistModel *model = [self.historyArray objectAtIndex:btn.tag];
    
    btn.selected = btn.selected ? NO : YES;
    
    self.isOpen = btn.selected;
    
    //    model.isOpen = self.isOpen;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RecommendlistModel *model = [self.historyArray objectAtIndex:indexPath.section];
    SixArticleDetailViewController *detail = [[SixArticleDetailViewController alloc]init];
    detail.ID = model.ID;
    detail.isShowHistoryBtn = NO;
    PUSH(detail);
}


- (UIButton *)backToHomeBtn{
    if (!_backToHomeBtn) {
        _backToHomeBtn = [[UIButton alloc] init];
        if (IS_IPHONEX) {
            _backToHomeBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 70);
            _backToHomeBtn.titleEdgeInsets = UIEdgeInsetsMake(-15, 0, 0, 0);
        }else{
            _backToHomeBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
        }
        _backToHomeBtn.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];
        [_backToHomeBtn setTitleColor:BASECOLOR forState:UIControlStateNormal];
        [_backToHomeBtn setTitle:@"返回首页" forState: UIControlStateNormal];
        [_backToHomeBtn addTarget:self action:@selector(backToHomeVc) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backToHomeBtn;
}

#pragma mark HistoryArticleTableViewCellDelegate
- (void)clickZanBtn:(UIButton *)btn{
    [btn setUserInteractionEnabled:NO];
    RecommendlistModel *model = [self.historyArray objectAtIndex:btn.tag];
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/addRecommendAdmire.json" params:@{@"recommendId":[NSString stringWithFormat:@"%ld", (long)model.ID], @"deleted" : @"0"} success:^(BaseData *data) {
        @strongify(self)
        [btn setUserInteractionEnabled:YES];
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        RecommendlistModel *model = [self.historyArray objectAtIndex:btn.tag];
        model.alreadyAdmire = @"1";
        model.totalAdmire += 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:btn.tag];
        HistoryArticleTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.zanNumLbl.text = [NSString stringWithFormat:@"%ld", (long)model.totalAdmire];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
    } failure:^(NSError *error) {
        [btn setUserInteractionEnabled:YES];
    }showHUD:NO];
}

@end
