//
//  VVAdaptUI.h
//  Project
//
//  Created by AFan on 2019/1/5.
//  Copyright © 2019 CDJay. All rights reserved.
//

#ifndef VVAdaptUI_h
#define VVAdaptUI_h

/*

@2x     iPhone 4、4s
        iPhone 5、5c、5s、SE
        iPhone 6、6s、7、8
        iPhone XR


@3x     iPhone 6/6s/7/8/ Plus
        iPhone X、XS
        iPhone XS Max
 
 
 iPhone X
 375 * 812
 width = 1125, height = 2436
 
 iPhone XS
 375 * 812
 width = 1125, height = 2436
 
 iPhone XS Max
 414 * 896
 width = 1242, height = 2688
 
 iPhone XR
 414 * 896
 width = 828, height = 1792
 
 iPhone 8 plus (7p /7sp /6p /6sp)
 414 * 736
 width = 1242, height = 2208
 
 iPhone 8 (7 /7s /6 /6s)
 375 * 667
 width = 750, height = 1334
 
 iPhone SE (5s / 5c)
 320 * 568
 width = 640, height = 1136

 
 //获取显示分辨率
 [UIScreen mainScreen].bounds
 //获取像素分辨率
 [[UIScreen mainScreen] currentMode].size
 
 
 func CGFloatAutoFit(_ float:CGFloat)->CGFloat {
 let min = UIScreen.main.bounds.height < UIScreen.main.bounds.width ? UIScreen.main.bounds.height :UIScreen.main.bounds.width
 return min / 375 * float
 }
 
 // 有时候横屏
 - (CGFloat)CGFloatAutoFit:(CGFloat)widhtOrHeight {
 CGFloat min = [[UIScreen mainScreen] bounds].size.height < [[UIScreen mainScreen] bounds].size.width ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width;
 return min / 375 * widhtOrHeight;
 }
 
 
 // 判断系统版本
     NSString *version = [UIDevice currentDevice].systemVersion;
     if (version.doubleValue >= 9.0) {
     // 针对 9.0 以上的iOS系统进行处理
     } else {
     // 针对 9.0 以下的iOS系统进行处理
     }
 
 */



#define kSCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define kSCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height


// 判断是否是ipad
#define IS_Pad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !IS_Pad : NO)
// 判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !IS_Pad : NO)
// 判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !IS_Pad : NO)
//判断iPhone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !IS_Pad : NO)
// 判断iPhone X
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_Pad : NO)
// 判断iPHone XR
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !IS_Pad : NO)
// 判断iPhone XS
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_Pad : NO)
// 判断iPhone XS Max
#define IS_IPHONE_Xs_Max_VV ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !IS_Pad : NO)

#define Height_StatusBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max_VV == YES) ? 44.0 : 20.0)
#define Height_NavBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max_VV == YES) ? 88.0 : 64.0)
#define Height_TabBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max_VV == YES) ? 83.0 : 49.0)

/**
 * 屏幕适配--iPhoneX全系
 */
#define kiPhoneXAll ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)

/**
 * iPhoneX全系导航栏增加高度 (64->88)
 */
#define kiPhoneX_Top_Height (([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)?24:0)

/**
 * iPhoneX全系TabBar增加高度 (49->83)
 */
#define kiPhoneX_Bottom_Height  (([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)?34:0)




#endif /* VVAdaptUI_h */
