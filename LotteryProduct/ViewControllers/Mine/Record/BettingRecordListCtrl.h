//
//  BettingRecordListCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface BettingRecordListCtrl : RootCtrl

/**
 类型：NORMAL 投注 | BACK 撤单 | CHASE 追号
 */
@property (nonatomic, copy) NSString *Bettingtype;

@end
