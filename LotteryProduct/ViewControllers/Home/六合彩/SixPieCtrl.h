//
//  SixPieCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/3.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixInfoBaseCtrl.h"

@interface SixPieCtrl : SixInfoBaseCtrl

/**
 1：生肖特码冷热图
 2：生肖正码冷热图
 3：波色特码冷热图
 4：波色正码冷热图
 5：特码尾数冷热图
 6：正码尾数冷热图
 7：号码波段统计图
 */
@property (nonatomic, assign)NSInteger type;

@end
