//
//  SixArticleDetailViewController.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/30.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import "SixArticleDetailViewController.h"
#import "HistoryArticleViewController.h"
#import "SixArticleDetailHeaderView.h"
#import "RemarkAreaTableViewCell.h"
#import "XinShuiRecommendRemarkModel.h"
#import "RemarkBarView.h"
#import "NSString+IsBlankString.h"
#import "PublishArticleViewController.h"
#import <IQKeyboardManager.h>
#import "NavigationVCViewController.h"
#import "XinShuiRecommentTopResultVeiw.h"
#import "TouPiaoView.h"
#import "TouPiaoContentView.h"
#import "TouPiaoModel.h"
#import "IGKbetListCtrl.h"
#import <WebKit/WebKit.h>
#import "LoginAlertViewController.h"
#import "CPTBuyRootVC.h"
#import "CPTBuySexViewController.h"
#import "LiveOpenLotteryViewController.h"
#import "CPTInfoManager.h"
#import "ChatRoomCtrl.h"
#import "PublicInterfaceTool.h"


@interface SixArticleDetailViewController ()<RemarkBarViewDelegate, SixArticleDetailHeaderViewDelegate,UITabBarDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate, XinShuiRecommentTopResultVeiwDelegate, TouPiaoViewDelegate, TouPiaoContentViewDelegate>

@property (nonatomic, strong) UITableView *remarkTableView;
@property (nonatomic, weak)UIView *bottonView;
@property (nonatomic, strong)UILabel *creattimelab;
@property (nonatomic, strong)UILabel *sawcountlab;
@property (nonatomic,weak) UILabel *zanNumLbl;
@property (nonatomic, weak)UIButton *zanBtn;
@property (nonatomic, assign)BOOL ShowRemarkBtn;
@property (nonatomic, strong)RecommendDetailModel *model;
@property (nonatomic, strong) NSMutableArray *remarkData;
@property (nonatomic, assign)NSInteger pageNum;
//记录是否点赞
@property (nonatomic, assign)BOOL isZan;
//回复评论前面字段
@property (nonatomic, copy) NSString *responsePreStr;
//记录是否为回复评论
@property (nonatomic, assign)BOOL isResponse;
//记录评论 id
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic,weak) SixArticleDetailHeaderView *tableViewHeader;
//评论按钮
@property (nonatomic, strong) UIButton *remarkBtn;
//评论内容
@property (nonatomic, copy) NSString *remarkText;
@property (nonatomic, weak)RemarkBarView *remarkBar;
@property (nonatomic, assign)CGFloat titleHeight;
@property (nonatomic, assign)CGFloat contentWebHight;
@property (nonatomic, strong) XinShuiRecommentTopResultVeiw *resultView;
@property (nonatomic, strong) TouPiaoContentView *toupiaoContentView;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, strong) NSMutableArray *toupiaoArray;
@property (nonatomic,weak) TouPiaoView *toupiaoView;
@property (nonatomic, strong)UIView *refreshBgV;

@property (nonatomic, assign) NSInteger tableViewKVO_Count;

@end

@implementation SixArticleDetailViewController

- (void)dealloc{

    if(_tableViewHeader){
        if(_tableViewHeader.contentWebVeiw){
            
            if([_tableViewHeader.contentWebVeiw observationInfo]){
                [_tableViewHeader.contentWebVeiw removeObserver:self forKeyPath:@"scrollView.contentSize"];
            }
            _tableViewHeader.contentWebVeiw.UIDelegate = nil;
            _tableViewHeader.contentWebVeiw.navigationDelegate = nil;
            _tableViewHeader.contentWebVeiw.scrollView.delegate = nil;
        }
    }
        if(_tableViewHeader){
            _tableViewHeader = nil;
        }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void)popback{
//
//
//    [super popback];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleStr = @"心水推荐详情";
    if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
        self.titleStr = @"小鱼论坛详情";
    }
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(receiveShareNotification:) name:@"xinshuiRecommentShare" object:nil];
    
    [self setupUI];
    self.page = 1;
    self.tableViewKVO_Count = 50;

    [self initsixData];
    [self downloadShareUrl];
    [self downloadToupiaoData];
    [self downloadRemarkData];
    [self initData];
    //投注按钮
    [self buildBettingBtn];
    
    [self.tableViewHeader.contentWebVeiw addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
}
#pragma mark -  获取APP管理详情
- (void)downloadShareUrl{
    __weak __typeof(self)weakSelf = self;
    [[CPTInfoManager shareManager] checkModelCallBack:^(CPTInfoModel * _Nonnull model, BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.shareUrl = model.shareUrl;
        }
    }];
}

-(void)initsixData {
    @weakify(self)

    [WebTools postWithURL:@"/lhcSg/getNewestSgInfo.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        self.liuHeCaiModel = [SixInfoModel mj_objectWithKeyValues:data.data];
        NSArray * numberArry = [self.liuHeCaiModel.number componentsSeparatedByString:@","];
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
            lab.text = [NSString stringWithFormat:@"%@/%@",shengxiao,wuxing];
        }
        
        self.resultView.dateLbl.text = self.liuHeCaiModel.issue;
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

//- (void)dealloc{
//    MBLog(@"%s dealloc",object_getClassName(self));
//
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}


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

#pragma mark 投票数据
- (void)downloadToupiaoData{
    @weakify(self)

    [WebTools postWithURL:@"/lottery/getVotesInfo.json" params:nil success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        @strongify(self)

        NSArray *toupiaoArray = [NSArray arrayWithArray:data.data];
        
        self.toupiaoArray = [TouPiaoModel mj_objectArrayWithKeyValuesArray:toupiaoArray];
        
        self.toupiaoView.modelsArray = self.toupiaoArray;
        [self.remarkTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark评论列表数据
- (void)downloadRemarkData {
    
    self.pageNum = 1;
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/pageRecommendCommendByRecommendId.json" params:@{@"number":@(self.ID), @"pageNum": @(self.pageNum), @"pageSize" : pageSize} success:^(BaseData *data) {
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        @strongify(self)

        [self.remarkData removeAllObjects];
        
        NSArray *newArray = [XinShuiRecommendRemarkModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.remarkTableView.mj_footer endRefreshing];
        [self.remarkTableView.mj_header endRefreshing];
        
        if (newArray.count == 0 ) {
            [self.remarkTableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        [self.remarkData addObjectsFromArray:newArray];
        
        [self.remarkTableView reloadData];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }showHUD:NO];
}

- (void)downloadMoreRemarkData{
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/pageRecommendCommendByRecommendId.json" params:@{@"number":@(self.ID), @"pageNum": @(self.pageNum), @"pageSize" : pageSize} success:^(BaseData *data) {
        @strongify(self)
        [self.remarkTableView.mj_footer endRefreshing];
        [self.remarkTableView.mj_header endRefreshing];
        
        NSArray *newArr = [XinShuiRecommendRemarkModel mj_objectArrayWithKeyValuesArray:data.data];
        
        if (newArr.count == 0 ) {
            [self.remarkTableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        
        [self.remarkData addObjectsFromArray:newArr];
        
        [self.remarkTableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.remarkTableView.mj_footer endRefreshing];
        [self.remarkTableView.mj_header endRefreshing];
    }];
}

#pragma mark - header数据  六合彩资讯: 心水推荐详情
-(void)initData {
    @weakify(self)
//    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    
    NSDictionary *dic = @{@"id":@(self.ID)};
//    /lhcSg/getOneXsCommend.json
    NSString *url = @"/xsTj/getOneXsCommend.json";

    [WebTools postWithURL:url params:dic success:^(BaseData *data) {
        @strongify(self)
        
        [self.remarkTableView.mj_header endRefreshing];
        self.model = [RecommendDetailModel mj_objectWithKeyValues:data.data];
//        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
//        MBLog(@"getOneXsCommend: in %f s", linkTime);
//        CFAbsoluteTime startTime2 =CFAbsoluteTimeGetCurrent();

        self.isAttention = self.model.alreadyFllow;
        
        self.tableViewHeader.followBtn.selected = [self.isAttention isEqualToString: @"1"] ? YES : NO;
        
        if (self.tableViewHeader.followBtn.selected) {
            self.tableViewHeader.followBtn.backgroundColor = [UIColor whiteColor];
            self.tableViewHeader.followBtn.layer.borderColor = [[[CPTThemeConfig shareManager] xinshuiFollowBtnBackground] CGColor];
            self.tableViewHeader.followBtn.layer.borderWidth = 1;
            
        }else{
            self.tableViewHeader.followBtn.backgroundColor = [[CPTThemeConfig shareManager] xinshuiFollowBtnBackground];
        }
        
        self.creattimelab.text = self.model.createTime;
        self.sawcountlab.text = [Tools getWanString:self.model.realViews];
        self.zanNumLbl.text = [Tools getWanString:[self.model.totalAdmire integerValue]];
        
        if (self.model.qrShow == 1) {
            self.tableViewHeader.qrCodeImgViewHeight.constant = 100;
            UIImage *qrcode = [Tools generateQRCode:self.model.qrCode width:100 height:100];
            self.tableViewHeader.qrImgView.image = qrcode;
        }else{
            self.tableViewHeader.qrCodeImgViewHeight.constant = 0;
        }
        CGFloat titleHeight = [self heightForAttrText:self.model.title];
        if (titleHeight < 50 || titleHeight > 80) {
            titleHeight = titleHeight + 10;
        }
        self.titleHeight = titleHeight;
        self.tableViewHeader.titleLblHeight.constant = titleHeight;
        self.remarkTableView.tableHeaderView = self.tableViewHeader;
        self.tableViewHeader.model = self.model;
        
        
        [self.remarkTableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.remarkTableView.mj_header endRefreshing];
        
    }showHUD:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (self.tableViewKVO_Count <= 0) {
        return;
    }
    self.tableViewKVO_Count--;
    
    if (object == self.tableViewHeader.contentWebVeiw && [keyPath isEqual:@"scrollView.contentSize"]) {
        UIScrollView *scrollView = self.tableViewHeader.contentWebVeiw.scrollView;
        CGSize size = CGSizeMake(SCREEN_WIDTH - 20, scrollView.contentSize.height);
//        self.tableViewHeader.contentWebviewHeight.constant = size.height;
        self.tableViewHeader.WKWebViewBackView.frame = CGRectMake(self.tableViewHeader.WKWebViewBackView.x, self.tableViewHeader.WKWebViewBackView.y, self.tableViewHeader.WKWebViewBackView.width, size.height);
        self.tableViewHeader.contentWebVeiw.frame = self.tableViewHeader.WKWebViewBackView.bounds;
        self.tableViewHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 70 + self.titleHeight + size.height + self.tableViewHeader.qrCodeImgViewHeight.constant);
        self.remarkTableView.tableHeaderView = self.tableViewHeader;
        
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //    MBLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    if(error){
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@", error]];
    }else{
        [MBProgressHUD showSuccess:@"保存成功"];
    }
}

#pragma mark setupUI
- (void)setupUI{
    self.titlestring = self.titleStr;
    
    //禁止侧滑手势
//    NavigationVCViewController *nav = (NavigationVCViewController *)self.navigationController;
//    [nav removepang];
    self.coverView.backgroundColor = [UIColor colorWithHex:@"000000" Withalpha:0.5];
    self.remarkTableView.estimatedRowHeight = 50;
    self.remarkTableView.delegate = self;
    self.remarkTableView.dataSource = self;
    //    [[IQKeyboardManager sharedManager] setEnable:YES];
    self.remarkTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WHITE;
    [self.remarkTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RemarkAreaTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RemarkAreaTableViewCell"];
    
    @weakify(self)
    self.remarkTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.pageNum = 1;
        
        [self initData];
        
        [self downloadRemarkData];
    }];
    
    [self.view addSubview:self.resultView];
    self.view.backgroundColor = WHITE;
    
    self.remarkTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        @strongify(self)
        self.pageNum ++ ;
        
        [self downloadMoreRemarkData];
    }];
    
    self.leftBlock = ^(UIButton *sender) {
        @strongify(self)
        if (self.isToRootVc) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    };
    self.pageNum = 1;
    
    self.isResponse = NO;
    
    [self setupNav];

    [self setupTableViewHeaderView];

    [self buildbottomView];
    
    
    [self.view addSubview:self.remarkTableView];
    
    [self.remarkTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.resultView.mas_bottom);
        make.bottom.equalTo(self.bottonView.mas_top);
    }];
}

#pragma mark XinShuiRecommentTopResultVeiwDelegate
- (void)skipToHistoryVc{
    IGKbetListCtrl *list = [[IGKbetListCtrl alloc]init];
    list.type = CPTBuyTicketType_LiuHeCai;
    list.titlestring =@"六合彩";
    PUSH(list);
}

- (void)replyArticle{
    [self remarkArticle];
}

#pragma mark 隐藏顶部
- (void)IsShowResultView:(UIButton *)sender{
    sender.selected = sender.selected ? NO : YES;
    if (sender.selected) {
        [self.view sendSubviewToBack:self.resultView];
        self.resultView.frame = CGRectMake(0, NAV_HEIGHT - 82, SCREEN_WIDTH, 92);
        self.tableViewHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.titleHeight + self.tableViewHeader.contentWebviewHeight.constant + self.tableViewHeader.qrCodeImgViewHeight.constant);
    }else{
        self.resultView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 92);
        self.tableViewHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150 + self.titleHeight + self.tableViewHeader.contentWebviewHeight.constant + self.tableViewHeader.qrCodeImgViewHeight.constant);
    }
}

#pragma mark TouPiaoViewDelegate
- (void)toupiao{
    //    [self downloadToupiaoData]
    @weakify(self)
    [UIView animateWithDuration:0.5 animations:^{
        @strongify(self)
        self.toupiaoContentView.frame = CGRectMake(15,( SCREEN_HEIGHT - 445)/2, SCREEN_WIDTH - 30, 445);
    }];
    self.toupiaoContentView.backgroundColor = [UIColor whiteColor];
    self.toupiaoContentView.toupiaoList = self.toupiaoArray;
    //    self.toupiaoContentView.issue = self..issue;
    self.toupiaoContentView.issue = self.liuHeCaiModel.nextIssue;
    [self.view addSubview:self.coverView];
}

#pragma mark TouPiaoContentViewDelegate
- (void)removeTouPiaoContentView{
    [self.coverView removeFromSuperview];
}
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
        [self.coverView removeFromSuperview];
    }];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XinShuiRecommendRemarkModel *model = self.remarkData[indexPath.row];
    
    self.parentId = model.ID;
    
    self.responsePreStr = [NSString stringWithFormat:@"%@ @%@:",[Person person].nickname, model.nickname];
    
    self.isResponse = YES;
    
    [self remarkArticle];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TouPiaoView *toupiaoView = [[TouPiaoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25 * (self.toupiaoArray.count%2 ? self.toupiaoArray.count/2 : self.toupiaoArray.count/2 + 1) + 40 + 140 + 40 + 20 + 10)];
    self.toupiaoView = toupiaoView;
    toupiaoView.backgroundColor = WHITE;
    toupiaoView.delegate = self;
    toupiaoView.modelsArray = self.toupiaoArray;
    
    return toupiaoView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25 * (self.toupiaoArray.count%2 ? self.toupiaoArray.count/2 : self.toupiaoArray.count/2 + 1) + 40 + 140 + 40 + 20 + 10;
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.remarkData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RemarkAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RemarkAreaTableViewCell"];
    
    XinShuiRecommendRemarkModel *model = self.remarkData[indexPath.row];
    cell.contentLbl.text = model.content;
    cell.nicknameLbl.text = model.nickname;
    cell.timeLbl.text = model.createTime ? model.createTime : @"";
    [cell.icon sd_setImageWithURL:IMAGEPATH(model.heads) placeholderImage:IMAGE(@"touxiang")];
    
    return cell;
}

#pragma mark 点击评论 RemarkArticleDelegate;
- (void)remarkArticle{
    
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];
        login.loginBlock = ^(BOOL result) {

        };
        return;
    }
    
    self.ShowRemarkBtn = NO;
    
    self.bottonView.hidden = YES;
    
    self.remarkText = nil;
    
    RemarkBarView *remarkBar = [[RemarkBarView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    self.remarkBar = remarkBar;
    remarkBar.delegate = self;
    
    [remarkBar.textField becomeFirstResponder];
    
    [self.view addSubview:remarkBar];
    
    if (self.isResponse) {
        remarkBar.textField.text = self.responsePreStr;
    }
    
}

#pragma mark 进入聊天室
- (void)joinChatRoom{
    if([AppDelegate shareapp].wkjScheme == Scheme_LotterEight){
        LiveOpenLotteryViewController *liveVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"LiveOpenLotteryViewController"];
        liveVc.lotteryId = CPTBuyTicketType_LiuHeCai;
        liveVc.lottery_oldID = 4;
        liveVc.pureChat = YES;
        PUSH(liveVc);
        return;
    }
//    CPTBuyRootVC * vc = [[CPTBuyRootVC alloc] init];
//    vc.lotteryId = CPTBuyTicketType_LiuHeCai;
//    CPTBuySexViewController *six = [[CPTBuySexViewController alloc]init];
//    six.type = CPTBuyTicketType_LiuHeCai;
//    six.endTime = 60;
//    [[CPTBuyDataManager shareManager] configType:six.type];
//    six.lottery_type = CPTBuyTicketType_LiuHeCai;
//    six.categoryId = 12;
//    six.lotteryId = CPTBuyTicketType_LiuHeCai;
//    vc.type = six.type;
//    [vc loadVC:six title:@"六合彩"];
//    PUSH(vc);
//    [vc showChatVC];
    
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
    ChatRoomCtrl *chatVC = [[ChatRoomCtrl alloc] init];
    chatVC.lotteryId = CPTBuyTicketType_LiuHeCai;
    chatVC.roomName = @"聊天室";
    chatVC.isLive = NO;
    chatVC.isFormHome = YES;
    PUSH(chatVC);
}


- (void)getRemarkText:(NSString *)msg{
    self.remarkText = msg;
}

#pragma mark 发送评论

- (void)sendRemarkText:(UIButton *)sender{

    if ([NSString isBlankString:self.remarkText]) {
        [MBProgressHUD showMessage:@"评论不能为空"];
        return;
    }
    if (self.remarkText.length >= 200) {
        [MBProgressHUD showMessage:@"评论字数不能超过100"];
        return;
    }
    
    [self.view endEditing:YES];
    self.bottonView.hidden = NO;
    self.remarkBar.hidden = YES;
    
    NSMutableDictionary *paramDic;
    
    if (self.isResponse) {
        
        NSString *remarkStr = [[self.remarkText componentsSeparatedByString:@":"] lastObject];
        
        NSDictionary *params = @{@"recommendId":@(self.ID), @"content": remarkStr, @"parentId": self.parentId};
        paramDic = (NSMutableDictionary*)params;
        
        if ([NSString isBlankString:remarkStr]) {
            [MBProgressHUD showMessage:@"回复评论不能为空"];
            return;
        }
        
    }else{
        NSDictionary *params = @{@"recommendId":@(self.ID), @"content": self.remarkText};
        paramDic = (NSMutableDictionary*)params;
        
    }
    @weakify(self)
    sender.enabled = NO;
    [WebTools postWithURL:@"/lhcSg/addRecommendCommend.json" params:paramDic success:^(BaseData *data) {
        @strongify(self)
        sender.enabled = YES;
        if(![data.status isEqualToString:@"1"] ){
            
            [MBProgressHUD showMessage:[NSString stringWithFormat:@"%@", data.info]];
            return ;
        }
        self.model.replyViewFlag = NO;
        self.tableViewHeader.model = self.model;
        
        [self downloadRemarkData];
        
    } failure:^(NSError *error) {
        sender.enabled = YES;
    }showHUD:NO];
}

- (void)skipToEditVc{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PublishArticleViewController" bundle:nil];
    PublishArticleViewController *publishVc = [storyboard instantiateInitialViewController];
    //    publishVc.model = self.model;
    publishVc.content = self.model.content;
    publishVc.ID = self.model.ID;
    publishVc.controlerName = @"edit";
    
    [self.navigationController pushViewController:publishVc animated:YES];
    
}

#pragma mark - 心水推荐关注
- (void)attentionSomeone:(UIButton *)sender{
//    @weakify(self)
    NSDictionary *params = @{@"parentMemberId":self.model.parentMemberId, @"referrerId":self.model.referrerId};
    
    [WebTools postWithURL:@"/lhcSg/addRecommendFollow.json" params:params success:^(BaseData *data) {
//        @strongify(self)

        if ([data.status isEqualToString:@"1"]) {
            sender.selected = sender.selected ? NO : YES;
            
            if (sender.selected) {
                sender.backgroundColor = [UIColor whiteColor];
                sender.layer.borderColor = [[[CPTThemeConfig shareManager] xinshuiFollowBtnBackground] CGColor];
                sender.layer.borderWidth = 1;
                
            }else{
                sender.backgroundColor = [[CPTThemeConfig shareManager] xinshuiFollowBtnBackground];
//                sender.layer.borderColor = [MAINCOLOR CGColor];
//                sender.layer.borderWidth = 1;
            }
        }else{
            [MBProgressHUD showMessage:@"关注失败"];
        }
        
    } failure:^(NSError *error) {
        
        MBLog(@"发送请求失败");
    }showHUD:NO];
}

#pragma mark 点赞
- (void)didClickZanBtn:(UIButton *)Btn{
    //获取当前点赞数
    int currentZanNum = [self.zanNumLbl.text intValue];
    if (currentZanNum < 0) {
        currentZanNum = 0;
    }
    
    // deleted点赞的时候传0 取消点赞传1
    //    NSString *isZanStr = @"";
    //    if (Btn.selected) {
    //        isZanStr = @"0";
    //    }else{
    //        isZanStr = @"1";
    //    }
    
    [Btn setUserInteractionEnabled:NO];
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/addRecommendAdmire.json" params:@{@"recommendId":@(self.ID), @"deleted" : @"0"} success:^(BaseData *data) {
        @strongify(self)
        [Btn setUserInteractionEnabled:YES];

        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        self.zanNumLbl.text = [NSString stringWithFormat:@"%d", currentZanNum + 1];
        
    } failure:^(NSError *error) {
        [Btn setUserInteractionEnabled:YES];
    } showHUD:NO];
}

#pragma mark setupUI

- (void)setupTableViewHeaderView{
    NSArray *objs = [[NSBundle mainBundle]loadNibNamed:@"SixArticleDetailHeaderView" owner:nil options:nil];
    
    SixArticleDetailHeaderView *tableHeader = objs.firstObject;
    
    tableHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 350);
    tableHeader.delegate = self;
    
    tableHeader.contentWebVeiw.UIDelegate = self;
    tableHeader.contentWebVeiw.navigationDelegate = self;
    tableHeader.contentWebVeiw.scrollView.delegate = self;
    
    self.tableViewHeader.editBtn.hidden = YES;
    
    self.tableViewHeader = tableHeader;
    
    self.remarkTableView.tableHeaderView = tableHeader;
    
    self.tableViewHeader.followBtn.selected = [self.isAttention isEqualToString: @"1"] ? YES : NO;
    
//    if (self.tableViewHeader.followBtn.selected) {
//        self.tableViewHeader.followBtn.backgroundColor = [UIColor whiteColor];
////        self.tableViewHeader.followBtn.layer.borderColor = [[[CPTThemeConfig shareManager] xinshuiFollowBtnBackground] CGColor];
////        self.tableViewHeader.followBtn.layer.borderWidth = 1;
//
//    }else{
//        self.tableViewHeader.followBtn.backgroundColor = [[CPTThemeConfig shareManager] xinshuiFollowBtnBackground];
////        self.tableViewHeader.followBtn.layer.borderColor = [MAINCOLOR CGColor];
////        self.tableViewHeader.followBtn.layer.borderWidth = 1;
//    }
}


- (void)setupNav{
    
    if (self.isShowHistoryBtn) {
        @weakify(self)
        [self rigBtn:@"历史" Withimage:nil With:^(UIButton *sender) {
            @strongify(self)
            FollowModel * model = [[FollowModel alloc] init];
            model.parentMemberId = [self.model.parentMemberId integerValue];
            model.referrerId = self.model.referrerId;
            HistoryArticleViewController *historyVc = [[HistoryArticleViewController alloc] init];
            historyVc.idNum = self.ID;
            historyVc.followModel = model;
            PUSH(historyVc);
        }];
    }
    
}

- (CGFloat)heightForAttrText:(NSString *)string{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    //    paragraphStyle.lineSpacing = 2;  // 段落高度
    //    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, str.length)];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    
    CGSize attSize = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return attSize.height;
    
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailLabel.font = [UIFont systemFontOfSize:fontSize];
    detailLabel.text = value;
    detailLabel.numberOfLines = 0;
    CGSize deSize = [detailLabel sizeThatFits:CGSizeMake(width,1)];
    return deSize.height;
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSString *javascript = @"var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=0.7, maximum-scale=1.0, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);";

    [webView evaluateJavaScript:javascript completionHandler:nil];
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    NSString * urlStr = navigationResponse.response.URL.absoluteString;
//    NSLog(@"当前跳转地址：%@",urlStr);
    //允许跳转
//    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    decisionHandler(WKNavigationResponsePolicyCancel);
}

#pragma mark 懒加载
-(void)buildbottomView {
    
    UIView *bottomView = [[UIView alloc]init];
    
    CGFloat bottomViewHeight;
    
    if (IS_IPHONEX) {
        bottomViewHeight = 75 + SAFE_HEIGHT;
        
        bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - bottomViewHeight + SAFE_HEIGHT, SCREEN_WIDTH, bottomViewHeight);
    }else{
        bottomViewHeight = 75;
        
        bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - bottomViewHeight, SCREEN_WIDTH, bottomViewHeight);
    }
    
    self.bottonView = bottomView;
    bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:bottomView];
    
    self.creattimelab = [[UILabel alloc]init];
    self.creattimelab.font = FONT(15);
    self.creattimelab.textColor = [UIColor darkGrayColor];
    [bottomView addSubview:self.creattimelab];
    
    self.sawcountlab = [[UILabel alloc]init];
    self.sawcountlab.font = FONT(13);
    self.sawcountlab.textColor = [UIColor darkGrayColor];
    [bottomView addSubview:self.sawcountlab];
    
    UIImageView *sawimgv = [[UIImageView alloc]initWithImage:IMAGE(@"看")];
    [bottomView addSubview:sawimgv];
    sawimgv.contentMode = UIViewContentModeScaleAspectFit;
    UIButton *zanBtn = [[UIButton alloc] init];
    self.zanBtn = zanBtn;
    [zanBtn setImage:[[CPTThemeConfig shareManager] XSTJdetailZanImage] forState:UIControlStateNormal];
    //    [zanBtn setImage:IMAGE(@"赞_b")forState:UIControlStateSelected];
    [zanBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [zanBtn addTarget:self action:@selector(didClickZanBtn:) forControlEvents:UIControlEventTouchUpInside];
    zanBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [bottomView addSubview:zanBtn];
    
    UILabel *zanNumLbl = [[UILabel alloc] init];
    zanNumLbl.textColor = [UIColor darkGrayColor];
    zanNumLbl.font = [UIFont systemFontOfSize:13];
    self.zanNumLbl = zanNumLbl;
    [bottomView addSubview:zanNumLbl];
    
    UIButton *remarkButton = [[UIButton alloc] init];
    [remarkButton setTitle:@"评 论" forState: UIControlStateNormal];
    [remarkButton setTitleColor:[[CPTThemeConfig shareManager] xinshuiRemarkTitleColor] forState:UIControlStateNormal];
    remarkButton.titleLabel.font = [UIFont systemFontOfSize:14];
    if (IS_IPHONEX) {
        remarkButton.titleEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
        remarkButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    remarkButton.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];
    [remarkButton addTarget:self action:@selector(remarkArticle) forControlEvents:UIControlEventTouchUpInside];
    
//    UIView *line = [[UIView alloc] init];
//    line.backgroundColor = [[CPTThemeConfig shareManager] xinshuiBottomVeiwSepeLineColor];
//    [bottomView addSubview:line];

    
    UIButton *joinRoomButton = [[UIButton alloc] init];
    [joinRoomButton setTitle:@"聊天室" forState: UIControlStateNormal];
    [joinRoomButton setTitleColor:[[CPTThemeConfig shareManager] xinshuiRemarkTitleColor] forState:UIControlStateNormal];
    joinRoomButton.titleLabel.font = [UIFont systemFontOfSize:14];
    if (IS_IPHONEX) {
        joinRoomButton.titleEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
        joinRoomButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    joinRoomButton.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];
    [joinRoomButton addTarget:self action:@selector(joinChatRoom) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:joinRoomButton];
    [bottomView addSubview:remarkButton];
    
    [self.creattimelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bottomView).offset(10);
        make.top.equalTo(bottomView).offset(5);
        //        make.centerY.equalTo(self.bottonView);
        make.height.equalTo(@(30));
    }];
    
    [self.sawcountlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.creattimelab);
        make.right.equalTo(self.bottonView).mas_offset(-10);
        
    }];
    
    [sawimgv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.sawcountlab.mas_left).offset(-5);
        make.centerY.equalTo(self.creattimelab);
        make.height.with.equalTo(@15);
    }];
    
    [zanNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.sawcountlab.mas_top);
        make.centerY.equalTo(self.creattimelab);
        make.right.equalTo(sawimgv.mas_left).offset(-20);
    }];
    
    [zanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(sawimgv.mas_top);
        make.centerY.equalTo(self.creattimelab);
        make.height.with.equalTo(@25);
        make.right.equalTo(zanNumLbl.mas_left).offset(-5);
    }];
    
    [remarkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView);
        make.left.equalTo(bottomView);
        make.width.equalTo(@(SCREEN_WIDTH/2 - 1));
        make.top.equalTo(self.creattimelab.mas_bottom).offset(0);
    }];
    
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(remarkButton.mas_right);
//        make.top.equalTo(remarkButton.mas_top).offset(5);
//        make.bottom.equalTo(remarkButton.mas_bottom).offset(-5);
//        make.width.equalTo(@1);
//    }];
    [joinRoomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(remarkButton.mas_right).offset(1);
        make.right.equalTo(bottomView.mas_right);
        make.top.equalTo(remarkButton.mas_top);
        make.bottom.equalTo(remarkButton.mas_bottom);
    }];
}

- (NSMutableArray *)remarkData{
    if (!_remarkData) {
        _remarkData = [NSMutableArray arrayWithCapacity:5];
    }
    return _remarkData;
}

- (XinShuiRecommentTopResultVeiw *)resultView{
    if (!_resultView) {
        _resultView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([XinShuiRecommentTopResultVeiw class]) owner:self options:nil]firstObject];
        _resultView.delegate = self;
        _resultView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 115);
        
    }
    
    return _resultView;
}

- (UITableView *)remarkTableView{
    if (!_remarkTableView) {
        _remarkTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _remarkTableView;
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

- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _coverView.backgroundColor = [UIColor colorWithHex:@"000000" Withalpha:0.5];
        
        [_coverView addSubview:self.toupiaoContentView];
        
    }
    
    return _coverView;
}


- (NSMutableArray *)toupiaoArray{
    if(!_toupiaoArray){
        _toupiaoArray = [NSMutableArray arrayWithCapacity:12];
    }
    return _toupiaoArray;
}

@end

