//
//  MyReportModel.h
//  LotteryProduct
//
//  Created by pt c on 2019/7/26.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyReportModel : NSObject

/// 投注总额
@property (nonatomic, assign) CGFloat betAmount;
/// 活动总额
@property (nonatomic, assign) CGFloat activityAmount;
/// 返点总额
@property (nonatomic, assign) CGFloat backAmount;
/// 跟单分红
@property (nonatomic, assign) CGFloat orderFollowBonus;
/// 推单分红
@property (nonatomic, assign) CGFloat orderPushBonus;
/// 个人盈亏
@property (nonatomic, assign) CGFloat profitAmount;
/// 分享赠送
@property (nonatomic, assign) CGFloat shareAward;
/// 分享返水
@property (nonatomic, assign) CGFloat shareBack;
/// VIP升级奖励
@property (nonatomic, assign) CGFloat vipUpgradeAwards;
/// 中奖总额
@property (nonatomic, assign) CGFloat winAmount;


@end

NS_ASSUME_NONNULL_END
