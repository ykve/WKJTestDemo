//
//  LeftViewController.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/13.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LeftViewController.h"
#import "BuyLeftCell.h"
#import "BuyLeftHeader.h"
#import "CartHomeModel.h"
#import "CPTBuyRootVC.h"
#import "ChatRoomCtrl.h"
#import "CPTBuySexViewController.h"
#import "CPTBuyFantanCtrl.h"
#import "CPTChangLongController.h"
#import "LeftLotteryCell.h"

@interface LeftViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UICollectionViewFlowLayout *layout;
@property (nonatomic, assign)NSInteger icon_Number;
@property (nonatomic, strong)UICollectionView *collectView;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (strong, nonatomic) UIControl *overlayView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CartHomeModel * currentmodel;
@property (nonatomic, assign)NSInteger currentIndex;


@end

@implementation LeftViewController
-(NSMutableArray *)dataSource {
    
    if(!_dataSource){
        
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

-(UITableView *)tableView {
    
    if (!_tableView){
        
        UIView * nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.75, NAV_HEIGHT)];
        [nav setBackgroundColor:[[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack]];
        [self addSubview:nav];
        
        UILabel * titleLa = [[UILabel alloc] initWithFrame:CGRectMake(0, IS_IPHONEX?40:0, SCREEN_WIDTH*0.75, IS_IPHONEX?NAV_HEIGHT-40:NAV_HEIGHT)];
        [nav addSubview:titleLa];
        titleLa.text = @"更多彩种";
        titleLa.textAlignment = NSTextAlignmentCenter;
        titleLa.textColor = [[CPTThemeConfig shareManager] CO_NavigationBar_TintColor];
        
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, 90, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 40;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.backgroundColor = [[CPTThemeConfig shareManager] CO_BuyLot_Left_ViewBack];
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LeftLotteryCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RJCellIdentifiervv"];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self addSubview:_tableView];

        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(89.5, NAV_HEIGHT, 0.5, SCREEN_HEIGHT)];
        [self addSubview:line];
        line.backgroundColor = [UIColor hexStringToColor:@"3d3e42"];
    }
    return _tableView;
}

-(UICollectionViewFlowLayout *)layout {
    
    if (!_layout) {
        CGFloat itemSpace = 0;
        
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        _layout.minimumInteritemSpacing = itemSpace;
        
        _layout.minimumLineSpacing = itemSpace;
        
        CGFloat itemWidth = (SCREEN_WIDTH*0.75 - itemSpace * (self.icon_Number - 1)) / self.icon_Number;
        
        _layout.itemSize = CGSizeMake(itemWidth, 110);
        
//        _layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH*0.75 , 30 + SCREEN_WIDTH*0.75  * 0.4 + 10);
    }
    
    return _layout;
}

-(UICollectionView *)collectView {
    
    if (!_collectView) {
        
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        
//        _collectView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_ADCollectionViewCell_Back];//[[CPTThemeConfig shareManager] HomeViewBackgroundColor];
        _collectView.backgroundColor = [[CPTThemeConfig shareManager] CO_BuyLot_Left_ViewBack];

        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([BuyLeftCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:RJCellIdentifier];

        _collectView.showsVerticalScrollIndicator = NO;
        
        _collectView.delegate = self;
        
        _collectView.dataSource = self;
        
        [self addSubview:_collectView];
        
        [_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(NAV_HEIGHT, 90, 0, 0));
        }];
    }
    return _collectView;
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        [self loadview];
    }
    return self;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)loadview {
    self.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH *0.75, SCREEN_HEIGHT + SAFE_HEIGHT);

    self.backgroundColor = [UIColor hexStringToColor:@"27282d"];

    _overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _overlayView.backgroundColor = [UIColor colorWithHex:@"18191D"];
    _overlayView.alpha = 0.4;
    self.icon_Number = 3;

    self.backgroundColor = [[CPTThemeConfig shareManager] HomeViewBackgroundColor];
    
//    [self.dataSource addObject:[self configFavData]];
    [self.dataSource addObjectsFromArray:[Tools readDataFromPlistFile:@"buyLotteryPlist.plist"]];

//    self.collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self initData];
//    }];
    self.currentIndex = 0;
    [self initData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.currentmodel) {
        return self.currentmodel.lotterys.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BuyLeftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    CrartHomeSubModel * subModel = self.currentmodel.lotterys[indexPath.row];

    cell.titlelab.text = [NSString stringWithFormat:@"%@",subModel.name];
    NSString *imagen = subModel.name;
    if([imagen isEqualToString:@"排列3/5"]){
        imagen = @"排列35";
    }
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        imagen = [NSString stringWithFormat:@"tw_%@",imagen];
    }
    cell.iconImageV.image = IMAGE(imagen);
    cell.backgroundColor = cell.contentView.backgroundColor = CLEAR;
    cell.titlelab.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_Left_CellTitleText];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if([self.currentmodel.cateName isEqualToString:@"番摊专区"]){
        return CGSizeMake(SCREEN_WIDTH-90-SCREEN_WIDTH*0.25, 60);
//    }
//     return CGSizeMake((self.bounds.size.width-90)/2, 42);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    BuyLeftCell *cell = (BuyLeftCell *)[collectionView cellForItemAtIndexPath:indexPath];
    CartHomeModel * model = self.currentmodel;

    CrartHomeSubModel * subModel = model.lotterys[indexPath.row];
//    CPTBuySexViewController *six = [[CPTBuySexViewController alloc]init];
//    six.type = subModel.lotteryId;
//    six.endTime = subModel.endTime;
//    [[CPTBuyDataManager shareManager] configType:six.type];
//    six.lottery_type = subModel.ID;
//    six.categoryId = subModel.categoryId;
//    six.lotteryId = subModel.lotteryId;
//    [self cw_pushViewController:six];
//    return;
    if ([subModel.name isEqualToString:@"长龙资讯"]) {
        CPTChangLongController * longV = [[CPTChangLongController alloc] init];
        [self.vc.navigationController pushViewController:longV animated:YES];
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
         [self.vc.navigationController pushViewController:vc animated:YES];
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
        [self.vc.navigationController pushViewController:vc animated:YES];
    }
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.vc.navigationController.viewControllers];
    for (UIViewController *vc in marr) {
        if (vc == self.vc) {
            [marr removeObject:vc];
            break;
        }
    }
    self.vc.navigationController.viewControllers = marr;

    [self dismiss];
}

#pragma mark - HomeheaderViewDelegate
-(void)dismiss2{
    
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)

        self.vc.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        self.vc.view.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        
    } completion:^(BOOL finished) {

    }];
}

-(void)dismiss3{
    
    CGRect frame = self.frame;
    frame.origin.x = -SCREEN_WIDTH;
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        self.frame = frame;
    } completion:^(BOOL finished) {
        @strongify(self)
        [_overlayView removeTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_overlayView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(void)dismiss{
    [self performSelector:@selector(dismiss2) withObject:nil afterDelay:0.1];
    [self performSelector:@selector(dismiss3) withObject:nil afterDelay:0.21];
}
-(void)show:(RootCtrl *)viewcontroller {
    [self performSelector:@selector(showe2:) withObject:viewcontroller afterDelay:0.1];
    [self performSelector:@selector(showe3:) withObject:viewcontroller afterDelay:0.2];

}

- (void)showe2:(RootCtrl *)viewcontroller {
    self.vc = viewcontroller;
    
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    if (@available(iOS 11.0, *)) {
        self.collectView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.vc.automaticallyAdjustsScrollViewInsets = NO;
    }
    CGRect frame = self.frame;
    frame.origin.x = 0;
    @weakify(self)
    [UIView animateWithDuration:0.2 animations:^{
        @strongify(self)
        self.frame = frame;
//        self.vc.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
//        self.vc.view.center = CGPointMake(SCREEN_WIDTH+SCREEN_WIDTH*0.25, SCREEN_HEIGHT / 2);
//        self.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
//        self.center = CGPointMake(SCREEN_WIDTH*0.75/2, self.center.y);

    } completion:^(BOOL finished){
        @strongify(self)
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }];
}
- (void)showe3:(RootCtrl *)viewcontroller {
    self.vc = viewcontroller;
    @weakify(self)
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self)
        self.vc.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        self.vc.view.center = CGPointMake(SCREEN_WIDTH+SCREEN_WIDTH*0.25, SCREEN_HEIGHT / 2);

        
    } completion:^(BOOL finished){
    }];
}

- (void)changeToBuy:(UIButton *)btn{
    //    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //    if([AppDelegate shareapp].homeType == HomeSwitchTypeInfo){
    //        btn.tag = 10002;
    //        [AppDelegate shareapp].homeType = HomeSwitchTypeBuy;
    //        [btn setImage:IMAGE(@"cptChangeInfo") forState:UIControlStateNormal];
    //        //        self.layout.itemSize = CGSizeMake(self.layout.itemSize.width, 80);
    //
    //    }else{
    //        btn.tag = 10003;
    //        [AppDelegate shareapp].homeType = HomeSwitchTypeInfo;
    //        [btn setImage:IMAGE(@"cptChange") forState:UIControlStateNormal];
    //        //        self.layout.itemSize = CGSizeMake(self.layout.itemSize.width, 110);
    //    }
    
    [self.collectView reloadData];
    
    
}



-(void)initData {
    [WebTools postWithURL:@"/lottery/queryLotteryList.json" params:nil success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return;
        }
        [Tools saveDataToPlistFile:data.data WithName:@"buyLotteryPlist.plist"];
        [self.dataSource removeAllObjects];
        NSArray *array = [CartHomeModel mj_objectArrayWithKeyValuesArray:data.data];
        for (CartHomeModel *model in array) {
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
        [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        [self.collectView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.collectView.mj_header endRefreshing];
    } showHUD:NO];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftLotteryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RJCellIdentifiervv"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CartHomeModel * model = self.dataSource[indexPath.row];
    cell.titlelab.text = model.cateName;
    if(self.currentIndex == indexPath.row){
        cell.contentView.backgroundColor = [[CPTThemeConfig shareManager] CO_BuyLot_Left_LeftCellBack_Selected];
        cell.titlelab.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_Left_LeftCellTitleText_Selected];
    } else {
        cell.contentView.backgroundColor = [[CPTThemeConfig shareManager] CO_BuyLot_Left_LeftCellBack];
        cell.titlelab.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_Left_LeftCellTitleText];
    }
    MBLog(@"%@",model.cateName);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentIndex = indexPath.row;
    self.currentmodel = self.dataSource[indexPath.row];
    [self.tableView reloadData];
    if([self.currentmodel.cateName isEqualToString:@"番摊专区"]){
        self.icon_Number = 1;
    }else{
        self.icon_Number = 2;
    }
    [self.collectView reloadData];
}
@end

