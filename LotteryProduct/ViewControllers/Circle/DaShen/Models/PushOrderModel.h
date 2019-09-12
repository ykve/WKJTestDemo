//
//  PushOrderModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushOrderModel : NSObject
@property (nonatomic , copy) NSString              * btState;//WAIT 等待开奖 | WIN 中奖 | NO_WIN 未中奖 | HE 打和
@property (nonatomic , assign) NSInteger              gdCount;
@property (nonatomic , copy) NSString              * showRate;
@property (nonatomic , copy) NSString              * odds;
@property (nonatomic , assign) CGFloat              ensureOdds;
@property (nonatomic , copy) NSString              * heads;
@property (nonatomic , copy) NSNumber             * betAmount;
@property (nonatomic , assign) NSInteger              pushOrderId;
@property (nonatomic , assign) NSInteger              secretStatus;
@property (nonatomic , copy) NSString              * godAnalyze;
@property (nonatomic , copy) NSString              * playName;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * lotteryAndIssue;

@property (nonatomic , assign) NSInteger              godId;
@property (nonatomic , assign) CGFloat              bonusScale;
@property (nonatomic , copy) NSString              * lotteryName;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , assign) NSInteger              lotteryId;
@property (nonatomic , copy) NSNumber               * fenhongAmount;
@property (nonatomic , copy) NSNumber               * winAmount;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , assign) NSTimeInterval          endTime;//截止时间
@property (nonatomic , assign) NSInteger              isRecord;//
@property (nonatomic , copy) NSString              * lotteryRecord;//近10期战绩 ，分割 0 赢 1 亏 2 和

@end
