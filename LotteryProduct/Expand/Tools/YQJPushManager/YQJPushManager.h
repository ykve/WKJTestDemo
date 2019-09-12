//
//  YQJPushManager.h
//  HappyBlueOcean
//
//  Created by Mopon on 16/7/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YQJPushManagerDelegate <NSObject>

@required
-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo;

@end

@interface YQJPushManager : NSObject<YQJPushManagerDelegate>

+(YQJPushManager *)sharedManager;

/**
 *  注册极光推送
 *
 *  @param launchOptions didFinishLaunchingWithOptions方法里边的launchOptions传进来
 */
+(void)registerJPush:(NSDictionary *)launchOptions;

/**
 *  添加监听对象
 */
+(void)addListener:(id<YQJPushManagerDelegate>)listener;

/**
 *  移除监听对象
 */
+(void)removeListener:(id<YQJPushManagerDelegate>)listener;


@end
