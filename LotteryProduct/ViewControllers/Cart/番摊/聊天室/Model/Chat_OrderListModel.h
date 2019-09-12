//
//  Chat_OrderListModel.h
//  LotteryProduct
//
//  Created by pt c on 2019/5/7.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Chat_OrderListModel : NSObject
@property (nonatomic,copy) NSString *showProfitRate;// 盈利率
@property (nonatomic,copy) NSString *playName;//玩法名称
@property (nonatomic,copy) NSString *betAmount;//投注金额
@property (nonatomic,copy) NSString *ensureOdds;//保障赔率
@property (nonatomic,copy) NSString *bonusScale;//分红
@property (nonatomic,copy) NSString *lotteryName;//彩种名称
@property (nonatomic,copy) NSString *issue;//期号
@property (nonatomic,copy) NSString *odds;//赔率
@property (nonatomic,copy) NSString *pushOrderId;//推单ID
@end

NS_ASSUME_NONNULL_END
