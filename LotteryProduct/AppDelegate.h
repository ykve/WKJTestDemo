//
//  AppDelegate.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabbarCtrl.h"
#import "ChatSentHongbaoView.h"
#import "AdView.h"

typedef NS_ENUM(NSUInteger, SocketDataType) {
    distributeOrder,
    cancelCall,
    orderLost,
    changeDeviceType,
};



typedef NS_ENUM(NSInteger, WKJSchemes) {
    Scheme_LotterProduct = 0,
    Scheme_LotterHK = 2,
    Scheme_LotterEight = 3,
    Scheme_LitterFish = 4
};
// 皮肤主题类型
typedef NS_ENUM(NSInteger, SKinThemeType) {
    SKinType_Theme_White = 0,
    SKinType_Theme_Dark = 1
};

typedef NS_ENUM(NSInteger,HomeSwitchType)//彩种
{
    HomeSwitchTypeInfo                      =   0,
    HomeSwitchTypeBuy                       =   1,
};
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainTabbarCtrl *tab;
@property (copy, nonatomic) NSString *mqttURL;

@property(nonatomic,assign)BOOL allowRotation;
@property(nonatomic,assign) WKJSchemes wkjScheme;
@property(nonatomic,assign) SKinThemeType sKinThemeType;
@property(nonatomic, strong)ChatSentHongbaoView *chatSentHongbaoView;
@property (assign, nonatomic) NSTimeInterval serverTime;
@property (nonatomic, assign) BOOL isInfoToutiaoClose;
@property (nonatomic, assign) BOOL isBuyClose;
@property (assign, nonatomic) BOOL HomeSwitchType;
@property (assign, nonatomic) HomeSwitchType homeType;

+(AppDelegate *)shareapp;

-(void)setmainroot;

-(void)setloginroot;
-(void)clearRootVC;

//获取Window当前显示的ViewController
+ (UIViewController*)currentViewController;
- (void)showGif;
- (void)dismissGif;
- (void)showFailedGif;
- (void)saveServerTime:(double)serverTimeStamp;
- (NSTimeInterval)serverCurrentDate;
-(void)startScrollByType:(CPTADType)type target:(id)aTarget selector:(SEL)aSelector;
- (void)endScroll;

- (void)setThemeSkin;
@end

