//
//  YQJPushManager.m
//  HappyBlueOcean
//
//  Created by Mopon on 16/7/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YQJPushManager.h"

#import <UIKit/UIKit.h>




@interface YQJPushManager ()

@property (nonatomic ,strong)NSMutableArray *listeners;//监听对象数组

@end

@implementation YQJPushManager

+ (YQJPushManager *)sharedManager
{
    static YQJPushManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

+(void)registerJPush:(NSDictionary *)launchOptions{
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];

    NSString *JPushAppKey = nil;
    
//    if (![Person person].Information) {
    
        JPushAppKey = Info_push_key;
//    }
//    else{
//        JPushAppKey = BUY_PUSH_KEY;
//    }
    
#if DEBUG
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:JPushChannel
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
#else
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:JPushChannel
                 apsForProduction:YES
            advertisingIdentifier:nil];
#endif
    
    MBLog(@"%@", JPushAppKey);
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
        MBLog(@"%@", registrationID);
        
    }];

    
    BOOL chongqin = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_cqssc"] boolValue];
    if (chongqin) {
        [YQJPushManager setopenpush:@"kj_cqssc"];
    }
    
    BOOL liuhe = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_xglhc"] boolValue];
    if (liuhe) {
        [YQJPushManager setopenpush:@"kj_xglhc"];
    }
    
    BOOL beijin = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_bjpks"] boolValue];
    if (beijin) {
        [YQJPushManager setopenpush:@"kj_bjpks"];
    }
    
    BOOL feitin = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_xyft"] boolValue];
    if (feitin) {
        [YQJPushManager setopenpush:@"kj_xyft"];
    }
    
    BOOL xinjiang = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_xjssc"] boolValue];
    if (xinjiang) {
        [YQJPushManager setopenpush:@"kj_xjssc"];
    }
    
    BOOL tengxun = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_txffc"] boolValue];
    if (tengxun) {
        [YQJPushManager setopenpush:@"kj_txffc"];
    }
    
    BOOL pcdandan = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_pcegg"] boolValue];
    if (pcdandan) {
        [YQJPushManager setopenpush:@"kj_pcegg"];
    }
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(getjpushInfo:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
}

+(void)getjpushInfo:(NSNotification *)ntf
{
    MBLog(@"收到消息  %@",ntf);
    NSDictionary *extras = [ntf.userInfo valueForKey:@"extras"];
    
    if (extras && [extras isKindOfClass:[NSDictionary class]]) {
        
        NSString *msgType = [extras valueForKey:@"msgType"];
        MBLog(@"收到消息类型  %@",msgType);

        [[NSNotificationCenter defaultCenter]postNotificationName:msgType object:nil];
     
        /*
        if ([msgType isEqualToString:@"kj_cqssc"]) {
            
            
        }
        else if ([msgType isEqualToString:@"kj_xglhc"]) {
            
            
        }
        else if ([msgType isEqualToString:@"kj_bjpks"]) {
            
            
        }
        else if ([msgType isEqualToString:@"kj_xyft"]) {
            
            
        }
        else if ([msgType isEqualToString:@"kj_xjssc"]) {
            
            
        }
        else if ([msgType isEqualToString:@"kj_txffc"]) {
            
            
        }
        else if ([msgType isEqualToString:@"kj_pcegg"]) {
            
            
        }
        */
    }
}


+(void)setopenpush:(NSString *)key {
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
        [JPUSHService setTags:[NSSet setWithObject:key] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
         
        } seq:1];
    });
}

+(void)addListener:(id<YQJPushManagerDelegate>)listener{

    YQJPushManager *manager = [YQJPushManager sharedManager];
    if ([manager.listeners containsObject:listener]) {//如果对象已经添加了监听但没有被移除
        return;
    }else{
        [manager.listeners addObject:listener];
    }
}

+(void)removeListener:(id<YQJPushManagerDelegate>)listener{

    YQJPushManager *manager = [YQJPushManager sharedManager];
    if ([manager.listeners containsObject:listener]) {//如果存在该监听对象，移除
        [manager.listeners removeObject:listener];
    }else{
        return;
    }
}

-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    if (self.listeners.count == 0) return;//没有监听对象。return
    [self.listeners enumerateObjectsUsingBlock:^(id<YQJPushManagerDelegate>listener , NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([listener respondsToSelector:@selector(didReceiveRemoteNotification:)]) {
            
            [listener didReceiveRemoteNotification:userInfo];
        }
        
    }];
}


-(NSMutableArray *)listeners{

    if (!_listeners) {
        _listeners = [NSMutableArray array];
    }
    return _listeners;
}

@end
