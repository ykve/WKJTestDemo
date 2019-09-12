//
//  CPTOpenLotteryRootCtrlViewController.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/3/23.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTOpenLotteryRootCtrlViewController.h"
#import "CPTOpenLotteryCtrl.h"


@interface CPTOpenLotteryRootCtrlViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) CJScroViewBar *topView;
@end

@interface CPTOpenLotteryRootCtrlViewController ()



@end

@implementation CPTOpenLotteryRootCtrlViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
 
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[CPTOpenLotteryManager shareManager] checkModelByIds:[[CPTBuyDataManager shareManager] allLotteryIds] callBack:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOpenLotteryUI" object:data];
    }];
    [[CPTOpenLotteryManager shareManager] startTimer];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[CPTOpenLotteryManager shareManager] pauseTimer];
}

- (void)loadView{
    [super loadView];
    
}

- (void)loadUIScrollView {
    _topView = [[CJScroViewBar alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 40)];
    [self.view addSubview:self.topView];
    self.topView.isCart = YES;
    self.topView.lineHeight = 2.0;
    self.topView.backgroundColor = [[CPTThemeConfig shareManager] CartBarBackgroundColor];
    self.topView.lineColor = [[CPTThemeConfig shareManager] CartBarTitleSelectColor];
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT+40, SCREEN_WIDTH, SCREEN_HEIGHT-40-NAV_HEIGHT-Tabbar_HEIGHT)];
    self.myScrollView.delegate = self;
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.bounces = NO;
    self.myScrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:self.myScrollView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setmenuBtn:[[CPTThemeConfig shareManager] IC_Nav_SideImageStr]];

     @weakify(self)
    if ([AppDelegate shareapp].wkjScheme == Scheme_LotterProduct) {
        NSString * titleName =@"td_nav_openL_icon";
        if([[AppDelegate shareapp] sKinThemeType]== SKinType_Theme_White){
            titleName = @"tw_nav_openL_center";
        }
       
        UIImageView *imgv = [[UIImageView alloc]initWithImage:IMAGE(titleName)];
        [self.navView addSubview:imgv];
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.equalTo(self.leftBtn);
            make.centerX.equalTo(self.navView);
            make.size.mas_equalTo(CGSizeMake(imgv.image.size.width, imgv.image.size.height));
        }];
    } else {
        self.titlestring = @"开奖";
    }
    
    
    
    [self loadUIScrollView];
    
    //    NSArray * playArray = @[@"官方",@"时时彩",@"PK10",@"六合彩",@"番摊",@"牛牛"];
    //    NSArray * playTypeArray = @[@[@(CPTBuyTicketType_SSC),@(CPTBuyTicketType_XJSSC),@(CPTBuyTicketType_TJSSC),@(CPTBuyTicketType_LiuHeCai),@(CPTBuyTicketType_PK10),@(CPTBuyTicketType_AoMenPK10),@(CPTBuyTicketType_XYFT),@(CPTBuyTicketType_DaLetou),@(CPTBuyTicketType_PaiLie35),@(CPTBuyTicketType_HaiNanQiXingCai),@(CPTBuyTicketType_Shuangseqiu),@(CPTBuyTicketType_3D),@(CPTBuyTicketType_QiLecai),@(CPTBuyTicketType_AoZhouACT)],
    //                            @[@(CPTBuyTicketType_SSC),@(CPTBuyTicketType_XJSSC),@(CPTBuyTicketType_TJSSC),@(CPTBuyTicketType_TenSSC),@(CPTBuyTicketType_FiveSSC),@(CPTBuyTicketType_JiShuSSC),@(CPTBuyTicketType_HuanLe_Shishicai),@(CPTBuyTicketType_FFC)],
    //
    //                            @[@(CPTBuyTicketType_PK10),@(CPTBuyTicketType_TenPK10),@(CPTBuyTicketType_FivePK10),@(CPTBuyTicketType_JiShuPK10),@(CPTBuyTicketType_AoMenPK10),@(CPTBuyTicketType_XYFT),@(CPTBuyTicketType_HuanLe_Saiche),@(CPTBuyTicketType_HuanLe_FeiTing)],
    //
    //                                @[@(CPTBuyTicketType_LiuHeCai),@(CPTBuyTicketType_OneLiuHeCai),@(CPTBuyTicketType_FiveLiuHeCai),@(CPTBuyTicketType_ShiShiLiuHeCai)],
    //
    //                                @[@(CPTBuyTicketType_FantanPK10),@(CPTBuyTicketType_FantanXYFT),@(CPTBuyTicketType_FantanSSC)],
    //
    //                                @[@(CPTBuyTicketType_NiuNiu_KuaiLe),@(CPTBuyTicketType_NiuNiu_AoZhou),@(CPTBuyTicketType_NiuNiu_JiShu),]];
    
    NSArray * playArray = @[@"全部",@"澳洲系列",@"六合彩",@"时时彩",@"PK10",@"番摊",@"牛牛"];
    NSArray * playTypeArray = @[
                                [[CPTBuyDataManager shareManager] allLotteryIds],
                                @[@(CPTBuyTicketType_AoZhouF1),@(CPTBuyTicketType_AoZhouACT),@(CPTBuyTicketType_AoZhouShiShiCai)],
                                @[@(CPTBuyTicketType_LiuHeCai),@(CPTBuyTicketType_OneLiuHeCai),@(CPTBuyTicketType_FiveLiuHeCai),@(CPTBuyTicketType_ShiShiLiuHeCai)],
                                @[@(CPTBuyTicketType_SSC),@(CPTBuyTicketType_XJSSC),@(CPTBuyTicketType_TJSSC),@(CPTBuyTicketType_TenSSC),@(CPTBuyTicketType_FiveSSC),@(CPTBuyTicketType_JiShuSSC),@(CPTBuyTicketType_FFC)],
                                @[@(CPTBuyTicketType_PK10),@(CPTBuyTicketType_TenPK10),@(CPTBuyTicketType_FivePK10),@(CPTBuyTicketType_JiShuPK10),@(CPTBuyTicketType_XYFT)],
                                
                                @[@(CPTBuyTicketType_FantanPK10),@(CPTBuyTicketType_FantanXYFT),@(CPTBuyTicketType_FantanSSC)],
                                @[@(CPTBuyTicketType_NiuNiu_KuaiLe),@(CPTBuyTicketType_NiuNiu_AoZhou),@(CPTBuyTicketType_NiuNiu_JiShu)],
                                ];
    
    [self.topView setData:playArray NormalColor:[[CPTThemeConfig shareManager] CartBarTitleNormalColor] SelectColor: [[CPTThemeConfig shareManager] CartBarTitleSelectColor] Font:[UIFont systemFontOfSize:13]];
    
    self.myScrollView.contentSize = CGSizeMake(playArray.count*SCREEN_WIDTH, 40);

    for (int i=0; i<playArray.count; i++) {
        
        CPTOpenLotteryCtrl * vc;
//        if (i == 1) {
//            vc = [[CPTOpenLotteryManager shareManager] longVC];
//            vc.idArray = playTypeArray[i];
//            vc.changlong = YES;
//
//        }else{
            vc = [[CPTOpenLotteryCtrl alloc] init];
            vc.idArray = playTypeArray[i];
            vc.changlong = NO;
//        }
        vc.isShowNav = NO;
        vc.view.frame = CGRectMake(SCREEN_WIDTH *i, 0, SCREEN_WIDTH, self.myScrollView.bounds.size.height);
        [self addChildViewController:vc];
        [self.myScrollView addSubview:vc.view];
    }
    [self.topView setViewIndex:0];
    self.myScrollView.contentOffset = CGPointMake(0, 0);

    [self.topView getViewIndex:^(NSString *title, NSInteger index) {
        [UIView animateWithDuration:0.3 animations:^{
            @strongify(self)
            self.myScrollView.contentOffset = CGPointMake(index * SCREEN_WIDTH, 0);
        }];
    }];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self.topView setViewIndex:index];
}


@end
