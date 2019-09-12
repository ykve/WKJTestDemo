//
//  CartListCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface CartListCtrl : RootCtrl

@property (nonatomic, strong) CartTypeModel *selectModel;

@property (nonatomic, copy) void (^updataArray)(NSArray *array);

@property (nonatomic, assign) NSInteger lotteryId;
@property(assign,nonatomic)CPTBuyTicketType  type;
- (void)cannelTimer;
@end
