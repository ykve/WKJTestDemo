//
//  PK10TwoFaceListCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface PK10TwoFaceListCtrl : RootCtrl

/**
 0： 大小历史
 1：单双历史
 2：龙虎历史
 */
@property (nonatomic, assign)NSInteger type;

-(void)initData;

@end
