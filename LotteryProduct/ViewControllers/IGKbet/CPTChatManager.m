//
//  CPTChatManager.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/8/9.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTChatManager.h"
@interface CPTChatManager()<SRWebSocketDelegate>{
    NSTimer * heartBeat;
    NSTimeInterval reConnectTime;
    SocketDataType type;
    NSString *host;
}

@property (nonatomic,strong) SRWebSocket *socket;

@end
@implementation CPTChatManager
static CPTChatManager *manager;
+ (id)shareManager
{
    @synchronized(self){
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            manager = [[self alloc] init];
        });
    }
    return manager;
}
- (BOOL)nowIsConnected{
    if(self.socket.readyState == SR_OPEN){
        return YES;
    }else{
        return NO;
    }
}

- (void)cannelBlock{
    if(self.didReceiveChatMessage){
        self.didReceiveChatMessage = nil;
    }
    if(self.connectSuccess){
        self.connectSuccess= nil;
    }
}

#pragma mark - websocket

- (void)registerNetworkNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChangedNote:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}
- (void)networkChangedNote:(NSNotification *)note{
    
    AFNetworkReachabilityStatus status = [note.userInfo[AFNetworkingReachabilityNotificationStatusItem] integerValue];
    switch (status) {
        case AFNetworkReachabilityStatusUnknown:
            NSLog(@"网络类型：未知网络");
            break;
        case AFNetworkReachabilityStatusNotReachable:
            NSLog(@"网络类型：断网");
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            NSLog(@"网络类型：数据流量");
            [self openSocket];
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            NSLog(@"网络类型：WIFI");
            [self openSocket];
            break;
    }
}

-(void)openSocket{
    //如果是同一个url return
    if (self.socket) {
        return;
    }
    if(self.socket.readyState == SR_OPEN){
        return;
    }
    
    self.socket = [[SRWebSocket alloc] initWithURLRequest:
                   [NSURLRequest requestWithURL:[NSURL URLWithString:kWebSocket_wss]]];//这里填写你服务器的地址 


    MBLog(@"请求的websocket地址：%@",self.socket.url.absoluteString);
    self.socket.delegate = self;   //实现这个 SRWebSocketDelegate 协议
    [self.socket open];     //open 就是直接连接了
}

-(void)closeocket{
    if (self.socket){
        [self.socket close];
        self.socket = nil;
        //断开连接时销毁心跳
        [self destoryHeartBeat];
    }
}

#pragma mark - socket delegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    
    //每次正常连接的时候清零重连时间
    reConnectTime = 0;
    
    //开启心跳
    [self initHeartBeat];
    if (webSocket == self.socket) {
        MBLog(@"************************** socket 连接成功************************** ");
        if(self.connectSuccess){
            self.connectSuccess();
        }
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    
    if (webSocket == self.socket) {
        MBLog(@"************************** socket 连接失败************************** ");
        _socket = nil;
        //连接失败就重连
        [self reConnect];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    
    if (webSocket == self.socket) {
        MBLog(@"************************** socket连接断开************************** ");
        MBLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",(long)code,reason,wasClean);
        [self closeocket];
        [self reConnect];
    }
    
}

/*该函数是接收服务器发送的pong消息，其中最后一个是接受pong消息的，
 在这里就要提一下心跳包，一般情况下建立长连接都会建立一个心跳包，
 用于每隔一段时间通知一次服务端，客户端还是在线，这个心跳包其实就是一个ping消息，
 我的理解就是建立一个定时器，每隔十秒或者十五秒向服务端发送一个ping消息，这个消息可是是空的
 */

-(void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
//    MBLog(@"reply===%@",reply);
}


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark - 收到的回调
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message  {
    
    if (webSocket == self.socket) {
//        MBLog(@"************************** socket收到数据了************************** ");
//        MBLog(@"message:%@",message);
        if(!message){
            return;
        }
//        NSData * data = [message dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [self dictionaryWithJsonString:message];
        //    id aaa = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        BaseData *basedata = [BaseData mj_objectWithKeyValues:dic];
        //    MBLog(@"====+++%@",topic);
        if (basedata.status.integerValue == 1){
//                MBLog(@"%@",basedata.data);
            if(self.didReceiveChatMessage){
                ChatMessageModel *model = [ChatMessageModel mj_objectWithKeyValues:basedata.data];
                model.orderModel = [OrderModel mj_objectWithKeyValues:model.pushOrderContentVO];
                self.didReceiveChatMessage(model, @"1");
            }
        }
        [self handleReceivedMessage:message];
        
    }
}
- (void)handleReceivedMessage:(id)message{
    
    if(self.didReceiveMessage){
        self.didReceiveMessage(message);
    }
    
}


//重连机制
- (void)reConnect
{
    
    [self closeocket];
    //超过一分钟就不再重连 所以只会重连5次 2^5 = 64
    if (reConnectTime > 64*2) {
        //您的网络状况不是很好，请检查网络后重试
        return;
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.socket = nil;
        [self openSocket];
        MBLog(@"重连");
    });
    
    //重连时间2的指数级增长
    if (reConnectTime == 0) {
        reConnectTime = 2;
    }else{
        reConnectTime *= 2;
    }
    
}

//初始化心跳
- (void)initHeartBeat
{
    dispatch_main_async_safe(^{
        [self destoryHeartBeat];
        
        heartBeat = [NSTimer timerWithTimeInterval:28 target:self selector:@selector(ping) userInfo:nil repeats:YES];
        //和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
        [[NSRunLoop currentRunLoop]addTimer:heartBeat forMode:NSRunLoopCommonModes];
    })
}


//取消心跳
- (void)destoryHeartBeat
{
    dispatch_main_async_safe(^{
        if (heartBeat) {
            if ([heartBeat respondsToSelector:@selector(isValid)]){
                if ([heartBeat isValid]){
                    [heartBeat invalidate];
                    heartBeat = nil;
                }
            }
        }
    })
}

//pingPong
- (void)ping{
    if (self.socket.readyState == SR_OPEN) {
        [self.socket sendPing:nil];
    }
}

- (void)sendData:(NSDictionary *)paramDic withRequestURI:(NSString *)requestURI{
    //这一块的数据格式由你们跟你们家服务器哥哥商定
    NSDictionary *configDic;
    
    //requestURI = [NSString stringWithFormat:@"/api/%@",requestURI];
    
    //    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    NSDictionary *configDic = @{
    //                                @"usersign"  :appDelegate.appToken,
    //                                @"command"   :@"response",
    //                                @"requestURI":requestURI,                                @"headers"   :@{@"Version":AboutVersion,
    //                                                @"Token":appDelegate.appToken,
    //                                                @"LoginName":appDelegate.appLoginName},
    //                                @"params"    :paramDic
    //                                };
//    MBLog(@"socketSendData--configDic --------------- %@",configDic);
    NSError *error;
    NSString *data;
    //(NSJSONWritingOptions) (paramDic ? NSJSONWritingPrettyPrinted : 0)
    //采用这个格式的json数据会比较好看，但是不是服务器需要的
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:configDic
                                                       options:0
                                                         error:&error];
    
    if (!jsonData) {
        MBLog(@" error: %@", error.localizedDescription);
        return;
    } else {
        data = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //这是为了取代requestURI里的"\"
        //data = [data stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    }
    @weakify(self);
    dispatch_queue_t queue =  dispatch_queue_create("zy", NULL);
    
    dispatch_async(queue, ^{
        @strongify(self)
        if (self.socket != nil) {
            // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
            if (self.socket.readyState == SR_OPEN) {
                [self.socket send:data];    // 发送数据
                
            } else if (self.socket.readyState == SR_CONNECTING) {
                
                [self reConnect];
                
            } else if (self.socket.readyState == SR_CLOSING || self.socket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                MBLog(@"重连");
                
                [self reConnect];
            }
        } else {
            // 这里要看你的具体业务需求；不过一般情况下，调用发送数据还是希望能把数据发送出去，所以可以再次打开链接；不用担心这里会有多个socketopen；因为如果当前有socket存在，会停止创建哒
            [self openSocket];
        }
    });
}

-(SRReadyState)socketReadyState{
    return self.socket.readyState;
}


@end
