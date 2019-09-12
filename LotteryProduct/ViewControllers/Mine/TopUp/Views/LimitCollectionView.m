//
//  LimitCollectionView.m
//  LotteryProduct
//
//  Created by pt c on 2019/7/19.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LimitCollectionView.h"
#import "PriceCell.h"

static NSString * const kPriceCellId = @"PriceCell";
@interface LimitCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
//
@property (nonatomic, strong) NSMutableArray *resultDataArray;
@property (nonatomic, strong) NSIndexPath *selectItemIndexPath;


@end

@implementation LimitCollectionView



+ (LimitCollectionView *)headViewWithModel:(id)model {
    
    return nil;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self initData];
        [self initSubviews];
        //        [self initLayout];
    }
    return self;
}


- (void)setModel:(id)model {
    self.selectItemIndexPath = nil;
    self.resultDataArray = [NSMutableArray arrayWithArray:(NSArray *)model];
    [self.collectionView reloadData];
}



#pragma mark - collectionView
- (void)initSubviews {
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 10*2 - 4*10) / 5.0;
    // 设置每个item的大小
    layout.itemSize = CGSizeMake(itemWidth, 29);
    layout.minimumInteritemSpacing = 10;
//    layout.minimumLineSpacing = 1;
//    layout.sectionInset = UIEdgeInsetsMake(3, 10, 3, 10);
    
    // 设置布局方向(滚动方向)
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat height = self.frame.size.height;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, height) collectionViewLayout:layout];
    
    /** mainCollectionView 的布局(必须实现的) */
    _collectionView.collectionViewLayout = layout;
    
    //mainCollectionView 的背景色
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    //禁止滚动
    //_collectionView.scrollEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[PriceCell class] forCellWithReuseIdentifier:kPriceCellId];
    [self addSubview:self.collectionView];
}


#pragma mark -- UICollectionViewDataSource 数据源

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.resultDataArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PriceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPriceCellId forIndexPath:indexPath];
    CGFloat money = [[self.resultDataArray objectAtIndex:indexPath.item] floatValue];
    
    if (self.selectItemIndexPath == indexPath) {
        cell.pricelab.textColor =  [[CPTThemeConfig shareManager] chargeMoneyLblSelectColor];//WHITE;
        cell.pricelab.backgroundColor = [[CPTThemeConfig shareManager] chargeMoneyLblSelectBackgroundcolor];
        cell.pricelab.layer.borderColor = [[CPTThemeConfig shareManager] chargeMoneyLblSelectColor].CGColor;
    } else {
        cell.pricelab.textColor = [UIColor blackColor];
        cell.pricelab.backgroundColor = [UIColor whiteColor];
        cell.pricelab.layer.borderColor = [UIColor colorWithHex:@"#b2b2b2"].CGColor;
    }
    cell.pricelab.text = [NSString stringWithFormat:@"%0.lf",money];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout  视图布局
//定义每个UICollectionView 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - 3 * 12 - 2*12) / 4.0;
//    return CGSizeMake(itemW, 29);
//}

#pragma mark --UICollectionViewDelegate 代理
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectItemIndexPath = indexPath;
    
    CGFloat money = [[self.resultDataArray objectAtIndex:indexPath.item] floatValue];
    if (self.headClickBlock) {
        self.headClickBlock(money);
    }
    [self.collectionView reloadData];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
