//
//  SixRecommendCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixRecommendCtrl.h"
#import "SixRecommendCell.h"
#import "RecommendlistModel.h"
#import "AttentionView.h"
#import "AttentionCollectionViewCell.h"
#import "PublishArticleViewController.h"
#import "NSString+IsBlankString.h"
#import "MyArticlesViewController.h"
#import "SixSearchView.h"
#import "FollowModel.h"
#import "NoDataView.h"
#import "AdvertModel.h"
#import "SixArticleDetailViewController.h"
#import <IQKeyboardManager.h>
#import "HistoryArticleViewController.h"
#import "NavigationVCViewController.h"
#import "XinShuiRecommentTopResultVeiw.h"
#import "CJScroViewBar.h"
#import "SGHorseRaceLampView.h"
#import "CCHSuspendWindow.h"
#import "PCInfoModel.h"
#import "LiuHeDaShenViewController.h"
#import "CJScroViewBar.h"
#import "XinShuiRecommentContentViewController.h"
#import "IGKbetListCtrl.h"
#import "LoginAlertViewController.h"
#import "CPTBuyRootVC.h"
#import "CPTBuySexViewController.h"
#import "ChatRoomCtrl.h"
#import "PublicInterfaceTool.h"

#define formulaBarHeight 45
#define iPhoneXScrollViewHeight SCREEN_HEIGHT - CGRectGetMaxY(self.formulaBar.frame) - self.bottomView.height + 30
#define scrollViewHeight SCREEN_HEIGHT - CGRectGetMaxY(self.formulaBar.frame) - self.bottomView.height
#define resultViewHeight 100

@interface SixRecommendCtrl ()<UINavigationControllerDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,SixSearchViewDelegate,AttentionCollectionViewCellDelegate,AttentionViewDelegate,XinShuiRecommentTopResultVeiwDelegate>

{
    CCHSuspendWindow *win;
}

//底部 view
@property (nonatomic, strong)UIView *bottomView;
//关注 view
@property (nonatomic, strong)AttentionView *attentionView;

@property (nonatomic, strong) SixSearchView *searchVeiw;

/*  关注数据  */
@property (nonatomic, strong) NSMutableArray *attentionModelArray;

/*  搜索关键词  */
@property (nonatomic, copy) NSString *searchStr;
//记录是否点击formulaBar按钮
@property (nonatomic, assign)BOOL isActionFormulaBar;

@property (nonatomic, assign)NSInteger followPage;;

@property (nonatomic, copy) NSString *downloadType;

@property (nonatomic, strong)UIView *coverView;

@property (nonatomic, strong) XinShuiRecommentTopResultVeiw *resultView;

@property (nonatomic, assign)BOOL isShowResultView;

@property (nonatomic, strong) UIButton *showBtn;

@property (nonatomic, strong) SGHorseRaceLampView *noticeView;

@property (nonatomic, strong) SixInfoModel *liuHeCaiModel;

@property (nonatomic, strong)CJScroViewBar *formulaBar;

@property (nonatomic, strong)UIButton *searchBtn;

@property (nonatomic, copy) NSString *noticeContent;

@property (nonatomic, strong) NSMutableArray *childVcs;


@end

@implementation SixRecommendCtrl

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.downloadType = @"1";
    self.followPage = 1;
    self.isShowResultView = YES;
    NSString *title = @"心水推荐";
    if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
        title = @"小鱼论坛";
    }
    self.titlestring = title;
    self.view.backgroundColor = [[CPTThemeConfig shareManager] SixRecommendVC_View_BackgroundC];

    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(receiveCloseBannerNoti:) name:@"closeBanner" object:nil];
    [self.view addSubview:self.resultView];
    [self.view addSubview:self.bottomView];
    [self setupFormulaBar];
    //投注按钮
    [self buildBettingBtn];

    //六合大神按钮
    [self buildDashenBtn];
    [self setupNav];
    [self initsixData];
    [self initNoticeData];
    
}

- (void)receiveCloseBannerNoti: (NSNotification *)noti{
    for (XinShuiRecommentContentViewController *vc in self.childVcs) {
        
        [vc.bannerView removeFromSuperview];
        
        vc.tableVeiwHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        vc.tableView.tableHeaderView = vc.tableVeiwHeaderView;
        
    }
}

- (void)setupFormulaBar{
    
    NSArray *titlesArray = @[@"大厅",@"精华帖",@"热门帖",@"今日发表"];
    
    self.formulaBar = [[CJScroViewBar alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.resultView.frame) - 13, SCREEN_WIDTH, formulaBarHeight)];
    self.formulaBar.lineColor = [[CPTThemeConfig shareManager] xinShuiReconmentRedColor];
    self.formulaBar.isXinshui = YES;
    self.formulaBar.backgroundColor = [[CPTThemeConfig shareManager] XinshuiRecommentScrollBarBackgroundColor];
    [self.view addSubview:self.formulaBar];

    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * titlesArray.count, 0);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    [self.view sendSubviewToBack:self.formulaBar];
//    [self.formulaBar layoutIfNeeded];
    [self.view bringSubviewToFront:self.resultView];
    
    [self.formulaBar setData:titlesArray NormalColor:[[CPTThemeConfig shareManager] grayColor666] SelectColor:[[CPTThemeConfig shareManager] xinShuiReconmentRedColor] Font:[UIFont systemFontOfSize:14]];
    
    for (int i = 0; i < titlesArray.count; i++) {
        XinShuiRecommentContentViewController *vc = [[XinShuiRecommentContentViewController alloc] init];
        vc.view.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.height);
        vc.view.backgroundColor = SIXRandomColor;
        [self.childVcs addObject:vc];
        [self addChildViewController:vc];
        vc.downloadType = [NSString stringWithFormat:@"%d", i + 1];
        [self.scrollView addSubview:vc.view];
        
    }

    @weakify(self)
    [self.formulaBar getViewIndex:^(NSString *title, NSInteger index) {
        @strongify(self)
        
        self.formulaBar.frame = CGRectMake(0, CGRectGetMaxY(self.resultView.frame), SCREEN_WIDTH, formulaBarHeight);
        [UIView animateWithDuration:0.3 animations:^{
            @strongify(self)
            self.downloadType = [NSString stringWithFormat:@"%d", index + 1];
            self.scrollView.contentOffset = CGPointMake(index * SCREEN_WIDTH, 0);
        }];
        self.searchBtn.selected = YES;
        [self search:self.searchBtn];
        
    }];
    
    [self.formulaBar setViewIndex:0];
}

#pragma mark 六合大神
- (void)transDaShenView:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint translation = [recognizer translationInView:self.view];
    
    CGFloat centerX=recognizer.view.center.x+ translation.x;
    CGFloat centerY=recognizer.view.center.y+ translation.y;
    CGFloat thecenterX=0;
    CGFloat thecenterY=0;
    recognizer.view.center=CGPointMake(centerX,
                                       
                                       recognizer.view.center.y+ translation.y);
    
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if(recognizer.state==UIGestureRecognizerStateEnded|| recognizer.state==UIGestureRecognizerStateCancelled) {
        
        if(centerX>SCREEN_WIDTH/2) {
            
            thecenterX=SCREEN_WIDTH-50/2;
            
        }else{
            
            thecenterX=50/2;
            
        }
        if (centerY>SCREEN_HEIGHT-NAV_HEIGHT) {
            
            thecenterY=SCREEN_HEIGHT-NAV_HEIGHT;
        }
        else if (centerY<NAV_HEIGHT) {
            
            thecenterY=NAV_HEIGHT;
        }
        else{
            thecenterY = recognizer.view.center.y+ translation.y;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            
            recognizer.view.center=CGPointMake(thecenterX,thecenterY);
            
        }];
        
    }

}

- (void)closeNoticeView{
    [self.noticeView removeFromSuperview];
}

- (void)setupHorseRaceLampView : (NSString *)content{
    SGHorseRaceLampView *HRLView = [[SGHorseRaceLampView alloc] init];
    HRLView.frame = CGRectMake(0, NAV_HEIGHT, self.view.frame.size.width, 40);
    HRLView.backgroundColor = [UIColor colorWithHex:@"000000" Withalpha:0.8];
    HRLView.titleFont = [UIFont systemFontOfSize:14];
    HRLView.title = content;
    HRLView.titleColor = WHITE;
    
    [self.view addSubview:HRLView];
    self.noticeView = HRLView;
    [self.view bringSubviewToFront:HRLView];
    
    UIButton *closeBtn = [Tools createButtonWithFrame:CGRectMake(HRLView.width - 40, 0, 30, HRLView.height) andTitle:nil andTitleColor:nil andBackgroundImage:nil andImage:IMAGE(@"icon_jjgg_close") andTarget:self andAction:@selector(closeNoticeView) andType:UIButtonTypeCustom];
    
    [HRLView addSubview:closeBtn];
    
//    HRLView.selectedBlock = ^{
//        MBLog(@"紧急通知被点击了");
//    };
    
    @weakify(self)
    HRLView.closeBlock = ^{
        @strongify(self)
        [self.noticeView removeFromSuperview];
    };
}

- (void)setupNav{
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn = searchBtn;
    
    [searchBtn setImage:IMAGE([[CPTThemeConfig shareManager] XSTJSearchImage]) forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *myArticleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [myArticleBtn setImage:[[CPTThemeConfig shareManager] XSTJMyArticleImage] forState:UIControlStateNormal];
    
    [myArticleBtn addTarget:self action:@selector(myArticla) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightBts = @[myArticleBtn,searchBtn];
    
    [self.view addSubview:self.searchVeiw];
    
}

#pragma mark SixSearchViewDelegate
- (void)searchArticles:(NSString *)content{
    
    [self.view endEditing:YES];
    
    if ([NSString isBlankString:content]) {
        content = @"";
    }
    self.searchStr = content;
    
    self.page = 1;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"searchArticle" object:[NSString stringWithFormat:@"%@%@", self.searchStr,self.downloadType]];
}

- (void)initNoticeData{
    
    @weakify(self)

    [WebTools postWithURL:@"/lottery/sendXsnotice.json" params:nil success:^(BaseData *data) {
        
        @strongify(self)
        NSLog(@"%@", data.data);
        
        if (![data.status isEqualToString:@"1"]) {
            
            return ;
        }
        NSString *content = data.data[@"content"];
        if ([NSString isBlankString:content]) {
            return;
        }
        
        [self setupHorseRaceLampView:content];
        
    } failure:^(NSError *error) {
        MBLog(@"1");
    } showHUD:NO];
}

#pragma mark 导航栏搜索按钮
- (void)search:(UIButton *)sender{
    
    sender.selected = sender.selected ? NO : YES;
    
    if (sender.selected) {
        
        self.searchVeiw.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 50);
        self.searchVeiw.hidden = NO;
        
        if (self.isShowResultView) {
            
            self.resultView.frame = CGRectMake(0, CGRectGetMaxY(self.searchVeiw.frame), SCREEN_WIDTH, self.resultView.height);
            self.formulaBar.frame = CGRectMake(0, CGRectGetMaxY(self.resultView.frame) - 13, SCREEN_WIDTH, formulaBarHeight);
            
        }else{
            self.formulaBar.frame = CGRectMake(0, CGRectGetMaxY(self.searchVeiw.frame), SCREEN_WIDTH, formulaBarHeight);
            self.showBtn.hidden = NO;
        }
        
        self.scrollView.frame = IS_IPHONEX ? CGRectMake(0, CGRectGetMaxY(self.formulaBar.frame), SCREEN_WIDTH, iPhoneXScrollViewHeight) : CGRectMake(0, CGRectGetMaxY(self.formulaBar.frame), SCREEN_WIDTH, scrollViewHeight);
        [self.view sendSubviewToBack:self.formulaBar];
        
        
    }else{
        
        self.searchVeiw.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 0);
        self.searchVeiw.hidden = YES;
        if (self.isShowResultView) {
            self.resultView.frame = CGRectMake(0, CGRectGetMaxY(self.searchVeiw.frame), SCREEN_WIDTH, self.resultView.height);
            self.formulaBar.frame = CGRectMake(0, CGRectGetMaxY(self.resultView.frame) - 13, SCREEN_WIDTH, formulaBarHeight);
        }else{
            self.formulaBar.frame = CGRectMake(0, CGRectGetMaxY(self.searchVeiw.frame), SCREEN_WIDTH, formulaBarHeight);
            [self.view bringSubviewToFront:self.formulaBar];
            [self.view sendSubviewToBack:self.resultView];
        }
        
        self.scrollView.frame = IS_IPHONEX ? CGRectMake(0, CGRectGetMaxY(self.formulaBar.frame), SCREEN_WIDTH, iPhoneXScrollViewHeight) : CGRectMake(0, CGRectGetMaxY(self.formulaBar.frame), SCREEN_WIDTH, scrollViewHeight);
        [self.view sendSubviewToBack:self.formulaBar];
        [self.view endEditing:YES];
    }
    
    
}

#pragma mark 我的帖子
- (void)myArticla{
    
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:login animated:YES completion:nil];
        @weakify(self)
        login.loginBlock = ^(BOOL result) {
            @strongify(self)
            MyArticlesViewController *myArticleVc = [[MyArticlesViewController alloc] init];
            myArticleVc.isShowEditBtn = YES;
            [self.navigationController pushViewController:myArticleVc animated:YES];
        };
        return;
    }
    MyArticlesViewController *myArticleVc = [[MyArticlesViewController alloc] init];
    myArticleVc.isShowEditBtn = YES;
    [self.navigationController pushViewController:myArticleVc animated:YES];
}
#pragma mark 发帖
- (void)publishArticle{
    
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];
        login.loginBlock = ^(BOOL result) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PublishArticleViewController" bundle:nil];
            PublishArticleViewController *publishVc = [storyboard instantiateInitialViewController];
            publishVc.controlerName = @"new";
            [self.navigationController pushViewController:publishVc animated:YES];
            
        };
        return;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PublishArticleViewController" bundle:nil];
    PublishArticleViewController *publishVc = [storyboard instantiateInitialViewController];
    publishVc.controlerName = @"new";
    [self.navigationController pushViewController:publishVc animated:YES];
    
}
#pragma mark 进入聊天室
- (void)joinChatRoom{

    __weak __typeof(self)weakSelf = self;
    [PublicInterfaceTool getWechatInfoSuccess:^(BaseData * _Nonnull data) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if ([data.data[@"chatRoom"] integerValue] == 1) {
            [MBProgressHUD showError:kGoInChatRoomMessage];
        } else {
            [strongSelf gotoChatRoom];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:kGoInChatRoomMessage];
    }];

}

- (void)gotoChatRoom {
//    MBLog(@"聊天室");
    ChatRoomCtrl *chatVC = [[ChatRoomCtrl alloc] init];
    chatVC.lotteryId = CPTBuyTicketType_LiuHeCai;
    chatVC.roomName = @"聊天室";
    chatVC.isLive = NO;
    chatVC.isFormHome = YES;
    PUSH(chatVC);
}

#pragma mark 关注
- (void)payAttentionU : (UIButton *)sender{
    
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];
        login.loginBlock = ^(BOOL result) {
           
        };
        return;
    }
    
    sender.selected = sender.selected  ? NO : YES;
    
    if (sender.selected) {
        [self.view addSubview:self.coverView];
        self.attentionView.frame = CGRectMake(0, self.coverView.height - 270, SCREEN_WIDTH, 270);
        self.followPage = 1;
        [self downloadAttentionData];
    }else{
        self.attentionView.isDeleteModel = NO;
        self.attentionView.editBtn.selected = NO;
        [self.attentionView.collectionView reloadData];
        [self.coverView removeFromSuperview];
    }
    
}

- (void)closeCoverView{
    self.attentionView.isDeleteModel = NO;
    self.attentionView.editBtn.selected = NO;
    [self.attentionView.collectionView reloadData];
    [self.coverView removeFromSuperview];
}

#pragma mark 删除关注
- (void)deleteAttentionPerson:(UIButton *)btn{
    
    FollowModel *model = self.attentionModelArray[btn.tag];

    @weakify(self)

    NSString *parentMemberId ;
    if (model.parentMemberId) {
        parentMemberId = [NSString stringWithFormat:@"%ld", model.parentMemberId];
    }else{
        parentMemberId = @"";
    }
    [WebTools postWithURL:@"/lhcSg/deleteRecommendFollow.json" params:@{@"id":parentMemberId, @"referrerId":model.referrerId ? model.referrerId : @"", @"pageSize" : pageSize} success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        [self downloadAttentionData];
        
    } failure:^(NSError *error) {
        MBLog(@"1");
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)initsixData {
    
    @weakify(self)

    [WebTools postWithURL:@"/lhcSg/getNewestSgInfo.json" params:nil success:^(BaseData *data) {
        
        @strongify(self)
        
        self.liuHeCaiModel = [SixInfoModel mj_objectWithKeyValues:data.data];
        NSArray * numberArry = [self.liuHeCaiModel.number componentsSeparatedByString:@","];
//        NSArray * numberArry = self.liuHeCaiModel.number;
        NSArray * shengxiaoArry = [self.liuHeCaiModel.shengxiao componentsSeparatedByString:@","];

        for (int i = 0; i<numberArry.count; i++) {
            NSString *num = numberArry[i];
            NSString *shengxiao = shengxiaoArry[i];
            NSString *wuxing = [Tools numbertowuxin:numberArry[i]];
            UIButton *btn = self.resultView.numberResults[i];
            [btn setUserInteractionEnabled:NO];
            [btn setBackgroundImage:[Tools numbertoimage:num Withselect:NO] forState:UIControlStateNormal];
            UILabel *lab = self.resultView.numberShengXiaos[i];
            [btn setTitle:num forState:UIControlStateNormal];
            lab.text = [NSString stringWithFormat:@"%@/%@", shengxiao,wuxing];
        }
        self.resultView.dateLbl.text = [NSString  stringWithFormat:@"%@ %@期",self.liuHeCaiModel.time,self.liuHeCaiModel.issue];
        
    } failure:^(NSError *error) {
        MBLog(@"1");
    } showHUD:NO];
}

#pragma mark XinShuiRecommentTopResultVeiwDelegate

- (void)skipToHistoryVc{
    IGKbetListCtrl *list = [[IGKbetListCtrl alloc]init];
    list.type = CPTBuyTicketType_LiuHeCai;
    list.titlestring =@"六合彩";
    PUSH(list);
}
- (void)IsShowResultView:(UIButton *)sender{//隐藏
    
    self.isShowResultView = NO;
    self.showBtn.hidden = NO;
    self.resultView.hidden = YES;
    self.resultView.frame = CGRectMake(0, self.searchVeiw.height + NAV_HEIGHT - resultViewHeight, SCREEN_WIDTH, resultViewHeight);
    self.formulaBar.frame = CGRectMake(0, CGRectGetMaxY(self.resultView.frame), SCREEN_WIDTH,  formulaBarHeight);
    [self.view sendSubviewToBack:self.resultView];
    [self.view addSubview:self.showBtn];
    [self.showBtn setImage:IMAGE(@"btn_下拉") forState:UIControlStateNormal];
    [self.showBtn addTarget:self action:@selector(showResultView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showBtn];
    
    if (self.noticeView) {
        [self.view bringSubviewToFront:self.noticeView];
    }
    
    self.scrollView.frame = IS_IPHONEX ? CGRectMake(0, CGRectGetMaxY(self.formulaBar.frame), SCREEN_WIDTH, iPhoneXScrollViewHeight):CGRectMake(0, CGRectGetMaxY(self.formulaBar.frame), SCREEN_WIDTH, scrollViewHeight);
    
}
//显示
- (void)showResultView:(UIButton *)button{
    
    self.isShowResultView = YES;
    self.showBtn.hidden = YES;
    self.resultView.hidden = NO;
    [self.view bringSubviewToFront:self.resultView];
    self.resultView.frame = CGRectMake(0, CGRectGetMaxY(self.searchVeiw.frame), SCREEN_WIDTH, self.resultView.height);
    self.formulaBar.frame = CGRectMake(0, CGRectGetMaxY(self.resultView.frame) - 13, SCREEN_WIDTH, formulaBarHeight);
    self.scrollView.frame = IS_IPHONEX ? CGRectMake(0, CGRectGetMaxY(self.formulaBar.frame), SCREEN_WIDTH, iPhoneXScrollViewHeight):CGRectMake(0, CGRectGetMaxY(self.formulaBar.frame), SCREEN_WIDTH, scrollViewHeight);
    [self.view sendSubviewToBack:self.formulaBar];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.attentionModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AttentionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AttentionCollectionViewCellID forIndexPath:indexPath];
    
    FollowModel *model = self.attentionModelArray[indexPath.row];
    cell.model = model;
    cell.delegate = self;
    cell.closeBtn.tag = indexPath.row;
    
    if (self.attentionView.isDeleteModel) {
        cell.closeBtn.hidden = NO;
    }else{
        cell.closeBtn.hidden = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FollowModel *model = self.attentionModelArray[indexPath.row];
    HistoryArticleViewController *historyVc = [[HistoryArticleViewController alloc] init];
    historyVc.idNum = [model.referrerId integerValue];//[model.parentMemberId integerValue];
    historyVc.isHistoryVc = YES;
    historyVc.followModel = model;
    [self.navigationController pushViewController:historyVc animated:YES];
}

#pragma mark 加载关注数据
- (void)downloadAttentionData{
    
    @weakify(self)
    NSString * ss = @"/lhcSg/pageLhcXsRecommendFollow.json";

    [WebTools postWithURL:ss params:@{@"pageNum": @(self.followPage), @"pageSize" : pageSize} success:^(BaseData *data) {
        
        @strongify(self)
        [self.attentionView.collectionView.mj_header endRefreshing];
        [self.attentionView.collectionView.mj_footer endRefreshing];
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        [self.attentionModelArray removeAllObjects];
        self.attentionModelArray = [FollowModel mj_objectArrayWithKeyValuesArray:data.data];
        [self.view addSubview:self.coverView];

        MBLog(@"%@", [NSThread currentThread]);
        [self.attentionView.collectionView reloadData];

    } failure:^(NSError *error) {
        @strongify(self)
        [self.attentionView.collectionView.mj_header endRefreshing];
        [self.attentionView.collectionView.mj_footer endRefreshing];
        
    }];
}

#pragma mark 加载更多关注数据
- (void)downloadMoreAttentionData{
    
    @weakify(self)
    NSString * ss = @"/lhcSg/pageLhcXsRecommendFollow.json";

    [WebTools postWithURL:ss params:@{@"pageNum": @(self.followPage), @"pageSize" : pageSize} success:^(BaseData *data) {
        @strongify(self)
        [self.attentionView.collectionView.mj_header endRefreshing];
        [self.attentionView.collectionView.mj_footer endRefreshing];

        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        NSArray *array = [FollowModel mj_objectArrayWithKeyValuesArray:data.data];
        if (array.count == 0) {
            [self.attentionView.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.attentionModelArray addObjectsFromArray:array];
        [self.attentionView.collectionView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.attentionView.collectionView.mj_header endRefreshing];
        [self.attentionView.collectionView.mj_footer endRefreshing];
        
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    //设置Bar的移动位置
    [self.formulaBar setViewIndex:index];
    
    if(scrollView.contentOffset.x<=-10){
        [self popback];
    }
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        CGFloat tmpX = 0;
        if ((IS_IPHONEX)) {
            _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 70);
            
        }else{
            tmpX = 2;
            _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
        }
        
        _bottomView.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];
        //关注
        UIButton *attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(tmpX, 0, 80, _bottomView.height)];
        attentionBtn.backgroundColor = CLEAR;
        [attentionBtn setTitle:@"关注" forState: UIControlStateNormal];
        [attentionBtn setTitleColor:[[CPTThemeConfig shareManager] xinshuiBottomViewTitleColor] forState:UIControlStateNormal];
        attentionBtn.layer.cornerRadius = 2;
        attentionBtn.layer.masksToBounds = YES;
        attentionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [attentionBtn addTarget:self action:@selector(payAttentionU:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:attentionBtn];
        UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(attentionBtn.frame), attentionBtn.y + 10, 1, attentionBtn.height - 20)];
        [_bottomView addSubview:leftLine];
        leftLine.backgroundColor = [[CPTThemeConfig shareManager] xinshuiBottomVeiwSepeLineColor];
        
        //发帖
        UIButton *publishBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(attentionBtn.frame) + 2, 0, SCREEN_WIDTH - (attentionBtn.width + 2 )*2 - 15, attentionBtn.frame.size.height)];
        publishBtn.backgroundColor = CLEAR;
        [publishBtn setTitle:@"发 帖" forState: UIControlStateNormal];
        [publishBtn setTitleColor:[[CPTThemeConfig shareManager] xinshuiBottomViewTitleColor] forState:UIControlStateNormal];
        publishBtn.layer.cornerRadius = 2;
        publishBtn.layer.masksToBounds = YES;
        publishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [publishBtn addTarget:self action:@selector(publishArticle) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:publishBtn];
        
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(publishBtn.frame), attentionBtn.y + 10, 1, attentionBtn.height - 20)];
        [_bottomView addSubview:rightLine];
        rightLine.backgroundColor = [[CPTThemeConfig shareManager] xinshuiBottomVeiwSepeLineColor];
        
        //聊天室
        UIButton *chatRomeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - attentionBtn.width - 14, 0, attentionBtn.width + 10, attentionBtn.frame.size.height)];
        chatRomeBtn.backgroundColor = CLEAR;
        [chatRomeBtn setTitle:@"聊天室" forState: UIControlStateNormal];
        [chatRomeBtn setTitleColor:[[CPTThemeConfig shareManager] xinshuiBottomViewTitleColor] forState:UIControlStateNormal];
        chatRomeBtn.layer.cornerRadius = 2;
        chatRomeBtn.layer.masksToBounds = YES;
        chatRomeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [chatRomeBtn addTarget:self action:@selector(joinChatRoom) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:chatRomeBtn];
        
        if ((IS_IPHONEX)) {
            attentionBtn.titleEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
            publishBtn.titleEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
            chatRomeBtn.titleEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
        }
    }
    return _bottomView;
}

- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        if (IS_IPHONEX) {
            _coverView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.bottomView.height - NAV_HEIGHT + 30);
        }else{
            _coverView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.bottomView.height - NAV_HEIGHT);
        }
        _coverView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        [_coverView addSubview:self.attentionView];
        
    }
    
    return _coverView;
}

- (AttentionView *)attentionView{
    if (!_attentionView) {
        
        _attentionView = [[AttentionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270)];
        _attentionView.backgroundColor = [UIColor whiteColor];
        _attentionView.delegate = self;
        _attentionView.collectionView.dataSource = self;
        _attentionView.collectionView.delegate = self;
        @weakify(self)
        _attentionView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            self.followPage = 1;
            [self downloadAttentionData];
        }];
        _attentionView.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            self.followPage += 1;
            [self downloadMoreAttentionData];
        }];
        
    }
    return _attentionView;
}

- (NSMutableArray *)attentionModelArray{
    if (!_attentionModelArray) {
        _attentionModelArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _attentionModelArray;
}


- (SixSearchView *)searchVeiw{
    if (!_searchVeiw) {
        _searchVeiw = [[SixSearchView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 0)];
        _searchVeiw.hidden = YES;
//        [_searchVeiw.searchBar layoutIfNeeded];
        _searchVeiw.delegate = self;
        _searchVeiw.placehold = @"搜索: 人名、标题";
    }
    
    return _searchVeiw;
}


- (XinShuiRecommentTopResultVeiw *)resultView{
    if (!_resultView) {
        _resultView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([XinShuiRecommentTopResultVeiw class]) owner:self options:nil]firstObject];
        _resultView.delegate = self;
        _resultView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, resultViewHeight);
    }
    
    return _resultView;
}

- (UIButton *)showBtn{
    if (!_showBtn) {
        _showBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 30)/2, NAV_HEIGHT, 30, 14)];
    }
    
    return _showBtn;
}

- (NSMutableArray *)childVcs{
    if (!_childVcs) {
        _childVcs = [NSMutableArray arrayWithCapacity:4];
    }
    return _childVcs;
}

@end
