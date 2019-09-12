//
//  VVLongCollectionView.m
//  LotteryProduct
//
//  Created by pt c on 2019/7/28.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "VVLongCollectionView.h"
#import "VVLongCollectionViewCell.h"
#import "VVLongCollectionReusableView.h"

static NSString * const kVVLongCollectionViewCell = @"kVVLongCollectionViewCell";

@interface VVLongCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation VVLongCollectionView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}


- (void)setModel:(id)model {
    self.dataSource = [NSMutableArray arrayWithArray:(NSArray *)model];
    [self.collectionView reloadData];
    [self setupCollectionViewData];
}

- (void)setupCollectionViewData {

    
    for (NSIndexPath *indexPath in self.selectedItemAtIndexPathArray) {
        [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    }
    
}


#pragma mark - collectionView
- (void)initSubviews {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat itemW = (self.frame.size.width - 10 *4) / 2.0;
    // 设置每个item的大小
    layout.itemSize = CGSizeMake(itemW, 35);
    
    // 设置列间距
    layout.minimumInteritemSpacing = 10;
    
    // 设置行间距
    layout.minimumLineSpacing = 10;
    
    //每个分区的四边间距UIEdgeInsetsMake
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(self.frame.size.width, 30);
    layout.sectionFootersPinToVisibleBounds = YES;
    
    CGFloat height = self.frame.size.height;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, height) collectionViewLayout:layout];
    
    _collectionView.collectionViewLayout = layout;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.allowsMultipleSelection = YES;
    
    //禁止滚动
    //_collectionView.scrollEnabled = NO;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[VVLongCollectionViewCell class] forCellWithReuseIdentifier:kVVLongCollectionViewCell];
    
    [_collectionView registerClass:[VVLongCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"VVLongCollectionReusableView"];
    
    [self addSubview:self.collectionView];
    
    
    
    
}

#pragma mark -  UICollectionViewDelegate | UICollectionViewDataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat itemW = (self.frame.size.width - 10 *4) / 2.0;
    return CGSizeMake(itemW, 35);
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.dataSource[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    VVLongCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kVVLongCollectionViewCell forIndexPath:indexPath];
    NSArray *item0 = [self.dataSource objectAtIndex:indexPath.section];
    NSDictionary *dict = [item0 objectAtIndex:indexPath.item];
    cell.titleLabel.text = dict[@"title"];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        VVLongCollectionReusableView *view = (VVLongCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"VVLongCollectionReusableView"forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
            view.titleLabel.text = @"彩种选择";
        } else if (indexPath.section == 1) {
            view.titleLabel.text = @"长龙连中期数";
        }
        return view;
    }
    return nil;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectItemAtIndexPathBlock) {
        self.didSelectItemAtIndexPathBlock(self.collectionView.indexPathsForSelectedItems); // 获取所有选中的item的位置信息
    }
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectItemAtIndexPathBlock) {
        self.didSelectItemAtIndexPathBlock(self.collectionView.indexPathsForSelectedItems); // 获取所有选中的item的位置信息
    }
}

// 设置是否允许取消选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}




- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end
