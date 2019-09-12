//
//  XinShuiRecommentContentViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/23.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "XinShuiRecommentContentViewController.h"
#import "HistoryArticleTableViewCell.h"
#import "NSString+IsBlankString.h"
#import "AdvertModel.h"
#import "SixArticleDetailViewController.h"
#import "PCInfoModel.h"
#import "LoginAlertViewController.h"
#import "BallTool.h"

// title心水推荐
@interface XinShuiRecommentContentViewController ()<HistoryArticleTableViewCellDelegate,SDCycleScrollViewDelegate>


//轮播图图片数组
@property (nonatomic, strong)NSMutableArray *adsImageViews;

@property (nonatomic, assign)NSInteger followPage;;

@property (nonatomic, copy) NSString *searchStr;


@property (nonatomic, strong)NSMutableArray *dataList;


@end

@implementation XinShuiRecommentContentViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));

}

- (void)popback{
    [super popback];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"searchArticle" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.followPage = 1;
    
    self.searchStr = @"";
    
    [self setupUI];
    [self.tableVeiwHeaderView addSubview:self.bannerView];

    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(receiveNotifi:) name:@"searchArticle" object:nil];
}

- (void)setDownloadType:(NSString *)downloadType{
    _downloadType = downloadType;
    self.page = 1;
    [self.tableView.mj_header beginRefreshing];
}

- (void)receiveCloseBannerNoti:(NSNotification *)noti{
    [self closeBannerView];
}

- (void)receiveNotifi:(NSNotification *)noti{
    
    NSString *str = noti.object;
    self.searchStr = [str substringToIndex:str.length - 1];
    NSString *type = [str substringFromIndex:str.length - 1];
    if ([self.downloadType isEqualToString:type]) {
        [self initData:self.downloadType];
    }
}

- (void)setupUI {
    
    [self.view addSubview:self.tableView];
   
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    self.tableView.estimatedRowHeight = 111;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        
        self.page = 1;
        [self initData:self.downloadType];
        [self advertData];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self downloadMoreData:self.downloadType];
    }];
    
    [self.tableVeiwHeaderView addSubview:self.bannerView];
    
     [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HistoryArticleTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:historyArticleCell];
}

#pragma mark 加载更多列表
- (void)downloadMoreData:(NSString *)xsType{
    
    self.page ++ ;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *url;
    switch (xsType.integerValue) {
        case 1://大厅
        {
            url = @"/xsTj/getLhcXsHallReCommend.json";
            
        }break;
        case 2://精华
        {
            url = @"/xsTj/getLhcXsEssenceReCommend.json";
        }break;
        case 3://热门
        {
            url = @"/xsTj/getLhcXsHotReCommend.json";
        }break;
        case 4://今日发表
        {
            url = @"/xsTj/getLhcXsTodayReCommend.json";
        }break;
            
        default:
            break;
    }

    if ([NSString isBlankString:self.searchStr]) {
        self.searchStr = @"";
    }
    
    NSDictionary *dic = @{@"xstype":self.downloadType, @"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr};
    
    dict = (NSMutableDictionary *)dic;
    
    @weakify(self)

    [WebTools postWithURL:url params:dict success:^(BaseData *data) {
        @strongify(self)
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }

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
        
        [self.dataList addObjectsFromArray:newArray];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    MBLog(@"%ld", index);
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    MBLog(@"%ld", index);
}

#pragma mark 心水推荐点赞 HistoryArticleTableViewCellDelegate
- (void)clickZanBtn:(UIButton *)btn{
    
    [btn setUserInteractionEnabled:NO];
    
    RecommendlistModel *model = [self.dataList objectAtIndex:btn.tag];
    
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/addRecommendAdmire.json" params:@{@"recommendId":[NSString stringWithFormat:@"%ld", (long)model.ID], @"deleted" : @"0"} success:^(BaseData *data) {
        @strongify(self)
        [btn setUserInteractionEnabled:YES];
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        RecommendlistModel *model = [self.dataList objectAtIndex:btn.tag];
        
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


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hiddenavView];
}

#pragma mark 默认排序刷新数据
-(void)initData :(NSString *)xstype{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *url;
    switch (xstype.integerValue) {
        case 1://大厅
        {
            url = @"/xsTj/getLhcXsHallReCommend.json";
        }break;
        case 2://精华
        {
            url = @"/xsTj/getLhcXsEssenceReCommend.json";
        }break;
        case 3://热门
        {
            url = @"/xsTj/getLhcXsHotReCommend.json";
        }break;
        case 4://今日发表
        {
            url = @"/xsTj/getLhcXsTodayReCommend.json";
        }break;
            
        default:
            break;
    }
    NSDictionary *dic = @{@"xstype":self.downloadType, @"pageNum": @(self.page), @"pageSize" : pageSize, @"findNickNameOrTitle" : self.searchStr};
    
    dict = (NSMutableDictionary *)dic;
    
    @weakify(self)
    

    [WebTools postWithURL:url params:dict success:^(BaseData *data) {
        @strongify(self)
        [self.tableView .mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        [self.dataList removeAllObjects];
        
        if (!data.data) {
             [self.tableView reloadData];
            return;
        }
        if ([data.data isKindOfClass:[NSString class]]) {
            return;
        }
        NSMutableArray * tmpArray = [RecommendlistModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
        
        for(NSInteger i =0 ;i<tmpArray.count;i++){
            RecommendlistModel *model = [tmpArray objectAtIndex:i];
            NSMutableAttributedString *titleStr=  [[NSMutableAttributedString alloc] initWithData:[model.title dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f] range:NSMakeRange(0, titleStr.length)];
            [paragraphStyle setLineSpacing:12];
            [titleStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, titleStr.length)];
            model.htmlTitle = titleStr;
            [self.dataList addObject:model];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 获取轮播图
-(void)advertData {
    
    @weakify(self)
    [WebTools postWithURL:@"/lottery/sendXsad.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        //        NSArray *array= [AdvertModel mj_objectArrayWithKeyValuesArray:data.data[@"iosUrl"]];
        
        //        NSArray *array = @[model];
        //        [self.adsImageViews removeAllObjects];
        
        //        for (AdvertModel *model in array) {
        //
        //            [self.adsImageViews addObject:IMAGEPATH(model.photo)];
        //
        //        }
        NSURL *imageIos = IMAGEPATH(data.data[@"iosUrl"]);
        if(![self.adsImageViews containsObject:imageIos]){
            [self.adsImageViews addObject:imageIos];
        }
        UIView *header = self.tableVeiwHeaderView;
        self.bannerView.imageURLStringsGroup = self.adsImageViews;
        self.tableView.tableHeaderView = header;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        
    } showHUD:NO];
}


#pragma mark tableviewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 心水推荐cell
    HistoryArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:historyArticleCell];
    if(indexPath.section > self.dataList.count-1|| self.dataList.count<1){
        return cell;
    }
    RecommendlistModel *model = [self.dataList objectAtIndex:indexPath.section];
    
    cell.model = model;
    
    cell.zanBtn.tag = indexPath.section;
    
    cell.delegate = self;
    
    cell.editBtn.hidden = YES;
    
    return cell;
}

#pragma mark tableviewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendlistModel *model = [self.dataList objectAtIndex:indexPath.section];
    CGFloat height = [BallTool heightWithFont:18 limitWidth:SCREEN_WIDTH-30 string:model.title];
    if (height > 115) {
        return 115 + 115;
    } else {
        return 115 + height;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    RecommendlistModel *model = [self.dataList objectAtIndex:indexPath.section];
    if (model.loginViewFlag && [Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];

    }else{
 
        SixArticleDetailViewController *detailArticleVc = [[SixArticleDetailViewController alloc] init];
        detailArticleVc.parentMemberId = model.parentMemberId;
        detailArticleVc.ID = model.ID;
        detailArticleVc.referId = model.referrerId;
        detailArticleVc.isAttention = model.alreadyFllow;
        detailArticleVc.isShowHistoryBtn = YES;
        detailArticleVc.lottery_oldID = 4;
        
        //    detailArticleVc.liuHeCaiModel = self.liuHeCaiModel;
        
        PUSH(detailArticleVc);
    }
    
}

- (float)heightWithFont:(float)font limitWidth:(float)width string:(NSString *)str
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:attribute
                                    context:nil].size;
    return size.height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)nextResponder;
            [vc.view endEditing:YES];
        }
    }
}

- (void)closeBannerView{
    
    [self.bannerView removeFromSuperview];
        
    self.tableVeiwHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    self.tableView.tableHeaderView = self.tableVeiwHeaderView;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"closeBanner" object:nil];
}



#pragma mark 懒加载
- (UIView *)tableVeiwHeaderView{
    if (!_tableVeiwHeaderView) {
        
        //        NSArray *titles = @[@"大厅",@"精华帖",@"热门帖", @"今日发表"];

        CGFloat height = (SCREEN_WIDTH * 12)/75;
        _tableVeiwHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        
        SDCycleScrollView *bannerView = [[SDCycleScrollView alloc] initWithFrame:self.tableVeiwHeaderView.bounds];
        self.bannerView = bannerView;
        
        bannerView.placeholderImage = IMAGE(@"bannerHoldplace");
        
        self.bannerView.currentPageDotImage = [Tools createImageWithColor:WHITE Withsize:CGSizeMake(12, 2)];
        self.bannerView.pageDotImage = [Tools createImageWithColor:[UIColor colorWithWhite:1 alpha:0.5] Withsize:CGSizeMake(12, 2)];
        
        self.bannerView.delegate = self;
        
        self.bannerView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        self.bannerView.autoScrollTimeInterval = 2.0;
        self.bannerView.autoScroll = NO;
        
        UIButton *closeBannerBtn = [Tools createButtonWithFrame:CGRectMake(SCREEN_WIDTH - 30, 0, 30, 30) andTitle:nil andTitleColor:nil andBackgroundImage:IMAGE(@"icon_banner_close") andImage:nil andTarget:self andAction:@selector(closeBannerView) andType:UIButtonTypeCustom];
        
        closeBannerBtn.imageView.contentMode = UIViewContentModeScaleToFill;
        [self.bannerView addSubview:closeBannerBtn];
        
        [_tableVeiwHeaderView addSubview:bannerView];
        
    }
    
    return _tableVeiwHeaderView;
}

- (NSMutableArray *)adsImageViews{
    if (!_adsImageViews) {
        _adsImageViews = [NSMutableArray arrayWithCapacity:2];
    }
    return _adsImageViews;
}


- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:5];
    }
    return _dataList;
}

@end
