//
//  WKJMacros.h
//  LotteryProduct
//
//  Created by pt c on 2019/8/2.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#ifndef WKJMacros_h
#define WKJMacros_h


#define SYS_IOS_VEERSION ([ [ [ UIDevice currentDevice ] systemVersion ] floatValue ])
//#define IS_IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !isPad : NO)
#define IS_IPHONEX (((int)(([UIScreen mainScreen].bounds.size.height/[UIScreen mainScreen].bounds.size.width)*100) == 216) ? YES : NO)
#define NAV_HEIGHT (IS_IPHONEX ? 88.0 : 64.0)
#define SAFE_HEIGHT (IS_IPHONEX ? 24.0 : 0.0)//34.0
#define SAFE_TO_BOTTOM (IS_IPHONEX ? 34.0 : 0.0)
#define SafeAreaBottomHeight 34
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height-SAFE_HEIGHT)
#define SCAL (375/SCREEN_WIDTH)
#define ISNEEDSHOWHH (SCREEN_WIDTH>375 ? 2: 0)
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define Tabbar_HEIGHT (IS_IPHONEX ? 60.0 : 49.0)
#define KIsBlankString(str)  [NSString isBlankString:str]



#define pageSize @10
#define PUSH(X) [self.navigationController pushViewController:X animated:YES]
#define WEAKPUSH(X) [weakSelf.navigationController pushViewController:X animated:YES];
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define IMAGE(x) [UIImage imageNamed:x]

#define jbbj(x) [Tools rj_creatGradientLayer:@[(id)[UIColor colorWithHex:@"64A281"].CGColor,(id)[UIColor colorWithHex:@"4887A9"].CGColor] frame:x]


#define getColorImage(imagePath) [UIImage imageWithContentsOfFile:imagePath]


//#define path_document NSHomeDirectory()
//
//#define imagePath [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/pic%@.png", imageName]]
//NSString *path_document = NSHomeDirectory();
//设置一个图片的存储路径
//NSString *imagePath = ;
#define NSURLX(X) [NSURL URLWithString:X]
#define INTTOSTRING(X) [NSString stringWithFormat:@"%ld",(long)X]
#define ChangeBuyTicketTypeToString(X) [[CPTBuyDataManager shareManager] changeTypeToTypeString:X]
#define STRING(X) [NSString stringWithFormat:@"%@",X]
//#define IMAGEPATH(X) [NSURL URLWithString:[X containsString:@"http://"]==YES ? X : [X containsString:@"https://"]==YES ? X : [NSString stringWithFormat:@"%@%@",IMGIP,X]]
#define IMAGEPATH(X) [NSURL URLWithString:[X hasPrefix:@"http://"]==YES ? X : [X hasPrefix:@"https://"]==YES ? X : [NSString stringWithFormat:@"%@%@",IMGIP,X]]


#define DEFAULTHEAD [UIImage imageNamed:@"头像"]
#define NOPHOTO [UIImage imageNamed:@"icon_error_unkown"]

#ifdef DEBUG
#define MBLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define MBLog(format, ...)
#endif

#ifdef DEBUG
#define NSLog(format, ...)
#else
#define NSLog(format, ...)
#endif

#define kWeakSelf __weak __typeof__(self) weakSelf = self;

#define kChatFont 13
#define kChatMiniHeight 20
// 获得RGB颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define FONT(X) [UIFont systemFontOfSize:X]
#define BOLDFONT(X) [UIFont fontWithName:@"Helvetica-Bold" size:X]
#define MFONT(X) [UIFont fontWithName:@"Helvetica-Medium" size:X]

#define CLEAR [UIColor clearColor]
#define WHITE [UIColor whiteColor]
#define BLACK [UIColor blackColor]
// 雅黑
#define YAHEI [UIColor colorWithHex:@"#222222"]

// 辅色调（深灰色）：
#define MAINCOLOR [UIColor colorWithHex:@"1D1E24"]
#define HomeMainColor [UIColor colorWithHex:@"2E3238"]
#define HomeMainTextColor [UIColor colorWithHex:@"8D8D8D"]
#define HomeMainWhiteColor [UIColor colorWithHex:@"FDFDFD"]

#define No1Color  [UIColor colorWithHex:@"e5de14"];
#define No2Color  [UIColor colorWithHex:@"106ced"];
#define No3Color  [UIColor colorWithHex:@"4c4a4a"];
#define No4Color  [UIColor colorWithHex:@"ec6412"];
#define No5Color  [UIColor colorWithHex:@"1ed0d3"];
#define No6Color  [UIColor colorWithHex:@"1e0df4"];
#define No7Color  [UIColor colorWithHex:@"a6a6a6"];
#define No8Color  [UIColor colorWithHex:@"e9281f"];
#define No9Color  [UIColor colorWithHex:@"770800"];
#define No10Color  [UIColor colorWithHex:@"2e9c18"];

/// 深红色
#define kDarkRedColor  [UIColor colorWithHex:@"#AC1E2D"]

// 主色调（金黄色）
#define BASECOLOR [UIColor colorWithHex:@"fed696"]

#define TITLECOLOR kColor(188, 153, 89)
// 按钮填充色
#define BUTTONCOLOR [UIColor colorWithHex:@"DBBA7D"]
// 浅灰色
#define CC [UIColor colorWithHex:@"CCCCCC"]

#define LINECOLOR [UIColor colorWithHex:@"D68B00"]

#define kIssueListWidth  60.0f  // 期号label宽度
#define kItemSize        CGSizeMake(35, 35)

#define kRGB(r, g, b)    [UIColor colorWithRed:(r)/255.0  green:(g)/255.0  blue:(b)/255.0  alpha:1.0]
#define kBG_COLOR        [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0]
#define kDARK_GRAY_COLOR [UIColor colorWithRed:220/255.0  green:220/255.0  blue:220/255.0  alpha:1.0]

#define CPT_StatusBarAndNavigationBarHeight  (IS_IPHONEX ? 88.f : 64.f)


#define PERSONKEY @"PERSONKEY"

#define LOTTERYTYPE @"Lotterytype"

// RGB颜色
#define SIXColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define SIXRandomColor SIXColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#define CPTCART_TOTLEMONEY @"CPTCART_TOTLEMONEY" //购彩蓝 总金额
#define CPTCART_MAXWIN @"CPTCART_MAXWIN" //购彩蓝 最高可赢
#define CPTCART_TOTLEAvailable @"CPTCART_TOTLEAvailable" //购彩蓝 有效注数
#define CPTCART_LimitCount @"CPTCART_LimitCount" //玩法限制多少个为一注
#define CPTCART_LeftOrRight @"CPTCART_LeftOrRight" //计算left or right 的model





/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#endif /* WKJMacros_h */
