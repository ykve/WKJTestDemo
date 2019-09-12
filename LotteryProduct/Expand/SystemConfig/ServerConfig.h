//
//  ServerConfig.h
//  LotteryProduct
//
//  Created by AFan c on 2019/8/5.
//  Copyright © 2019 AFan. All rights reserved.
//

#ifndef ServerConfig_h
#define ServerConfig_h

#define IMGIP @"http://47.75.199.227:9001/caipiaoMedia"
#define OKFORBUY @"OKFORBUY"
#define CPTSHOWMONEYUI @"CPTSHOWMONEYUI"
#define CPTHIDDENMONEYUI @"CPTHIDDENMONEYUI"

#define CPTSHOWINFO @"CPTSHOWINFO"



#if ROUTER == 3 //008
#pragma mark - ************ 008 ************

////正式服务器
#define kServerUrl @"https://app.008api.com/appEntry"  // api地址
#define kUploadFileUrl @"https://uploadfile.008api.com/" // 文件上传
#define kRepairUrl @"http://008prodzx.oss-cn-hongkong.aliyuncs.com/"   // 请求维护的接口 封盘api
#define kPAYAPI @"https://pay-app.cptuat.net:443/appEntry"  // 支付

#define LIVE_H5 @"http://live.webcpt.com/"  // 直播开奖
#define kWebSocket_wss @"wss://message-websocket.008api.com:443/websocket" // 聊天
#define kOpenLotWebSocket_wss @"wss://sg-websocket.hkprod.net:443/websocket" // 开奖
// 暂时没有使用到
#define MQTTURL @"wss://mqclient.cptconn.com/mqtt"
#define MQTTNAME @"cptprodactivemqro"
#define MQTTSS @"kFVGWy8y9wG2WHVx"


//测试服务器
//#define kServerUrl @"https://app.008uat.com/appEntry"
//#define kUploadFileUrl @"http://uploadfile.008uat.com/"
//
//#define kRepairUrl @"http://008uatzx.oss-cn-hongkong.aliyuncs.com/"
//#define MQTTURL @"b-c112837e-277c-444d-99fd-0a0e99200219-1.mq.ap-southeast-1.amazonaws.com"
//#define MQTTNAME @"008uatactivemqro"
//#define MQTTSS @"008uatactivemqro"
//#define kPAYAPI @"https://pay-app.008uat.com:443/appEntry"
//#define LIVE_H5 @"https://live.cptcsxz.com/"
//#define kWebSocket_wss @"wss://message-websocket.cptconn.com:443/websocket"
//#define kOpenLotWebSocket_wss @"wss://sg-websocket.cptconn.com:443/websocket"


//// CPT测试库
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


//#define kServerUrl @"http://47.75.199.227:8001/appEntry"
//#define kUploadFileUrl @"http://47.75.199.227:8061/"

//#define kServerUrl @"http://192.168.0.74:8001/appEntry"

//友盟
#define UMSHARE @"5c3dae7ef1f5561a590000e1"
//极光推送
#define BUY_PUSH_KEY @"11c2c29287b0d34bb000f4b9"
//#define Info_push_key @"6f8df8c91f5b832596827fa7"
#define Info_push_key @"ad05908dc9ca789035e97070"


#define Bugly_APPID @"d904a56051"

#define QQ_APPID @"101542711"
#define QQ_SECRET @"8b2e23de0c2ed957dfd0c44a01ad3a7f"
#define kMQAppKey @"be0003af889007d4aaafcd801a1091f1"

//环信
#define HX_APPKEY @"1429190115068344#kefuchannelapp64187"
#define HX_IM @"service1"

#define Weichat_APPID @"wx0f0f1bcf56586cc5"
#define Weichat_KEY @"da8924b48d2d7209d1c608dc02c5e5db"

#define kDefaultAppKey @"1429190213068099#kefuchannelapp65763"
#define kDefaultCustomerName @"kefuchannelimid_769931"
#define kDefaultCustomerNickname @"访客昵称"
#define kDefaultTenantId @"95915"
#define kDefaultProjectId @"306713"

#elif ROUTER == 4
#pragma mark - ************ 小鱼儿 ************

//正式服务器
#define kServerUrl @"https://app.sfishapi.com/appEntry"
#define kUploadFileUrl @"http://uploadfile.zk01.cc/"
#define kRepairUrl @"http://static.zk01.cc/"
#define kPAYAPI @"https://api.paycpt.com:443/appEntry"

#define MQTTURL @"wss://mqclient.cptconn.com/mqtt"
#define MQTTNAME @"cptprodactivemqro"
#define MQTTSS @"kFVGWy8y9wG2WHVx"

#define LIVE_H5 @"https://live.webcpt.com/"
#define kWebSocket_wss @"wss://message-websocket.sfishapi.com:443/websocket"
#define kOpenLotWebSocket_wss @"wss://sg-websocket.cptconn.com:443/websocket"



//打包测试地址
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






#define UMSHARE @"5d5f9b670cafb26f14001124"
#define QQ_APPID @"101767019"
#define QQ_SECRET @"4206c39e72080f5a770d73a9edc8427a"

#define Weichat_APPID @"wx8667e3a85a26db1f"
#define Weichat_KEY @"cea32f0f7e253bff6db79a2039b89a86"

//极光推送
//#define BUY_PUSH_KEY @"bdc914029a58caaacaf37e4a"
#define Info_push_key @"bdc914029a58caaacaf37e4a"

#define Bugly_APPID @"41e65ce779"

/// 美洽AppKey
#define kMQAppKey @"bbb83646bf7e93ff23e25dc9bb677fa2"

//环信
//#define HX_APPKEY @"1113180915228439#cpbd"


#define HX_APPKEY [Tools isFirstLaunching] ? @"1141161024115978#kefuchannelapp29593" : @"1113180915228439#cpbd"
#define HX_IM @"service1"

#define kDefaultAppKey [Tools isFirstLaunching] ? @"1141161024115978#kefuchannelapp29593" : @"1113180915228439#cpbd"

#define kDefaultCustomerName @"service1"
#define kDefaultCustomerNickname @"访客昵称"
#define kDefaultTenantId @"60342"
#define kDefaultProjectId @"306713"



#elif ROUTER == 2
#pragma mark - ************ 香港彩 ************

//正式服务器
#define kServerUrl @"https://app.hkcp08.com/appEntry"
#define kUploadFileUrl @"http://uploadfile.hkcp08.com/"
#define kRepairUrl @"http://hkprodzx.oss-cn-hongkong.aliyuncs.com/"

#define MQTTURL @"b-f2344878-7d8f-4d5a-b9c7-12679b250b3d-2.mq.ap-southeast-1.amazonaws.com"
#define MQTTNAME @"hksdwgactivemqrw"
#define MQTTSS @"hkk23F5MPL93NGqrw"
#define kPAYAPI @"https://pay-app.hkprod.net:443/appEntry"
#define LIVE_H5 @"https://live.webcpt.com/"
#define kWebSocket_wss @"wss://message-websocket.cptconn.com:443/websocket"
#define kOpenLotWebSocket_wss @"wss://sg-websocket.cptconn.com:443/websocket"

//香港测试
//#define kServerUrl @"http://app.hkcp001.com/appEntry"
//#define kUploadFileUrl  @"http://uploadfile.hkcp001.com/"
//#define kRepairUrl @"http://hkuatzx.oss-cn-hongkong.aliyuncs.com/"
//
//#define MQTTURL @"b-77f9df7d-6a09-4f46-89df-00ce95e7eab0-1.mq.ap-southeast-1.amazonaws.com"
//#define MQTTNAME @"hkuatactivemqrw"
//#define MQTTSS @"hk23GMAQ834ivemqrw"
//#define kPAYAPI @"https://pay-app.hkuat.net:80/appEntry"
//#define LIVE_H5 @"https://live.cptcsxz.com/"
//#define kWebSocket_wss @"wss://message-websocket.cptconn.com:443/websocket"
//#define kOpenLotWebSocket_wss @"wss://sg-websocket.cptconn.com:443/websocket"

// 小鱼儿正式库
//#define kServerUrl @"https://app.sfishapi.com/appEntry"
//#define kUploadFileUrl @"http://uploadfile.zk01.cc/"
//#define kRepairUrl @"http://static.zk01.cc/"
//#define kPAYAPI @"https://api.paycpt.com:443/appEntry"
//
//#define MQTTURL @"wss://mqclient.cptconn.com/mqtt"
//#define MQTTNAME @"cptprodactivemqro"
//#define MQTTSS @"kFVGWy8y9wG2WHVx"
//
//#define LIVE_H5 @"https://live.webcpt.com/"
//#define kWebSocket_wss @"wss://message-websocket.sfishapi.com:443/websocket"
//#define kOpenLotWebSocket_wss @"wss://sg-websocket.cptconn.com:443/websocket"

// CPT测试库
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



//#define kServerUrl @"http://ec2-54-254-234-149.ap-southeast-1.compute.amazonaws.com:8001/appEntry"
//#define kUploadFileUrl @"http://ec2-54-169-122-8.ap-southeast-1.compute.amazonaws.com:8061/"


//nick
//#define kServerUrl @"http://192.168.0.189:8001/appEntry"

////测试服务器
//#define kServerUrl [Person person].Information == YES ? @"http://ec2-52-221-221-204.ap-southeast-1.compute.amazonaws.com:8001/appEntry" : @"http://47.75.199.227:8001/appEntry"
//#define kUploadFileUrl [Person person].Information == YES ? @"http://ec2-13-250-8-150.ap-southeast-1.compute.amazonaws.com:8061/" : @"http://47.75.199.227:8061/"

//友盟
#define UMSHARE @"5c640123b465f567f4000258"
//极光推送
#define BUY_PUSH_KEY @"f43127883a80c904c9b52e25"

//#define Info_push_key @"6f8df8c91f5b832596827fa7"
#define Info_push_key @"f43127883a80c904c9b52e25"
#define kMQAppKey @"f134723c6c1ea76072780fc21573fa17"

//环信
#define HX_APPKEY @"1429190213068099#kefuchannelapp65763"
#define HX_IM @"kefuchannelimid_769931"

#define QQ_APPID @"101548151"
#define QQ_SECRET @"98764aba20a7dcf4f770e54c76109b91"

#define Bugly_APPID @"8a4aec85cf"

#define Weichat_APPID @"wx4fafbce3d5676594"
#define Weichat_KEY @"569548c23dbc847d6034a1052f29a992"

#define kDefaultAppKey @"1429190213068099#kefuchannelapp65763"
#define kDefaultCustomerName @"kefuchannelimid_769931"
#define kDefaultCustomerNickname @"访客昵称"
#define kDefaultTenantId @"95915"
#define kDefaultProjectId @"306713"

#else //cpt




#pragma mark - ************ CPT ************

//正式服务器
//#define kServerUrl @"https://app.zk01.cc/appEntry"
//#define kUploadFileUrl @"http://uploadfile.zk01.cc/"
//#define kRepairUrl @"http://static.zk01.cc/"
//#define kPAYAPI @"https://api.paycpt.com:443/appEntry"
//
//#define MQTTURL @"wss://mqclient.cptconn.com/mqtt"
//#define MQTTNAME @"cptprodactivemqro"
//#define MQTTSS @"kFVGWy8y9wG2WHVx"
//
//#define LIVE_H5 @"https://live.webcpt.com/"
//#define kWebSocket_wss @"wss://message-websocket.cptconn.com:443/websocket"
//#define kOpenLotWebSocket_wss @"wss://sg-websocket.cptconn.com:443/websocket"


//打包测试地址
#define kServerUrl @"http://app.chengykj.com/appEntry"
#define kUploadFileUrl @"https://uploadfile.chengykj.com/"
#define kRepairUrl @"https://cptuatzx.oss-cn-hongkong.aliyuncs.com/"
#define kPAYAPI @"https://pay-app.cptuat.net:443/appEntry"

#define MQTTURL @"wss://activemq.cptuat.net/mqtt"
#define MQTTNAME @"cptuatactivemqro"
#define MQTTSS @"cptuatactivemqro"

#define LIVE_H5 @"https://liveuat.cptcsxz.com/"
#define kWebSocket_wss @"wss://message-websocket.cptuat.net:443/websocket"
#define kOpenLotWebSocket_wss @"wss://sg-websocket.cptconn.com:443/websocket"




//开发
//#define kServerUrl @"http://47.75.199.227:8001/appEntry"
//#define kUploadFileUrl @"http://47.75.199.227:8061/"
//#define kRepairUrl @"https://cptuatzx.oss-cn-hongkong.aliyuncs.com/"
//#define MQTTURL @"activemquat.cptuat.net"
//#define MQTTNAME @"cptuatactivemqro"
//#define MQTTSS @"cptuatactivemqro"
//#define kPAYAPI @"http://47.75.199.227:80/appEntry"
//#define LIVE_H5 @"https://live.webcpt.com/"

//nick
//#define kServerUrl @"http://192.168.0.195:8001/appEntry"
//#define kUploadFileUrl @"http://47.75.199.227:8061/"
//#define kRepairUrl @"https://cptuatzx.oss-cn-hongkong.aliyuncs.com/"

//lucky
//#define kServerUrl @"http://192.168.0.12:8001/appEntry"
//#define kUploadFileUrl @"http://47.75.199.227:8061/"

//Hans
//#define kServerUrl @"http://192.168.0.121:8001/appEntry"
//#define kUploadFileUrl @"http://47.75.199.227:8061/"
//#define kRepairUrl @"https://cptuatzx.oss-cn-hongkong.aliyuncs.com/"

//Hai
//#define kServerUrl @"http://172.16.43.23:8001/appEntry"
//#define kUploadFileUrl @"http://47.75.199.227:8061/"
//#define kRepairUrl @"https://cptuatzx.oss-cn-hongkong.aliyuncs.com/"


#define UMSHARE @"5be44c26f1f556a70100031f"
#define QQ_APPID @"101517011"
#define QQ_SECRET @"8b78d6d792872fff1b525b62505e747d"

#define Weichat_APPID @"wxb5985d7a813de973"
#define Weichat_KEY @"c66e86edc1e1403e1a48b86c1dabc779"

//极光推送
#define BUY_PUSH_KEY @"bdc914029a58caaacaf37e4a"
#define Info_push_key @"bdc914029a58caaacaf37e4a"

#define Bugly_APPID @"41e65ce779"
//环信
//#define HX_APPKEY @"1113180915228439#cpbd"

/// 美洽AppKey
#define kMQAppKey @"9363afe9c774b49669da366f214eb35f"


#define HX_APPKEY [Tools isFirstLaunching] ? @"1141161024115978#kefuchannelapp29593" : @"1113180915228439#cpbd"
#define HX_IM @"service1"

#define kDefaultAppKey [Tools isFirstLaunching] ? @"1141161024115978#kefuchannelapp29593" : @"1113180915228439#cpbd"

#define kDefaultCustomerName @"service1"
#define kDefaultCustomerNickname @"访客昵称"
#define kDefaultTenantId @"60342"
#define kDefaultProjectId @"306713"

#endif

#define JPushChannel @"appStore"

////正式服务器
//#define kServerUrl @"https://app.zk01.cc/appEntry"
//#define kUploadFileUrl @"http://uploadfile.zk01.cc/"
//#define kRepairUrl @"http://static.zk01.cc/"
//#define kPAYAPI @"https://api.paycpt.com:443/appEntry"
//
//#define MQTTURL @"wss://mqclient.cptconn.com/mqtt"
//#define MQTTNAME @"cptprodactivemqro"
//#define MQTTSS @"kFVGWy8y9wG2WHVx"
//
//#define LIVE_H5 @"https://live.webcpt.com/"
//#define kWebSocket_wss @"wss://message-websocket.cptconn.com:443/websocket"
//#define kOpenLotWebSocket_wss @"wss://sg-websocket.cptconn.com:443/websocket"



// 测试

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



static NSString * const kServerAddressJSON = @"[\
{\"url\":\"http://app.chengykj.com/appEntry\",\"isBeta\":\"1\",\"baseKey\":\"YXBwOmFwcA==\"},\
{\"url\":\"https://app.zk01.cc/appEntry\",\"isBeta\":\"1\",\"baseKey\":\"YXBwOmFwcA==\"}\
]";



#endif /* ServerConfig_h */
