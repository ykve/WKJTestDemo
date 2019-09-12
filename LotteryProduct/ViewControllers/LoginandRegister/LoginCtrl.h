//
//  LoginCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface LoginCtrl : RootCtrl

@property (nonatomic, copy) void (^loginBlock)(BOOL result);


@end
