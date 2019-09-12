//
//  CartCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartCtrl.h"
#import "CartBeijinPK10Ctrl.h"
#import "CartPCCtrl.h"
#import "CartSixCtrl.h"
#import "CartHomeModel.h"
#import "CartHomeCell.h"
#import "CartHomeCollectionViewCell.h"
#import "CartHomeHeaderView.h"
#import "CartChongqingBPanViewController.h"
#import "CartBPanBeijingPKViewController.h"
#import "CartHomeFooterCollectionReusableView.h"
#import "CrartHomeSubModel.h"
#import "LoginAlertViewController.h"
#import "CPTBuySexViewController.h"
#import "CPTBuyHomeCtrl.h"
#import "CPTBuyFantanCtrl.h"
#import "CPTOpenLotteryCtrl.h"
#import "CPTChangLongController.h"
#import "CPTBuyRootVC.h"
#import "CPTWebViewController.h"
#define kLineItem_Number 2
#import "EsgameViewController.h"
#import "KeFuViewController.h"

@interface CartCtrl ()<WB_StopWatchDelegate, CartHomeHeaderViewDelegate>

@property (nonatomic, assign) NSInteger curenttime;


@property (nonatomic, strong)UICollectionViewFlowLayout *layout;

@property (nonatomic, strong)UICollectionView *collectView;

@property (nonatomic, assign)BOOL isShowFooter;

//记录点击的 section
@property (nonatomic, assign)NSInteger sectionNum;

@property (nonatomic, assign)NSIndexPath* selectIndexPath;

@property (nonatomic, strong) CartHomeModel *selectModel;

@property (nonatomic, weak)CartHomeHeaderView *footer;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) CJScroViewBar *topScroViewBar;
@property (nonatomic, strong) UICollectionView *myCollectionView;

@property (nonatomic, strong) EsgameViewController*esgameVC;
@end

@implementation CartCtrl

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(self.topScroViewBar.selectindex==2){
        if([[Person person] uid]){
            [[Person person] checkIsNeedRMoney:^(double money) {
            } isNeedHUD:NO];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CPTOpenLotteryManager shareManager] openSocket];
    self.view.backgroundColor = [[CPTThemeConfig shareManager] CO_buyLotBgColor];
    
    [self setNavUI];
  
    [MobClick setLogEnabled:NO];
    _topScroViewBar = [[CJScroViewBar alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 40)];
    [self.view addSubview:self.topScroViewBar];
    self.topScroViewBar.isCart = YES;
    self.topScroViewBar.lineHeight =  2.0;
    self.topScroViewBar.backgroundColor = [[CPTThemeConfig shareManager] CartBarBackgroundColor];
    self.topScroViewBar.lineColor = [[CPTThemeConfig shareManager] CartBarTitleSelectColor];
    
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT+40, SCREEN_WIDTH, SCREEN_HEIGHT-40-NAV_HEIGHT-Tabbar_HEIGHT)];
    self.myScrollView.delegate = self;
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.bounces = NO;
    self.myScrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:self.myScrollView];

    
    _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,_myScrollView.frame.size.height) collectionViewLayout:self.layout];
    self.myCollectionView.backgroundColor = [[CPTThemeConfig shareManager] Buy_HomeView_BackgroundColor];
    self.myCollectionView.showsVerticalScrollIndicator = NO;
    [self.myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CartHomeCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CartHomeCollectionViewCellID];
    [self.myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"buyLotteryTopLineID"];
    [self.myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CartHomeHeaderView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CartHomeHeaderViewID];
    [self.myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CartHomeHeaderView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CartHomeHeaderViewID];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myScrollView addSubview:self.myCollectionView];
    
    NSArray * playArray = @[@"彩票类",@"棋牌类",@"电竞",@"真人视讯",@"足彩"] ;
    NSArray * playTypeArray = @[@(CPTBuyHomeType_QiPai),@(CPTBuyHomeType_DianJing),@(CPTBuyHomeType_ZhenRenShiXun),@(CPTBuyHomeType_ZuCai)];
    
    [self.topScroViewBar setData:playArray NormalColor:[[CPTThemeConfig shareManager] CartBarTitleNormalColor] SelectColor: [[CPTThemeConfig shareManager] CartBarTitleSelectColor] Font:[UIFont systemFontOfSize:13]];

    self.myScrollView.contentSize = CGSizeMake(playArray.count*SCREEN_WIDTH, 0);
    for (int i=0; i<playArray.count; i++) {
       if(i==2){
           if(!self.esgameVC){
               self.esgameVC = [[EsgameViewController alloc] init];
               self.esgameVC.view.frame = CGRectMake(SCREEN_WIDTH *i, 0, SCREEN_WIDTH, self.myScrollView.bounds.size.height);
               [self addChildViewController:self.esgameVC];
               [self.myScrollView addSubview:self.esgameVC.view];
               [self.esgameVC changeWebViewHeight:self.myScrollView.bounds.size.height];
           }
       }else  if(i!=0){
           CPTBuyHomeCtrl * vc = [[CPTBuyHomeCtrl alloc] init];
           vc.type = [playTypeArray[i-1] integerValue];
           vc.view.frame = CGRectMake(SCREEN_WIDTH *i, 0, SCREEN_WIDTH, self.myScrollView.bounds.size.height);
           [self addChildViewController:vc];
           [self.myScrollView addSubview:vc.view];
       }
    }
    [self.dataSource addObjectsFromArray:[Tools readDataFromPlistFile:@"buyLotteryPlist.plist"]];
    [self initData];

    
    //TabBar回调
    [self.topScroViewBar getViewIndex:^(NSString *title, NSInteger index) {
        [UIView animateWithDuration:0.3 animations:^{
            self.myScrollView.contentOffset = CGPointMake(index * SCREEN_WIDTH, 0);
        }];
        if(index !=4){
            if(self.topScroViewBar.selectindex==2){
                //            if([[Person person] uid]== nil){
                [self.esgameVC changeWebViewHeight:self.myScrollView.bounds.size.height];
                //            }
            }else{
                if([[Person person] uid]){
                    [[Person person] checkIsNeedRMoney:^(double money) {
                    } isNeedHUD:NO];
                }
            }
        }
    }];
    [self.topScroViewBar setViewIndex:0];
}


- (void)setNavUI {
    
    [self setmenuBtn:[[CPTThemeConfig shareManager] IC_Nav_SideImageStr]];
    NSString * titleName =@"td_nav_home_logo";
    NSString * kefuName =@"td_nav_kefu_icon";
    if([[AppDelegate shareapp] sKinThemeType]== SKinType_Theme_White){
        titleName = @"tw_nav_hometitle_logo";
        kefuName = @"tw_kefu_icon";
    }
   
    @weakify(self)
    if ([AppDelegate shareapp].wkjScheme == Scheme_LotterProduct) {
        
        [self rigBtnImage:kefuName With:^(UIButton *sender) {
            @strongify(self)
            [self goto_kefu];
        }];
    } else {
        
        [self rigBtn:@" 客服" Withimage:[[CPTThemeConfig shareManager] IC_Nav_Kefu_Text] With:^(UIButton *sender) {
            @strongify(self)
            [self goto_kefu];
        }];
    }
    
    UIImageView *imgv = [[UIImageView alloc]initWithImage:IMAGE(titleName)];
    [self.navView addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rightBtn);
        make.centerX.equalTo(self.navView);
        make.size.mas_equalTo(CGSizeMake(imgv.image.size.width, imgv.image.size.height));
    }];
}

- (void)goto_kefu {
    KeFuViewController *kefuVc = [[KeFuViewController alloc] init];
    PUSH(kefuVc);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self.topScroViewBar setViewIndex:index];
}

- (void)loadEsgameData{
    NSDictionary *dic = @{@"userId":[Person person].uid,@"account":[Person person].account};
    @weakify(self)
    [WebTools postWithURL:@"/esgame/go.json" params:dic success:^(BaseData *data) {
        @strongify(self)
        if(data.status.integerValue == 1){
            MBLog(@"%@",data.data);
            NSString *url = data.data;

        }else{
            [MBProgressHUD showMessage:data.info];
        }
    } failure:^(NSError *error) {
        MBLog(@"%@",error.description);
    }];
}


- (void)skipToBPan:(CrartHomeSubModel *)subModel{

    NSInteger num = self.selectIndexPath.section * kLineItem_Number + self.selectIndexPath.item;
    
    CartHomeModel *model = [self.dataSource objectAtIndex:num];
    MBLog(@"%ld",(long)subModel.ID);
    MBLog(@"categoryId-%ld",(long)model.categoryId);
    MBLog(@"lotteryId-%ld",(long)subModel.lotteryId);
//    return;
    if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该彩种暂未开放" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
    }else{
        if(!subModel.isWork){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该彩种暂未开放" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    if(model.categoryId == CPTBuyCategoryId_FT||subModel.lotteryId == CPTBuyTicketType_Shuangseqiu||subModel.lotteryId == CPTBuyTicketType_DaLetou||subModel.lotteryId == CPTBuyTicketType_QiLecai||model.categoryId == CPTBuyCategoryId_NN){//番摊&双色球，大乐透，七乐彩
        CPTBuyRootVC * vc = [[CPTBuyRootVC alloc] init];
        vc.lotteryId = subModel.lotteryId;
            CPTBuyFantanCtrl *fantanVC = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"CPTBuyFantanCtrl"];
            fantanVC.endTime = subModel.endTime;
            fantanVC.lotteryName = subModel.name;
            fantanVC.type = subModel.lotteryId;
            fantanVC.lotteryId = subModel.lotteryId;
            fantanVC.categoryId = model.categoryId;
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
            six.categoryId = model.categoryId;
            six.lotteryId = subModel.lotteryId;
        vc.type = six.type;
        [vc loadVC:six title:subModel.name];
        PUSH(vc);

    }
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //   self.dataSource.count - (section + 1) * kItem_Number
    //如果能被每行的个数整除
    if (self.dataSource.count % kLineItem_Number == 0) {
        //返回每行的个数
        return  kLineItem_Number;
        
    }else{
        
        if (section == self.dataSource.count/kLineItem_Number) {
            return self.dataSource.count % kLineItem_Number;
        }else{
            return kLineItem_Number;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CartHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CartHomeCollectionViewCellID forIndexPath:indexPath];
    
    cell.backgroundColor = [[CPTThemeConfig shareManager] Buy_HomeView_BackgroundColor];
    
    NSInteger num = indexPath.section * kLineItem_Number + indexPath.item;
    
    CartHomeModel *model = [self.dataSource objectAtIndex:num];
    NSString *imageName;
    
    SKinThemeType sKinThemeType = [[AppDelegate shareapp] sKinThemeType];
   
    imageName = model.cateName;
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        imageName = [NSString stringWithFormat:@"tw_%@",imageName];
    }

    cell.icon.image = IMAGE(imageName);
    
    cell.titlelab.text = model.cateName;
    cell.subTitleLbl.text = model.intro;
    
    cell.isSelected = NO;
    //当选中的时候让色块出现
    if (indexPath == self.selectIndexPath){
        if (self.isSelected) {
            cell.isSelected = YES;
        }
    }
    
    cell.titlelab.textColor = [[CPTThemeConfig shareManager] CO_Home_CollectionView_CartCellTitle];
    cell.subTitleLbl.textColor = [[CPTThemeConfig shareManager] CO_Home_CellCartCellSubtitleText];
    cell.timelab.textColor = [UIColor lightGrayColor];
    
    return cell;
}



#pragma mark collectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionFooter) {
        if (self.isShowFooter) {
            
           CartHomeHeaderView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CartHomeHeaderViewID forIndexPath:indexPath];

            footer.delegate = self;
            self.footer = footer;
            self.footer.model = self.selectModel;

            return footer;

        }else{
            return nil;
        }
    }else if(kind == UICollectionElementKindSectionHeader){
        
        if (indexPath.section != 0) {
            UICollectionReusableView *topLine = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"buyLotteryTopLineID" forIndexPath:indexPath];
            topLine.backgroundColor = [[CPTThemeConfig shareManager] CartSectionLineColor];
            return topLine;
        }else{
            return nil;
        }

    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        return CGSizeMake(SCREEN_WIDTH, 1);
    }else{
        return CGSizeMake(0, 0);
    }
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CartHomeModel *model = self.dataSource[indexPath.section * kLineItem_Number + indexPath.item];

    if ([model.name isEqualToString:@"长龙资讯"]) {
        if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该彩种暂未开放" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        CPTChangLongController * longV = [[CPTChangLongController alloc] init];
        [self.navigationController pushViewController:longV animated:YES];
        return;
    }
    
    if(self.selectIndexPath != indexPath) {
        self.isShowFooter = YES;
        self.sectionNum = indexPath.section;
        self.selectIndexPath = indexPath;
        self.isSelected = self.isShowFooter;
        
        CartHomeModel *model = self.dataSource[indexPath.section * kLineItem_Number + indexPath.item];
        self.selectModel = model;
        CartHomeCollectionViewCell *cell = (CartHomeCollectionViewCell *)[self.myCollectionView cellForItemAtIndexPath:indexPath];
        cell.isSelected = self.isShowFooter;
    } else {
        self.isShowFooter = !self.isShowFooter;
        self.sectionNum = indexPath.section;
        self.selectIndexPath = indexPath;
        self.isSelected = self.isShowFooter;
        
        CartHomeModel *model = self.dataSource[indexPath.section * kLineItem_Number + indexPath.item];
        self.selectModel = model;
        CartHomeCollectionViewCell *cell = (CartHomeCollectionViewCell *)[self.myCollectionView cellForItemAtIndexPath:indexPath];
        cell.isSelected = self.isShowFooter;
    }
    
    [self.myCollectionView reloadData];
    [self.myCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}

- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{

    if (self.sectionNum == section) {
        if (self.isShowFooter) {
            NSInteger s = self.selectModel.lotterys.count/2;
            if (self.selectModel.lotterys.count%2 != 0) {
               s = s +1;
            }
            CGSize size = CGSizeMake(SCREEN_WIDTH, (s * 44) + (s-1)*22 + 34*2);
            return size;
            
        }else{
            return CGSizeZero;
        }
    }else{
        return CGSizeZero;
    }
  
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.0f, 15.0f, 0.0f, 15.0f);
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (self.dataSource.count%kLineItem_Number == 0) {
        return self.dataSource.count/kLineItem_Number;
        
    }else{
        return self.dataSource.count/kLineItem_Number + 1;
    }

}




-(void)initData {
    
    [WebTools postWithURL:@"/lottery/queryLotteryList.json" params:nil success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return;
        }
        [Tools saveDataToPlistFile:data.data WithName:@"buyLotteryPlist.plist"];
        [self.dataSource removeAllObjects];
        NSArray *array = [CartHomeModel mj_objectArrayWithKeyValuesArray:data.data];
        self.curenttime = data.time;
        for (CartHomeModel *model in array) {
//            CrartHomeSubModel *subModel = model.lotterys.firstObject;
            switch (model.ID) {
                case 1:
                    model.icon = model.isWork ? @"home_1":@"home_1_un";
                    break;
                case 2:
                    model.icon = model.isWork ? @"home_4":@"home_4_un";
                    break;
                case 3:
                    model.icon = model.isWork ? @"home_6":@"home_6_un";
                    break;
                case 4:
                    model.icon = model.isWork ? @"home_2":@"home_2_un";
                    break;
                case 5:
                    model.icon = model.isWork ? @"home_7":@"home_7_un";
                    break;
                case 6:
                    model.icon = model.isWork ? @"home_3":@"home_3_un";
                    break;
                case 7:
                    model.icon = model.isWork ? @"home_5":@"home_5_un";
                    break;
                default:
                    break;
            }
            
            [self.dataSource addObject:model];
        }
        [self.myCollectionView reloadData];
        [self endRefresh:self.myCollectionView WithdataArr:array];
    } failure:^(NSError *error) {
        [self endRefresh:self.myCollectionView WithdataArr:nil];
    } showHUD:NO];
}



-(UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        CGFloat itemSpace = 0;
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.minimumInteritemSpacing = itemSpace;
        _layout.minimumLineSpacing = itemSpace;
        CGFloat itemWidth = (SCREEN_WIDTH - 30 - itemSpace * (kLineItem_Number + 1)) / kLineItem_Number;
        _layout.itemSize = CGSizeMake(itemWidth, 110);
//        _layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 30 + SCREEN_WIDTH * 0.4 + 10);
    }
    return _layout;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
