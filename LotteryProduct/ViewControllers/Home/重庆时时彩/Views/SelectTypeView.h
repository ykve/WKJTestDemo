//
//  SelectTypeView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/31.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeModel.h"
@interface SelectTypeView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (strong, nonatomic) UIControl *overlayView;

@property (strong, nonatomic) NSArray<TypeModel *> *array;

@property (copy, nonatomic) void (^selectCategoryBlock)(TypeModel *model ,NSInteger index);

@property (copy, nonatomic) void (^dismissBlock)(void);

- (void)dismiss;

- (void)show:(UIView *)view;

@end
