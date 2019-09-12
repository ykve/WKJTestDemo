//
//  FormulaListCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/6.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface FormulaListCtrl : RootCtrl

@property (nonatomic, assign)NSInteger number;

@property (nonatomic, strong)NSDictionary *StatisticsDic;

@property (nonatomic, copy) void (^StatisticsBlock)(NSDictionary *statis);

-(void)initDataWithtime:(NSString *)time;

@end
