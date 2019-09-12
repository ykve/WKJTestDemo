//
//  LiuHeDaShenViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/22.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiuHeDaShenViewController.h"
#import "LiuHeDaShenTableViewCell.h"
#import "LiuHeBangDanListViewController.h"
#import "LiuHeDashenModel.h"
#import "UIImage+color.h"
#import "SixPhotosCtrl.h"
#import "LHDSHomeCell.h"

@interface LiuHeDaShenViewController ()

@property (nonatomic, strong) LiuHeDashenModel *dashenModel;

@property (nonatomic, strong) NSMutableArray *dashenModelArray;

@property (nonatomic, strong)UICollectionView *collectionView;


@end

@implementation LiuHeDaShenViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initdata];
}

- (void)initdata{
    NSNumber * type = @(1);
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        type = @(2);
    }
    NSDictionary *dic = @{@"typeId":type};
    @weakify(self)
    [WebTools postWithURL:@"/lottery/queryGodtype.json" params:dic success:^(BaseData *data) {
        @strongify(self)
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        [self.dashenModelArray removeAllObjects];
        self.dashenModelArray = [LiuHeDashenModel mj_objectArrayWithKeyValuesArray:data.data];
        if (self.dashenModelArray.count == 0) {
            [self setShowNoDataTips:YES];
            return ;
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        @strongify(self)
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark setupUI
- (void)setupUI{
    self.titlestring = @"六合大神";
    self.view.backgroundColor = [[CPTThemeConfig shareManager] LiuheDashendBackgroundColor];

    
    @weakify(self)
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@NAV_HEIGHT);
        make.left.right.bottom.equalTo(self.view);
    }];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self initdata];
    } ];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dashenModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LHDSHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LHDSHomeCellID forIndexPath:indexPath];
    LiuHeDashenModel *model = self.dashenModelArray[indexPath.row];
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:IMAGE(@"lhds_placeholder")];
    cell.backgroundColor = [[CPTThemeConfig shareManager] LiuheDashendBackgroundColor];
    return cell;

}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LiuHeDashenModel *model = self.dashenModelArray[indexPath.row];
    
    if ([model.name isEqualToString:@"六合图库"]) {
        SixPhotosCtrl *sixVc = [[SixPhotosCtrl alloc] init];
        sixVc.lottery_oldID = 4;
        PUSH(sixVc);
    }else{
        LiuHeBangDanListViewController *bangdanVc = [[LiuHeBangDanListViewController alloc] init];
        //        bangdanVc.ID = model.ID;
        bangdanVc.model = model;
        PUSH(bangdanVc);
    }

}

- (NSMutableArray *)dashenModelArray{
    if (!_dashenModelArray) {
        _dashenModelArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _dashenModelArray;
}

-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumInteritemSpacing = 10;
        
        layout.minimumLineSpacing = 10;
        
         CGFloat itemSpace = 10;
        CGFloat itemWidth = (SCREEN_WIDTH - 3 * itemSpace)/2 ;

        layout.itemSize = CGSizeMake(itemWidth, (itemWidth * 60)/173 );
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [[CPTThemeConfig shareManager] LiuheDashendBackgroundColor];
        //注册
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LHDSHomeCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:LHDSHomeCellID];

    }
    
    return _collectionView;
}



@end
