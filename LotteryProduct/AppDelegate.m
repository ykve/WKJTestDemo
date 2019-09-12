//
//  AppDelegate.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

/*
 购彩
 com.softgarden.lotterybuy
 资讯
 com.softgarden.lotteryInfo
 */

#import "AppDelegate.h"
//#import "AppDelegate+HelpDesk.h"
#import "YQJPushManager.h"
#import "NavigationVCViewController.h"
#import "MainTabbarCtrl.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <UMMobClick/MobClick.h>
#import <UMSocialCore/UMSocialCore.h>
#import "MBAppFistguideUseViewController.h"
#import <Bugly/Bugly.h>
#import "CartCtrl.h"
#import <UserNotifications/UserNotifications.h>
#import "CLGifLoadView.h"
#import "MSWeakTimer.h"
#import "RepairView.h"
#import <MeiQiaSDK/MQManager.h>
#import "ZAlertViewManager.h"
#import "DragonLongModel.h"
#import "CPTChangLongController.h"
#import "RequestIPAddress.h"


@interface AppDelegate ()<JPUSHRegisterDelegate, UNUserNotificationCenterDelegate, JPUSHGeofenceDelegate>{
    __block CLGifLoadView *gifLoading;
    MSWeakTimer *weakTimer;
    NSTimer *_timer;
    NSTimer *_sendIpTimer;
}

@property (nonatomic, strong) RepairView *repairView;

@end

@implementation AppDelegate

+ (AppDelegate *)shareapp{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
     application.statusBarStyle = UIStatusBarStyleLightContent;
    
    self.wkjScheme = ROUTER;
    [self setThemeSkin];
    
    [self AFNReachability];
    
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemImage = IMAGE(@"keyboarddown");
    [[IQKeyboardManager sharedManager] setEnable:YES];

    [Bugly startWithAppId:Bugly_APPID];

    // 极光推送设置
    [YQJPushManager registerJPush:launchOptions];
    // UM日志
    [self setThirdParth];
    
    [self getVersion];

    [[CPTBuyDataManager shareManager] loadData];
    [[CPTBuyDataManager shareManager] downloadOdds];

    [MQManager initWithAppkey:kMQAppKey completion:^(NSString *clientId, NSError *error) {
        if (!error) {
            MBLog(@"美洽 SDK：初始化成功");
        } else {
            MBLog(@"error:%@",error);
        }
    }];

    [self downloadUrlNews];
    [self dragonLongPushNotification];
    
    _sendIpTimer =[NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(sendDeviceIdIp) userInfo:@"小明" repeats:YES];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)getVersion {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isFirstOpen"];
    NSString *key = @"CFBundleShortVersionString";
    // 取出沙盒中存储的上次使用软件的版本号
    NSString *lastVersion = [userDefault stringForKey:key];
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        
        if ([userDefault objectForKey:PERSONKEY]) {
            
            NSMutableDictionary *dic = [userDefault objectForKey:PERSONKEY];
            
            [[Person person] setupWithDic:dic];
            
        }
        [self setmainroot];
        
        
    } else { // 新版本
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isFirstOpen"];
        [self setfirstroot];
        // 存储新版本
        [userDefault setObject:currentVersion forKey:key];
        [userDefault synchronize];
    }
}

#pragma mark -  切换主题
- (void)setThemeSkin {
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    if (self.wkjScheme == Scheme_LotterHK){
        self.sKinThemeType = SKinType_Theme_White;
        [user setObject:@(SKinType_Theme_White) forKey:WKJTheme_ThemeType];
        [user synchronize];
        [[CPTThemeConfig shareManager] hkTheme];
    } else if (self.wkjScheme == Scheme_LotterEight){
        self.sKinThemeType = SKinType_Theme_White;
        [user setObject:@(SKinType_Theme_White) forKey:WKJTheme_ThemeType];
        [user synchronize];
        [[CPTThemeConfig shareManager] eightTheme];
    } else if (self.wkjScheme == Scheme_LitterFish){
        
        if([user objectForKey:WKJTheme_ThemeType]) {
            SKinThemeType sKinThemeType = [[user objectForKey:WKJTheme_ThemeType] integerValue];
            if(sKinThemeType == SKinType_Theme_White) {
                self.sKinThemeType = SKinType_Theme_White;
                [[CPTThemeConfig shareManager] LitterFish_whiteTheme];
            }else{
                self.sKinThemeType = SKinType_Theme_Dark;
                [[CPTThemeConfig shareManager] LitterFish_darkTheme];
            }
        } else {
            self.sKinThemeType = SKinType_Theme_White;
            [[CPTThemeConfig shareManager] LitterFish_whiteTheme];
        }
        
    } else {
        
        if([user objectForKey:WKJTheme_ThemeType]) {
          SKinThemeType sKinThemeType = [[user objectForKey:WKJTheme_ThemeType] integerValue];
            if(sKinThemeType == SKinType_Theme_White) {
                self.sKinThemeType = SKinType_Theme_White;
                [[CPTThemeConfig shareManager] whiteTheme];
            }else{
                self.sKinThemeType = SKinType_Theme_Dark;
                [[CPTThemeConfig shareManager] darkTheme];
            }
        } else {
            self.sKinThemeType = SKinType_Theme_White;
            [[CPTThemeConfig shareManager] whiteTheme];
        }
    }

}


//获取rootViewController
+ (UIViewController *)rootViewController{
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    return window.rootViewController;
}

//获取Window当前显示的ViewController
+ (UIViewController*)currentViewController{
    
    UIViewController* vc = [AppDelegate rootViewController];
    
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            
            vc = vc.presentedViewController;
        }
        else{
            break;
        }
        
    }
    
    return vc;//
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
{
    if (self.allowRotation == YES) {
        //横屏
        return UIInterfaceOrientationMaskLandscape;
        
    }else{
        //竖屏
        return UIInterfaceOrientationMaskPortrait;
    }
}

-(void)setmainroot {
    self.tab = [[MainTabbarCtrl alloc]init];
    NavigationVCViewController *nav = [[NavigationVCViewController alloc]initWithRootViewController:self.tab];
    nav.navigationBar.hidden = YES;
    self.window.rootViewController = nav;
}

-(void)clearRootVC {
    if([AppDelegate shareapp].tab){
        [AppDelegate shareapp].tab = nil;
    }
    NavigationVCViewController *nav = (NavigationVCViewController *)self.window.rootViewController ;
    if(nav){
        nav = nil;
    }
}


-(void)setfirstroot {
    
    [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:@"lottery_shake"];
    [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:@"lottery_voice"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.25f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];//表示动画是否结束,动画结束返回YES，否则NO。
        
        [UIView setAnimationsEnabled:NO];
        
        NavigationVCViewController *nav=[[NavigationVCViewController alloc]initWithRootViewController:[[MBAppFistguideUseViewController alloc ]init]];
        [nav setNavigationBarHidden:YES];
        nav.navigationBar.hidden = YES;
        self.window.rootViewController = nav;
        [UIView setAnimationsEnabled:oldState];
    } completion:nil];
}


- (void)getRepairData{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSInteger time = interval;
    NSString *timestamp = [NSString stringWithFormat:@"%zd",time];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:timestamp forKey:@"time"];
    @weakify(self)
    [self requestURL:[NSString stringWithFormat:@"%@else/sys-upgrade/systemUpgrade.txt?time=%@", kRepairUrl,timestamp] httpMethod:@"GET" params:nil complection:^(NSDictionary *response) {
        @strongify(self)
        if ([response[@"state"] isEqualToString:@"1"]) {//维护中
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                [self showRepairVc:response];
            });
            
        }else{//维护结束
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                [self.repairView removeFromSuperview];
                if(response[@"mqttUrl"]){
//                    MBLog(@"mqttUrl:%@",response[@"mqttUrl"]);
                    self.mqttURL = response[@"mqttUrl"];
                }
            });
        }
    } error:^(NSError *err, id errMsg) {
        
    }];
}

- (void)showRepairVc : (NSDictionary *)dic{
    if(dic[@"mqttUrl"]){
        MBLog(@"mqttUrl:%@",dic[@"mqttUrl"]);
        self.mqttURL = dic[@"mqttUrl"];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.repairView];
    [self.repairView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([UIApplication sharedApplication].keyWindow);
    }];
    
    if (dic) {
        self.repairView.dict = dic;
    }
}

//获取界面最上层的控制器
- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
//一层一层的进行查找判断
- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* nav = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


-(void)setThirdParth {
    
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:NO];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMSHARE];
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:Weichat_APPID appSecret:Weichat_KEY redirectURL:@"http://mobile.umeng.com/social"];
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APPID  appSecret:QQ_SECRET redirectURL:@"http://mobile.umeng.com/social"];
    UMConfigInstance.appKey = UMSHARE;
    UMConfigInstance.channelId = @"1336884683";
    UMConfigInstance.eSType = E_UM_NORMAL; //仅适用于游戏场景，应用统计不用设置
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    //注册APNs推送
    [self registerRemoteNotification];
}

// 注册推送
- (void)registerRemoteNotification{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    [application registerForRemoteNotifications];
#endif
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    UIApplication*  app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
#pragma mark  集成第三步: 进入后台 关闭美洽服务
    [MQManager closeMeiqiaService];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}




- (void)applicationWillEnterForeground:(UIApplication *)application {
#pragma mark  集成第二步: 进入前台 打开meiqia服务
    [MQManager openMeiqiaService];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [self getRepairData];

    weakTimer = [MSWeakTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(getRepairData) userInfo:nil repeats:YES dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    [weakTimer invalidate];
    weakTimer = nil;
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    
    return result;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    
    return result;
}



- (void)applicationWillTerminate:(UIApplication *)application {
    [self destroyIPTimer];
}

-(void)updateMethod:(NSDictionary *)sender {

    if (sender) {

        NSString *releaseNote = [sender valueForKey:@"releaseNote"];
        
        NSString *url = [sender valueForKey:@"appUrl"];
        [AlertViewTool alertViewToolShowTitle:@"更新提示" message:releaseNote cancelTitle:@"取消" confiormTitle:@"更新" fromController:self.window.rootViewController handler:^(NSInteger index) {

            if (index == 1) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                
                [MBProgressHUD showMessage:@"请回到桌面查看安装进度"];

            }
        }];
    }

}

//使用AFN框架来检测网络状态的改变
-(void)AFNReachability
{
    //1.创建网络监听管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //2.监听网络状态的改变
    /*
     AFNetworkReachabilityStatusUnknown     = 未知
     AFNetworkReachabilityStatusNotReachable   = 没有网络
     AFNetworkReachabilityStatusReachableViaWWAN = 3G
     AFNetworkReachabilityStatusReachableViaWiFi = WIFI
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
            NSLog(@"没有网络");
        }
        else{
            
            NSLog(@"有网络");
            if ([Person person].neturl){
                
                [WebTools postWithURL:[Person person].neturl params:[Person person].netparmas success:[Person person].successBlock failure:[Person person].failureBlock showHUD:[Person person].show];
            }
            
        }
        
    }];
    
    //3.开始监听
    [manager startMonitoring];
}

- (void)showGif{
    @weakify(gifLoading)
    if ([NSThread currentThread] == [NSThread mainThread]) {
        if(gifLoading ){
            [gifLoading removeFromSuperview];
            gifLoading = nil;
        }
//            gifLoading = [[CLGifLoadView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        gifLoading = [[CLGifLoadView alloc]initWithFrame:CGRectMake(0, Height_NavBar, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width - Height_NavBar)];
        
            [gifLoading tapHandle:^{
                @strongify(gifLoading)
                [gifLoading remove];
            }];
            //        gifLoading.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.3];
            gifLoading.backgroundColor = [UIColor clearColor];
            [[UIApplication sharedApplication].keyWindow addSubview:gifLoading];
        gifLoading.state = CLLoadStateLoading;
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(gifLoading)
            if(gifLoading ){
                [gifLoading removeFromSuperview];
                gifLoading = nil;
            }
                gifLoading = [[CLGifLoadView alloc]initWithFrame:CGRectMake(0, Height_NavBar, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width - Height_NavBar)];
                
                [gifLoading tapHandle:^{
                    
                    [gifLoading remove];
                }];
                //        gifLoading.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.3];
                gifLoading.backgroundColor = [UIColor clearColor];
                [[UIApplication sharedApplication].keyWindow addSubview:gifLoading];
            gifLoading.state = CLLoadStateLoading;
        });
    }
}

- (void)dismissGif{
    @weakify(gifLoading)
    if ([NSThread currentThread] == [NSThread mainThread]) {
        
        if(gifLoading ){
            gifLoading.state = CLLoadStateFinish;
            [gifLoading removeFromSuperview];
            gifLoading = nil;
        }
    }
    else{
        @strongify(gifLoading)
        dispatch_async(dispatch_get_main_queue(), ^{
            if(gifLoading ){
                gifLoading.state = CLLoadStateFinish;
                [gifLoading removeFromSuperview];
            }
        });
    }
}

- (void)showFailedGif{
    @weakify(gifLoading)
    if ([NSThread currentThread] == [NSThread mainThread]) {
        if(gifLoading){
            gifLoading.state = CLLoadStateFailed;
            //        @weakify(self)
            gifLoading.retryBlcok = ^{
                NSLog(@"重试");
                //            @strongify(self)
                //            [self postWithURL:url params:params success:success failure:failure  showHUD:YES];
            };
        }
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(gifLoading)
            if(gifLoading){
                gifLoading.state = CLLoadStateFailed;
                //        @weakify(self)
                gifLoading.retryBlcok = ^{
                    NSLog(@"重试");
                    //            @strongify(self)
                    //            [self postWithURL:url params:params success:success failure:failure  showHUD:YES];
                };
            }
        });
        
    }

}

- (RepairView *)repairView{
    
    if (!_repairView) {
        _repairView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([RepairView class]) owner:self options:nil]firstObject];
    }
    
    return _repairView;
}

// 通用请求
- (void)requestURL:(NSString *)urlStr
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)params
       complection:(void (^) (id response))succ
             error:(void (^) (NSError *err, id errMsg))fail
{
    // 可以在此处拼接公共url
    NSString *strUrl = [NSString stringWithFormat:@"%@",urlStr];
    // 将URL中的空白全部去掉，防止url前后有空白
    NSString *urlPath = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *url = [NSURL URLWithString:urlPath];
    
    // 构造request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.timeoutInterval = 15;
    NSString *methodUpperCase = [method uppercaseString];
    // 参数拼接
    NSMutableString *paramsString = [[NSMutableString alloc] init];
    //  取出参数中所有的key值
    NSArray *allKeysFromDic = params.allKeys;
    for (int i =0 ; i < params.count; i++)
    {
        NSString *key = allKeysFromDic[i];
        NSString *value = params[key];
        
        [paramsString appendFormat:@"%@=%@",key,value];
        // 每个关键字之间都用&隔开
        if (i < params.count - 1)
        {
            [paramsString appendString:@"&"];
        }
    }
    
    if ([methodUpperCase isEqualToString:@"GET"]) // get请求就只有URL
    {
        // GET请求需要拼接
        NSString *separe = url.query ? @"&" : @"";
        NSString *paramsURL = [NSString stringWithFormat:@"%@%@%@",urlPath,separe,paramsString];
        request.URL = [NSURL URLWithString:paramsURL];
        request.HTTPMethod = @"GET";
    }
    else if ([methodUpperCase isEqualToString:@"POST"]) // POST请求就需要设置请求正文
    {
        NSData *bodyData = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
        request.URL = url;
        request.HTTPBody = bodyData;
        request.HTTPMethod = @"POST";
    }
    else // 暂时没有考虑DELETE PUT等其他方式
    {
        return;
    }
    
    // 设置请求数据的content-type
    //  [reuqest setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    // NSURLSessionConfiguration 设置请求超时时间， 请求头等信息
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 设置请求超时为30秒钟
    configuration.timeoutIntervalForRequest = 15;
    // 设置在流量情况下是否继续请求
    configuration.allowsCellularAccess = YES;
    // 设置请求的header
    configuration.HTTPAdditionalHeaders = @{@"Accept": @"application/json,text/html,text/plain",
                                            @"Accept-Language": @"en"};
    // 创建NSURLSession
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue currentQueue]];
    // 发送Request
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            fail(error,@"没有网络");
            return;
        }
        NSError *err  = nil;
        
        NSHTTPURLResponse *http = (NSHTTPURLResponse*)response;
        NSLog(@"%@",http.MIMEType);
        /*
         1、 服务端需要返回一段普通文本给客户端，Content-Type="text/plain"
         2 、服务端需要返回一段HTML代码给客户端 ，Content-Type="text/html"
         3 、服务端需要返回一段XML代码给客户端 ，Content-Type="text/xml"
         4 、服务端需要返回一段javascript代码给客户端，text/javascript
         5 、服务端需要返回一段json串给客户端，application/Json
         */
        if ([http.MIMEType isEqualToString:@"text/html"])
        {
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            succ(html);
        }
        else
        {
            id res =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:&err];
            if (err)
            {
                fail(err, @"数据解析错误");
                return;
            }
            succ(res);
        }
    }];
    [task resume];
}

- (void)downloadUrlNews{
    @weakify(self)
    [WebTools postWithURL:@"/app/downloadUrlNews.json" params:@{@"id":@1} success:^(BaseData *data) {
        @strongify(self)
        NSString *url = data.data;
        
    } failure:^(NSError *error) {
        MBLog(@"1");
    } showHUD:NO];
}

#define kLastSaveServerTimeStamp @"kLastSaveServerTimeStamp"
#define kLastSaveLocalTimeStamp @"kLastSaveLocalTimeStamp"

- (void)saveServerTime:(double)serverTimeStamp{
    [[NSUserDefaults standardUserDefaults] setDouble:serverTimeStamp forKey:kLastSaveServerTimeStamp];
    double currentLocalTimeStamp = [[NSDate date] timeIntervalSince1970] * 1000;
    [[NSUserDefaults standardUserDefaults]setDouble:currentLocalTimeStamp forKey:kLastSaveLocalTimeStamp];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 服务器当前时间
- (NSTimeInterval )serverCurrentDate{
    double serverTimeStamp = [self serverCurrentTimeStamp] / 1000;
    NSDate *serverDateZone = [NSDate dateWithTimeIntervalSince1970:(serverTimeStamp)];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:serverDateZone];
    NSDate *serverDate = [serverDateZone dateByAddingTimeInterval:interval];
    return [serverDate timeIntervalSince1970];
}

// 服务器当前时间戳（精确到毫秒）
- (double)serverCurrentTimeStamp{
    // 最后保存的服务器时间戳
    double lastSaveServerTimeStamp = [[NSUserDefaults standardUserDefaults] doubleForKey:kLastSaveServerTimeStamp];
    // 最后保存服务器时间戳时的本地时间戳
    double lastSaveLocalTimeStamp = [[NSUserDefaults standardUserDefaults] doubleForKey:kLastSaveLocalTimeStamp];
    // 当前本地时间戳
    double currentLocalTimeStamp = [[NSDate date] timeIntervalSince1970] * 1000;
    
    if (lastSaveLocalTimeStamp != 0 || lastSaveServerTimeStamp != 0) {
        return (lastSaveServerTimeStamp + (currentLocalTimeStamp - lastSaveLocalTimeStamp));
    }else{
        // 如果没有获取到服务器时间，说明客户端还没开始用过，则视服务器时间与本地时间相同
        return  currentLocalTimeStamp;
    }
}


- (void)dragonLongPushNotification {
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //监听回调事件
    center.delegate = self;
    
    //iOS 10 使用以下方法注册，才能得到授权，注册通知以后，会自动注册 deviceToken，如果获取不到 deviceToken，Xcode8下要注意开启 Capability->Push Notification。
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              // Enable or disable features based on authorization.
                              if (!error) {
                                  NSLog(@"succeeded!");
                              }
                          }];
    
    //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
    }];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerNotification:) name:kDragonLongPushNotification object:nil];
    
    
//    DragonLongModel *longModel = [[DragonLongModel alloc] init];
//    longModel.dragonTip = @"彩种:PC蛋蛋玩法:大小,连开大,5期";
//    [[NSNotificationCenter defaultCenter] postNotificationName:kDragonLongPushNotification object:longModel];
}


#pragma mark - UNUserNotificationCenterDelegate
//将要推送     //在展示通知前进行处理，即有机会在展示通知前再修改通知内容。
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    //1. 处理通知
    
    //2. 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
    completionHandler(UNNotificationPresentationOptionAlert);
}
//已经完成推送
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSString *categoryID = response.notification.request.content.categoryIdentifier;
    if ([categoryID isEqualToString:PushNotificationDragonLongCategoryIdentifierID]) {
        CPTChangLongController *vc = [[CPTChangLongController alloc] init];
        
        [[AppDelegate currentViewController].navigationController pushViewController:vc animated:YES];
    }
    completionHandler();
}



- (void)registerNotification:(NSNotification *)note {
    
    DragonLongModel *model;
    if ([note.object isKindOfClass:[DragonLongModel class]]) {
        model = (DragonLongModel *)note.object;
    }
    
    // 设置推送内容
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    
    //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
//    content.title = [NSString localizedUserNotificationStringForKey:@"长龙!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:model.dragonTip
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    content.categoryIdentifier = PushNotificationDragonLongCategoryIdentifierID;
    
    //第三步：设置推送方式
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:PushNotificationRequestID content:content trigger:timeTrigger];
    
    //第四步：添加推送request
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
//    [center removePendingNotificationRequestsWithIdentifiers:@[PushNotificationRequestID]];
//    [center removeAllDeliveredNotifications];
    
//     [[ZAlertViewManager shareManager] showWithType:AlertViewTypeMessage title:@"彩种:PC蛋蛋玩法:大小,连开大,5期"];
}

-(void)startScrollByType:(CPTADType)type target:(id)aTarget selector:(SEL)aSelector{
    if(!_timer){
        if(type == CPTADType_hb){
            _timer = [NSTimer timerWithTimeInterval:2.0 target:aTarget selector:aSelector userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
            
        }else{
            _timer = [NSTimer timerWithTimeInterval:4.0 target:aTarget selector:aSelector userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
            
        }
    }
}

- (void)endScroll{
    [_timer invalidate];
    _timer = nil;
}

- (void)destroyIPTimer {
    [_sendIpTimer invalidate];
    _sendIpTimer = nil;
}

// 发送设备ID 和 ip
-(void)sendDeviceIdIp {
    NSString *ip = [RequestIPAddress getIPAddress:YES];
    NSString *clientID = [UIDevice currentDevice].identifierForVendor.UUIDString;
    NSString *sourceOfUser = [NSString stringWithFormat:@"ios:%@:%@",clientID,ip];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:sourceOfUser forKey:@"sourceOfUser"];

    [WebTools postWithURL:@"/ad/sendDeviceIdIp.json" params:dic success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
    } failure:^(NSError *error) {
         MBLog(@"1");
    } showHUD:NO];
    
}

@end


