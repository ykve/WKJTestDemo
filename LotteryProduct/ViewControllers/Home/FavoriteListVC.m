//
//  FavoriteListVC.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/9.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "FavoriteListVC.h"
#import "FavoriteCell.h"
#import "FavoriteHeader.h"
#import "CartHomeModel.h"
#import "CrartHomeSubModel.h"

#import "CPTChangLongController.h"
#import "LoginAlertViewController.h"
#import "CPTWebViewController.h"
#import "CPTBuyRootVC.h"
#import "CPTBuyFantanCtrl.h"
#import "CPTBuySexViewController.h"
@interface FavoriteListVC ()<FavoriteHeaderDelegate>

@property (nonatomic, strong)UICollectionViewFlowLayout *layout;
@property (nonatomic, assign)NSInteger icon_Number;
@property (nonatomic, strong)UICollectionView *collectView;
@property (nonatomic, retain) NSIndexPath *indexPath;

@end

@implementation FavoriteListVC

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
        
        _collectView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_ADCollectionViewCell_Back];//[[CPTThemeConfig shareManager] HomeViewBackgroundColor];
        
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([FavoriteCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:RJCellIdentifier];
        
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([FavoriteHeader class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RJHeaderIdentifier];

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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.icon_Number = 4;
    self.titlestring = @"我的收藏";

    self.view.backgroundColor = [[CPTThemeConfig shareManager] HomeViewBackgroundColor];

    [self.dataSource addObject:[self configFavData]];

    self.collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self initLtData];
    }];

    [self initLtData];
}

- (CartHomeModel *)configFavData{
    CartHomeModel * model = [[CartHomeModel alloc] init];
    model.intro = @"我的收藏";
    model.name = @"我的收藏";
    model.cateName = @"我的收藏";
    model.lotterys = self.favData;
    return model;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.dataSource.count > 0) {
        return self.dataSource.count;
    }
    return 0;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource.count > 0) {
        CartHomeModel * model = self.dataSource[section];
        return model.lotterys.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FavoriteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = cell.contentView.backgroundColor = CLEAR;
    CartHomeModel * model = self.dataSource[indexPath.section];
    CrartHomeSubModel * subModel = model.lotterys[indexPath.row];
    NSString * imagen = subModel.name;
    if([imagen isEqualToString:@"排列3/5"]){
        imagen = @"排列35";
    }
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        imagen = [NSString stringWithFormat:@"tw_%@",imagen];
    }
    cell.isWorkView.hidden = subModel.isWork;
    cell.iconimgv.image = IMAGE(imagen);
    cell.type = subModel.lotteryId;
    cell.titlelab.text = subModel.name;
    cell.rBtn.hidden = self.state == EditState_ing ? NO:YES;
    if(indexPath.section != 0){
        cell.rBtn.image = IMAGE(@"scadd");
    }else{
        cell.rBtn.image = IMAGE(@"scjj");
    }
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        FavoriteHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:RJHeaderIdentifier forIndexPath:indexPath];
        header.delegate = self;
        CartHomeModel *model = self.dataSource[indexPath.section];
        header.titleL.text = model.cateName;
        switch (self.state) {
            case EditState_ing:
            {
                [header.editBtn setTitle:@"完成" forState:UIControlStateNormal];
                header.editBtn.borderWidth = 0;
                [header.editBtn setTitleColor:WHITE forState:UIControlStateNormal];
                if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
                    header.editBtn.backgroundColor = [UIColor hexStringToColor:@"EC6A2C"];
                }else{
                    header.editBtn.backgroundColor = [UIColor hexStringToColor:@"AC1E2D"];
                }

            }
                break;
            case EditState_ok:
            {
                [header.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
                header.editBtn.borderWidth = 1;
                if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
                    [header.editBtn setTitleColor:[UIColor hexStringToColor:@"666666"] forState:UIControlStateNormal];
                    header.editBtn.backgroundColor = [UIColor hexStringToColor:@"F0F2F5"];

                }else{
                    [header.editBtn setTitleColor:WHITE forState:UIControlStateNormal];
                    header.editBtn.backgroundColor = CLEAR;
                }
            }
                break;
            default:
                break;
        }
        if(indexPath.section ==0){
            header.editBtn.hidden = header.remindLbl.hidden = header.leftImageView.hidden = NO;
            header.titleL.hidden = header.line1.hidden = YES;
        }else{
            header.editBtn.hidden = header.remindLbl.hidden = header.leftImageView.hidden = YES;
            header.titleL.hidden = header.line1.hidden = NO;
        }
        return header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWidth = (SCREEN_WIDTH - 0 * (self.icon_Number - 1)) / self.icon_Number;
    return CGSizeMake(itemWidth, 80);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return CGSizeMake(SCREEN_WIDTH, 42);
    }else{
        return CGSizeMake(SCREEN_WIDTH, 50);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.state) {
        case EditState_ing:
        {
            FavoriteCell *cell = (FavoriteCell *)[collectionView cellForItemAtIndexPath:indexPath];

            CartHomeModel * modelF = self.dataSource[0];

            CartHomeModel * model = self.dataSource[indexPath.section];
            CrartHomeSubModel * submodel = model.lotterys[indexPath.row];
            if(indexPath.section != 0){
                if(self.favData.count>=15){
                    [MBProgressHUD showError:@"最多只能收藏15个彩种"];
                    return;
                }
                [self.favData addObject:submodel];
                [model.lotterys removeObject:submodel];
                [self.dataSource replaceObjectAtIndex:0 withObject:[self configFavData]];
                cell.rBtn.image = IMAGE(@"scjj");
                [self.collectView moveItemAtIndexPath:indexPath  toIndexPath:[NSIndexPath indexPathForRow:modelF.lotterys.count-1 inSection:0]];
            }else{
                if(self.favData.count<=3){
                    [MBProgressHUD showError:@"最少需要收藏3个彩种"];
                    return;
                }
                for (NSInteger i =1;i<self.dataSource.count;i++) {
                    CartHomeModel *modelA = self.dataSource[i];
                            if(modelA.categoryId == submodel.categoryId){
                                [modelA.lotterys addObject:submodel];
                                [model.lotterys removeObject:submodel];
                                cell.rBtn.image = IMAGE(@"scadd");
                                [self.collectView moveItemAtIndexPath:indexPath  toIndexPath:[NSIndexPath indexPathForRow:modelA.lotterys.count-1 inSection:i]];
                                break;
                            }
                    }
            }
        }
            break;
        case EditState_ok:
        {
            FavoriteCell *cell = (FavoriteCell *)[collectionView cellForItemAtIndexPath:indexPath];

                if(cell.isWorkView.hidden == NO){
                    return;
                }
            if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该彩种暂未开放" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            CartHomeModel * model = self.dataSource[indexPath.section];
            CrartHomeSubModel * subModel = model.lotterys[indexPath.row];
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
                }else if([subModel.intro isEqualToString:@"tw_电竞游戏"]){//
                    if ([Person person].uid == nil) {
                        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                        
                        [self presentViewController:login animated:YES completion:^{
                        }];
                        return ;
                    }
                    NSDictionary *dic = @{@"userId":[Person person].uid,@"account":[Person person].account};
                    @weakify(self)
                    [WebTools postWithURL:@"/esgame/go.json" params:dic success:^(BaseData *data) {
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
                            [MBProgressHUD showError:data.info];
                        }
                    } failure:^(NSError *error) {
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
        }
            break;
        default:
            break;
    }
}

#pragma mark - HomeheaderViewDelegate



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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initLtData {
    
    [WebTools postWithURL:@"/lottery/all/list.json" params:nil success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return;
        }
//        [Tools saveDataToPlistFile:data.data WithName:@"favoritelist.json"];
        NSArray *array = [CartHomeModel mj_objectArrayWithKeyValuesArray:data.data];
        [self.dataSource removeAllObjects];
        CartHomeModel *m = [self configFavData];
        [self.dataSource addObject:m];
        for(CrartHomeSubModel *model in m.lotterys) {
            for (CartHomeModel *modelA in array) {
                for (CrartHomeSubModel *modelB in modelA.lotterys) {
                    if(model.lotteryId == modelB.lotteryId){
                        [modelA.lotterys removeObject:modelB];
                        break;
                        }
                    }
                }
            }
        [self.dataSource addObjectsFromArray:array];

        if(self.dataSource.count>0){

            [self.collectView reloadData];
            [self.collectView.mj_header endRefreshing];

        }
    } failure:^(NSError *error) {
    } showHUD:NO];
}

-(void)updateData {
    
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];
        @weakify(self)
        login.loginBlock = ^(BOOL result) {
            @strongify(self)
            [self updateData];
        };
        return;
    }
    
    CartHomeModel * modelF = self.dataSource[0];
    NSString *ids;
    for(NSInteger i=0 ;i<modelF.lotterys.count;i++){
        CrartHomeSubModel * subModel = modelF.lotterys[i];
        if(i==0){
            ids = [NSString stringWithFormat:@"%ld",(long)subModel.lotteryId];
        }else{
            ids = [ids stringByAppendingString:[NSString stringWithFormat:@",%ld",(long)subModel.lotteryId]];
        }
    }
//    [MBProgressHUD showMessage:@"正在更新"];
    [WebTools postWithURL:@"/lottery/favorite/update" params:@{@"lotteryIds":ids} success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return;
        }
//        [MBProgressHUD hideHUD];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadFFData" object:nil];

        [MBProgressHUD showSuccess:@"更新成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"更新失败"];
    } showHUD:NO];
}

- (void)clickEdit:(UIButton *)sender {
    switch (self.state) {
        case EditState_ing:
            {
                [sender setTitle:@"编辑" forState:UIControlStateNormal];
                self.state = EditState_ok;
                sender.backgroundColor = CLEAR;
                sender.borderWidth = 1;
                [self.collectView reloadData];
                [self updateData];

            }
            break;
        case EditState_ok:
        {
            [sender setTitle:@"完成" forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor hexStringToColor:@"AC1E2D"];
            sender.borderWidth = 0;
            self.state = EditState_ing;
            [self.collectView reloadData];

        }
            break;
        default:
            break;
    }
}

@end
