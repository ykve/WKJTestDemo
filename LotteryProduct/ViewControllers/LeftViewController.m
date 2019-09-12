//
//  LeftViewController.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/13.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@property (nonatomic, strong)UICollectionViewFlowLayout *layout;
@property (nonatomic, assign)NSInteger icon_Number;
@property (nonatomic, strong)UICollectionView *collectView;
@property (nonatomic, retain) NSIndexPath *indexPath;

@end

@implementation LeftViewController

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
        
        _collectView.backgroundColor = [[CPTThemeConfig shareManager] HomeVC_ADCollectionViewCell_BackgroundC];//[[CPTThemeConfig shareManager] HomeViewBackgroundColor];
        
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
    if (getSkinType == SKinTypeProtectEye) {
        [self.view.layer insertSublayer:jbbj(self.view.bounds) atIndex:0];
    }
    self.view.backgroundColor = [[CPTThemeConfig shareManager] HomeViewBackgroundColor];
    
    [self.dataSource addObject:[self configFavData]];
    
    self.collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self initLtData];
    }];
    
    [self initLtData];
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
    cell.iconimgv.image = [UIImage imageNamed:subModel.name];
    cell.type = subModel.lotteryId;
    cell.titlelab.text = subModel.name;
    cell.rBtn.hidden = self.state == EditState_ing ? NO:YES;
    if(indexPath.section != 0){
        [cell.rBtn setImage:IMAGE(@"sc_+") forState:UIControlStateNormal];
    }else{
        [cell.rBtn setImage:IMAGE(@"sc_-") forState:UIControlStateNormal];
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
                header.editBtn.backgroundColor = [UIColor hexStringToColor:@"AC1E2D"];
                header.editBtn.borderWidth = 0;
                [header.editBtn setTitleColor:WHITE forState:UIControlStateNormal];
                
            }
                break;
            case EditState_ok:
            {
                [header.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
                header.editBtn.backgroundColor = CLEAR;
                [header.editBtn setTitleColor:WHITE forState:UIControlStateNormal];
                
                header.editBtn.borderWidth = 1;
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
                [cell.rBtn setImage:IMAGE(@"sc_-") forState:UIControlStateNormal];
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
                        [cell.rBtn setImage:IMAGE(@"sc_+") forState:UIControlStateNormal];
                        [self.collectView moveItemAtIndexPath:indexPath  toIndexPath:[NSIndexPath indexPathForRow:modelA.lotterys.count-1 inSection:i]];
                        break;
                    }
                }
            }
        }
            break;
        case EditState_ok:
        {
        }
            break;
        default:
            break;
    }
}

#pragma mark - HomeheaderViewDelegate



- (void)changeToBuy:(UIButton *)btn{
    //    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //    if(self.CPTSYType == CPTSYTypeInfo){
    //        btn.tag = 10002;
    //        self.CPTSYType = CPTSYTypeBuy;
    //        [btn setImage:IMAGE(@"cptChangeInfo") forState:UIControlStateNormal];
    //        //        self.layout.itemSize = CGSizeMake(self.layout.itemSize.width, 80);
    //
    //    }else{
    //        btn.tag = 10003;
    //        self.CPTSYType = CPTSYTypeInfo;
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
@end

