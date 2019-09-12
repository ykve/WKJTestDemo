//
//  PK10guanyahelistCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface PK10guanyahelistCtrl : RootCtrl

/**
 0： 冠亚和
 1：冠亚和两面
 3：两面长龙
 */
@property (nonatomic, assign)NSInteger type;

-(void)initData;

@end
