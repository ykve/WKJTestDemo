//
//  HomeCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CPTHomeCtrl.h"
#import "HomeHeaderViewNew.h"
#import "HomeFootView.h"
#import "HomeCell.h"
#import "NoticeView.h"
#import "HomeBottom.h"
#import "HKShareViewViewController.h"
#import "HobbyCtrl.h"
#import "ActiveListCtrl.h"
#import "HistoryLotteryCtrl.h"
#import "MissCtrl.h"
#import "TodayStatisticsCtrl.h"
#import "FreeRecommendCtrl.h"
#import "FormulaCtrl.h"
#import "SixPhotosCtrl.h"
#import "SixHelpCtrl.h"
#import "SixHistoryResultCtrl.h"
#import "SixInformationCtrl.h"
#import "SixRecommendCtrl.h"
#import "PickHelperCtrl.h"
#import "SixAIPickCtrl.h"
#import "PK10HistoryCtrl.h"
#import "PK10MissNumberCtrl.h"
#import "PK10FreeRecommendCtrl.h"
#import "PK10TodayNumberCtrl.h"
#import "PK10HotandCoolCtrl.h"
#import "SixPropertyCtrl.h"
#import "TemaHistoryCtrl.h"
#import "LastnumberCtrl.h"
#import "PK10guanyahetongjiCtrl.h"
#import "PK10TwoFaceCtrl.h"
#import "PK10guanyahelistCtrl.h"
#import "PK10TwoFaceMissCtrl.h"
#import "PK10TwoFaceLuzhuCtrl.h"
#import "PK10TwoFaceLuzhulistCtrl.h"
#import "SixPieCtrl.h"
#import "SixBarCtrl.h"
#import "GraphCtrl.h"
#import "PCHistoryCtrl.h"
#import "PCNumberTrendCtrl.h"
#import "PCFreeRecommendCtrl.h"
#import "PCTodayStatisticsCtrl.h"
#import "PK10VersionTrendCtrl.h"
#import "AdvertModel.h"
#import "IGKbetModel.h"
#import "UpdateVersionView.h"
#import "AppDelegate.h"
#import "ShareViewController.h"
#import "MessageModel.h"
#import "ListNoticeViewController.h"
#import "ListNoticeView.h"
#import "CPTWebViewController.h"
#import "LiuHeDaShenViewController.h"
#import "LoginAlertViewController.h"
#import "FootBallPlanCtrl.h"
#import "LiveOpenLotteryViewController.h"
#import "TiaomazhushouVC.h"
#import "IGKbetListCtrl.h"
#import "KeFuViewController.h"
#import "TopUpViewController.h"
#import "CPTBuyDataManager.h"
#import "CPTBuyRootVC.h"
#import "CPTBuySexViewController.h"
#import "CartHomeModel.h"
#import "CPTBuyFantanCtrl.h"
#import "FavoriteListVC.h"
#import "ActivityVC.h"
#import <SafariServices/SafariServices.h>
#import "CPTChangLongController.h"
#import "ChatRoomCtrl.h"
#import "GetOutViewController.h"
#import "HomeHongBaoAlertView.h"
#import "HomeActivityAlertView.h"
#import "DaShenViewController.h"
#import "ActivityDetailVC.h"
#import "CPTInfoManager.h"
#import "SixArticleDetailViewController.h"
#import "CircleDetailViewController.h"
//#import "FBShimmeringView.h"
#import <SDWebImage/UIImage+GIF.h>
#import "AdView.h"
#import "JJScrollTextLable.h"
#import "PublicInterfaceTool.h"



@interface CPTHomeCtrl ()<WB_StopWatchDelegate, HomeHeaderViewNewDelegate,HomeBottomViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) NSInteger icon_Number;

@property (nonatomic, strong) UICollectionView *collectView;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, retain) NSIndexPath *indexPath;

@property (nonatomic, retain) NSMutableArray *sectionAry;

@property (nonatomic, assign) BOOL showall;
/**
 轮播图片集
 */
@property (nonatomic, strong) NSMutableArray *advertimgs;

/**
 底部图片集
 */
@property (nonatomic, strong) NSMutableArray *bottomimgs;

@property (nonatomic, strong) NSArray *bottomArray;
/**
 距离截止时间模型
 */
@property (nonatomic, strong) IGKbetModel *endtimemodel;

@property (nonatomic, assign) NSInteger curenttime;

@property (nonatomic, strong) NSMutableString *scorllLabelString;


@property (nonatomic, strong) NSMutableArray *ltData;
@property (strong, nonatomic) NSMutableArray *favData;
@property(strong, nonatomic) CrartHomeSubModel *settingModel;

//@property (nonatomic, strong) FBShimmeringView *shimmeringView;
@property (nonatomic, strong) UILabel *logoLabel;
@property (nonatomic, assign) CGFloat panStartValue;;
@property (nonatomic, assign) BOOL panVertical;
@property (nonatomic, strong) AdView  *adView;

@property (strong, nonatomic) JJScorllTextLable *scorllLabel;
@property (strong, nonatomic) HomeHeaderViewNew *myheader;
@end

@implementation CPTHomeCtrl

-(UICollectionViewFlowLayout *)layout {
    
    if (!_layout) {
        CGFloat itemSpace = 0;
        
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        _layout.minimumInteritemSpacing = itemSpace;
        
        _layout.minimumLineSpacing = itemSpace;
        
        CGFloat itemWidth = (SCREEN_WIDTH - itemSpace * (self.icon_Number - 1)) / self.icon_Number;
        
        _layout.itemSize = CGSizeMake(itemWidth, 110);
        
        _layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 30 + SCREEN_WIDTH * 0.4 + 10);
    }
    
    return _layout;
}

-(UICollectionView *)collectView {
    
    if (!_collectView) {
        
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        
        //        _collectView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_ADCollectionViewCell_Back];//[[CPTThemeConfig shareManager] HomeViewBackgroundColor];
        _collectView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_Cell_ViewBack];
        
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:RJCellIdentifier];
        
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeBottom class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:XMFHomeAdCollectionViewCell];
        
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeHeaderViewNew class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RJHeaderIdentifier];
        
        [_collectView registerClass:[HomeFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:RJFooterIdentifier];
        _collectView.showsVerticalScrollIndicator = NO;
        
        _collectView.delegate = self;
        
        _collectView.dataSource = self;
        
        [self.view addSubview:_collectView];
        [_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT, 0, 0, 0));
        }];
    }
    return _collectView;
}



- (CrartHomeSubModel *)settingModel{
    if(!_settingModel){
        _settingModel = [[CrartHomeSubModel alloc] init];
        _settingModel.name = @"更多彩种";
        _settingModel.isWork = 1;
        _settingModel.lotteryId = 999;
    }
    return _settingModel;
}

-(NSMutableArray *)ltData {
    
    if(!_ltData){
        
        _ltData = [[NSMutableArray alloc]init];
    }
    return _ltData;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;

    if(self.adView){
        [self.adView startScroll];
    }
    if (_scorllLabel && !_scorllLabel.timer) {
        [self.scorllLabel start];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    HomeHeaderViewNew *header = [self.collectView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RJHeaderIdentifier forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if(self.myheader){
        [self.myheader checkMoney];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];

    if(self.adView){
        [self.adView endScroll];
    }
    [self.scorllLabel stop];
}

-(void)getlistNoticeData {
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/listNotice.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        NSMutableArray * a = [MessageModel mj_objectArrayWithKeyValuesArray:data.data];
        NSMutableArray * tmp = [NSMutableArray array];
        for(NSInteger i=0;i<a.count;i++){
            MessageModel * model = a[i];
            if(model.popup){
                [tmp addObject:model];
            }
        }
        if(tmp.count<0){
            return ;
        }
        //        [self.tableView reloadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            ListNoticeView *vc = [[[NSBundle mainBundle]loadNibNamed:@"ListNoticeView" owner:self options:nil]firstObject];
            vc.models = tmp;
            vc.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [vc uiSet];
            [vc show];
            
        });
        
    } failure:^(NSError *error) {
        
    }];
    
    //    });
    
}

- (void)dealloc {
    MBLog(@"%s dealloc",object_getClassName(self));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadFFData{
    [self configData];
    [self.collectView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[CPTThemeConfig shareManager] HomeViewBackgroundColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFFData) name:@"reloadFFData" object:nil];

    self.icon_Number = 3;

    [self getnewversion];
    [self getlistNoticeData];
    
    
    [self setNavUI];
    [self getPlist];
    [self configData];
    [self advertData];
    [self bottomadvertData];
    [self noticeData];
    [self initLtData];
    [self initActivityData];
    
    
    [[CPTInfoManager shareManager] checkModelCallBack:^(CPTInfoModel * _Nonnull model, BOOL isSuccess) {
        
    }];
    
    
    @weakify(self)
    self.collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self noticeData];
    }];
    
    if([[AppDelegate shareapp] wkjScheme] != Scheme_LitterFish){
        [self switchView];
    }

    if([[AppDelegate shareapp] wkjScheme] == Scheme_LotterProduct || [[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
        [self switchThemeView];
    }
    
}

- (void)setNavUI {
    
    [self setmenuBtn:[[CPTThemeConfig shareManager] IC_Nav_SideImageStr]];
    @weakify(self)
    if ([AppDelegate shareapp].wkjScheme == Scheme_LotterProduct) {
        [self rigBtnImage:[[CPTThemeConfig shareManager] IC_Nav_ActivityImageStr] With:^(UIButton *sender) {
            @strongify(self)
            ActivityVC * vc = [[ActivityVC alloc] init];
            PUSH(vc);
        }];
    } else {
        [self rigBtn:@"活动" Withimage:nil With:^(UIButton *sender) {
            ActivityVC * vc = [[ActivityVC alloc] init];
            PUSH(vc);
        }];
    }
    
    
    UIImage *titleimg = [[CPTThemeConfig shareManager] IM_Nav_TitleImage_Logo];
    
    UIImageView *imgv = [[UIImageView alloc]initWithImage:titleimg];
    [self.navView addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.rightBtn);
        make.centerX.equalTo(self.navView);
        make.size.mas_equalTo(CGSizeMake(imgv.image.size.width, imgv.image.size.height));
    }];
}

- (void)getPlist {
    NSArray *aPlist = [Tools readDataFromPlistFile:@"favoritelist.plist"];
    if(aPlist){
        if(aPlist.count>0){
            [self.favData addObjectsFromArray:aPlist];
        }else{
            NSArray * bPlist = [Tools readDataFromBundle:@"favoritelist.plist"];
            [self.favData addObjectsFromArray:bPlist];
        }
    }else{
        NSArray *bbb = [Tools readDataFromBundle:@"favoritelist.plist"];
        [self.favData addObjectsFromArray:bbb];
    }
}


- (void)switchThemeView {
    
    BOOL isTheme = [[[NSUserDefaults standardUserDefaults] valueForKey:WKJTheme_ThemeType] boolValue];
    
    UIButton *switchThemeBtn = [[UIButton alloc] init];
    [switchThemeBtn addTarget:self action:@selector(onSwitchThemeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if (isTheme) {
        [switchThemeBtn setBackgroundImage:[UIImage imageNamed:@"td_home_theme_switch"] forState:UIControlStateNormal];
    } else {
         [switchThemeBtn setBackgroundImage:[UIImage imageNamed:@"tw_home_theme_switch"] forState:UIControlStateNormal];
    }
    
    switchThemeBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:switchThemeBtn];
    [switchThemeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(Height_NavBar + 15);
        make.right.mas_equalTo(self.view.mas_right);
        make.size.mas_equalTo(CGSizeMake(69, 32));
    }];

    [self.view bringSubviewToFront:switchThemeBtn];
 
}

- (void)onSwitchThemeBtn:(UIButton *)sender {
    if(self.adView){
        [self.adView endScroll];
    }
    [self.scorllLabel stop];
    BOOL isTheme = [[[NSUserDefaults standardUserDefaults] valueForKey:WKJTheme_ThemeType] boolValue];
    
    if(!isTheme) {
        [sender setBackgroundImage:[UIImage imageNamed:@"td_home_theme_switch"] forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"tw_home_theme_switch"] forState:UIControlStateNormal];
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:@(!isTheme) forKey:WKJTheme_ThemeType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[AppDelegate shareapp] setThemeSkin];
    
    [[AppDelegate shareapp] clearRootVC];
    [[AppDelegate shareapp] setmainroot];
}

- (void)switchView {
    
    NSString *gifImgName;
    if([AppDelegate shareapp].homeType == HomeSwitchTypeInfo){
        gifImgName = @"home_switch_buylot";
    }else{
        gifImgName = @"home_switch_news";
    }
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        gifImgName= [NSString stringWithFormat:@"tw_%@",gifImgName];
    }
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:gifImgName ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    UIImage *image = [UIImage sd_animatedGIFWithData:imageData];
    
    UIButton *switchBtn = [[UIButton alloc] init];
//    [switchBtn setTitle:@"切换购彩版" forState:UIControlStateNormal];
    [switchBtn addTarget:self action:@selector(changeToBuy:) forControlEvents:UIControlEventTouchUpInside];
//    switchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    [switchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [switchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//    [switchBtn setBackgroundImage:[UIImage imageNamed:@"home_switch_backView"] forState:UIControlStateNormal];
     [switchBtn setBackgroundImage:image forState:UIControlStateNormal];
    switchBtn.backgroundColor = [UIColor clearColor];
    //    switchBtn.layer.borderWidth = 1.0;
    //    switchBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    //    switchBtn.layer.cornerRadius = 5;
    [self.view addSubview:switchBtn];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(Height_NavBar + 15);
        make.left.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(64, 50));
    }];
    
    
    
//    _shimmeringView = [[FBShimmeringView alloc] init];
//    _shimmeringView.shimmering = YES;
//    _shimmeringView.shimmeringBeginFadeDuration = 0.5;
//    _shimmeringView.shimmeringOpacity = 0.8;
//    [switchBtn addSubview:_shimmeringView];
//
//    _logoLabel = [[UILabel alloc] initWithFrame:_shimmeringView.bounds];
//    _logoLabel.text = @"切换购彩版 >";
//    _logoLabel.font = [UIFont systemFontOfSize:12.0];
//    _logoLabel.textColor = [UIColor whiteColor];
//    _logoLabel.textAlignment = NSTextAlignmentCenter;
//    _logoLabel.backgroundColor = [UIColor clearColor];
//    _shimmeringView.contentView = _logoLabel;
//
//
//    [_shimmeringView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.right.equalTo(switchBtn);
//    }];
//
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeToBuy)];
//    [_shimmeringView addGestureRecognizer:tapRecognizer];
    
    
//    UIImageView *iconImageView = [[UIImageView alloc] init];
//    iconImageView.image = [UIImage imageNamed:@"home_rightz_arrow"];
//    [switchBtn addSubview:iconImageView];
//
//    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(switchBtn.mas_centerY);
//        make.right.mas_equalTo(switchBtn.mas_right).offset(-4);
//        make.size.mas_equalTo(CGSizeMake(6, 10));
//    }];
    [self.view bringSubviewToFront:switchBtn];
    
    
    
    
    
    
    
    
    
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"home_switch" ofType:@"gif"];
//    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
//    UIImage *image = [UIImage sd_animatedGIFWithData:imageData];
//
//    UIImageView *backImageView = [[UIImageView alloc] init];
//    backImageView.image = image;
//    [self.view addSubview:backImageView];
//
//    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view.mas_top).offset(Height_NavBar + 15);
//        make.right.mas_equalTo(self.view.mas_right);
//        make.size.mas_equalTo(CGSizeMake(90, 26));
//    }];
//    [self.view bringSubviewToFront:backImageView];
}




-(NSMutableArray *)favData {
    if(!_favData){
        _favData = [[NSMutableArray alloc]init];
    }
    return _favData;
}

-(void)configData {
    [self.dataSource removeAllObjects];
    switch ([AppDelegate shareapp].homeType) {
        case HomeSwitchTypeInfo:
        {
            self.icon_Number = 3;
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            
            if ([userDefault valueForKey:LOTTERYTYPE]) {
                
                NSArray *array = [userDefault valueForKey:LOTTERYTYPE];
                
                NSMutableArray *newArray = [NSMutableArray array];
                for (NSDictionary *dict in array) {
                    
                    NSString *iconStr;
                    int lotteryId = [dict[@"ID"] intValue];
                    
                    switch (lotteryId) {
                        case 1:
                            iconStr = [[CPTThemeConfig shareManager] IC_Home_CQSSC];
                            break;
                        case 2:
                            iconStr = [[CPTThemeConfig shareManager] IC_Home_XJSSC];
                            break;
                        case 3:
                            iconStr = [[CPTThemeConfig shareManager] IC_Home_TXFFC];
                            break;
                        case 4:
                            iconStr = [[CPTThemeConfig shareManager] IC_Home_LHC];
                            break;
                        case 5:
                            iconStr = [[CPTThemeConfig shareManager] IC_Home_PCDD];
                            break;
                        case 6:
                            iconStr = [[CPTThemeConfig shareManager] IC_Home_BJPK10];
                            break;
                        case 7:
                            iconStr = [[CPTThemeConfig shareManager] IC_Home_XYFT];
                            break;
                        case 9:
                            iconStr = [[CPTThemeConfig shareManager] IC_Home_ZCZX];
                            break;
                        case 11:
                            iconStr = [[CPTThemeConfig shareManager] IC_Home_AZF1SC];
                            break;
                        default:
                            break;
                    }
                    
                    
                    NSDictionary *newDic = @{@"ID" : dict[@"ID"],@"select" : dict[@"select"], @"subtitle" : dict[@"subtitle"],@"title":dict[@"title"], @"icon" : iconStr};
                    
                    [newArray addObject:newDic];
                }
                [self.dataSource addObjectsFromArray:newArray];
                
                [self.dataSource addObject:@{@"title":@"更多彩种",@"ID":@(999),@"icon":[[CPTThemeConfig shareManager] IC_Home_GDCZ],@"subtitle":@"好挣好玩",@"hotTitle":@""}];
                
            } else {
                    NSArray *array = @[@{@"title":@"六合彩",@"ID":@(4),@"icon":[[CPTThemeConfig shareManager] IC_Home_LHC],@"subtitle":@"一周开三期",@"hotTitle":@"huo"},
                                       @{@"title":@"北京PK10",@"ID":@(6),@"icon":[[CPTThemeConfig shareManager] IC_Home_BJPK10],@"subtitle":@"全天44期",@"hotTitle":@"huo"},
                                       @{@"title":@"更多彩种",@"ID":@(999),@"icon":[[CPTThemeConfig shareManager] IC_Home_GDCZ],@"subtitle":@"好挣好玩",@"hotTitle":@""}];
                    [self.dataSource addObjectsFromArray:array];
                
            }
        }
            break;
        case HomeSwitchTypeBuy:
        {
            self.icon_Number = 4;
            if(![self.favData containsObject:self.settingModel]){
                [self.favData addObject:self.settingModel];
            }
            [self.dataSource addObjectsFromArray:self.favData];
            
        }
            break;
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.dataSource.count%self.icon_Number == 0) {
        return (self.dataSource.count + self.icon_Number - 1) / self.icon_Number + 1 ;
    }else if(self.dataSource.count%self.icon_Number == 1){
        return (self.dataSource.count + self.icon_Number - 1) / self.icon_Number + 1;
    }else{
        return (self.dataSource.count + self.icon_Number - 1) / self.icon_Number + 1 ;
    }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //如果数组中有元素的时候走下面方法
    if (self.dataSource.count > 0) {
        
        //找到最后一个分区
        if (section == (self.dataSource.count + self.icon_Number - 1) / self.icon_Number-1) {
            
            //如果能被每行的个数整除
            if (self.dataSource.count % self.icon_Number == 0) {
                //返回每行的个数
                return self.icon_Number;
            }
            
            //不然返回元素个数对每行个数的取余数
            //            return self.dataSource.count % self.icon_Number;
            return self.icon_Number;
            
        }else if (section == (self.dataSource.count + self.icon_Number - 1) / self.icon_Number) {
            
            return 1;
        }
        
        //其他情况返回正常的个数
        return self.icon_Number;
        
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == (self.dataSource.count + self.icon_Number - 1) / self.icon_Number) {
        
        HomeBottom *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XMFHomeAdCollectionViewCell forIndexPath:indexPath];
        cell.delegate = self;
        cell.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_CellBackgroundColor];
        if([AppDelegate shareapp].homeType == HomeSwitchTypeBuy){
            cell.footView.hidden = NO;
        }else{
            cell.footView.hidden = NO;
        }
        return cell;
    }
    
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_CellBackgroundColor];
    if (indexPath.row + indexPath.section * self.icon_Number < self.dataSource.count ) {
        NSInteger type = indexPath.row + indexPath.section * self.icon_Number;
        id some = self.dataSource[type];
        
        if([AppDelegate shareapp].homeType == HomeSwitchTypeBuy && [some isKindOfClass:[CrartHomeSubModel class]]){
            CrartHomeSubModel * model = self.dataSource[type];
            if(model){
                cell.model = model;
                
                cell.isWorkView.hidden = model.isWork;
                NSString *imagen = model.name;
                if([imagen isEqualToString:@"更多彩种"]){
                    imagen = @"更多";
                }
                else if([imagen isEqualToString:@"排列3/5"]){
                    imagen = @"排列35";
                }
                if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
                    imagen = [NSString stringWithFormat:@"tw_%@",imagen];
                }
                cell.iconimgv.image = IMAGE(imagen);
                cell.type = model.lotteryId;
                cell.titlelab.text = model.name;
            }
            
            cell.subTitleLbl.text = @"";
            if (indexPath == self.indexPath)
            {
                if (self.isSelected) {
                    cell.isHiddened = YES;
                    cell.isSelected = YES;
                }
            }
        } else {
        
            NSDictionary *dic = self.dataSource[type];
            NSString *imagen = dic[@"title"];
            
            if([imagen isEqualToString:@"更多彩种"]){
                imagen = @"更多";
            }
            if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
                imagen = [NSString stringWithFormat:@"tw_%@",imagen];
            }
            cell.iconimgv.image = [UIImage imageNamed:imagen];
            cell.type = [dic[@"ID"] integerValue];
            cell.titlelab.text = dic[@"title"];
            cell.subTitleLbl.text = dic[@"subtitle"];
            cell.isHiddened = YES;
            cell.isSelected = YES;
            //当选中的时候让色块出现
            cell.isWorkView.hidden = YES;
            if (indexPath == self.indexPath)
            {
                if (self.isSelected) {
                    cell.isHiddened = NO;
                    cell.isSelected = NO;
                }
            }
        }
    }else{
        cell.iconimgv.image = IMAGE(@"");
        cell.titlelab.text = @"";
        cell.subTitleLbl.text = @"";
        cell.hotImgView.image = IMAGE(@"");
    }
    
    cell.hotImgView.hidden = YES;;
    
    return cell;
    
}

-(JJScorllTextLable *)scorllLabel {
    
    if (!_scorllLabel) {
        _scorllLabel = [[JJScorllTextLable alloc] initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH -(30+20), 30)];
        _scorllLabel.textColor = [[CPTThemeConfig shareManager] CO_Home_NoticeView_LabelText];
        _scorllLabel.font = [UIFont systemFontOfSize:12];

        _scorllLabel.userInteractionEnabled = YES;
        //添加tap手势 事件
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scorllLabelTap)];
        [_scorllLabel addGestureRecognizer:singleTap];
    }
    return _scorllLabel;
}

- (void)scorllLabelTap {
     [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MessageCenterViewController"] animated:YES];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    @weakify(self)
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        if (indexPath.section == 0) {
            
            HomeHeaderViewNew *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:RJHeaderIdentifier forIndexPath:indexPath];
            
            
            UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 13, 13)];
            icon.image = [UIImage imageNamed: [[CPTThemeConfig shareManager] quanziLaBaImage]];
            [header.noticeView addSubview:icon];
            [header.noticeView addSubview:self.scorllLabel];
            
            self.scorllLabel.text = self.scorllLabelString;

            
            [header loadLhcData];
            //            header.bannerView.placeholderImage = IMAGE(@"轮播图");
            header.bannerView.currentPageDotImage = [Tools createImageWithColor:WHITE Withsize:CGSizeMake(12, 2)];
            header.bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
            header.bannerView.pageDotImage = [Tools createImageWithColor:[UIColor colorWithWhite:1 alpha:0.5] Withsize:CGSizeMake(12, 2)];
            header.delegate = self;
            self.adView = header.adView;
            switch ([AppDelegate shareapp].homeType) {
                case HomeSwitchTypeBuy:
                {
                    if([AppDelegate shareapp].isBuyClose){
                        [header.touTiaoBg setHidden:YES];
                    }else{
                        [header.touTiaoBg setHidden:NO];
                    }
                    [header showBuyViewNeedReload:![AppDelegate shareapp].isBuyClose];
                    
                }
                    break;
                case HomeSwitchTypeInfo:
                {
                    if([AppDelegate shareapp].isInfoToutiaoClose){
                        [header.touTiaoBg setHidden:YES];
                    }else{
                        [header.touTiaoBg setHidden:NO];
                    }
                    [header showInfoViewNeedReload:![AppDelegate shareapp].isInfoToutiaoClose];
                }
                    break;
                default:
                    break;
            }
            //            header.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_HeadView_Back];
            
            //            header.bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
            header.bannerView.imageURLStringsGroup = self.advertimgs;
            header.bannerView.autoScrollTimeInterval = 6.0f;
            header.bannerView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_HeadView_Back];
            header.bannerView.clickItemOperationBlock = ^(NSInteger currentIndex) {
                @strongify(self)
                AdvertModel *adv = [self.dataArray objectAtIndex:currentIndex];
                
                [self advertpush:adv];
            };
            [header setClickCell:^(NSInteger index) {
                @strongify(self)
                [self toTiezi:index];
            }];
            self.myheader = header;
            return header;
        }
        else{
            return nil;
            
        }
    }
    else {
        HomeFootView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:RJFooterIdentifier forIndexPath:indexPath];
        
        footer.showall = self.showall;
        
        NSInteger data_type = self.indexPath.row + self.indexPath.section * self.icon_Number;
        
        NSDictionary *dic = self.dataSource[data_type];
        
        footer.type = [dic[@"ID"]integerValue];
        footer.footshowallBlock = ^(BOOL showall) {
            @strongify(self)
            
            self.showall = showall;
            
            [self.collectView reloadData];
        };
        
        footer.selectcontentBlock = ^(NSInteger type, NSInteger index) {
            @strongify(self)
            if (type == 1 || type == 2 || type == 3) {
                
                if (index == 0) {
                    
                    HistoryLotteryCtrl *history = [[HistoryLotteryCtrl alloc]init];
                    history.lottery_type = type;
                    PUSH(history);
                }
                else if (index == 1) {
                    
                    MissCtrl *miss = [[MissCtrl alloc]init];
                    miss.lottery_type = type;
                    PUSH(miss);
                }
                else if (index == 2) {
                    
                    TodayStatisticsCtrl *today = [[TodayStatisticsCtrl alloc]init];
                    today.lottery_type = type;
                    PUSH(today);
                }
                else if (index == 3) {
                    
                    FreeRecommendCtrl *free = [[FreeRecommendCtrl alloc]init];
                    free.lottery_type = type;
                    PUSH(free);
                }
                else if (index == 4) {
                    
                    GraphCtrl *graph = [[GraphCtrl alloc]init];
                    graph.lottery_type = type;
                    PUSH(graph);
                }
                else {
                    
                    FormulaCtrl *forumla = [[FormulaCtrl alloc]init];
                    forumla.lottery_type = type;
                    PUSH(forumla);
                }
            }
            else if (type == 4) {
                
                if (index == 3) {
                    TiaomazhushouVC*recommend = [[TiaomazhushouVC alloc]initWithNibName:@"TiaomazhushouVC" bundle:nil];
                    PUSH(recommend);
                    return;
                }
                else if(index>=4){
                    index = index -1;
                }
                if (index == 0) {
                    
                    SixHistoryResultCtrl *history = [[SixHistoryResultCtrl alloc]init];
                    history.type = 1;
                    history.lottery_oldID = 4;
                    PUSH(history);
                }
                else if (index == 1) {
                    
                    SixPhotosCtrl *photo = [[SixPhotosCtrl alloc]init];
                    photo.lottery_oldID = 4;
                    
                    PUSH(photo);
                }
                else if (index == 2) {
                    
                    SixRecommendCtrl *recommend = [[SixRecommendCtrl alloc]init];
                    recommend.lottery_oldID = 4;
                    
                    PUSH(recommend);
                    
                }
                else if (index == 3) {
                    
                    SixHelpCtrl *help = [[SixHelpCtrl alloc]init];
                    help.lottery_oldID = 4;
                    
                    PUSH(help);
                }
                else if (index == 4) {
                    
                    SixInformationCtrl *information = [[SixInformationCtrl alloc]init];
                    information.lottery_oldID = 4;
                    
                    PUSH(information);
                }
                else if (index == 5) {
                    
                    SixHistoryResultCtrl *history = [[SixHistoryResultCtrl alloc]init];
                    history.type = 2;
                    history.lottery_oldID = 4;
                    
                    PUSH(history);
                }
                else if (index == 6) {
                    
                    FormulaCtrl *formula = [[FormulaCtrl alloc]init];
                    formula.lottery_type = 4;
                    formula.lottery_oldID = 4;
                    
                    PUSH(formula);
                    
                }
                else if (index == 7) {
                    
                    SixAIPickCtrl *ai = [[SixAIPickCtrl alloc]initWithNibName:NSStringFromClass([SixAIPickCtrl class]) bundle:[NSBundle mainBundle]];
                    ai.lottery_oldID = 4;
                    PUSH(ai);
                }
                else if (index == 8) {
                    
                    SixPropertyCtrl *propertyctrl = [[SixPropertyCtrl alloc]init];
                    propertyctrl.lottery_oldID = 4;
                    
                    PUSH(propertyctrl);
                }
                else if (index == 9) {
                    
                    TemaHistoryCtrl *tema = [[TemaHistoryCtrl alloc]initWithNibName:NSStringFromClass([TemaHistoryCtrl class]) bundle:[NSBundle mainBundle]];
                    tema.lottery_oldID = 4;
                    
                    tema.type = 621;
                    PUSH(tema);
                }
                else if (index == 10) {
                    
                    TemaHistoryCtrl *tema = [[TemaHistoryCtrl alloc]initWithNibName:NSStringFromClass([TemaHistoryCtrl class]) bundle:[NSBundle mainBundle]];
                    tema.type = 622;
                    tema.lottery_oldID = 4;
                    
                    PUSH(tema);
                }
                else if (index == 11) {
                    
                    LastnumberCtrl *last = [[LastnumberCtrl alloc]init];
                    last.type = Weishudaxiao;
                    last.lottery_oldID = 4;
                    
                    PUSH(last);
                }
                else if (index == 12) {
                    
                    SixPieCtrl *pie = [[SixPieCtrl alloc]initWithNibName:NSStringFromClass([SixPieCtrl class]) bundle:[NSBundle mainBundle]];
                    pie.type = 1;
                    pie.lottery_oldID = 4;
                    
                    PUSH(pie);
                }
                else if (index == 13) {
                    
                    SixPieCtrl *pie = [[SixPieCtrl alloc]initWithNibName:NSStringFromClass([SixPieCtrl class]) bundle:[NSBundle mainBundle]];
                    pie.type = 2;
                    pie.lottery_oldID = 4;
                    
                    PUSH(pie);
                }
                else if (index == 14) {
                    
                    SixPieCtrl *pie = [[SixPieCtrl alloc]initWithNibName:NSStringFromClass([SixPieCtrl class]) bundle:[NSBundle mainBundle]];
                    pie.type = 3;
                    pie.lottery_oldID = 4;
                    
                    PUSH(pie);
                }
                else if (index == 15) {
                    
                    SixPieCtrl *pie = [[SixPieCtrl alloc]initWithNibName:NSStringFromClass([SixPieCtrl class]) bundle:[NSBundle mainBundle]];
                    pie.type = 4;
                    pie.lottery_oldID = 4;
                    
                    PUSH(pie);
                }
                else if (index == 16) {
                    
                    SixBarCtrl *bar = [[SixBarCtrl alloc]init];
                    bar.type = 1;
                    bar.lottery_oldID = 4;
                    
                    PUSH(bar);
                }
                else if (index == 17) {
                    
                    SixPieCtrl *pie = [[SixPieCtrl alloc]initWithNibName:NSStringFromClass([SixPieCtrl class]) bundle:[NSBundle mainBundle]];
                    pie.type = 5;
                    pie.lottery_oldID = 4;
                    
                    PUSH(pie);
                }
                else if (index == 18) {
                    
                    SixPieCtrl *pie = [[SixPieCtrl alloc]initWithNibName:NSStringFromClass([SixPieCtrl class]) bundle:[NSBundle mainBundle]];
                    pie.type = 6;
                    pie.lottery_oldID = 4;
                    
                    PUSH(pie);
                }
                else if (index == 19) {
                    
                    SixBarCtrl *bar = [[SixBarCtrl alloc]init];
                    bar.type = 2;
                    bar.lottery_oldID = 4;
                    
                    PUSH(bar);
                }
                else if (index == 20) {
                    
                    SixPieCtrl *pie = [[SixPieCtrl alloc]initWithNibName:NSStringFromClass([SixPieCtrl class]) bundle:[NSBundle mainBundle]];
                    pie.type = 7;
                    pie.lottery_oldID = 4;
                    
                    PUSH(pie);
                }
                else if (index == 21) {
                    
                    LastnumberCtrl *last = [[LastnumberCtrl alloc]init];
                    last.type = Jiaqinyeshou;
                    last.lottery_oldID = 4;
                    
                    PUSH(last);
                }
                else if (index == 22) {
                    
                    LastnumberCtrl *last = [[LastnumberCtrl alloc]init];
                    last.type = Lianmazoushi;
                    last.lottery_oldID = 4;
                    
                    PUSH(last);
                }
                else if (index == 23) {
                    
                    LastnumberCtrl *last = [[LastnumberCtrl alloc]init];
                    last.type = Lianxiaozoushi;
                    last.lottery_oldID = 4;
                    
                    PUSH(last);
                }
                else if (index == 24) {
                    LiuHeDaShenViewController *dashenVc = [[LiuHeDaShenViewController alloc] init];
                    dashenVc.lottery_oldID = 4;
                    
                    PUSH(dashenVc);
                }
            }
            else if (type == 6 || type == 7 || type == 11) {
                
                if (index == 0) {
                    
                    PK10HistoryCtrl *history = [[PK10HistoryCtrl alloc]init];
                    history.lottery_type = type;
                    PUSH(history);
                }
                else if (index == 1) {
                    
                    PK10MissNumberCtrl *miss = [[PK10MissNumberCtrl alloc]init];
                    miss.lottery_type = type;
                    PUSH(miss);
                }
                else if (index == 2) {
                    
                    PK10TodayNumberCtrl *today = [[PK10TodayNumberCtrl alloc]init];
                    today.lottery_type = type;
                    PUSH(today);
                }
                else if (index == 3) {
                    
                    PK10FreeRecommendCtrl *recommend = [[PK10FreeRecommendCtrl alloc]init];
                    recommend.lottery_type = type;
                    PUSH(recommend);
                }
                else if (index == 4) {
                    
                    PK10HotandCoolCtrl *hotandcool = [[PK10HotandCoolCtrl alloc]init];
                    hotandcool.lottery_type = type;
                    PUSH(hotandcool);
                }
                else if (index == 5) {
                    
                    FormulaCtrl *forumla = [[FormulaCtrl alloc]init];
                    forumla.lottery_type = type;
                    PUSH(forumla);
                }
                else if (index == 6) {
                    
                    PK10guanyahetongjiCtrl *guanyahetongji = [[PK10guanyahetongjiCtrl alloc]init];
                    guanyahetongji.lottery_type = type;
                    PUSH(guanyahetongji);
                }
                else if (index == 7) {
                    
                    PK10guanyahelistCtrl *list = [[PK10guanyahelistCtrl alloc]init];
                    list.lottery_type = type;
                    list.type = 3;
                    PUSH(list);
                }
                else if (index == 8) {
                    
                    PK10TwoFaceLuzhuCtrl *luzhu = [[PK10TwoFaceLuzhuCtrl alloc]init];
                    luzhu.lottery_type = type;
                    PUSH(luzhu);
                }
                else if (index == 9) {
                    
                    PK10TwoFaceMissCtrl *miss = [[PK10TwoFaceMissCtrl alloc]init];
                    miss.lottery_type = type;
                    PUSH(miss);
                }
                else if (index == 10) {
                    
                    PK10TwoFaceLuzhulistCtrl *luzhu = [[PK10TwoFaceLuzhulistCtrl alloc]init];
                    luzhu.lottery_type = type;
                    luzhu.type = 3;
                    
                    PUSH(luzhu);
                }
                else if (index == 11) {
                    
                    PK10TwoFaceCtrl *twoface = [[PK10TwoFaceCtrl alloc]init];
                    twoface.lottery_type = type;
                    PUSH(twoface);
                }
                else if (index == 12) {
                    
                    PK10TwoFaceLuzhulistCtrl *luzhu = [[PK10TwoFaceLuzhulistCtrl alloc]init];
                    luzhu.lottery_type = type;
                    luzhu.type = 4;
                    
                    PUSH(luzhu);
                }
                else if (index == 13) {
                    
                    PK10VersionTrendCtrl *trend = [[PK10VersionTrendCtrl alloc]init];
                    trend.lottery_type = type;
                    PUSH(trend);
                }
            }
            else if (type == 5) {
                
                if (index == 0) {
                    
                    PCHistoryCtrl *hisotry = [[PCHistoryCtrl alloc]init];
                    
                    PUSH(hisotry);
                }
                else if (index == 1) {
                    
                    PCTodayStatisticsCtrl *statistic = [[PCTodayStatisticsCtrl alloc]init];
                    
                    PUSH(statistic);
                }
                else if (index == 2) {
                    
                    PCFreeRecommendCtrl *recommend = [[PCFreeRecommendCtrl alloc]init];
                    
                    PUSH(recommend);
                }
                else if (index == 3) {
                    
                    PCNumberTrendCtrl *trend = [[PCNumberTrendCtrl alloc]init];
                    
                    PUSH(trend);
                }
            }else if (type == 9){
                if(index == 2){//专家
                    //                    if ([Person person].uid == nil) {
                    //                        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                    //                        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    //                        [self presentViewController:login animated:YES completion:nil];
                    ////                        login.loginBlock = ^(BOOL result) {
                    ////
                    ////                        };
                    //                    }else{
                    //                        FootBallPlanCtrl *footVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"FootBallPlanCtrl"];
                    //                        PUSH(footVc);
                    //                    }
                    FootBallPlanCtrl *footVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"FootBallPlanCtrl"];
                    PUSH(footVc);
                }else{
                    [AlertViewTool alertViewToolShowMessage:@"研发中,敬请期待" fromController:self handler:nil];
                }
            }
        };
        
        return footer;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == (self.dataSource.count + self.icon_Number - 1) / self.icon_Number) {
        if([AppDelegate shareapp].homeType == HomeSwitchTypeInfo){
            return CGSizeMake(self.view.frame.size.width, 72);
        }else{
            if([AppDelegate shareapp].isBuyClose){
                CGFloat hei = 250+25 + (collectionView.numberOfSections-1)*90;
                CGFloat jjj = SCREEN_HEIGHT- NAV_HEIGHT- Tabbar_HEIGHT;
                return CGSizeMake(SCREEN_WIDTH,jjj-hei>0?(jjj-hei)>72?jjj-hei:72:72);
            }else{
                CGFloat hei = 260+95+25 +(collectionView.numberOfSections-1)*90;
                CGFloat jjj = SCREEN_HEIGHT- NAV_HEIGHT- Tabbar_HEIGHT;
                return CGSizeMake(SCREEN_WIDTH,jjj-hei>0?(jjj-hei)>72?jjj-hei:72:72);
            }
        }
    }
    CGFloat itemWidth = ((SCREEN_WIDTH - 0 * (self.icon_Number - 1)) / self.icon_Number);
    //    if (IS_IPHONEX) {
    if([AppDelegate shareapp].homeType == HomeSwitchTypeInfo){
        return CGSizeMake(itemWidth, 124);
    }else{
        return CGSizeMake(itemWidth, 90);
    }
    //    }
    //    if([AppDelegate shareapp].homeType == HomeSwitchTypeInfo){
    //        return CGSizeMake(itemWidth, 125);
    //    }else{
    //        return CGSizeMake(itemWidth, 80);
    //    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0 ) {
        switch ([AppDelegate shareapp].homeType) {
            case HomeSwitchTypeBuy:
            {
                if([AppDelegate shareapp].isBuyClose){
                    return CGSizeMake(SCREEN_WIDTH, 250+25);
                }else{
                    return CGSizeMake(SCREEN_WIDTH, 260+95+25);
                }
            }
                break;
            case HomeSwitchTypeInfo:
            {
                if([AppDelegate shareapp].isInfoToutiaoClose){
                    return CGSizeMake(SCREEN_WIDTH, 513+25);
                }else{
                    return CGSizeMake(SCREEN_WIDTH, 620+25);
                }
            }
                break;
            default:
                break;
        }
        
    }
    else{
        return CGSizeZero;
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    if (section == self.dataArray.count / self.icon_Number) {
    //        return UIEdgeInsetsMake(15, 20, 5, 15);//分别为上、左、下、右
    //    }
    //    if (section == 2) {
    //        return UIEdgeInsetsMake(10, 0, 0, 0);
    //    }
    //    if (section == (self.dataSource.count + self.icon_Number - 1) / self.icon_Number) {
    return UIEdgeInsetsMake(0, 0, 0, 0);
    //    }
    //    if (section == self.dataArray.count / self.icon_Number) {
    //        return UIEdgeInsetsMake(0, 5, 0, 0);
    //    }else{
    //        return UIEdgeInsetsMake(0, 0, 0, 0);
    //    }
    //    if([AppDelegate shareapp].homeType == HomeSwitchTypeInfo){
    //        return UIEdgeInsetsMake(0, 0, 0, 0);
    //
    //    }else{
    //        return UIEdgeInsetsMake(0, 5, 0, 0);
    //    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if([AppDelegate shareapp].homeType == HomeSwitchTypeBuy){
        return CGSizeZero;
    }
    @weakify(self)
    
    if (self.sectionAry.count == 0 || self.isSelected == NO) {
        
        return CGSizeZero;
    }
    
    NSInteger data_type = self.indexPath.row + self.indexPath.section * self.icon_Number;
    
    if (data_type >= self.dataSource.count) {
        
        return CGSizeZero;
    }
    
    NSDictionary *dic = self.dataSource[data_type];
    
    NSInteger type = [dic[@"ID"]integerValue];
    
    CGFloat itemWidth = (SCREEN_WIDTH - 15 * 5) / 3;
    
    NSIndexPath *indexPath = [self.sectionAry lastObject];
    
    if (section == indexPath.section) {
        
        if (type == 1 || type == 2 || type == 3) {
            
            return CGSizeMake(SCREEN_WIDTH, itemWidth * 2 + 60);
        }
        else if (type == 4) {
            
            if (self.showall) {
                
                //                [UIView animateWithDuration:0.5 animations:^{
                //                    @strongify(self)
                //
                //                    if (IS_IPHONEX) {
                //                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.7)];
                //
                //                    }else{
                //                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.9)];
                //                    }
                //
                //                }];
                
                return CGSizeMake(SCREEN_WIDTH, itemWidth * 6 + 160);
            }
            else {
                
                //                [UIView animateWithDuration:0.5 animations:^{
                //                    @strongify(self)
                //
                //                    if (IS_IPHONEX) {
                //                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.5 - 120)];
                //                    }else{
                //                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.5 + 10)];
                //                    }
                //
                //                }];
                
                return CGSizeMake(SCREEN_WIDTH, itemWidth * 2 + 180);
            }
        }
        else if (type == 6 || type == 7 || type == 11) {
            
            if (self.showall) {
                
                //                [UIView animateWithDuration:0.5 animations:^{
                //                    @strongify(self)
                //
                //                    if (IS_IPHONEX) {
                //                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.5)];
                //
                //                    }else{
                //                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.7)];
                //
                //                    }
                //
                //                }];
                
                return CGSizeMake(SCREEN_WIDTH, itemWidth * 5 + 20);
            }
            else {
                
                //                [UIView animateWithDuration:0.5 animations:^{
                //                    @strongify(self)
                //
                //                    if (IS_IPHONEX) {
                //                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.5 - 120)];
                //                    }else{
                //                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.5 + 10)];
                //                    }
                //
                //                }];
                return CGSizeMake(SCREEN_WIDTH, itemWidth * 2 + 170);
            }
        }else if (type == 9){
            return CGSizeMake(SCREEN_WIDTH, itemWidth);
        }
        else {
            return CGSizeMake(SCREEN_WIDTH, itemWidth + 83);
        }
        
        
    }
    
    return CGSizeZero;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger type = indexPath.row + indexPath.section * self.icon_Number;
    
    if (indexPath.section == (self.dataSource.count + self.icon_Number - 1) / self.icon_Number) {
        
        AdvertModel *advmodel = self.bottomArray.firstObject;
        
        [self advertpush:advmodel];
        
        return;
    }
    
    @weakify(self)
    if (type == self.dataSource.count-1) {
        if([AppDelegate shareapp].homeType != HomeSwitchTypeInfo){
            [self clickEditBtn2];
            return;
        }
        HobbyCtrl *hobby = [[HobbyCtrl alloc]init];
        
        hobby.updataBlock = ^(NSArray *hobArray) {
            @strongify(self)
            
            [self.dataSource removeAllObjects];
            
            [self.dataSource addObjectsFromArray:hobArray];
            
            [self.dataSource addObject:@{@"title":@"更多彩种",@"ID":@(999),@"icon":[[CPTThemeConfig shareManager] IC_Home_GDCZ],@"subtitle":@"好挣好玩",@"hotTitle":@""}];
            
            [self.collectView reloadData];
        };
        
        self.isSelected = NO;
        [self.sectionAry removeObject:self.indexPath];
        
        [self presentViewController:hobby animated:YES completion:nil];
        
        return;
    }
    
    self.indexPath = indexPath;
    
    self.showall = NO;
    
    HomeCell *cell = (HomeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([cell.titlelab.text isEqualToString:@""]) {
        return;
    }
    
    [self JudgeSelected:indexPath Withcell:cell];
    
    [self.collectView reloadData];
    [self.collectView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    //    CGFloat offsetX = indexPath.item * 124;
    //
    //    if([AppDelegate shareapp].isInfoToutiaoClose){
    //        [self.collectView setContentOffset:CGPointMake(0, offsetX+513)];
    //
    //    }else{
    //        [self.collectView setContentOffset:CGPointMake(0, offsetX+620)];
    //
    //    }
}

#pragma mark - HomeheaderViewDelegate
-(void)didClickTiXian{
    GetOutViewController *getoutVC = [[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"GetOutViewController"];
    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController pushViewController:getoutVC animated:YES];
}
- (void)clickClose{
    switch ([AppDelegate shareapp].homeType) {
        case HomeSwitchTypeBuy:
        {
            [AppDelegate shareapp].isBuyClose = YES;
        }
            break;
        case HomeSwitchTypeInfo:
        {
            [AppDelegate shareapp].isInfoToutiaoClose = YES;
        }
            break;
        default:
            break;
    }
    @weakify(self)
    [UIView animateWithDuration:0 animations:^{
        @strongify(self)
        [self.collectView  performBatchUpdates:^{
            @strongify(self)
            [self.collectView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        } completion:nil];
    }];
}

- (void)clickEditBtn{
    FavoriteListVC *kefuVc = [[FavoriteListVC alloc] init];
    kefuVc.state = EditState_ing;
    if([self.favData containsObject:self.settingModel]){
        [self.favData removeLastObject];
    }
    kefuVc.favData = self.favData;
    PUSH(kefuVc);
}

- (void)clickEditBtn2{
    FavoriteListVC *kefuVc = [[FavoriteListVC alloc] init];
    kefuVc.state = EditState_ok;
    if([self.favData containsObject:self.settingModel]){
        [self.favData removeLastObject];
    }
    kefuVc.favData = self.favData;
    PUSH(kefuVc);
}

- (void)clickKefu{
    KeFuViewController *kefuVc = [[KeFuViewController alloc] init];
    PUSH(kefuVc);
}

- (void)didClickChongzhi{
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];
        __weak __typeof(self)weakSelf = self;
        login.loginBlock = ^(BOOL result) {
            __strong __typeof(self)weakSelf = self;
            [weakSelf didClickChongzhi];
        };
        return;
    }
    TopUpViewController *topUpVC = [[TopUpViewController alloc] init];
    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController pushViewController:topUpVC animated:YES];
    
}

- (void)goLHCHistory{
    SixHistoryResultCtrl *history = [[SixHistoryResultCtrl alloc]init];
    history.type = 1;
    history.lottery_oldID = 4;
    PUSH(history);
}

#pragma mark -  切换购彩版
- (void)changeToBuy:(UIButton *)btn {
//- (void)changeToBuy {
    
    NSString *gifImgName;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if([AppDelegate shareapp].homeType == HomeSwitchTypeInfo){
//        btn.tag = 10002;
        [AppDelegate shareapp].homeType = HomeSwitchTypeBuy;
        self.logoLabel.text = @"切换资讯版 >";
//        [btn setTitle:@"切换资讯版" forState:UIControlStateNormal];
//        [btn setImage:IMAGE(@"cptChangeInfo") forState:UIControlStateNormal];
        //        self.layout.itemSize = CGSizeMake(self.layout.itemSize.width, 80);
        gifImgName = @"home_switch_news";
    }else{
//        btn.tag = 10003;
        [AppDelegate shareapp].homeType = HomeSwitchTypeInfo;
        self.logoLabel.text = @"切换购彩版 >";
//        [btn setTitle:@"切换购彩版" forState:UIControlStateNormal];
//        [btn setImage:IMAGE(@"cptChange") forState:UIControlStateNormal];
        //        self.layout.itemSize = CGSizeMake(self.layout.itemSize.width, 110);
        gifImgName = @"home_switch_buylot";
        
    }
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        gifImgName= [NSString stringWithFormat:@"tw_%@",gifImgName];
    }
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:gifImgName ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    UIImage *image = [UIImage sd_animatedGIFWithData:imageData];
    [btn setImage:image forState:UIControlStateNormal];
    
    
    
    [self configData];
    [self.collectView reloadData];
    
    [userDefault setObject:@([AppDelegate shareapp].homeType) forKey:@"HomeSwitchType"];
    [userDefault synchronize];
    
    //    @weakify(self)
    //    [UIView animateWithDuration:0 animations:^{
    //        @strongify(self)
    //        [self.collectView  performBatchUpdates:^{
    //            @strongify(self)
    //            [self.collectView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    //        } completion:nil];
    //    }];
    
}

- (void)clickIcon:(UIButton *)sender{
    //    NSArray *icons = @[@"心水推荐",@"六合大神",@"六合图库",@"公式杀号",@"查询助手",@"资讯统计",@"开奖日历",@"AI智能选号",@"开奖直播",@"历史开奖",@"聊天室",@"挑码助手",@"生肖特码",@"生肖正码",@"尾数大小",@"连码走势"]; 1000+i;
    
    switch (sender.tag) {
        case 1000:
        {
            SixRecommendCtrl *recommend = [[SixRecommendCtrl alloc]init];
            recommend.lottery_oldID = 4;
            PUSH(recommend);
        }
            break;
        case 1001:
        {
//            SixInformationCtrl *information = [[SixInformationCtrl alloc]init];
//            information.lottery_oldID = 4;
//            PUSH(information);
            LiuHeDaShenViewController *daShenVc = [[LiuHeDaShenViewController alloc] init];
            daShenVc.lottery_oldID = 4;
            PUSH(daShenVc);
        }
            break;
        case 1002:
        {
            SixPhotosCtrl *photo = [[SixPhotosCtrl alloc]init];
            photo.lottery_oldID = 4;
            
            PUSH(photo);
        }
            break;
        case 1003:
        {
            FormulaCtrl *formula = [[FormulaCtrl alloc]init];
            formula.lottery_type = 4;
            formula.lottery_oldID = 4;
            PUSH(formula);
        }
            break;
        case 1004://,@"查询助手",@"资讯统计",@"开奖日历",@"AI智能选号"
        {
            SixHelpCtrl *help = [[SixHelpCtrl alloc]init];
            help.lottery_oldID = 4;
            PUSH(help);
        }
            break;
        case 1005:
        {
            SixInformationCtrl *information = [[SixInformationCtrl alloc]init];
            information.lottery_oldID = 4;
            PUSH(information);
        }
            break;
        case 1006:
        {
            SixHistoryResultCtrl *history = [[SixHistoryResultCtrl alloc]init];
            history.type = 2;
            history.lottery_oldID = 4;
            
            PUSH(history);
        }
            break;
        case 1007:
        {
            SixAIPickCtrl *ai = [[SixAIPickCtrl alloc]initWithNibName:NSStringFromClass([SixAIPickCtrl class]) bundle:[NSBundle mainBundle]];
            ai.lottery_oldID = 4;
            PUSH(ai);
        }
            break;
        case 1008:
        {
            LiveOpenLotteryViewController *liveVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"LiveOpenLotteryViewController"];
            liveVc.lotteryId = CPTBuyTicketType_LiuHeCai;
            liveVc.lottery_oldID = 4;
            PUSH(liveVc);
        }
            break;
        case 1009:
        {
            SixHistoryResultCtrl *history = [[SixHistoryResultCtrl alloc]init];
            history.type = 1;
            history.lottery_oldID = 4;
            PUSH(history);
        }
            break;
        case 1010:
        {
            [self clickChatF];
        }
            break;
        case 1011:
        {
            TiaomazhushouVC *vc = [[TiaomazhushouVC alloc]initWithNibName:@"TiaomazhushouVC" bundle:nil];
            PUSH(vc);
        }
            break;
        case 1012://@"生肖特码",@"生肖正码",@"尾数大小",@"连码走势"
        {
            SixPieCtrl *pie = [[SixPieCtrl alloc]initWithNibName:NSStringFromClass([SixPieCtrl class]) bundle:[NSBundle mainBundle]];
            pie.type = 1;
            pie.lottery_oldID = 4;
            PUSH(pie);
        }
            break;
        case 1013:
        {
            SixPieCtrl *pie = [[SixPieCtrl alloc]initWithNibName:NSStringFromClass([SixPieCtrl class]) bundle:[NSBundle mainBundle]];
            pie.type = 2;
            pie.lottery_oldID = 4;
            PUSH(pie);
        }
            break;
        case 1014:
        {
            LastnumberCtrl *last = [[LastnumberCtrl alloc]init];
            last.type = Weishudaxiao;
            last.lottery_oldID = 4;
            PUSH(last);
        }
            break;
        case 1015:
        {
            LastnumberCtrl *last = [[LastnumberCtrl alloc]init];
            last.type = Lianmazoushi;
            last.lottery_oldID = 4;
            PUSH(last);
        }
            break;
            
        default:
            break;
    }
}
- (void)clickSixRecommetNews:(UIButton *)sender{
    
    if (sender.tag == 10) {
        
        SixRecommendCtrl *recommend = [[SixRecommendCtrl alloc]init];
        
        recommend.lottery_oldID = 4;
        
        PUSH(recommend);
        
    }else if(sender.tag == 20){
        
        SixInformationCtrl *information = [[SixInformationCtrl alloc]init];
        information.lottery_oldID = 4;
        PUSH(information);
        
    }else if(sender.tag == 30){
        
        SixPhotosCtrl *photo = [[SixPhotosCtrl alloc]init];
        photo.lottery_oldID = 4;
        
        PUSH(photo);
        
    }else if(sender.tag == 40){
        
        FormulaCtrl *formula = [[FormulaCtrl alloc]init];
        formula.lottery_type = 4;
        formula.lottery_oldID = 4;
        PUSH(formula);
        
    }else if(sender.tag == 50){
        
        LiuHeDaShenViewController *daShenVc = [[LiuHeDaShenViewController alloc] init];
        daShenVc.lottery_oldID = 4;
        PUSH(daShenVc);
    }else if(sender.tag == 60){
        
        LiveOpenLotteryViewController *liveVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"LiveOpenLotteryViewController"];
        liveVc.lotteryId = CPTBuyTicketType_LiuHeCai;
        liveVc.lottery_oldID = 4;
        PUSH(liveVc);
    }else if(sender.tag == 70){
        SixHistoryResultCtrl *history = [[SixHistoryResultCtrl alloc]init];
        history.type = 1;
        history.lottery_oldID = 4;
        PUSH(history);
    }else if(sender.tag == 80){
        SixHelpCtrl *help = [[SixHelpCtrl alloc]init];
        help.lottery_oldID = 4;
        PUSH(help);
    }else if(sender.tag == 90){
        
        TiaomazhushouVC *vc = [[TiaomazhushouVC alloc]initWithNibName:@"TiaomazhushouVC" bundle:nil];
        PUSH(vc);
        //        SixInformationCtrl *information = [[SixInformationCtrl alloc]init];
        //        information.lottery_oldID = 4;
        //        PUSH(information);
    }
    
}

#pragma mark - 设置表头方式二
// 要先设置表头大小
//- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
//    return size;
//}

//// 创建一个继承collectionReusableView的类,用法类比tableViewcell
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView *reusableView = nil;
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        // 头部视图
//        // 代码初始化表头
//        // [collectionView registerClass:[HeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"];
//        // xib初始化表头
//        [collectionView registerNib:[UINib nibWithNibName:@"HeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"];
//        HeaderReusableView *tempHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView" forIndexPath:indexPath];
//        reusableView = tempHeaderView;
//    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
//        // 底部视图
//    }
//    return reusableView;
//}

#pragma mark - UICollectionViewDelegate 选中执行

- (void)JudgeSelected:(NSIndexPath *)indexPath Withcell:(HomeCell *)cell
{
    if([AppDelegate shareapp].homeType == HomeSwitchTypeBuy){
        if(cell.isWorkView.hidden == NO){
            return;
        }
        if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该功能暂未开放" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        CrartHomeSubModel * subModel = cell.model;
        if ([subModel.name isEqualToString:@"长龙资讯"]) {
            CPTChangLongController * longV = [[CPTChangLongController alloc] init];
            [self.navigationController pushViewController:longV animated:YES];
            return;
        }
        if([subModel.intro isEqualToString:@"棋牌类"]){//棋牌
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                
                [self presentViewController:login animated:YES completion:^{
                }];
                return ;
            }
            NSString *gameId = [NSString stringWithFormat:@"%ld",(long)subModel.lotteryId];
            MBLog(@"---%@",gameId);
            @weakify(self)
            NSDictionary *dic = @{@"userId":[Person person].uid,@"account":[Person person].account,@"kindId":gameId};
            [WebTools postWithURL:@"/ky/game.json" params:dic success:^(BaseData *data) {
                @strongify(self)
                if(data.status.integerValue == 1){
                    MBLog(@"%@",data.data);
                    NSString *url = data.data;
                    CPTWebViewController *webVc = [[CPTWebViewController alloc] init];
                    webVc.urlStr = url;
                    webVc.isKY = YES;
                    PUSH(webVc);
                }else{
                    [MBProgressHUD showMessage:data.info];
                }
                
            } failure:^(NSError *error) {
                
            }];
        }else if([subModel.intro isEqualToString:@"真人视讯"]){//
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                
                [self presentViewController:login animated:YES completion:^{
                }];
                return ;
            }
            NSDictionary *dic = @{@"userId":[Person person].uid,@"account":[Person person].account,@"actype":@"1",@"gameType":@(18)};
            @weakify(self)
            [WebTools postWithURL:@"/ag/agJump.json" params:dic success:^(BaseData *data) {
                @strongify(self)
                if(data.status.integerValue == 1){
                    MBLog(@"%@",data.data);
                    NSString *url = data.data;
                    CPTWebViewController *webVc = [[CPTWebViewController alloc] init];
                    webVc.isGame = YES;
                    webVc.isAG = YES;
                    webVc.urlStr = url;
                    PUSH(webVc);
                }else{
                    [MBProgressHUD showMessage:data.info];
                }
            } failure:^(NSError *error) {
                MBLog(@"%@",error.description);
            }];
        }
        
        
        else if(subModel.lotteryId==CPTBuyTicketType_FantanSSC||subModel.lotteryId == CPTBuyTicketType_FantanXYFT||subModel.lotteryId == CPTBuyTicketType_FantanPK10||subModel.lotteryId == CPTBuyTicketType_Shuangseqiu||subModel.lotteryId == CPTBuyTicketType_DaLetou||subModel.lotteryId == CPTBuyTicketType_QiLecai||subModel.lotteryId == CPTBuyTicketType_NiuNiu_JiShu||subModel.lotteryId == CPTBuyTicketType_NiuNiu_AoZhou||subModel.lotteryId == CPTBuyTicketType_NiuNiu_KuaiLe){//番摊&双色球，大乐透，七乐彩
            CPTBuyRootVC * vc = [[CPTBuyRootVC alloc] init];
            vc.lotteryId = subModel.lotteryId;
            CPTBuyFantanCtrl *fantanVC = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"CPTBuyFantanCtrl"];
            fantanVC.endTime = subModel.endTime;
            fantanVC.lotteryName = subModel.name;
            fantanVC.type = subModel.lotteryId;
            fantanVC.lotteryId = subModel.lotteryId;
            fantanVC.categoryId = subModel.categoryId;
            [[CPTBuyDataManager shareManager] configType:fantanVC.type];
            vc.type = fantanVC.type;
            [vc loadVC:fantanVC title:subModel.name];
            PUSH(vc);
        }
        else{
            CPTBuyRootVC * vc = [[CPTBuyRootVC alloc] init];
            vc.lotteryId = subModel.lotteryId;
            CPTBuySexViewController *six = [[CPTBuySexViewController alloc]init];
            six.type = subModel.lotteryId;
            six.endTime = subModel.endTime;
            [[CPTBuyDataManager shareManager] configType:six.type];
            six.lottery_type = subModel.ID;
            six.categoryId = subModel.categoryId;
            six.lotteryId = subModel.lotteryId;
            vc.type = six.type;
            [vc loadVC:six title:subModel.name];
            PUSH(vc);
        }
        return;
    }
    @weakify(self)
    //始终保持数组中只有一个元素或则无元素
    if (self.sectionAry.count > 1)
    {
        [self.sectionAry removeObjectAtIndex:0];
    }
    
    //如果这此点击的元素存在于数组中则状态置为NO,并将此元素移除数组
    /*
     这里之所以置为NO的时候把元素移除是因为, 如果不移除, 下次点击的时候代码走到这里里面还是有一个元素, 而且是上次的元素, 不会走else的代码
     */
    if ([self.sectionAry containsObject:indexPath])
    {
        self.isSelected = NO;
        [self.sectionAry removeObject:indexPath];
    }else{
        //当数组为空的时候或者点击的非上次元素的时候走这里
        self.isSelected = YES;
        [self.sectionAry addObject:indexPath];
        return;
        //        CGRect cellRect = [self.collectView convertRect:cell.frame toView:self.collectView];
        //
        //        CGRect rect2 = [self.collectView convertRect:cellRect toView:self.view];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                @strongify(self)
                
                if (self.showall) {
                    
                    [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.5)];
                    
                }else{
                    
                    if (IS_IPHONEX) {
                        
                        if ([cell.titlelab.text isEqualToString:@"足彩资讯"]) {
                            [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.11)];
                        }else{
                            [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.5 - 120)];
                        }
                    }else{
                        if ([cell.titlelab.text isEqualToString:@"足彩资讯"]) {
                            [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.17)];
                        }else{
                            [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.5 + 10)];
                        }
                    }
                }
            }];
            
        });
        
        
    }
}

- (NSMutableArray *)sectionAry
{
    
    if (!_sectionAry) {
        self.sectionAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _sectionAry;
}

////是否可以旋转
//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
////支持的方向
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}

#pragma mark - 获取轮播图
-(void)advertData {
  
    
    @weakify(self)
    [WebTools postWithURL:@"/ad/queryAdPhoto.json" params:@{@"type":@2,@"siteId":@3} success:^(BaseData *data) {
        
        @strongify(self)
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        self.dataArray = [AdvertModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.advertimgs removeAllObjects];
        
        for (AdvertModel *model in self.dataArray) {
            
            [self.advertimgs addObject:IMAGEPATH(model.photo)];
            
        }
        
        [self.collectView reloadData];
        
        [self.collectView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        @strongify(self)
        
        [self.collectView.mj_header endRefreshing];
        
    } showHUD:YES];
    
}

-(void)bottomadvertData {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if([[Person person] uid]){
        [dic setObject:[[Person person] uid] forKey:@"userID"];
    }
    [dic setObject:@2 forKey:@"type"];
    [dic setObject:@10 forKey:@"siteId"];
    
    @weakify(self)
    [WebTools postWithURL:@"/ad/queryAdPhoto.json" params:dic success:^(BaseData *data) {
        @strongify(self)
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        [self.bottomimgs removeAllObjects];
        
        self.bottomArray = [AdvertModel mj_objectArrayWithKeyValuesArray:data.data];
        
        for (AdvertModel *model in self.bottomArray) {
            
            [self.bottomimgs addObject:IMAGEPATH(model.photo)];
            
        }
        
        [self.collectView reloadData];
        
        [self.collectView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.collectView.mj_header endRefreshing];
    } showHUD:NO];
    
}




-(void)advertpush:(AdvertModel *)model {
    
    if([model.targetType isEqualToString: @"-1"]){
        if (model.url.length > 0) {
            CPTWebViewController * web = [[CPTWebViewController alloc] init];
            web.urlStr = model.url;
            web.title = model.title;
            web.isAD = YES;
            PUSH(web);
        }
    }else  if([model.targetType isEqualToString: @"1"]){
        ActivityDetailVC * vc = [[ActivityDetailVC alloc] initWithNibName:@"ActivityDetailVC" bundle:nil];
        vc.acttID = model.targetId;
        [self.navigationController pushViewController:vc animated:YES];
    }else  if([model.targetType isEqualToString: @"0"]){
        switch ([model.targetId integerValue]) {
            case 0:
            {
                SixRecommendCtrl *recommend = [[SixRecommendCtrl alloc]init];
                recommend.lottery_oldID = 4;
                PUSH(recommend);
            }
                break;
            case 1:
            {
                DaShenViewController *dashen = [[DaShenViewController alloc] init];
                self.navigationController.navigationBar.hidden = NO;
                PUSH(dashen);
            }
                break;
            case 2:
            {
                CPTBuyRootVC * vc = [[CPTBuyRootVC alloc] init];
                vc.lotteryId = CPTBuyTicketType_LiuHeCai;
                CPTBuySexViewController *six = [[CPTBuySexViewController alloc]init];
                six.type = CPTBuyTicketType_LiuHeCai;
                six.endTime = 60;
                [[CPTBuyDataManager shareManager] configType:six.type];
                six.lottery_type = CPTBuyTicketType_LiuHeCai;
                six.categoryId = 12;
                six.lotteryId = CPTBuyTicketType_LiuHeCai;
                vc.type = six.type;
                [vc loadVC:six title:@"六合彩"];
                PUSH(vc);
            }
                break;
            case 3:
            {
                FootBallPlanCtrl *footVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"FootBallPlanCtrl"];
                PUSH(footVc);
            }
                break;
            case 4:
            {
                if ([Person person].uid == nil) {
                    LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                    login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    [self presentViewController:login animated:YES completion:nil];
                    login.loginBlock = ^(BOOL result) {
                        
                    };
                    return;
                }
                if ([Person person].payLevelId.length == 0) {
                    [MBProgressHUD showError:@"无用户层级, 暂无法充值"];
                    return;
                }
                TopUpViewController *topUpVC = [[TopUpViewController alloc] init];
                self.navigationController.navigationBar.hidden = NO;
                
                [self.navigationController pushViewController:topUpVC animated:YES];
            }
                break;
            case 5:{
                if ([Person person].uid == nil) {
                    LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                    login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    
                    [self presentViewController:login animated:YES completion:nil];
                    @weakify(self)
                    login.loginBlock = ^(BOOL result) {
                        @strongify(self)
                        CircleDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
                        [self.navigationController pushViewController:detail animated:YES];
                    };
                    
                    return;
                }
                
                CircleDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
                [self.navigationController pushViewController:detail animated:YES];
            }
                break;
                
            default:
                break;
        }
    }

    //    else{
    //        CPTWebViewController * web = [[CPTWebViewController alloc] init];
    //        web.urlStr = @"https://www.baidu.com";
    //        web.title = @"分享页面";
    //        PUSH(web);
    //    }
    
}


-(void)noticeData {
    
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/getRollNotice.json" params:nil success:^(BaseData *data) {
        @strongify(self)

        self.scorllLabelString = [NSMutableString stringWithFormat:@""];
        
        if ([data.data isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *dic in data.data) {
                
                if ([dic[@"intro"]length] > 0) {
                    [self.scorllLabelString appendFormat:@"   %@", dic[@"intro"]];
                }
                
            }
        }
        
        [self.collectView reloadData];
        
        [self.collectView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        @strongify(self)
        
        [self.collectView.mj_header endRefreshing];
        
    } showHUD:NO];
}


-(NSMutableArray *)advertimgs {
    
    if (!_advertimgs) {
        
        _advertimgs = [[NSMutableArray alloc]init];
    }
    return _advertimgs;
}

-(NSMutableArray *)bottomimgs {
    
    if (!_bottomimgs) {
        
        _bottomimgs = [[NSMutableArray alloc]init];
    }
    return _bottomimgs;
}

#pragma mark -  版本更新接口
-(void)getnewversion {
    
    NSString *key = @"CFBundleShortVersionString";
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    @weakify(self)
    [WebTools postWithURL:@"/app/editionUpdate.json" params:@{@"appEdittion":currentVersion} success:^(BaseData *data) {
        @strongify(self)
        if ([data.data isKindOfClass:[NSDictionary class]]) {
            
            NSString *url = data.data[@"iosDownUrl"];
            
            NSInteger noticeStatus = [data.data[@"noticeStatus"]integerValue];
            
            NSString *message = [NSString stringWithFormat:@"%@\n大小：%@ M", data.data[@"message"],data.data[@"iosSize"]];
            
            if ([currentVersion isEqualToString:data.data[@"number"]] == NO) {
                
                UpdateVersionView *update = [UpdateVersionView update];
                //公告状态，0：更新 1：强制更新 2：公告
                if (noticeStatus == 0){
                    
                    update.cancelBtn.hidden = NO;
                    update.updateBtn.hidden = NO;
                }
                else if (noticeStatus == 1) {
                    
                    update.cancelBtn.hidden = YES;
                    update.updateBtn.hidden = NO;
                }else {
                    update.cancelBtn.hidden = NO;
                    update.cancelBtn.hidden = YES;
                    update.bottom_const.constant = 0;
                }
                update.textView.text = message;
                
                @weakify(self)
                update.updateBlock = ^{
                    @strongify(self)
                    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
                    
                    UIWebView *web = [[UIWebView alloc]init];
                    
                    [web loadRequest:request];
                    
                    [self.view addSubview:web];
                    
                    //                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //
                    //                        AppDelegate *app = [AppDelegate shareapp];
                    //
                    //                        UIWindow *window = app.window;
                    //
                    //                        [UIView animateWithDuration:1.0f animations:^{
                    //
                    //                            window.alpha = 0;
                    //
                    //                            window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
                    //
                    //                        } completion:^(BOOL finished) {
                    //
                    //                            exit(0);
                    //                        }];
                    //                    });
                };
                [update show];
            }
        }
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initLtData {
    
    [WebTools postWithURL:@"/lottery/favorite/list.json" params:nil success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return;
        }
        
        [Tools saveDataToPlistFile:data.data WithName:@"favoritelist.plist"];
        NSArray *array = [CrartHomeSubModel mj_objectArrayWithKeyValuesArray:data.data];
        self.curenttime = data.time;
        
        if(array.count>0){
            [self.dataSource removeAllObjects];
            [self.favData removeAllObjects];
            
            for (CrartHomeSubModel *submodel in array) {
                [self.favData addObject:submodel];
            }
            [self configData];
            [self.collectView reloadData];
            
        }
    } failure:^(NSError *error) {
        MBLog(@"1");
    } showHUD:NO];
}

- (void)clickKeFu{
    [self clickKefu];
}

- (void)clickChatF {

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

- (void)clicWebVersion{
    
    [[CPTInfoManager shareManager] checkModelCallBack:^(CPTInfoModel * _Nonnull model, BOOL isSuccess) {
        if(isSuccess){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.h5Url]];
        }
    }];
    //    SFSafariViewController *safari = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"https://www.cpth5.com"] entersReaderIfAvailable:YES];
    //    [self presentViewController:safari animated:YES completion:nil];
}

-(void)initActivityData {
    @weakify(self)
    //    "actType" 活动类型0其他，1红包
    //    "actStatus"  活动状态0开启，1关闭
    //    "actIntoPage"  进入页面 0心水推荐 1跟单大厅 2六合彩购彩 3足彩专家 4充值页面
    //    "isPopup" 是否弹出0是，1否
    [WebTools postWithURL:@"/activity/getPopupActivity.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        
        if (![data.status isEqualToString:@"1"]) {
            return;
        }
        __block NSDictionary * dic = data.data;
        if([dic isKindOfClass:[NSString class]]){
//            dic = @{@"actType":@(1),@"actStatus":@(0),@"actTitle":@"全新升级 超高返水",@"actGuide":@"全新返水，只要达到指定流水，返水率就会进阶，流水越高返水越多。",@"actIntoPage":@(0),@"id":@(2)};
            return;
        }
        NSNumber * actTypeNumber = dic[@"actType"] ;
        NSNumber * actStatusNumber = dic[@"actStatus"] ;
        NSInteger actType = [actTypeNumber integerValue];
        NSInteger actStatus = [actStatusNumber integerValue];
        
        if(actStatus ==1){
            return;
        }
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        if([user objectForKey:[NSString stringWithFormat:@"%@",dic[@"id"]]]){
            return;
        }
        if( actType == 1){
            dispatch_async(dispatch_get_main_queue(), ^{
                HomeActivityAlertView *vc = [[[NSBundle mainBundle]loadNibNamed:@"HomeActivityAlertView" owner:self options:nil]firstObject];
                vc.actID = dic[@"id"];
                vc.titleL.text = dic[@"actTitle"];
                vc.isFromHome = YES;
                vc.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                [vc show];
                [vc setClickOKBtn:^{
                    @strongify(self)
                    [self clickToHongbaoVC:dic];
                }];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                HomeHongBaoAlertView *vc = [[[NSBundle mainBundle]loadNibNamed:@"HomeHongBaoAlertView" owner:self options:nil]firstObject];
                vc.titleLabel.text = dic[@"actTitle"];
                vc.subTitleLabel.text = dic[@"actGuide"];;
                vc.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                [vc show];
                [vc setClickOKBtn:^{
                    @strongify(self)
                    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                    [user setObject:@"9" forKey:[NSString stringWithFormat:@"%@",dic[@"id"]]];
                    [user synchronize];
                    [self clickToHongbaoVC:dic];
                    
                }];
            });
        }
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}
- (void)clickToHongbaoVC:(NSDictionary *)dic{
    ActivityDetailVC * vc = [[ActivityDetailVC alloc] initWithNibName:@"ActivityDetailVC" bundle:nil];
    vc.dic = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickLijiqianwangBtn:(NSDictionary *)dic{
    
    //"actIntoPage"  进入页面 0心水推荐 1跟单大厅 2六合彩购彩 3足彩专家 4充值页面 5晒单
    
    switch ([dic[@"actIntoPage"] integerValue]) {
        case 0:
        {
            SixRecommendCtrl *recommend = [[SixRecommendCtrl alloc]init];
            recommend.lottery_oldID = 4;
            PUSH(recommend);
        }
            break;
        case 1:
        {
            DaShenViewController *dashen = [[DaShenViewController alloc] init];
            self.navigationController.navigationBar.hidden = NO;
            PUSH(dashen);
        }
            break;
        case 2:
        {
            CPTBuyRootVC * vc = [[CPTBuyRootVC alloc] init];
            vc.lotteryId = CPTBuyTicketType_LiuHeCai;
            CPTBuySexViewController *six = [[CPTBuySexViewController alloc]init];
            six.type = CPTBuyTicketType_LiuHeCai;
            six.endTime = 60;
            [[CPTBuyDataManager shareManager] configType:six.type];
            six.lottery_type = CPTBuyTicketType_LiuHeCai;
            six.categoryId = 12;
            six.lotteryId = CPTBuyTicketType_LiuHeCai;
            vc.type = six.type;
            [vc loadVC:six title:@"六合彩"];
            PUSH(vc);
        }
            break;
        case 3:
        {
            FootBallPlanCtrl *footVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"FootBallPlanCtrl"];
            PUSH(footVc);
        }
            break;
        case 4:
        {
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self presentViewController:login animated:YES completion:nil];
                login.loginBlock = ^(BOOL result) {
                    
                };
                return;
            }
            
            if ([Person person].payLevelId.length == 0) {
                [MBProgressHUD showError:@"无用户层级, 暂无法充值"];
                return;
            }
            TopUpViewController *topUpVC = [[TopUpViewController alloc] init];
            self.navigationController.navigationBar.hidden = NO;
            
            [self.navigationController pushViewController:topUpVC animated:YES];
        }
            break;
        case 5:{
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                
                [self presentViewController:login animated:YES completion:nil];
                @weakify(self)
                login.loginBlock = ^(BOOL result) {
                    @strongify(self)
                    CircleDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
                    [self.navigationController pushViewController:detail animated:YES];
                };
                
                return;
            }
            
            CircleDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)toTiezi:(NSInteger)referrerId{
  
    SixArticleDetailViewController *vc = [[SixArticleDetailViewController alloc] init];
    //    detailArticleVc.parentMemberId = model.parentMemberId;
    //    detailArticleVc.ID = model.ID;
    vc.ID = referrerId;
    //    detailArticleVc.isAttention = model.alreadyFllow;
    vc.isShowHistoryBtn = YES;
    vc.lottery_oldID = 4;
    
    //    detailArticleVc.liuHeCaiModel = self.liuHeCaiModel;
    
    PUSH(vc);}

@end
