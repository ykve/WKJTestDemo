//
//  AoZhouACTScrollview.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/6.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AoZhouACTMiddleView.h"
#import "AoZhouActBuyLotteryVeiw.h"
NS_ASSUME_NONNULL_BEGIN

@interface AoZhouACTScrollview : UIView
@property (nonatomic, strong) AoZhouActBuyLotteryVeiw *lotteryView;
@property (nonatomic, strong) AoZhouACTMiddleView *middleView;
- (void)configUI;
@end

NS_ASSUME_NONNULL_END
