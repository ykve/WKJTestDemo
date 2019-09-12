//
//  HobbyCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface HobbyCtrl : RootCtrl

@property (nonatomic, copy) void(^updataBlock)(NSArray *hobArray);

@end
