//
//  CartNormalCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/18.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface CartNormalCtrl : RootCtrl

@property (nonatomic, strong) CartTypeModel *selectModel;

@property (nonatomic, copy) void (^updataArray)(NSArray *array);

@property (nonatomic, assign) NSInteger lotteryId;

@property (nonatomic, copy) NSString *nextversion;

/**
 清空购物车
 */
-(void)clearlist;

@end
