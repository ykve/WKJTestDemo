//
//  ChatMessageModel.h
//  LotteryProduct
//
//  Created by pt c on 2019/5/4.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface OrderModel : NSObject
@property (nonatomic,assign) NSInteger messageType;// 0 信息 1 公告 2 删除信息

@property (nonatomic,copy) NSString *accout;
@property (nonatomic,copy) NSNumber *betAmount;
@property (nonatomic,copy) NSString *betNumber;
@property (nonatomic,copy) NSString *bonusScale;
@property (nonatomic,copy) NSString *ensureOdds;
@property (nonatomic,copy) NSString *godId;
@property (nonatomic,copy) NSString *issue;
@property (nonatomic,copy) NSString *lotteryName;
@property (nonatomic,assign) NSInteger lotteryId;
@property (nonatomic,copy) NSString *odds;
@property (nonatomic,copy) NSString *playName;
@property (nonatomic,copy) NSString *showProfitRate;
@property (nonatomic,copy) NSString *winAmount;
@property (nonatomic,copy) NSString *orderBetId;

@end
@interface ChatMessageModel : NSObject

@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *head;
@property (nonatomic,copy) NSString *isFollow;
@property (nonatomic,copy) NSString *userType;//前后端标识 0 前端 1 后台
@property (nonatomic,assign) NSInteger totalNumber;
@property (nonatomic,assign) NSInteger money;
@property (nonatomic,assign) NSInteger sendNumber;
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,assign) NSInteger messageType;// 0 信息 1 公告 2 删除信息  6  踢出聊天室
@property (nonatomic,assign) NSInteger status;//公告字段 0 关闭 1 开启

@property (nonatomic,copy) NSString *level;
@property (nonatomic,assign) NSInteger lotteryId;
@property (nonatomic,assign) NSInteger type;//0 普通 1跟单
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *trackId;//推单id

@property (nonatomic, strong) NSDictionary *pushOrderContentVO;//跟单信息
@property (nonatomic, strong)OrderModel *orderModel;

@end

NS_ASSUME_NONNULL_END
