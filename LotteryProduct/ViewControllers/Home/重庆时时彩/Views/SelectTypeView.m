//
//  SelectTypeView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/31.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SelectTypeView.h"
#import "CollectionBaseCell.h"
@implementation SelectTypeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = WHITE;
        self.layer.shadowColor = kColor(0, 0, 0).CGColor;
        self.layer.shadowOffset = CGSizeMake(2, 5);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 5;
        _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _overlayView.backgroundColor = [UIColor clearColor];
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _overlayView.alpha = 0.3;
    }
    
    return self;
}

-(void)setArray:(NSArray *)array {
    
    _array = array;
    
    [self.collectionView reloadData];
}
-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
//        layout.minimumInteritemSpacing = 10;
//        
//        layout.minimumLineSpacing = 10;
        
        CGFloat itemWidth = (SCREEN_WIDTH - 5 * 5) / 4;
        
        layout.itemSize = CGSizeMake(itemWidth, 32);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = WHITE;
        //注册
        [_collectionView registerClass:[CollectionBaseCell class] forCellWithReuseIdentifier:RJCellIdentifier];
        
        [self addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(15, 15, 15, 15));
        }];
    }
    
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    TypeModel *model = [self.array objectAtIndex:indexPath.item];
    
    cell.titlelab.text = model.name;
    
    cell.titlelab.numberOfLines = 2;
    cell.titlelab.font = [UIFont systemFontOfSize:13];
    cell.titlelab.layer.cornerRadius = 4.0;
    cell.titlelab.layer.masksToBounds = YES;
    cell.titlelab.layer.borderWidth = 1.0;
    cell.titlelab.adjustsFontSizeToFitWidth = YES;
    cell.titlelab.textAlignment = NSTextAlignmentCenter;
    cell.titlelab.textColor = kColor(102, 102, 102);
    if (model.selected) {
        
        cell.titlelab.backgroundColor = BASECOLOR;
        cell.titlelab.textColor = WHITE;
        cell.titlelab.layer.borderColor = kColor(255, 163, 66).CGColor;
        
    }else{
        cell.titlelab.backgroundColor = CLEAR;
        cell.titlelab.layer.borderColor = kColor(153, 153, 153).CGColor;
        cell.titlelab.textColor = kColor(153, 153, 153);
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TypeModel *model = [self.array objectAtIndex:indexPath.item];
    
    model.selected = !model.selected;
    
    [self.collectionView reloadData];
    
    if (self.selectCategoryBlock) {
        
        self.selectCategoryBlock(model,indexPath.item);
        
        [self dismiss];
    }
}
- (void)dismiss{
    
    CGRect frame = self.frame;
    
    frame.size.height = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        
        if (self.dismissBlock) {
            
            self.dismissBlock();
        }
        
        [_overlayView removeFromSuperview];
        
        [self removeFromSuperview];
    }];
}

- (void)show:(UIView *)view{
    
    UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
    
    [keywindw addSubview:_overlayView];
    
    [keywindw addSubview:self];
    
    CGRect frame = self.frame;
    
    frame.size.height = 55 * (self.array.count + 3)/4;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = frame;
        
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
