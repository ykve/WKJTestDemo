//
//  CartChongqingBPanViewController.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/13.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"
#import "CartTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CartChongqingBPanViewController : RootCtrl

/**
 彩票分类ID
 */
@property (nonatomic, assign) NSInteger categoryId;
/**
 彩票类型ID
 */
@property (nonatomic, assign) NSInteger lotteryId;

/**
 13：特码包三
 14：特码
 */
@property (assign, nonatomic) NSInteger type;

@end

NS_ASSUME_NONNULL_END
