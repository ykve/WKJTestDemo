//
//  CPTOpenLotteryManager.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/18.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatMessageModel.h"
#import "CPTOpenLotteryCtrl.h"
#import <SocketRocket.h>

@class IGKbetModel;
NS_ASSUME_NONNULL_BEGIN
//void (^CPTOpenLotteryManagerSuccessGetModelBlock) (IGKbetModel *model);
@interface CPTOpenLotteryManager : NSObject
@property (nonatomic, assign) NSInteger curenttime;
@property (nonatomic,copy) void(^didReceiveChatMessage)(ChatMessageModel *,NSString *);
@property (nonatomic,copy) void(^connectSuccess)(void);
@property (nonatomic, strong) CPTOpenLotteryCtrl*longVC;

+ (id)shareManager;
//-(void)checkModel:(void (^)(IGKbetModel *data,BOOL isSuccess))success;
//-(void)refreshModel:(void (^)(IGKbetModel *data,BOOL isSuccess))success;
-(void)checkModelByIds:(NSArray *)ids callBack:(void (^)(IGKbetModel *data,BOOL isSuccess))success;
- (NSString *)checkNiuNiubyNumbers:(NSString *)numbers limitCount:(NSInteger)limitCount;//牛牛计算
- (void)getNewData;
//- (BOOL)isconfigWait30sDataByIds:(CPTBuyTicketType )ids;
//- (BOOL)isconfigWait6sDataByIds:(CPTBuyTicketType )ids;
- (void)pauseTimer;
- (void)startTimer;
- (BOOL)nowIsConnected;//判断是否是连接的状态
//- (void)startConnectServer;
//- (void)reconnet;//重连
//- (void)subscibeToTopic:(NSString *)topicUrl;//订阅
//- (void)cancelSubscibeToTopic:(NSString *)topic;//取消订阅
//-(void)closeMQTTClient;
- (void)cannelBlock;

@property (nonatomic,assign) SRReadyState socketReadyState;
@property (nonatomic,  copy) void (^didReceiveMessage)(id message);

-(void)openSocket;//开启连接
-(void)closeocket;//关闭连接
- (void)sendData:(NSDictionary *)paramDic withRequestURI:(NSString*)requestURI;//发送数据
- (void)registerNetworkNotifications;//监测网络状态

@end

NS_ASSUME_NONNULL_END
