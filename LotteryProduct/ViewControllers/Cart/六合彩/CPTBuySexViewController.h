//
//  CPTBuySexViewController.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"
NS_ASSUME_NONNULL_BEGIN

@interface CPTBuySexViewController : RootCtrl
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, assign) NSInteger lotteryId;
@property(assign,nonatomic)CPTBuyTicketType  type;
@property (nonatomic, assign) NSInteger endTime;

@end

NS_ASSUME_NONNULL_END
