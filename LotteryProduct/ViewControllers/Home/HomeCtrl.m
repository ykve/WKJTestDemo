//
//  HomeCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomeCtrl.h"
#import "HomeHeaderView.h"
#import "HomeFootView.h"
#import "HomeCell.h"
#import "NoticeView.h"
#import "HomeADCollectionViewCell.h"
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

#define kItem_Number 3

@interface HomeCtrl ()<WB_StopWatchDelegate, HomeHeaderViewDelegate,TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (nonatomic, strong)UICollectionViewFlowLayout *layout;

@property (nonatomic, strong)UICollectionView *collectView;

@property (nonatomic, strong)NoticeView *notice;

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

@property (nonatomic, strong) NSMutableArray *NoticeArray;

@end

@implementation HomeCtrl

-(UICollectionViewFlowLayout *)layout {
    
    if (!_layout) {
        CGFloat itemSpace = 0;
        
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        _layout.minimumInteritemSpacing = itemSpace;
        
        _layout.minimumLineSpacing = itemSpace;
        
        CGFloat itemWidth = (SCREEN_WIDTH - itemSpace * (kItem_Number - 1)) / kItem_Number;
        
        _layout.itemSize = CGSizeMake(itemWidth, 110);
        
        _layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 30 + SCREEN_WIDTH * 0.4 + 10);
    }
    
    return _layout;
}

-(UICollectionView *)collectView {
    
    if (!_collectView) {
        
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        
        _collectView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_ADCollectionViewCell_Back];//[[CPTThemeConfig shareManager] HomeViewBackgroundColor];

        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:RJCellIdentifier];
        
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeADCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:XMFHomeAdCollectionViewCell];
        
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeHeaderView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RJHeaderIdentifier];
        
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

-(NoticeView *)notice {
    
    if (!_notice) {

        @weakify(self)
        _notice = [[NoticeView alloc]initWithFrame:CGRectZero];
        _notice.textAlignment = NSTextAlignmentLeft;//默认
        _notice.isHaveTouchEvent = YES;
        _notice.labelFont = [UIFont systemFontOfSize:12];
        _notice.color = [UIColor redColor];
        _notice.time = 4.0f;
        _notice.defaultMargin = 10;
        _notice.numberOfTextLines = 2;
        _notice.edgeInsets = UIEdgeInsetsMake(7, 12,7, 12);
        _notice.clickAdBlock = ^(NSUInteger index){
            @strongify(self)
            [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MessageCenterViewController"] animated:YES];
        };
        _notice.headImg = IMAGE([[CPTThemeConfig shareManager] quanziLaBaImage]);
    }
    return _notice;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self.notice beginScroll];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.notice closeScroll];
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

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
        [self.view.layer insertSublayer:jbbj(self.view.bounds) atIndex:0];
    }
    self.view.backgroundColor = [[CPTThemeConfig shareManager] HomeViewBackgroundColor];

    [self getnewversion];
    
//   NSString *isFirstOpen = [[NSUserDefaults standardUserDefaults] valueForKey:@"isFirstOpen"];

//    if([isFirstOpen isEqualToString:@"1"]){
    
        [self getlistNoticeData];
//    }

    [self setmenuBtn:[[CPTThemeConfig shareManager] IC_Nav_SideImageStr]];
    
    @weakify(self)
    [self rigBtn:@"分享" Withimage:@"" With:^(UIButton *sender) {
        @strongify(self)
        
        if ([Person person].uid == nil) {
            LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
            login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            
            [self presentViewController:login animated:YES completion:^{
            }];
            return ;
        }
        
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"HKShareViewViewController" bundle:nil];
        HKShareViewViewController *shareVc = [storyBoard instantiateInitialViewController];
        [self.navigationController pushViewController:shareVc animated:YES];
 
    }];

    //    [self rigBtn:nil Withimage:@"礼包" With:^(UIButton *sender) {
    //
    //        ActiveListCtrl *active = [[ActiveListCtrl alloc]init];
    //
    //        PUSH(active);
    //    }];
    
    UIImage *titleimg ;
    
    titleimg =  [[CPTThemeConfig shareManager] IM_Nav_TitleImage_Logo];

    UIImageView *imgv = [[UIImageView alloc]initWithImage:titleimg];
    [self.navView addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.leftBtn);
        make.centerX.equalTo(self.navView);
        make.size.mas_equalTo(CGSizeMake(titleimg.size.width, titleimg.size.height));
    }];
    
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if ([userDefault valueForKey:LOTTERYTYPE]) {
        
        NSArray *array = [userDefault valueForKey:LOTTERYTYPE];
        
//        [self.dataSource addObjectsFromArray:array];
        
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
            ;


            NSDictionary *newDic = @{@"ID" : dict[@"ID"],@"select" : dict[@"select"], @"subtitle" : dict[@"subtitle"],@"title":dict[@"title"], @"icon" : iconStr};
            
            [newArray addObject:newDic];
        }
        [self.dataSource addObjectsFromArray:newArray];

        [self.dataSource addObject:@{@"title":@"更多彩种",@"ID":@(999),@"icon":[[CPTThemeConfig shareManager] IC_Home_GDCZ],@"subtitle":@"好挣好玩",@"hotTitle":@""}];
        
    }else {
        
//        NSArray *array = @[@{@"title":@"重庆时时彩",@"ID":@(1),@"icon":[[CPTThemeConfig shareManager] IC_Home_CQSSC],@"subtitle":@"全天59期",@"hotTitle":@"xin"},@{@"title":@"六合彩",@"ID":@(4),@"icon":[[CPTThemeConfig shareManager] IC_Home_LHC],@"subtitle":@"一周开三期",@"hotTitle":@"huo"},@{@"title":@"北京PK10",@"ID":@(6),@"icon":[[CPTThemeConfig shareManager] IC_Home_BJPK10],@"subtitle":@"全天44期",@"hotTitle":@"huo"},@{@"title":@"新疆时时彩",@"ID":@(2),@"icon":[[CPTThemeConfig shareManager] IC_Home_XJSSC],@"subtitle":@"全天48期",@"hotTitle":@"huo"},@{@"title":@"幸运飞艇",@"ID":@(7),@"icon":[[CPTThemeConfig shareManager] IC_Home_XYFT],@"subtitle":@"全天180期",@"hotTitle":@"huo"},@{@"title":@"比特币分分彩",@"ID":@(3),@"icon":[[CPTThemeConfig shareManager] IC_Home_TXFFC],@"subtitle":@"全天1440期",@"hotTitle":@"huo"},@{@"title":@"PC蛋蛋",@"ID":@(5),@"icon":[[CPTThemeConfig shareManager] IC_Home_PCDD],@"subtitle":@"全天179期",@"hotTitle":@"huo"}, @{@"title":@"足彩资讯",@"ID":@(9),@"icon":[[CPTThemeConfig shareManager] IC_Home_ZCZX],@"subtitle":@"专业数据分析",@"hotTitle":@"huo"},@{@"title":@"更多彩种",@"ID":@(999),@"icon":[[CPTThemeConfig shareManager] IC_Home_GDCZ],@"subtitle":@"好挣好玩",@"hotTitle":@""}];
        NSArray *array = @[@{@"title":@"六合彩",@"ID":@(4),@"icon":[[CPTThemeConfig shareManager] IC_Home_LHC],@"subtitle":@"一周开三期",@"hotTitle":@"huo"},@{@"title":@"足彩资讯",@"ID":@(9),@"icon":[[CPTThemeConfig shareManager] IC_Home_ZCZX],@"subtitle":@"专业数据分析",@"hotTitle":@"huo"},@{@"title":@"更多彩种",@"ID":@(999),@"icon":[[CPTThemeConfig shareManager] IC_Home_GDCZ],@"subtitle":@"好挣好玩",@"hotTitle":@""}];
        [self.dataSource addObjectsFromArray:array];
 
    }
    
    self.collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self noticeData];
    }];
    [self advertData];
    
    // if (DEBUG) {}
    
    [self bottomadvertData];
    
    [self noticeData];
    [self buildKeFuBtn];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //    return (self.dataSource.count + kItem_Number - 1) / kItem_Number + 1;
    
    if (self.dataSource.count%kItem_Number == 0) {
        return (self.dataSource.count + kItem_Number - 1) / kItem_Number + 1 ;
    }else if(self.dataSource.count%kItem_Number == 1){
        return (self.dataSource.count + kItem_Number - 1) / kItem_Number + 1;
    }else{
        return (self.dataSource.count + kItem_Number - 1) / kItem_Number + 1 ;
    }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //如果数组中有元素的时候走下面方法
    if (self.dataSource.count > 0) {
        
        //找到最后一个分区
        if (section == (self.dataSource.count + kItem_Number - 1) / kItem_Number-1) {
            
            //如果能被每行的个数整除
            if (self.dataSource.count % kItem_Number == 0) {
                //返回每行的个数
                return kItem_Number;
            }
            
            //不然返回元素个数对每行个数的取余数
            //            return self.dataSource.count % kItem_Number;
            return kItem_Number;
   
        }else if (section == (self.dataSource.count + kItem_Number - 1) / kItem_Number) {
            
            return 1;
        }
        
        //其他情况返回正常的个数
        return kItem_Number;

    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == (self.dataSource.count + kItem_Number - 1) / kItem_Number) {
        
        HomeADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XMFHomeAdCollectionViewCell forIndexPath:indexPath];
        
        cell.pagerView.delegate = self;
        cell.pagerView.dataSource = self;
        cell.backgroundColor = cell.contentView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_ADCollectionViewCell_Back];
    
        [cell.pagerView reloadData];
        
        return cell;
    }
    
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = cell.contentView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_ADCollectionViewCell_Back];

    if (indexPath.row + indexPath.section * kItem_Number < self.dataSource.count ) {
        NSInteger type = indexPath.row + indexPath.section * kItem_Number;
        
        NSDictionary *dic = self.dataSource[type];

        cell.iconimgv.image = [UIImage imageNamed:dic[@"title"]];
        
        cell.titlelab.text = dic[@"title"];
        cell.subTitleLbl.text = dic[@"subtitle"];
//        cell.backgroundColor = CLEAR;
        
        cell.isHiddened = YES;
        cell.isSelected = YES;
        //当选中的时候让色块出现
        if (indexPath == self.indexPath)
        {
            if (self.isSelected) {
                cell.isHiddened = NO;
                cell.isSelected = NO;
//                cell.contentView.backgroundColor = [UIColor colorWithHex:@"eeeeee"];
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

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    @weakify(self)

    if (kind == UICollectionElementKindSectionHeader) {
        
        if (indexPath.section == 0) {
            
            HomeHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:RJHeaderIdentifier forIndexPath:indexPath];
            self.notice.adTitles = self.NoticeArray.count > 0 ? self.NoticeArray : @[@""];
            self.notice.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
            self.notice.color = [[CPTThemeConfig shareManager] CO_Home_NoticeView_LabelText];
            [header.noticeView addSubview:self.notice];
            [self.notice beginScroll];
//            header.bannerView.placeholderImage = IMAGE(@"轮播图");
            header.bannerView.currentPageDotImage = [Tools createImageWithColor:WHITE Withsize:CGSizeMake(12, 2)];
            header.bannerView.pageDotImage = [Tools createImageWithColor:[UIColor colorWithWhite:1 alpha:0.5] Withsize:CGSizeMake(12, 2)];
            header.delegate = self;

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
            
            return header;
        }
        else{
            return nil;
            
        }
    }
    else {
        
        HomeFootView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:RJFooterIdentifier forIndexPath:indexPath];
        
        footer.showall = self.showall;
        
        NSInteger data_type = self.indexPath.row + self.indexPath.section * kItem_Number;
        
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
    
    if (indexPath.section == (self.dataSource.count + kItem_Number - 1) / kItem_Number) {
        
        return CGSizeMake(self.view.frame.size.width, 120);
    }
    
    CGFloat itemWidth = (SCREEN_WIDTH - 0 * (kItem_Number - 1)) / kItem_Number;
    
    if (IS_IPHONEX) {
        return CGSizeMake(itemWidth, 125);
    }

    return CGSizeMake(itemWidth, 110);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 30 + SCREEN_WIDTH * 0.467 + 20 + 152 + 90);
    }
    else{
        return CGSizeZero;
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    //    if (section == self.dataArray.count / kItem_Number) {
    //        return UIEdgeInsetsMake(15, 20, 5, 15);//分别为上、左、下、右
    //    }
    //    if (section == 2) {
    //        return UIEdgeInsetsMake(10, 0, 0, 0);
    //    }
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    @weakify(self)
    
    if (self.sectionAry.count == 0 || self.isSelected == NO) {
        
        return CGSizeZero;
    }
    
    NSInteger data_type = self.indexPath.row + self.indexPath.section * kItem_Number;
    
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
                
                [UIView animateWithDuration:0.5 animations:^{
                    @strongify(self)

                    if (IS_IPHONEX) {
                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.7)];

                    }else{
                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.9)];
                    }
                        
                }];
                
                return CGSizeMake(SCREEN_WIDTH, itemWidth * 6 + 160);
            }
            else {
                
                [UIView animateWithDuration:0.5 animations:^{
                    @strongify(self)

                    if (IS_IPHONEX) {
                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.5 - 120)];
                    }else{
                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.5 + 10)];
                    }
  
                }];
                
                return CGSizeMake(SCREEN_WIDTH, itemWidth * 2 + 180);
            }
        }
        else if (type == 6 || type == 7 || type == 11) {
            
            if (self.showall) {
                
                [UIView animateWithDuration:0.5 animations:^{
                    @strongify(self)

                    if (IS_IPHONEX) {
                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.5)];
                        
                    }else{
                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.7)];
                        
                    }
                    
                }];
                
                return CGSizeMake(SCREEN_WIDTH, itemWidth * 5 + 20);
            }
            else {
                
                [UIView animateWithDuration:0.5 animations:^{
                    @strongify(self)

                    if (IS_IPHONEX) {
                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.5 - 120)];
                    }else{
                        [self.collectView setContentOffset:CGPointMake(0, self.view.height*0.5 + 10)];
                    }
                    
                }];
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
    
    NSInteger type = indexPath.row + indexPath.section * kItem_Number;
    
    if (indexPath.section == (self.dataSource.count + kItem_Number - 1) / kItem_Number) {
        
        AdvertModel *advmodel = self.bottomArray.firstObject;
        
        [self advertpush:advmodel];
        
        return;
    }
    
    @weakify(self)
    if (type == self.dataSource.count-1) {
        
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
}

#pragma mark - HomeheaderViewDelegate
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
    
    NSString *clientID = [UIDevice currentDevice].identifierForVendor.UUIDString;
    NSString *sourceOfUser = [NSString stringWithFormat:@"ios:%@",clientID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    [dic setObject:sourceOfUser forKey:@"sourceOfUser"];
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

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    
    return self.bottomimgs.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    
    UICollectionViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:cell.bounds];
    icon.layer.cornerRadius = 5;
    icon.layer.masksToBounds = YES;
    [cell.contentView addSubview:icon];
    [icon sd_setImageWithURL:self.bottomimgs[index] placeholderImage:IMAGE(@"adHoldplace") options:SDWebImageRefreshCached];
//    icon.image = IMAGE(self.bottomimgs[index]);
    UIImageView *imgv = [pagerView viewWithTag:100];
    if (imgv) {
        [imgv removeFromSuperview];
    }
    
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame)*0.88, CGRectGetHeight(pageView.frame)*0.8);
    layout.itemSpacing = 15;
//    pageView.backgroundColor = HomeMainColor;
    pageView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_ADCollectionViewCell_Back];

    //layout.minimumAlpha = 0.3;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",(long)fromIndex,(long)toIndex);
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index{
    
}

-(void)advertpush:(AdvertModel *)model {
    
   
    if (model.url.length > 0) {
        CPTWebViewController * web = [[CPTWebViewController alloc] init];
        web.urlStr = model.url;
        web.title = model.title;
        PUSH(web);
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
        [self.NoticeArray removeAllObjects];
        
        if ([data.data isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *dic in data.data) {
                
                if ([dic[@"intro"]length] > 0) {
                    
                    [self.NoticeArray addObject:dic[@"intro"]];
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

-(NSMutableArray *)NoticeArray {
    
    if (!_NoticeArray) {
        
        _NoticeArray = [[NSMutableArray alloc]init];
    }
    return _NoticeArray;
}

-(NSMutableArray *)bottomimgs {
    
    if (!_bottomimgs) {
        
        _bottomimgs = [[NSMutableArray alloc]init];
    }
    return _bottomimgs;
}

-(void)getnewversion {
    
    NSString *key = @"CFBundleShortVersionString";
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    @weakify(self)
    [WebTools postWithURL:@"/app/editionUpdate.json" params:@{@"appId":[AppDelegate shareapp].wkjScheme == Scheme_LotterEight ? @"4" : @"2",@"appEdittion":currentVersion} success:^(BaseData *data) {
        @strongify(self)
        if ([data.data isKindOfClass:[NSDictionary class]]) {
            
            NSString *url = data.data[@"downUrl"];
            
            NSInteger noticeStatus = [data.data[@"noticeStatus"]integerValue];
            
            NSString *message = [NSString stringWithFormat:@"%@\n大小：%@ M", data.data[@"message"],data.data[@"size"]];
            
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

@end
