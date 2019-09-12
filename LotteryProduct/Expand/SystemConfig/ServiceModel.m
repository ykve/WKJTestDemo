//
//  ServiceModel.m
//  LotteryProduct
//
//  Created by pt c on 2019/8/26.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "ServiceModel.h"

@implementation ServiceModel

+ (instancetype)sharedInstance
{
    NSAssert(0, @"这是一个单例对象，请使用+(ServiceModel *)sharedInstance方法");
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    return sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}
- (id)copy
{
    return self;
}
- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return self;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}





- (instancetype)init {
    self = [super init];
    if (self) {
        [self initServieConfig];
    }
    return self;
}

- (void)initServieConfig {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger serverIndex = [[ud objectForKey:@"serverIndex"] integerValue];
    NSArray *arr = [self ipArray];
    if(serverIndex >= arr.count) {
        serverIndex = 0;
    }
    NSDictionary *dic = arr[serverIndex];
    _serverUrl = dic[@"url"];
    _isBeta = [dic[@"isBeta"] boolValue];
}

//#define kServerUrl @"http://app.chengykj.com/appEntry"
//#define kUploadFileUrl @"https://uploadfile.chengykj.com/"
//#define kRepairUrl @"https://cptuatzx.oss-cn-hongkong.aliyuncs.com/"
//#define kPAYAPI @"https://pay-app.cptuat.net:443/appEntry"
//
//#define MQTTURL @"wss://activemq.cptuat.net/mqtt"
//#define MQTTNAME @"cptuatactivemqro"
//#define MQTTSS @"cptuatactivemqro"
//
//#define LIVE_H5 @"https://liveuat.cptcsxz.com/"
//#define kWebSocket_wss @"wss://message-websocket.cptuat.net:443/websocket"
//#define kOpenLotWebSocket_wss @"wss://sg-websocket.cptconn.com:443/websocket"


-(NSArray *)ipArray {
    //    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //    NSArray *arr = [ud objectForKey:@"ipArray"];
    //    NSDictionary *dic1 = @{@"url":kServerUrl, @"isBeta":@(NO),@"baseKey":kBaseKey};
    //    NSMutableArray *array = [NSMutableArray arrayWithObjects:dic1, nil];
    NSArray *testArr = [kServerAddressJSON mj_JSONObject];
    return testArr;
}

@end
