//
//  CPTOpenLotteryCtrl.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/26.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPTOpenLotteryCtrl : UIViewController
@property (assign,nonatomic) CPTBuyTicketType type;
@property (copy, nonatomic) NSMutableArray* idArray;

@property (nonatomic, assign)BOOL changlong;
@property (nonatomic, assign)BOOL isShowNav;


@end

NS_ASSUME_NONNULL_END
