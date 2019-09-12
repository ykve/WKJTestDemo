//
//  CPTChatManager.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/8/9.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPTChatManager : NSObject
@property (nonatomic,assign) SRReadyState socketReadyState;
@property (nonatomic,  copy) void (^didReceiveMessage)(id message);
@property (nonatomic,copy) void(^didReceiveChatMessage)(ChatMessageModel *,NSString *);
@property (nonatomic,copy) void(^connectSuccess)(void);
- (BOOL)nowIsConnected;//判断是否是连接的状态

+ (id)shareManager;
- (void)cannelBlock;
-(void)openSocket;//开启连接
-(void)closeocket;//关闭连接
- (void)sendData:(NSDictionary *)paramDic withRequestURI:(NSString*)requestURI;//发送数据
- (void)registerNetworkNotifications;//监测网络状态
@end

NS_ASSUME_NONNULL_END
