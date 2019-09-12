//
//  CircleDetailViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/7/2.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//圈子

#import "CircleDetailViewController.h"
#import "MainTouchTableView.h"
#import "UIViewController+BackItem.h"
#import "CircleNotificationCell.h"
#import "HomeSectionTitleView.h"
#import "YHContainerTableViewCell.h"
#import "PostCirCleCtrl.h"
#import "CircleUserCenterCtrl.h"
#import "CircleListPostViewController.h"
#import "LoginAlertViewController.h"
#import "JJScrollTextLable.h"

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(1125, 2436),[[UIScreen mainScreen]currentMode].size):NO)

static NSString *listCellID = @"listCell";

@interface CircleDetailViewController () <UITableViewDelegate, UITableViewDataSource, YHDContainerCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *sectionView;
/// tag: 0最新发表  1我的关注  2 回复我的
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns;
@property (weak, nonatomic) IBOutlet UIView *btnsBackView;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineView_left;

@property (nonatomic, strong) YHContainerTableViewCell *containerCell;

/** <#Description#> */
@property (assign, nonatomic) NSInteger selectedIndex;

@property (weak, nonatomic) IBOutlet UIImageView *headimgv;

@property (weak, nonatomic) IBOutlet UILabel *numbercountlab;

@property (weak, nonatomic) IBOutlet UILabel *circlecountlab;

@property (weak, nonatomic) IBOutlet UIImageView *headbgimgv;

@property (weak, nonatomic) IBOutlet UIView *noticbgView;

@property (weak, nonatomic) IBOutlet UIImageView *labaImage;
@property (nonatomic, copy) NSString *rulestring;

@property (nonatomic, assign) NSInteger attentioncount;

@property (nonatomic, assign) NSInteger replycount;

@property (nonatomic, strong)RKNotificationHub *attentionHub;

@property (nonatomic, strong)RKNotificationHub *replyHub;
@property (weak, nonatomic) IBOutlet UIView *topBackView;

@property (nonatomic, strong)UIView *navigationBarLine;
@property (weak, nonatomic) IBOutlet UILabel *personCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *articleLbl;

@property (strong, nonatomic) JJScorllTextLable *scorllLabel;


@end

@implementation CircleDetailViewController


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[CPTThemeConfig shareManager] RootVC_ViewBackgroundC];
    
    self.labaImage.image = IMAGE([[CPTThemeConfig shareManager] quanziLaBaImage]);
    self.headbgimgv.image = [[CPTThemeConfig shareManager] IM_CircleDetailHeadImage];
    self.personCountLbl.textColor = self.articleLbl.textColor = [[CPTThemeConfig shareManager] PersonCountTextColor];
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }

    for (UIButton *btn in self.btns) {  
        [btn setTitleColor:[[CPTThemeConfig shareManager] Circle_Post_titleSelectColor] forState:UIControlStateSelected];
        [btn setTitleColor:[[CPTThemeConfig shareManager] Circle_Post_titleNormolColor] forState:UIControlStateNormal];

    }
    
    UIView *backgroundView = [self.navigationController.navigationBar subviews].firstObject;
    self.navigationBarLine = backgroundView.subviews.firstObject;
    self.navigationBarLine.hidden = YES;
    
    self.canScroll = YES;
    self.numbercountlab.textColor = HomeMainWhiteColor;
    self.btnsBackView.backgroundColor = [[CPTThemeConfig shareManager] Circle_HeadView_BackgroundC];
    self.lineView.backgroundColor = [[CPTThemeConfig shareManager] Circle_Line_BackgroundC];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [[CPTThemeConfig shareManager] RootVC_ViewBackgroundC];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.565625 + 0);
    self.tableView.tableHeaderView = self.topView;
    [self.tableView registerClass:[YHContainerTableViewCell class] forCellReuseIdentifier:listCellID];
    
    [self rj_setUpWhiteBackNavBarItem];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];

    
    [self.headimgv sd_setImageWithURL:IMAGEPATH([Person person].heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[[[CPTThemeConfig shareManager] PostCircleImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(postCircle)];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    UIButton *attentionbtn = self.btns[1];
    UIButton *replybtn = self.btns[2];
    
    self.attentionHub = [[RKNotificationHub alloc]initWithView:attentionbtn];
    self.attentionHub.hubcolor = [UIColor redColor];
    attentionbtn.clipsToBounds = NO;
    [self.attentionHub moveCircleByX:5 Y:5];
    
    self.replyHub = [[RKNotificationHub alloc]initWithView:replybtn];
    self.replyHub.hubcolor = [UIColor redColor];
    replybtn.clipsToBounds = NO;
    [self.replyHub moveCircleByX:5 Y:5];
    
    self.noticbgView.backgroundColor = [[CPTThemeConfig shareManager]  Circle_HeadView_NoticeView_BackgroundC];
    self.noticbgView.layer.masksToBounds = YES;
    self.noticbgView.layer.cornerRadius = 20;
  
    [self initdata];

    @weakify(self)
    [self.headimgv tapHandle:^{
        @strongify(self)
        [self tapHeadImageV];
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self)
        [self refreshCirclelistData];
        [self initCountData];

    }];
    
}

-(void)initdata{
    
    [self initCountData];
    [self initRulesData];
    [self initfocusnumData];
    [self initreplynumData];
}
- (void)tapHeadImageV{
    if ([Person person].uid == nil) {
        
        
        CircleUserCenterCtrl *user = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleUserCenterCtrl"];
        
        user.title = @"我的圈子";
        
        user.replynum = self.replycount;
        
        [self.navigationController pushViewController:user animated:YES];
//        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
//        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//
//        [self presentViewController:login animated:YES completion:^{
//        }];
//
//        login.loginBlock = ^(BOOL result) {
//            if (result) {
//            }
//        };
        
//        LoginCtrl *login = [[LoginCtrl alloc]initWithNibName:NSStringFromClass([LoginCtrl class]) bundle:[NSBundle mainBundle]];
//
//        login.loginBlock = ^(BOOL result) {
//
//            if (result) {
//
//                CircleUserCenterCtrl *user = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleUserCenterCtrl"];
//
//                user.title = @"我的圈子";
//
//                user.replynum = self.replycount;
//
//                [self.navigationController pushViewController:user animated:YES];
//            }
//        };
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
//
//        nav.navigationBar.hidden = YES;
//
//        [self presentViewController:nav animated:YES completion:nil];
    }
    else{
        CircleUserCenterCtrl *user = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleUserCenterCtrl"];
        
        user.title = @"我的圈子";
        
        user.replynum = self.replycount;
        
        [self.navigationController pushViewController:user animated:YES];
    }
}

// MARK: 切换
- (IBAction)swiftBtnAction:(UIButton *)sender {
    
    self.containerCell.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * sender.tag, 0);
    
    [self mmtdOptionalScrollViewDidEndDecelerating:self.containerCell.scrollView];
    
    if (sender.tag == 2) {
        self.replycount = 0;
        self.replyHub.count = 0;
    }
}

#pragma mark - Notification
- (void)changeScrollStatus {
    self.canScroll = YES;
    self.containerCell.objectCanScroll = NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    if(self.scorllLabel){
        [self.scorllLabel start];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationBarLine.hidden = NO;
    [self.scorllLabel stop];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UIScreen mainScreen].bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;// - [UIScreen mainScreen].bounds.size.width * (370.0 / 750);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.sectionView.backgroundColor = [[CPTThemeConfig shareManager] Circle_HeadView_BackgroundC];
    return self.sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHContainerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listCellID];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.contentView.backgroundColor = [UIColor yellowColor];//MAINCOLOR;//[UIColor whiteColor];
//    cell.backgroundColor = [UIColor redColor];
    //添加pageView
    self.containerCell = cell;
    cell.superViewController = self;
    cell.selectindex = self.selectedIndex;
    cell.delegate = self;
    cell.scrollView.contentOffset = CGPointMake(self.selectedIndex * SCREEN_WIDTH, 0);
    return cell;
}


#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        
        CGFloat offset = 64;
        if (iPhoneX) {
            offset = 88;
        }
        CGFloat bottomCellOffset = [self.tableView rectForSection:0].origin.y - offset;
        bottomCellOffset = floorf(bottomCellOffset);
        
        if (scrollView.contentOffset.y >= bottomCellOffset) {
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            if (self.canScroll) {
                self.canScroll = NO;
                self.containerCell.objectCanScroll = YES;
                [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
                self.title = @"晒单圈";
                self.navigationBarLine.hidden = NO;
            }
            
        }else{
            //子视图没到顶部
            if (!self.canScroll) {
                scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            } else {
                self.navigationBarLine.hidden = YES;

                [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
                self.title = @"";
            }
            
        }
    }
    
}

//- (HomeSectionTitleView *)sectionView {
//    if (!_sectionView) {
//        _sectionView = [[HomeSectionTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
//        __weak typeof(self) weakSelf = self;
//        [_sectionView setBlock:^(NSInteger index) {
//            weakSelf.selectedIndex = index;
//            weakSelf.containerCell.isSelectIndex = YES;
//            [weakSelf.containerCell.scrollView setContentOffset:CGPointMake(index*[UIScreen mainScreen].bounds.size.width, 0) animated:YES];
//        }];
//    }
//    return _sectionView;
//}

#pragma mark - YHDContainerCellDelegate

- (void)mmtdOptionalScrollViewDidScroll:(UIScrollView *)scrollView {
    self.tableView.scrollEnabled = NO;
    
    
}

- (void)mmtdOptionalScrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger page = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;

    self.selectedIndex = page;
    self.containerCell.selectindex = page;
    UIButton *sender = [self.btns objectAtIndex:page];
    for (UIButton *btn in self.btns) {
        btn.selected = sender.tag == btn.tag;
    }
    self.lineView_left.constant = sender.x + 12 ;
    self.tableView.scrollEnabled = YES;
    
    if (self.selectedIndex == 2) {
        
        [self refreshCirclelistData];
    }
}

-(void)postCircle {
    
    PostCirCleCtrl *post = [[PostCirCleCtrl alloc]init];
    @weakify(self)
    post.updatacircleBlock = ^{
        @strongify(self)
        CircleListPostViewController *vc = [self.containerCell.vcArray objectAtIndex:0];
        sleep(1.0);
        [vc refreshData];
        [self initCountData];
    };
    [self.navigationController pushViewController:post animated:YES];
}

#pragma mark - 获取人数和发帖人数
-(void)initCountData {
    @weakify(self)
    [WebTools postWithURL:@"/circle/getPostNumAndAccountNum" params:nil success:^(BaseData *data) {
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        @strongify(self)
        self.numbercountlab.text = [data.data[@"accountNum"] stringValue];
        self.circlecountlab.text = [data.data[@"postNum"] stringValue];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 获取规则
-(void)initRulesData {
    @weakify(self)
    [WebTools postWithURL:@"/circle/getCircleRules" params:nil success:^(BaseData *data) {
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        @strongify(self)

        self.rulestring = [data.data valueForKey:@"content"];
        [self scorllTextLabel];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)scorllTextLabel {
    JJScorllTextLable *scorllLabel = [[JJScorllTextLable alloc] initWithFrame:CGRectMake(35, 0, SCREEN_WIDTH - 35 -20, 40)];
    scorllLabel.text = self.rulestring;
    scorllLabel.textColor = [UIColor whiteColor];
    scorllLabel.font = [UIFont systemFontOfSize:12];
    [self.noticbgView addSubview:scorllLabel];
    _scorllLabel = scorllLabel;
}

#pragma mark - 获取我的关注人数
-(void)initfocusnumData {
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/getFocusMsgNumOrReplyNum" params:@{@"type":@(1)} success:^(BaseData *data) {
        @strongify(self)

        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        self.attentioncount = [data.data[@"msgNumber"]integerValue];;
        
        self.attentionHub.count = self.attentioncount;
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 获取回复我的人数
-(void)initreplynumData {
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/getFocusMsgNumOrReplyNum" params:@{@"type":@(2)} success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        self.replycount = [data.data[@"msgNumber"]integerValue];
        self.replyHub.count = self.replycount;
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(void)refreshCirclelistData {
    
    CircleListPostViewController *vc = [self.containerCell.vcArray objectAtIndex:self.selectedIndex];
   
    [vc refreshData];
    
    [self.tableView.mj_header endRefreshing];
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//
//    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
//}

@end
