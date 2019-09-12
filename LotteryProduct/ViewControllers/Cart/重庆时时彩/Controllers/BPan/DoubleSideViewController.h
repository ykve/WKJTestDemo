//
//  DoubleSideViewController.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"
#import "CartTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DoubleSideViewControllerDelegate <NSObject>

@optional
- (void)selectBalls:(NSMutableArray *)balls;

@end

@interface DoubleSideViewController : RootCtrl

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, assign) NSInteger lotteryId;

@property (nonatomic, strong)CartTypeModel *typeModel;

@property (nonatomic, strong) NSMutableArray *selectModels;


@property (nonatomic, weak)id<DoubleSideViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
