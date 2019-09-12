//
//  TuidanDetailModel.h
//  LotteryProduct
//
//  Created by pt c on 2019/7/4.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuidanDetailModel : NSObject
@property (nonatomic , assign) NSInteger              isFollow;//是否关注 0 否 1 是
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , copy) NSString              * head;
@property (nonatomic , copy) NSString              * calcProfitRate;//盈利率
@property (nonatomic , copy) NSString              * totalMoney;//累计中奖
@property (nonatomic , copy) NSString              * personalContent;//专家介绍
@property (nonatomic , copy) NSString              * lotteryRecord;//彩种近10期 ,逗号分隔 盈亏 0 赢 1 亏 2 和
@property (nonatomic , copy) NSString              * lotteryName;//彩种名称
@property (nonatomic , copy) NSString              * issue;//期号
@property (nonatomic , assign) NSTimeInterval      endTime;//截止时间
@property (nonatomic , assign) CGFloat              betAmount;//选号金额
@property (nonatomic , assign) CGFloat              numberAmount;//每注金额
@property (nonatomic , copy) NSString              * bonusScale;//分红比例
@property (nonatomic , copy) NSString              * ensureOdds;//保障赔率
@property (nonatomic , copy) NSString              * gdCount;//跟单人数
@property (nonatomic , copy) NSString              * betNumber;//投注号码
@property (nonatomic , copy) NSString              * betOdds;//投注赔率
@property (nonatomic , copy) NSString              * maxMoney;//最高可中
@property (nonatomic , copy) NSString              * btStatus;//中奖状态 WAIT 等待开奖 | WIN 中奖 | NO_WIN 未中奖 | HE 打和
@property (nonatomic , copy) NSString * allGodBonus;//总跟单大神分红
@property (nonatomic , assign) NSInteger isShow;//是否展示 0 不展示 1展示
@property (nonatomic , assign) NSInteger secretStatus;//保密状态 1 跟单后公开 2 开奖后公开
@property (nonatomic , assign) NSInteger godId;//大神ID
@property (nonatomic , assign) CGFloat winAmount;//中奖金额
@property (nonatomic , copy) NSString * godAnalyze;//专家分析
@property (nonatomic , copy) NSString * picture;//图片
@end

NS_ASSUME_NONNULL_END
