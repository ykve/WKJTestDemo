//
//  CartSixBallView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartSixModel.h"
@interface CartSixBallView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UILabel *titlelab;

@property (nonatomic, strong)UISegmentedControl *segment;

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)NSArray *array;

@property (nonatomic, strong) CartTypeModel *selectModel;

@property (nonatomic, copy) void (^cartInfoBlock)(void);

@property (nonatomic, copy) void (^refreshpriceBlock)(void);
@end
