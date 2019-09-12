//
//  SixPhotosCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/6.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixPhotosCtrl.h"
#import "SixPhotosListCtrl.h"
#import "LiuHeTuKuLeftTableViewCell.h"
#import "LiuHeTuKuTopView.h"
#import "LiuHeTuKuContentViewController.h"
#import "LiuHeTuKuShareView.h"
#import "LiuHeTuKuRemarkTableViewCell.h"
#import "LiuHeTuKuRemarkBar.h"
#import "NSString+IsBlankString.h"
#import "LiuHeTuKuProgressView.h"
#import "HZPhotoBrowser.h"
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import "TouPiaoContentView.h"
#import "TouPiaoModel.h"
#import "UIImage+color.h"
#import "LiuHeTukuListModel.h"
#import "LiuHeTKPhotoModel.h"
#import "LiuHeTKRemarkModel.h"
#import "TouPiaoCommonView.h"
#import "CirclePhotosView.h"
#import "LoginAlertViewController.h"
#import "CPTInfoManager.h"


@interface SixPhotosCtrl ()<LiuHeTuKuTopViewDelegate, LiuHeTuKuRemarkBarDelegate, TouPiaoContentViewDelegate, UIScrollViewDelegate,LiuHeTuKuRemarkBarDelegate, TouPiaoCommonViewDelegate>

@property (nonatomic, strong)CJScroViewBar *photosBar;

@property (nonatomic, strong) UITableView *leftTableView;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign)NSIndexPath* selectIndexPath;

@property (nonatomic, strong) LiuHeTuKuTopView *topView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) LiuHeTuKuShareView *shareView;

@property (nonatomic, strong) UIView *headerView;

/// 投票View
@property (nonatomic, strong) UIView *voteView;
@property (nonatomic, strong)TouPiaoCommonView *touPiaoCommonView;
/// 投票弹框
@property (nonatomic, strong) TouPiaoContentView *toupiaoContentView;

@property (nonatomic, assign) CGFloat ivoteViewHeight;

@property (nonatomic, strong) LiuHeTuKuRemarkBar *remarkBar;

@property (nonatomic, copy) NSString *remarkStr;

@property (nonatomic, strong) UIButton *showBigBtn;

@property (nonatomic, strong) UIButton *touPiaoBtn;



@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, copy) NSString *shareUrl;

@property (nonatomic, strong)NSMutableArray *leftListArray;

@property (nonatomic, strong)NSMutableArray *toupiaoArray;

@property (nonatomic, strong)TouPiaoModel *toupiaoModel;

//@property (nonatomic, strong)UIScrollView *imageScrollView;

@property (nonatomic, strong)UIButton *lastPan;

@property (nonatomic, strong) NSMutableArray *ABBtnsArray;
//记录选中类型ID
@property (nonatomic, copy) NSString *selectID;
@property (nonatomic, strong) NSString *selectPhotoId;

//A盘与B盘模型数组
@property (nonatomic, strong) NSMutableArray *photoModels;
//当前期数
@property (nonatomic, copy) NSString *currentIssue;
//评论数组
@property (nonatomic,copy) NSMutableArray *remarkModels;
//记录当前A盘或者B盘模型
@property (nonatomic, strong) LiuHeTKPhotoModel *currentPhotoM;
@property (nonatomic, assign)NSString *isAbtn;


@property (nonatomic, strong) NSArray *titlesArray;

@property (nonatomic, strong)UIView *abPanView;

@property (nonatomic, strong)NSMutableArray *progressViewArray;


@property (nonatomic, strong)CirclePhotosView *photosView;
@property (nonatomic,assign) BOOL isClickLeftTableView;


@property (nonatomic, strong) UIImageView *urlImageView;
/// 图片高度
@property (nonatomic, assign) CGFloat imageHeight;

@end

@implementation SixPhotosCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"xinshuiRecommentShare" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"六合图库";
    self.page = 1;
    self.isAbtn = @"0";
    self.imageHeight = 0;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(receiveShareNotification:) name:@"xinshuiRecommentShare" object:nil];
    
    [self setupUI];
    
    [self downloadShareUrl];
    [self downloadToupiaoData];
    //lefttableview 数据
    [self downloadListData];
    
    
    //投注按钮
    [self buildBettingBtn];
}




#pragma mark - tableHeaderView 相关数据

- (void)tableHeaderView {
    
}

-(LiuHeTuKuTopView *)topView {
    if (!_topView) {
//        _topView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([LiuHeTuKuTopView class]) owner:self options:nil]firstObject];
        _topView = [[LiuHeTuKuTopView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 50)];
        _topView.delegate = self;
    }
    return _topView;
}

- (UIView *)voteView {
    if (!_voteView) {
        _voteView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _voteView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.photosView.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageAction)];
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}


// 投票View
- (void)voteViewUI {
    
    self.ivoteViewHeight = 25 * (self.toupiaoArray.count%2 ? self.toupiaoArray.count/2 : self.toupiaoArray.count/2 + 1) + 65;
    self.voteView.frame = CGRectMake(0, CGRectGetMaxY(self.photosView.frame), self.tableView.width, self.ivoteViewHeight);
    
    self.shareView.y = CGRectGetMaxY(self.voteView.frame);
    if (!self.touPiaoCommonView) {
        TouPiaoCommonView *touPiaoCommonView = [[TouPiaoCommonView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, self.ivoteViewHeight)];
        self.touPiaoCommonView = touPiaoCommonView;
        touPiaoCommonView.delegate = self;
    }
    self.touPiaoCommonView.modelsArray = self.toupiaoArray;
    
    [self.voteView addSubview:self.touPiaoCommonView];
    [self.headerView addSubview:self.voteView];
    
}

// 分享
- (LiuHeTuKuShareView *)shareView{
    if (!_shareView) {
        _shareView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([LiuHeTuKuShareView class]) owner:self options:nil]firstObject];
        _shareView.frame = CGRectMake(0, self.ivoteViewHeight + 10, self.view.width - self.leftTableView.width, 140);
        //        _shareView.delegate = self;
    }
    
    return _shareView;
}

// 底部评论bar
- (LiuHeTuKuRemarkBar *)remarkBar{
    if (!_remarkBar) {
        _remarkBar = [[LiuHeTuKuRemarkBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60)];
        _remarkBar.backgroundColor = [[CPTThemeConfig shareManager] sixHeTuKuRemarkbarBackgroundcolor];
        _remarkBar.delegate = self;
    }
    
    return _remarkBar;
}





- (void)setupUI{
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.remarkBar];
    [self.view addSubview:self.showBigBtn];
    
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LiuHeTuKuLeftTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:LiuHeTuKuLeftTableCellId];
    
    // 左边选中第一个
    self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    LiuHeTuKuLeftTableViewCell *cell = (LiuHeTuKuLeftTableViewCell *)[self.leftTableView cellForRowAtIndexPath:self.selectIndexPath];
    self.isSelected = YES;
    cell.isSelected = YES;
    self.coverView.backgroundColor = [UIColor colorWithHex:@"000000" Withalpha:0.5];
    
    
    self.tableView.frame = CGRectMake(self.leftTableView.width, NAV_HEIGHT, self.view.width - self.leftTableView.width, SCREEN_HEIGHT - NAV_HEIGHT - self.remarkBar.height);
    self.tableView.tag = 101;
    self.tableView.estimatedRowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    
    //底部评论 tableView
    [self.view addSubview:self.tableView];
    
    
    [self.tableView registerClass:[LiuHeTuKuRemarkTableViewCell class] forCellReuseIdentifier:LiuHeTuKuRemarkTableViewCellID];
    
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        [self downloadShareUrl];
        [self downloadToupiaoData];
        NSString *issueStr = self.currentIssue ? self.currentIssue : @"0";
        if (self.isClickLeftTableView) {
            issueStr = @"0";
        }
        NSString *selectID = self.selectID ? self.selectID : @"";
        [self getPhotoInfo:selectID issueStr:issueStr AorB:[self.isAbtn intValue]];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);

        self.page += 1;
        
        for (UIButton *btn in self.ABBtnsArray) {
            if (btn.selected) {
                NSInteger tag = btn.tag - 10;
                NSString *selectID = self.selectID ? self.selectID : @"";
                [self getPhotoInfo:selectID issueStr:self.currentPhotoM.issue ? self.currentPhotoM.issue : @"0" AorB:(int)tag];
            }
            
        }
        
        if (self.ABBtnsArray.count == 0) {
            NSString *selectID = self.selectID ? self.selectID : @"";
            [self getPhotoInfo:selectID issueStr:@"0" AorB:0];
        }
        
    }];
    
}

#pragma mark - 评论数据
- (void)getPhotoInfo:(NSString *)photoID issueStr:(NSString *)issueStr AorB:(int)AorB{
    
    NSDictionary *dic = @{@"id":photoID,@"issue":issueStr, @"pageNum":@(self.page),@"PageSize":pageSize};
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/getLhPhotoInfo.json" params:dic success:^(BaseData *data) {
        @strongify(self)

        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        NSArray *array = [NSArray arrayWithArray:data.data];
        
        [self.photoModels removeAllObjects];
        if (self.page == 1) {
            [self.remarkModels removeAllObjects];
        }
        self.photoModels = [LiuHeTKPhotoModel mj_objectArrayWithKeyValuesArray:array];
        if (self.photoModels.count > AorB) {
            self.currentPhotoM = self.photoModels[AorB];
        }
        
        if (self.currentPhotoM.comments.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.remarkModels addObjectsFromArray:self.currentPhotoM.comments];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([self.currentPhotoM.nextIssue isEqualToString:@""]) {
            self.topView.nextBtn.hidden = YES;
        }else{
            self.topView.nextBtn.hidden = NO;
        }
        if ([self.currentPhotoM.lastIssue isEqualToString:@""]) {
            self.topView.preBtn.hidden = YES;
        }else{
            self.topView.preBtn.hidden = NO;
        }

        
        self.currentIssue = self.currentPhotoM.issue;
        self.topView.titleLbl.text = self.currentPhotoM.issue;
        
        self.isClickLeftTableView = NO;

        [self setImageHeightAction:AorB];

    } failure:^(NSError *error) {
//        self.page -= 1;
        @strongify(self);
        self.isClickLeftTableView = NO;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } showHUD:YES];
}

#pragma mark -  设置图片高度
- (void)setImageHeightAction:(int)AorB {
    __weak __typeof(self)weakSelf = self;
 
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
   NSURL *url = [NSURL URLWithString:self.currentPhotoM.imageUrl];
    
    [manager diskImageExistsForURL:url completion:^(BOOL isInCache) {
         __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (!isInCache) {
            [strongSelf.tableView reloadData];
        }
    }];

    
    self.urlImageView = [[UIImageView alloc]init];
    
    [self.urlImageView sd_setImageWithURL:[NSURL URLWithString:self.currentPhotoM.imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        CGFloat imageYW = CGImageGetWidth(image.CGImage);
        CGFloat imageW = strongSelf.view.width - strongSelf.leftTableView.width - 20;
        strongSelf.imageHeight = imageW / (imageYW / CGImageGetHeight(image.CGImage));
        [strongSelf buildABPanView:AorB];
        [strongSelf.tableView reloadData];
        strongSelf.urlImageView = nil;
    }];
}

- (void)buildABPanView : (int)AOrB{
    
    
    UIView *headerView = [[UIView alloc] init];
    self.headerView = headerView;
    [headerView addSubview:self.topView];
    
    self.abPanView = [[UIView alloc] init];
    if (self.photoModels.count >= 2){
        self.abPanView.frame = CGRectMake(10, CGRectGetMaxY(self.topView.frame), self.topView.width, 44);
    } else {
        self.abPanView.frame = CGRectMake(10, CGRectGetMaxY(self.topView.frame), self.topView.width, 0);
    }
    
    if (!AOrB) {
        [self.ABBtnsArray removeAllObjects];
    }
    
    if (self.photoModels.count >= 2 && !AOrB) {
        for (int i = 0; i < self.photoModels.count; i++) {
            
            CGFloat w = self.tableView.width/self.photoModels.count;
            CGFloat x = i * w;
            CGFloat y = 0;
            CGFloat h = self.abPanView.height;
            
            UIButton *btn = [[UIButton alloc] init];
            if (i == 0) {
                btn.frame = CGRectMake(x, y, w, h);
                [btn setTitle:@"A" forState:UIControlStateNormal];
            }else{
                btn.frame = CGRectMake(x, y + 3, w, h - 6);
                [btn setTitle:@"B" forState:UIControlStateNormal];
            }
            
            [self.abPanView addSubview:btn];
            btn.tag = 10 + i;
            
            [btn setBackgroundImage:[UIImage imageWithColor:[[CPTThemeConfig shareManager] LiugheTuKuTopBtnGrayColor] size:CGSizeMake(btn.width, btn.height - 5)] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[[CPTThemeConfig shareManager] LiuheTuKuOrangeColor] size:btn.size] forState:UIControlStateSelected];
            
            [btn setTitleColor:[[CPTThemeConfig shareManager] RootWhiteC]
                      forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(selectAOrB:) forControlEvents:UIControlEventTouchUpInside];

            
            [self.ABBtnsArray addObject:btn];
            if (i == 0) {
                btn.selected = YES;
                self.lastPan = btn;
            }
            
        }
    }
    
    for (UIButton *btn in self.ABBtnsArray) {
        [self.abPanView addSubview:btn];
    }
    
    // *** 1 ***
    [headerView addSubview:self.abPanView];
    // *** 2 ***
    [headerView addSubview:self.photosView];
    
    self.photosView.imageurlArray = @[self.currentPhotoM.imageUrl ? self.currentPhotoM.imageUrl : @"sixphoto"];
    
    if (isnan(self.imageHeight)) {
        self.imageHeight = 340;
    }

    if (self.photoModels.count >=2) {
        self.photosView.frame = CGRectMake(10, CGRectGetMaxY(self.abPanView.frame), self.view.width - self.leftTableView.width - 20, self.imageHeight);
    }else{
        self.photosView.frame = CGRectMake(10, CGRectGetMaxY(self.topView.frame), self.view.width - self.leftTableView.width - 20, self.imageHeight);
    }
    
    // *** 3 ***
    [self voteViewUI];
    // *** 4 ***
    [headerView addSubview:self.shareView];
    
    
    headerView.frame = CGRectMake(0, 0, self.tableView.width, self.topView.height + self.abPanView.height + self.photosView.height + self.ivoteViewHeight + self.shareView.height + 10);
    
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark -  分享URL数据
- (void)downloadShareUrl {
    
    __weak __typeof(self)weakSelf = self;
    [[CPTInfoManager shareManager] checkModelCallBack:^(CPTInfoModel * _Nonnull model, BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.shareUrl = model.shareUrl;
        }
    }];
}

#pragma mark -  投票数据
// 投票数据
- (void)downloadToupiaoData{
    
    @weakify(self)
    [WebTools postWithURL:@"/lottery/getVotesInfo.json" params:nil success:^(BaseData *data) {
        
        @strongify(self)
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        NSArray *toupiaoArray = [NSArray arrayWithArray:data.data];
        
        self.toupiaoArray = [TouPiaoModel mj_objectArrayWithKeyValuesArray:toupiaoArray];
        
        self.touPiaoCommonView.modelsArray = self.toupiaoArray;
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark -  左边列表数据
-(void)downloadListData {
    
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/getPhotoCategory.json" params:@{@"count":@198} success:^(BaseData *data) {
        
        @strongify(self)
        //        self.leftListArray = data.data[@"list"];
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        [self.leftListArray removeAllObjects];
        
        NSArray *array = [NSArray arrayWithArray:data.data[@"list"]];
        
        self.leftListArray = [LiuHeTukuListModel mj_objectArrayWithKeyValuesArray:array];
        
        if (!self.leftListArray || self.leftListArray.count == 0) {
            return;
        }
        LiuHeTukuListModel *model = self.leftListArray[0];
        
        self.selectID = model.ID;
        
        NSString *selectID = self.selectID ? self.selectID : @"";
        [self getPhotoInfo:selectID issueStr:@"0" AorB:0];
        
        [self.leftTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}




#pragma mark - 投票 弹框

- (void)commonToupiao {
    @weakify(self);
    [UIView animateWithDuration:0.5 animations:^{
        @strongify(self);

        self.toupiaoContentView.frame = CGRectMake(15,( SCREEN_HEIGHT - 445)/2, SCREEN_WIDTH - 30, 445);
        
        [self.view addSubview:self.coverView];
        
    }];
    self.toupiaoContentView.backgroundColor = [UIColor whiteColor];
    
    self.toupiaoContentView.toupiaoList = self.toupiaoArray;
    
    self.toupiaoContentView.issue = self.currentPhotoM.nextIssue;
}

- (TouPiaoContentView *)toupiaoContentView{
    if (!_toupiaoContentView) {
        _toupiaoContentView = [[TouPiaoContentView alloc] initWithFrame:CGRectMake(15,( SCREEN_HEIGHT - 445)/2, SCREEN_WIDTH - 30, 445)];
        _toupiaoContentView.layer.cornerRadius = 10;
        _toupiaoContentView.layer.masksToBounds = YES;
        _toupiaoContentView.delegate = self;
        
    }
    return _toupiaoContentView;
}

#pragma mark TouPiaoContentViewDelegate
- (void)removeTouPiaoContentView{
    [self.coverView removeFromSuperview];
}
#pragma mark 投票提交
- (void)submitTouPiao:(NSString *)str{
    
    if ([NSString isBlankString:str]) {
        [AlertViewTool alertViewToolShowMessage:@"请选择投票内容!" fromController:self handler:nil];
        return;
    }
    
    @weakify(self)
    [WebTools postWithURL:@"/lottery/addVotesInfo.json" params:@{@"id":str} success:^(BaseData *data) {
        
        @strongify(self)
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        [self.coverView removeFromSuperview];
        
        NSString *result = data.data;
        if ([result isEqualToString:@"success"]) {
            [MBProgressHUD showSuccess:@"投票成功"];
        }
        
        [self downloadToupiaoData];
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)showBigImage:(UIButton *)sender{
    
    sender.selected = sender.selected ? NO : YES;
    
    if (sender.selected) {
        
        self.leftTableView.frame = CGRectMake(0, NAV_HEIGHT, 0, SCREEN_HEIGHT - NAV_HEIGHT - self.remarkBar.height);
        
    }else{
        self.leftTableView.frame = CGRectMake(0, NAV_HEIGHT, 115, SCREEN_HEIGHT - NAV_HEIGHT - self.remarkBar.height);
    }
    
    self.tableView.frame = CGRectMake(self.leftTableView.width, NAV_HEIGHT, self.view.width - self.leftTableView.width, SCREEN_HEIGHT - NAV_HEIGHT - self.remarkBar.height);
    
    
    self.abPanView.frame = CGRectMake(10, CGRectGetMaxY(self.topView.frame), self.topView.width, self.abPanView.height);
    
    self.topView.frame = CGRectMake(self.scrollView.x, self.topView.y, self.tableView.width, self.topView.height);
    
    for (UIButton *btn in self.ABBtnsArray) {
        CGFloat w = self.tableView.width/2;
        CGFloat x = (btn.tag - 10) * w;
        CGFloat y = 0;
        CGFloat h = self.abPanView.height;
        
        if (btn.selected) {
            btn.frame = CGRectMake(x, y, w, h);
        }else{
            btn.frame = CGRectMake(x, y+3, w, h-6);
        }
        
    }
    if (self.photoModels.count >=2) {
        self.photosView.frame = CGRectMake(10, CGRectGetMaxY(self.abPanView.frame), self.view.width - self.leftTableView.width - 20, 340);
    }else{
        self.photosView.frame = CGRectMake(10, CGRectGetMaxY(self.topView.frame), self.view.width - self.leftTableView.width - 20, 340);
    }
    self.imageView.frame = self.photosView.bounds;
    
    self.voteView.frame = CGRectMake(0, CGRectGetMaxY(self.photosView.frame), self.tableView.width, 25 * (self.toupiaoArray.count/2) + 85);
    
    self.touPiaoCommonView.frame = CGRectMake(0, 0, self.tableView.width, 85 + 25 * (self.toupiaoArray.count%2 ? self.toupiaoArray.count/2 : self.toupiaoArray.count/2 + 1));
    
    self.touPiaoCommonView.isAdd = YES;
    self.touPiaoCommonView.modelsArray = self.toupiaoArray;
    
    [self.view bringSubviewToFront:self.showBigBtn];
    
    
}

- (void)clickImageAction{
    
    if (self.tableView.width < SCREEN_WIDTH) {
        
        [self showBigImage:self.showBigBtn];
        
    }
    
}

#pragma mark 分享
- (void)receiveShareNotification:(NSNotification *)noti{
    UIButton *sender = noti.object;
    
    if (sender.tag == 10) {//QQ好友
        
        [self shareWebPageToPlatformType:UMSocialPlatformType_QQ sender:sender];
        
    }else if (sender.tag == 20){//微信好友
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession sender:sender];
    } else if (sender.tag == 30){//微信朋友圈
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine sender:sender];
    }
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType sender:(UIButton *)sender
{
    
    UIImage *image = [UIImage imageNamed:@"share"];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    
    UMShareWebpageObject *shareObject;
    if ([AppDelegate shareapp].wkjScheme == Scheme_LotterEight) {
        shareObject = [UMShareWebpageObject shareObjectWithTitle:@"008" descr:@"多彩种,多玩法\n更全面的资讯信息\n更精准的开奖数据" thumImage:image];
    } else if([AppDelegate shareapp].wkjScheme == Scheme_LotterHK){
        shareObject = [UMShareWebpageObject shareObjectWithTitle:@"XGCP" descr:@"知道越多,赢得越多\n最权威的资讯平台\n算法精准,数据稳定,开奖及时" thumImage:image];
    } else if([AppDelegate shareapp].wkjScheme == Scheme_LitterFish){
        shareObject = [UMShareWebpageObject shareObjectWithTitle:@"小鱼儿" descr:@"知道越多,赢得越多\n最权威的资讯平台\n算法精准,数据稳定,开奖及时" thumImage:image];
    } else{
        shareObject = [UMShareWebpageObject shareObjectWithTitle:@"CPT" descr:@"知道越多,赢得越多\n最权威的资讯平台\n算法精准,数据稳定,开奖及时" thumImage:image];
    }
    
    //设置网页地址
    shareObject.webpageUrl = self.shareUrl;
    
    if (!self.shareUrl) {
        [MBProgressHUD showMessage:@"分享地址为空"];
        return;
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            if ([error.userInfo[@"message"] isEqualToString:@"APP Not Install"]) {
                if (sender.tag == 10) {
                    [MBProgressHUD showMessage:@"您没有安装该QQ应用"];
                }else{
                    [MBProgressHUD showMessage:@"您没有安装该微信应用"];
                }
            }
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

#pragma mark UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 100) {
        return self.leftListArray.count;
    }else{
        
        return self.remarkModels.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 100) {//lefttableview
        
        LiuHeTukuListModel *model = self.leftListArray[indexPath.row];
        
        LiuHeTuKuLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LiuHeTuKuLeftTableCellId forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isSelected = NO;
        cell.backgroundColor = [[CPTThemeConfig shareManager] LiuheTuKuLeftTableViewBackgroundColor] ;
        cell.titleLbl.numberOfLines = 0;

        if (indexPath.row == 0 || indexPath.row == 1) {
            cell.icon.image = IMAGE(@"lhtk_hotiocn");
            cell.icon.hidden = NO;
            cell.titleLbl.font = [UIFont systemFontOfSize:13 weight:UIFontWeightHeavy];
            
        }else{
            cell.titleLbl.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
            cell.icon.hidden = YES;
        }
        
        //当选中的时候让色块出现
        if (indexPath == self.selectIndexPath){
            
            if (self.isSelected) {
                
                cell.isSelected = YES;
                
            }
        }
        
        
        cell.titleLbl.text = model.name;
        
        return cell;
        
        
    }else{
        
        LiuHeTKRemarkModel *model = self.remarkModels[indexPath.row];
        
        LiuHeTuKuRemarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LiuHeTuKuRemarkTableViewCellID];
        if(cell == nil) {
            cell = [LiuHeTuKuRemarkTableViewCell cellWithTableView:tableView reusableId:LiuHeTuKuRemarkTableViewCellID];
        }
        if (indexPath.row == 0) {
            cell.isFirst = YES;
        } else {
            cell.isFirst = NO;
        }
//        LiuHeTuKuRemarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LiuHeTuKuRemarkTableViewCellID forIndexPath:indexPath];
        
        cell.model= model;
        return cell;
    }
    
}
#pragma mark UITableVeiwDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 100) {
        return 40;
    } else {
        if (indexPath.row == 0) {
            return 100;
        } else {
            return 68;
        }
    }
    return UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 100) {
        
        LiuHeTukuListModel *model = self.leftListArray[indexPath.row];
        
        LiuHeTuKuLeftTableViewCell *cell = (LiuHeTuKuLeftTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        self.selectIndexPath = indexPath;
        
        self.isSelected = YES;
        cell.isSelected = YES;
        self.selectID = model.ID;
        
        self.isClickLeftTableView = YES;
        self.isAbtn = @"0";
        
        [self.remarkModels removeAllObjects];
        
        [self.tableView.mj_header beginRefreshing];
        
        [self.leftTableView reloadData];
        
    }else{
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark LiuHeTuKuTopViewDelegate
- (void)selectAOrB: (UIButton *)sender{
    
    if (self.lastPan == sender) {
        return;
    }
    
    self.page = 1;
    self.lastPan.selected = NO;
    sender.selected = YES;
    
    sender.y = 0;
    sender.height = self.abPanView.height;
    
    self.lastPan.y = 3;
    self.lastPan.height = sender.height - 6;
    
    if (sender.tag == 10) {
        
        self.isAbtn = @"0";;
        [self getPhotoInfo:self.selectID ? self.selectID : @"" issueStr:@"0" AorB:0];
        
    }else{
        self.isAbtn = @"1";;
        
        [self getPhotoInfo:self.selectID ? self.selectID : @"" issueStr:@"0" AorB:1];
        
    }
    
    self.lastPan = sender;
}

- (void)selectPerios:(UIButton *)sender{
    
    if (sender.tag == 100) {//上一期
        
        if ([self.currentPhotoM.lastIssue isEqualToString:@""]) {
            return;
        }
        self.page = 1;
        NSString *selectedId = self.selectID ? self.selectID : @"";
        NSString *lastIssue = self.currentPhotoM.lastIssue ?  self.currentPhotoM.lastIssue : @"0";
        [self getPhotoInfo:selectedId issueStr:lastIssue AorB:self.isAbtn.intValue];
        
        
    } else{//下一期
        
        if ([self.currentPhotoM.nextIssue isEqualToString:@""]) {

            return;
        }

        self.page = 1;
        NSString *selectedId = self.selectID ? self.selectID : @"";
        NSString *nextIssue = self.currentPhotoM.nextIssue ?  self.currentPhotoM.nextIssue : @"0";

        [self getPhotoInfo:selectedId issueStr:nextIssue AorB:self.isAbtn.intValue];
        
    }
}

#pragma mark - LiuHeTuKuRemarkBarDelegate 评论


- (void)sendRemarkText:(UIButton *)sender{
    
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];
        login.loginBlock = ^(BOOL result) {
            
        };
        return;
    }
    
    if ([NSString isBlankString:self.remarkStr]) {
        [AlertViewTool alertViewToolShowMessage:@"评论不能为空!" fromController:self handler:nil];
        
        return;
    }
    [self.view endEditing:YES];
    
    NSDictionary *dict = @{@"content":self.remarkStr, @"id": self.currentPhotoM.photoid ? self.currentPhotoM.photoid : @"0"};
    
    sender.enabled = NO;
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/addphptoCommentsByAPP.json" params:dict success:^(BaseData *data) {
        @strongify(self)
        sender.enabled = YES;
        if(![data.status isEqualToString:@"1"] ){
            
            [MBProgressHUD showMessage:[NSString stringWithFormat:@"%@", data.info]];
            return ;
        }
        
        [MBProgressHUD showSuccess:@"评论成功"];
        self.remarkBar.textField.text = @"";
        self.remarkStr = @"";
        
        
        self.page = 1;
        NSString *issueStr = self.currentIssue ? self.currentIssue : @"0";
        if (self.isClickLeftTableView) {
            issueStr = @"0";
        }
        NSString *selectID = self.selectID ? self.selectID : @"";
        [self getPhotoInfo:selectID issueStr: issueStr AorB:[self.isAbtn intValue]];
//        [self.tableView.mj_header beginRefreshing];
        
        
    } failure:^(NSError *error) {
        sender.enabled = YES;
    }showHUD:NO];
}
-(void)getRemarkText:(NSString *)msg{
    
    if (msg.length > 25) {
        
        msg = [msg substringToIndex:25];
        return;
    }
    self.remarkStr = msg;
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
}     // return a view that will be scaled. if delegate returns nil, nothing happens

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                        scrollView.contentSize.height * 0.5 + offsetY);
}

#pragma mark - 滚动标题代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / (SCREEN_WIDTH - self.leftTableView.width);
    
    [self.photosBar setViewIndex:index];
}

- (UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, 115, SCREEN_HEIGHT - NAV_HEIGHT - self.remarkBar.height) style:UITableViewStylePlain];
        
        _leftTableView.backgroundColor = [[CPTThemeConfig shareManager] LiuheTuKuLeftTableViewBackgroundColor] ;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.tag = 100;
        
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
    }
    return _leftTableView;
}


//- (UIScrollView *)imageScrollView{
//    if (!_imageScrollView) {
//        _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.topView.frame), self.view.width - self.leftTableView.width - 20, 340)];
//        [_imageScrollView addSubview:self.imageView];
//
//        _imageScrollView.delegate = self;
//
//        _imageScrollView.maximumZoomScale = 5.0;
//        _imageScrollView.minimumZoomScale = 1;
//        [_imageScrollView setZoomScale:1];
//
//    }
//    return _imageScrollView;
//}





- (UIButton *)showBigBtn{
    if (!_showBigBtn) {
        _showBigBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 360, 40, 40)];
        [_showBigBtn setImage:IMAGE(@"lhtk_zjticon") forState:UIControlStateNormal];
        [_showBigBtn setImage:IMAGE(@"lhtk_yjticon") forState:UIControlStateSelected];
        [_showBigBtn addTarget:self action:@selector(showBigImage:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _showBigBtn;
}



- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _coverView.backgroundColor = [UIColor colorWithHex:@"000000" Withalpha:0.5];
        [_coverView addSubview:self.toupiaoContentView];
    }
    return _coverView;
}


- (NSMutableArray *)leftListArray{
    if (!_leftListArray) {
        _leftListArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _leftListArray;
}

- (NSMutableArray *)toupiaoArray{
    if (!_toupiaoArray) {
        _toupiaoArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _toupiaoArray;
}

- (NSMutableArray *)ABBtnsArray{
    if (!_ABBtnsArray) {
        _ABBtnsArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _ABBtnsArray;
}

- (NSMutableArray *)photoModels{
    if (!_photoModels) {
        _photoModels = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _photoModels;
}
- (NSMutableArray *)remarkModels{
    if (!_remarkModels) {
        _remarkModels = [NSMutableArray arrayWithCapacity:2];
    }
    return _remarkModels;
}

- (NSMutableArray *)progressViewArray{
    if (!_progressViewArray) {
        _progressViewArray = [NSMutableArray arrayWithCapacity:6];
    }
    return _progressViewArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(CirclePhotosView *)photosView {
    
    if (!_photosView) {
        
        _photosView = [[CirclePhotosView alloc]init];
        _photosView.backgroundColor = CLEAR;
        _photosView.LiuHePhoto = YES;
        
        [self.view addSubview:_photosView];
    }
    return _photosView;
}


@end
