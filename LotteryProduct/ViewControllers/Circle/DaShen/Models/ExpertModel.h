//
//  ExpertModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpertModel : NSObject

/// 大神id
@property (nonatomic , assign) NSInteger              godId;
/// 用户id
@property (nonatomic , assign) NSInteger              memberId;
/// 头像
@property (nonatomic , copy) NSString              * heads;
/// 昵称
@property (nonatomic , copy) NSString              * nickname;
/// //是否关注 NO 否  YES是
@property (nonatomic , assign) BOOL              isFocus;
/// 胜率、盈利率、连中
@property (nonatomic , copy) NSString              * showRate;
/// 累计中奖金额
@property (nonatomic , copy) NSString              * totalMoney;




@property (nonatomic , assign) BOOL              ing;//
@property (nonatomic , copy) NSString              * jizji;
@property (nonatomic , copy) NSString              * personalContent;//展示内容
@property (nonatomic , copy) NSString              * showProfitRate;//盈利率
@property (nonatomic , copy) NSString              * showWinRate;//胜率
@property (nonatomic , copy) NSString              * showMaxLz;//最大连中
@property (nonatomic , copy) NSString              * allRecord;// 近10期战绩 ，逗号分隔 0 赢 1 亏 2 和

@end
