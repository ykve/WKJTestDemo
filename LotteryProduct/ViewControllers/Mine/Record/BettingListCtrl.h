//
//  BettingListCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface BettingListCtrl : RootCtrl

/**
 状态：WAIT 等待开奖 | WIN 中奖 | NO_WIN 未中奖 | HE 打和
 */
@property (nonatomic, copy) NSString *status;
/**
 NORMAL 投注 | BACK 撤单 | CHASE 追号
 */
@property (nonatomic, copy) NSString *Bettingtype;

/**
 刷新数据
 */
-(void)refreshData;

@end
