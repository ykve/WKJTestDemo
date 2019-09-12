//
//  GraphTypeView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "GraphTypeView.h"
#import "CollectionBaseCell.h"
@interface GraphTypeView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSMutableArray *array;

@property (nonatomic, strong)UICollectionView *collectionView;

@property (strong, nonatomic) UIControl *overlayView;

@end

@implementation GraphTypeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(NSMutableArray *)array {
    
    if (!_array) {
        
        _array = [[NSMutableArray alloc]init];
    }
    return _array;
}
-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = WHITE;
        
        _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _overlayView.backgroundColor = [UIColor blackColor];
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _overlayView.alpha = 0.3;
        
        NSArray *arr1 = @[@{@"title":@"五星基本走势图",@"type":@"1"},@{@"title":@"三星基本走势图",@"type":@"2"},@{@"title":@"二星基本走势图",@"type":@"3"},@{@"title":@"大小单双走势图",@"type":@"4"},@{@"title":@"二星直选走势图1",@"type":@"5"},@{@"title":@"二星直选走势图2",@"type":@"6"},@{@"title":@"三星组选走势图",@"type":@"7"},@{@"title":@"二星组选走势图",@"type":@"8"}];
        NSArray *arr2 = @[@{@"title":@"三星大小号码分布图",@"type":@"9"},@{@"title":@"三星奇偶号码分布图",@"type":@"10"},@{@"title":@"三星质合号码分布图",@"type":@"11"},@{@"title":@"三星跨度走势图",@"type":@"12"},@{@"title":@"二星跨度走势图",@"type":@"13"}];
        NSArray *arr3 = @[@{@"title":@"五星和值走势图",@"type":@"14"},@{@"title":@"三星和值走势图",@"type":@"15"},@{@"title":@"二星和值走势图",@"type":@"16"}];
        NSArray *arr4 = @[@{@"title":@"个位(一星)走势图",@"type":@"17"},@{@"title":@"十位走势图",@"type":@"18"},@{@"title":@"百位走势图",@"type":@"19"},@{@"title":@"千位走势图",@"type":@"20"},@{@"title":@"万位走势图",@"type":@"21"}];
        NSArray *arr = @[@{@"title":@"号码走势：",@"array":arr1},@{@"title":@"形态分布：",@"array":arr2},@{@"title":@"和值走势：",@"array":arr3},@{@"title":@"定位走势：",@"array":arr4}];
        for (NSDictionary *dic in arr) {
            
            NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
            [mdic setValue:dic[@"title"] forKey:@"title"];
            NSMutableArray *marr = [[NSMutableArray alloc]init];
            NSArray *a = dic[@"array"];
            for (NSDictionary *dic in a) {
                
                TypeModel *model = [[TypeModel alloc]init];
                model.selected = NO;
                model.name = dic[@"title"];
                model.type = [dic[@"type"]integerValue];
                [marr addObject:model];
            }
            [mdic setValue:marr forKey:@"array"];
            [self.array addObject:mdic];
        }
        
        [self.collectionView reloadData];
        
    }
    return self;
}

-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumInteritemSpacing = 10;
        
        layout.minimumLineSpacing = 10;
        
        CGFloat itemWidth = (SCREEN_WIDTH - 10 * 4) / 3;
        
        layout.itemSize = CGSizeMake(itemWidth, 32);
        
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 40);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = WHITE;
        //注册
        [_collectionView registerClass:[CollectionBaseCell class] forCellWithReuseIdentifier:RJCellIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RJHeaderIdentifier];
        [self addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self);
        }];
    }
    
    return _collectionView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.array.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *dic = [self.array objectAtIndex:section];
    
    return [dic[@"array"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic = [self.array objectAtIndex:indexPath.section];
    NSArray *array = dic[@"array"];
    TypeModel *model = [array objectAtIndex:indexPath.item];
    
    UILabel *label = cell.titlelab;
    label.text = model.name;
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:13];
    label.layer.cornerRadius = 4.0;
    label.layer.masksToBounds = YES;
    label.layer.borderWidth = 1.0;
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kColor(102, 102, 102);
    if (model.selected) {
        
        label.backgroundColor = BASECOLOR;
        label.textColor = WHITE;
        label.layer.borderColor = kColor(255, 163, 66).CGColor;
        
    }else{
        label.backgroundColor = CLEAR;
        label.layer.borderColor = kColor(153, 153, 153).CGColor;
        label.textColor = kColor(153, 153, 153);
    }
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:RJHeaderIdentifier forIndexPath:indexPath];
        NSDictionary *dic = [self.array objectAtIndex:indexPath.section];
        
        UILabel *lab2 = [head viewWithTag:100];
        [lab2 removeFromSuperview];
        
        UILabel *lab = [Tools createLableWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 40) andTitle:dic[@"title"] andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
        lab.tag = 100;
        [head addSubview:lab];
        
        return head;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    for (NSDictionary *dic in self.array) {
        
        NSArray *array = dic[@"array"];
        
        for (TypeModel *model in array) {
            
            model.selected = NO;
        }
    }
    NSDictionary *dic = [self.array objectAtIndex:indexPath.section];
    
    NSArray *array = dic[@"array"];
    
    TypeModel *model = [array objectAtIndex:indexPath.item];
    
    model.selected = YES;
    
    [self.collectionView reloadData];
    
    if (self.graphTypeBlock){
        
        self.graphTypeBlock(model);
        
        [self dismiss];
    }
}
- (void)dismiss{
    
    CGRect frame = self.frame;
    
    frame.size.height = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [_overlayView removeFromSuperview];
        
        [self removeFromSuperview];
    }];
}

- (void)show:(UIView *)view{
    
    //    UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
    
    [view addSubview:_overlayView];
    
    [view addSubview:self];
    
    CGRect frame = self.frame;
    
    frame.size.height = SCREEN_HEIGHT - NAV_HEIGHT - 100;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = frame;
        
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
