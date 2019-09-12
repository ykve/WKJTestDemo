//
//  AddBanksteponeCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootCtrl.h"

@interface AddBanksteponeCtrl : RootCtrl

@property (nonatomic, copy) void (^addBankBlock)(BOOL result);

@end
