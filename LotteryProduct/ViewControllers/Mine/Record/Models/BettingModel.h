//
//  BettingModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BettingModel : NSObject

@property (nonatomic , copy) NSString              * lotteryIds;
@property (nonatomic , assign) NSInteger              lotteryId;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , assign) NSInteger              playId;
@property (nonatomic , copy) NSString              * pageNo;
@property (nonatomic , copy) NSString              * updateTime;
@property (nonatomic , copy) NSNumber              * betAmount;
@property (nonatomic , copy) NSString              * lotteryName;
@property (nonatomic , copy) NSNumber            *  backAmount;
// 中奖状态 WAIT 等待开奖 | WIN 中奖 | NO_WIN 未中奖 | HE 打和|BACK 撤单
@property (nonatomic , copy) NSString              * tbStatus;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * orderSn;
@property (nonatomic , copy) NSNumber              * winAmount;
@property (nonatomic , copy) NSNumber              * ID;
@property (nonatomic , copy) NSString              * odds;
@property (nonatomic , copy) NSString              * date;
@property (nonatomic , copy) NSString              * playName;
@property (nonatomic , assign) NSInteger              settingId;
@property (nonatomic , copy) NSString              * betNumber;
@property (nonatomic , assign) NSInteger              betCount;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , assign) NSInteger              orderId;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString               * openNumber;

@property (nonatomic , assign) BOOL                   selected;


@property (nonatomic , copy) NSNumber             * betPrice;
@property (nonatomic , assign) BOOL              isDelete;
@property (nonatomic , assign) BOOL              isStop;
@property (nonatomic , assign) NSInteger              appendCount;
@property (nonatomic , assign) NSInteger              appendedCount;
@property (nonatomic , assign) NSInteger              winCount;
@property (nonatomic , assign) NSInteger              betMultiples;
@property (nonatomic , copy) NSNumber             * currentBetPrice;
@property (nonatomic , assign) BOOL              winStop;
@property (nonatomic , assign) NSInteger              doubleMultiples;
@property (nonatomic , copy) NSString              * firstIssue;


@end
