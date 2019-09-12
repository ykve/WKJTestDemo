//
//  HomeFootView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeFootView : UICollectionReusableView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *subcollectionView;
/**
 1:重庆时时彩
 2：新疆时时彩
 3：比特币分分彩
 4：六合彩
 5：PC蛋蛋
 6：北京PK10
 7：幸运快艇
 */
@property (nonatomic, assign)NSInteger type;
/**
 重庆时时彩
 */
@property (nonatomic, strong)NSArray *chongqinArray;
/**
 六合彩
 */
@property (nonatomic, strong)NSArray *liuheArray;
/**
 北京PK10
 */
@property (nonatomic, strong)NSArray *beijinArray;
/**
 PC蛋蛋
 */
@property (nonatomic, strong)NSArray *dandanArray;

/**
 足彩
 */
@property (nonatomic, strong)NSArray *zucaiArray;

/**
 是否展示更多
 */
@property (nonatomic, assign)BOOL showall;
/**
 是否正在开奖
 */
@property (nonatomic, assign)BOOL waiting;

@property (nonatomic, copy) void (^selectcontentBlock)(NSInteger type , NSInteger index);

@property (nonatomic, copy) void (^footshowallBlock) (BOOL showall);

@end
