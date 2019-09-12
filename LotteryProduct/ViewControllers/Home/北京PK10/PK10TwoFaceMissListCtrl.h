//
//  PK10TwoFaceMissListCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface PK10TwoFaceMissListCtrl : RootCtrl

/**
 0：大小遗漏
 1：单双遗漏
 */
@property (nonatomic, assign)NSInteger type;

-(void)initDataWithway:(NSInteger)way;

@end
