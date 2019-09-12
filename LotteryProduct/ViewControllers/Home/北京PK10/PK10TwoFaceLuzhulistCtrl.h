//
//  PK10TwoFaceLuzhulistCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface PK10TwoFaceLuzhulistCtrl : RootCtrl

/**
 0：大小路珠
 1：单双路珠
 2：龙虎路珠
 3：前后路珠
 4：冠亚和路珠
 */
@property (nonatomic, assign)NSInteger type;

-(void)initDataWithtime:(NSString *)time;

@end
