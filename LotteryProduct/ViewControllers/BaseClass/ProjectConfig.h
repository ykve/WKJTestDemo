//
//  ProjectConfig.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/1/26.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#define IMGIP @"http://47.75.199.227:9001/caipiaoMedia"


//#define BASECOLOR [UIColor colorWithHex:@"fed696"]
#pragma mark 008

#if LOTTERY_EIGHT //008
#define KeyTitleColor [UIColor colorWithHex:@"fd463f"]

#define TABBARTITLE [UIColor colorWithHex:@"333333"]
#define TABBARTITLE_SEL [UIColor colorWithHex:@"666666"]
#define TabBarBackgroundC [UIColor colorWithHex:@"ffffff"]
#define NavigationBar_BarTintColor [UIColor colorWithHex:@"c01833"]
#define NavigationBar_TintColor [UIColor colorWithHex:@"ffffff"]

#define NavigationBar_TitleC [UIColor colorWithHex:@"ffffff"]
#define RootVC_ViewBackgroundC [UIColor colorWithHex:@"f4f4f4"]
#define RootVC_NAV_Bar_BackgroundC [UIColor colorWithHex:@"c01833"]

#define CircleVC_HeadView_BackgroundC [UIColor colorWithHex:@"f4f4f4"]
#define CircleVC_Cell_BackgroundC [UIColor colorWithHex:@"ffffff"]

#define CircleVC_Cell_TextLabel_BackgroundC [UIColor colorWithHex:@"333333"]
#define CircleVC_Cell_DetailTextLabel_BackgroundC [UIColor colorWithHex:@"999999"]


#define HomeVC_NoticeView_BackgroundC [UIColor colorWithHex:@"ffffff"]
#define HomeVC_NoticeView_RemindLbl_BackgroundC [UIColor colorWithHex:@"999999"]
#define HomeVC_NoticeView_MessageLbl_BackgroundC [UIColor colorWithHex:@"666666"]

#define HomeVC_HeadView_BackgroundC [UIColor colorWithHex:@"f4f4f4"]

#define HomeVC_HeadView_Command_BackView_BackgroundC [UIColor colorWithHex:@"ffffff"]
#define HomeVC_HeadView_Command_BackgroundC [UIColor colorWithHex:@"f4f4f4"]
#define HomeVC_HeadView_Command_Line_BackgroundC [UIColor colorWithHex:@"999999"]

#define HomeVC_HeadView_GuangBo_BackgroundC [UIColor colorWithHex:@"666666"]

#define HomeVC_HeadView_HotMessLabel_BackgroundC [UIColor colorWithHex:@"333333"]

#define HomeVC_HeadView_NumbrLables_BackgroundC [UIColor colorWithHex:@"333333"]
#define HomeVC_HeadView_HotNewsBackView_BackgroundC [UIColor colorWithHex:@"ffffff"]

#define HomeVC_Cell_BackgroundC [UIColor colorWithHex:@"ffffff"]
#define HomeVC_Cell_Titlelab_BackgroundC [UIColor colorWithHex:@"333333"]
#define HomeVC_Cell_SubTitlelab_BackgroundC [UIColor colorWithHex:@"999999"]

#define HomeVC_ADCollectionViewCell_BackgroundC [UIColor colorWithHex:@"ffffff"]

#define HomeVC_PCDanDan_BackgroundC1 [UIColor colorWithHex:@"333333"]
#define HomeVC_PCDanDan_BackgroundC2 [UIColor colorWithHex:@"404040"]
#define HomeVC_PCDanDan_line_BackgroundC [UIColor colorWithHex:@"404040"]
#define OpenLotteryVC_TitleLabs_TextC [UIColor colorWithHex:@"333333"]
#define OpenLotteryVC_ColorLabs_TextC [UIColor colorWithHex:@"fd463f"]
#define OpenLotteryVC_ColorLabs1_TextC [UIColor colorWithHex:@"999999"]

#define OpenLotteryVC_SubTitle_TextC [UIColor colorWithHex:@"999999"]
#define OpenLotteryVC_SubTitle_BorderC [UIColor colorWithHex:@"999999"]
#define OpenLotteryVC_Cell_BackgroundC [UIColor colorWithHex:@"ffffff"]
#define OpenLotteryVC_View_BackgroundC [UIColor colorWithHex:@"d4d4d7"]
#define MineVC_Btn_TitleC [UIColor colorWithHex:@"666666"]

#define HobbyVC_MessLab_BackgroundC [UIColor colorWithHex:@"d8d8d8"]
#define HobbyVC_MessLab_TextC [UIColor colorWithHex:@"666666"]
#define HobbyVC_View_BackgroundC [UIColor colorWithHex:@"f4f4f4"]
#define HobbyVC_OKButton_BackgroundC [UIColor colorWithHex:@"fd463f"]
#define HobbyVC_OKButton_TitleBackgroundC [UIColor colorWithHex:@"ffffff"]

#define HobbyVC_SelButton_TitleBackgroundC [UIColor colorWithHex:@"ffffff"]
#define HobbyVC_UnSelButton_TitleBackgroundC [UIColor colorWithHex:@"666666"]

#define HobbyVC_SelButton_BackgroundC [UIColor colorWithHex:@"be1a34"]
#define HobbyVC_UnSelButton_BackgroundC [UIColor colorWithHex:@"ffffff"]

#define Circle_HeadView_BackgroundC [UIColor colorWithHex:@"ffffff"]
#define Circle_HeadView_Title_UnSelC [UIColor colorWithHex:@"999999"]
#define Circle_HeadView_Title_SelC [UIColor colorWithHex:@"333333"]
#define Circle_HeadView_NoticeView_BackgroundC [UIColor colorWithHex:@"ffffff"]
#define Circle_HeadView_GuangBo_BackgroundC [UIColor colorWithHex:@"666666"]
#define Circle_Cell_BackgroundC [UIColor colorWithHex:@"f4f4f4"]
#define Circle_Cell_ContentlabC [UIColor colorWithHex:@"333333"]
#define Circle_Cell_Commit_BackgroundC [UIColor colorWithHex:@"f4f4f4"]
#define Circle_Cell_Commit_TitleC [UIColor colorWithHex:@"666666"]
#define Circle_Cell_AttentionBtn_TitleC [UIColor colorWithHex:@"fd463f"]
#define Circle_Line_BackgroundC [UIColor colorWithHex:@"fd463f"]
#define Circle_FooterViewLine_BackgroundC [UIColor colorWithHex:@"e4e5e8"]
#define OpenLottery_S_Cell_BackgroundC [UIColor colorWithHex:@"ffffff"]
#define OpenLottery_S_Cell_TitleC [UIColor lightGrayColor]
#define Login_NamePasswordView_BackgroundC [UIColor colorWithHex:@"000000" Withalpha:0.4]

#define Login_ForgetSigUpBtn_BackgroundC [UIColor clearColor]
#define Login_ForgetSigUpBtn_TitleC [UIColor colorWithHex:@"dddddd"]
#define Login_LogoinBtn_BackgroundC [UIColor whiteColor]
#define Login_LogoinBtn_TitleC [UIColor colorWithHex:@"641510"]
//#define HomeMainColor [UIColor colorWithHex:@"2E3238"]

//正式服务器
//#define WEBIP [Person person].Information == YES ? @"https://app.zk01.cc/appEntry" : @"https://47.75.199.227:8001/appEntry"
//#define UPFILEIP [Person person].Information == YES ? @"http://uploadfile.zk01.cc/" : @"https://47.75.199.227:8061/"

//测试服务器
#define WEBIP [Person person].Information == YES ? @"http://ec2-52-221-221-204.ap-southeast-1.compute.amazonaws.com:8001/appEntry" : @"http://47.75.199.227:8001/appEntry"
#define UPFILEIP [Person person].Information == YES ? @"http://ec2-13-250-8-150.ap-southeast-1.compute.amazonaws.com:8061" : @"http://47.75.199.227:8061/"

//友盟
#define UMSHARE @"5c3dae7ef1f5561a590000e1"
//极光推送
#define BUY_PUSH_KEY @"11c2c29287b0d34bb000f4b9"
#define Info_push_key @"6f8df8c91f5b832596827fa7"

#define QQ_APPID @"101517011"
#define QQ_SECRET @"8b78d6d792872fff1b525b62505e747d"
#define Weichat_APPID @"wxb5985d7a813de973"
#define Weichat_KEY @"c66e86edc1e1403e1a48b86c1dabc779"

#pragma mark cpt

#else //cpt
#define KeyTitleColor [UIColor colorWithHex:@"fed696"]
#define TABBARTITLE [UIColor colorWithHex:@"fed696"]
#define TABBARTITLE_SEL [UIColor redColor]
#define TabBarBackgroundC [UIColor colorWithHex:@"1D1E24"]
#define NavigationBar_BarTintColor [UIColor colorWithHex:@"1D1E24"]
#define NavigationBar_TintColor [UIColor colorWithHex:@"fed696"]
#define NavigationBar_TitleC [UIColor colorWithHex:@"fed696"]
#define RootVC_ViewBackgroundC [UIColor colorWithHex:@"1D1E24"]
#define RootVC_NAV_Bar_BackgroundC [UIColor colorWithHex:@"18191D"]
#define CircleVC_HeadView_BackgroundC [UIColor colorWithHex:@"303136"]
#define CircleVC_Cell_BackgroundC [UIColor colorWithHex:@"3a3b40"]
#define CircleVC_Cell_TextLabel_BackgroundC [UIColor colorWithHex:@"fed696"]
#define CircleVC_Cell_DetailTextLabel_BackgroundC [UIColor whiteColor]
#define HomeVC_NoticeView_BackgroundC [UIColor colorWithHex:@"2E3238"]
#define HomeVC_NoticeView_RemindLbl_BackgroundC [UIColor colorWithHex:@"8D8D8D"]
#define HomeVC_NoticeView_MessageLbl_BackgroundC [UIColor colorWithHex:@"cccccc"]

#define HomeVC_HeadView_BackgroundC [UIColor colorWithHex:@"1D1E24"]
#define HomeVC_HeadView_Command_BackView_BackgroundC [UIColor colorWithHex:@"2E3238"]
#define HomeVC_HeadView_Command_BackgroundC [UIColor colorWithHex:@"1D1E24"]
#define HomeVC_HeadView_Command_Line_BackgroundC [UIColor blackColor]
#define HomeVC_HeadView_HotMessLabel_BackgroundC [UIColor colorWithHex:@"ffffff"]

#define HomeVC_HeadView_GuangBo_BackgroundC [UIColor colorWithHex:@"FDFDFD"]

#define HomeVC_HeadView_NumbrLables_BackgroundC [UIColor colorWithHex:@"FDFDFD"]
#define HomeVC_HeadView_HotNewsBackView_BackgroundC [UIColor colorWithHex:@"2E3238"]
#define HomeVC_Cell_BackgroundC [UIColor colorWithHex:@"2E3238"]
#define HomeVC_Cell_Titlelab_BackgroundC [UIColor colorWithHex:@"FDFDFD"]
#define HomeVC_Cell_SubTitlelab_BackgroundC [UIColor colorWithHex:@"8D8D8D"]
#define HomeVC_ADCollectionViewCell_BackgroundC [UIColor colorWithHex:@"1D1E24"]
#define HomeVC_PCDanDan_BackgroundC2 [UIColor colorWithHex:@"1D1E24"]
#define HomeVC_PCDanDan_BackgroundC1 [UIColor colorWithHex:@"1D1E24"]
#define HomeVC_PCDanDan_line_BackgroundC [UIColor colorWithHex:@"1D1E24"]
#define OpenLotteryVC_ColorLabs_TextC [UIColor colorWithHex:@"DC612F"]
#define OpenLotteryVC_ColorLabs1_TextC [UIColor colorWithHex:@"8D8D8D"]
#define OpenLotteryVC_SubTitle_TextC [UIColor colorWithHex:@"FDFDFD"]
#define OpenLotteryVC_SubTitle_BorderC [UIColor colorWithHex:@"8D8D8D"]
#define OpenLotteryVC_Cell_BackgroundC [UIColor colorWithHex:@"3a3b3f"]
#define OpenLotteryVC_View_BackgroundC [UIColor colorWithHex:@"1D1E24"]
#define OpenLotteryVC_TitleLabs_TextC [UIColor colorWithHex:@"333333"]

#define MineVC_Btn_TitleC [UIColor colorWithHex:@"ffffff"]
#define HobbyVC_MessLab_BackgroundC [UIColor colorWithHex:@"1D1E24"]
#define HobbyVC_MessLab_TextC [UIColor lightGrayColor]
#define HobbyVC_View_BackgroundC [UIColor colorWithHex:@"2C2E35"]
#define HobbyVC_OKButton_BackgroundC [UIColor colorWithHex:@"9E2D32"]
#define HobbyVC_OKButton_TitleBackgroundC [UIColor colorWithHex:@"FDFDFD"]

#define HobbyVC_SelButton_TitleBackgroundC [UIColor colorWithHex:@"ffffff"]
#define HobbyVC_UnSelButton_TitleBackgroundC [UIColor lightGrayColor]

#define HobbyVC_SelButton_BackgroundC [UIColor colorWithHex:@"9E2D32"]
#define HobbyVC_UnSelButton_BackgroundC [UIColor colorWithHex:@"1D1E24"]
#define Circle_HeadView_Title_UnSelC [UIColor colorWithHex:@"999999"]
#define Circle_HeadView_Title_SelC [UIColor colorWithHex:@"333333"]
#define Circle_HeadView_BackgroundC [UIColor colorWithHex:@"393B44"]
#define Circle_HeadView_NoticeView_BackgroundC [UIColor colorWithHex:@"2D2D32"]
#define Circle_HeadView_GuangBo_BackgroundC [UIColor colorWithHex:@"8D8D8D"]
#define Circle_Cell_BackgroundC [UIColor colorWithHex:@"2C3036"]
#define Circle_Cell_ContentlabC [UIColor whiteColor]
#define Circle_Cell_Commit_BackgroundC [UIColor colorWithHex:@"2D2F36"]
#define Circle_Cell_Commit_TitleC [UIColor whiteColor]
#define Circle_Cell_AttentionBtn_TitleC [UIColor lightGrayColor]
#define Circle_Line_BackgroundC [UIColor colorWithHex:@"fed696"]

#define Circle_FooterViewLine_BackgroundC [UIColor darkGrayColor]
#define OpenLottery_S_Cell_BackgroundC [UIColor colorWithHex:@"3A3B40"]
#define OpenLottery_S_Cell_TitleC [UIColor colorWithHex:@"ffffff"]
#define Login_NamePasswordView_BackgroundC [UIColor colorWithHex:@"2c2e36"]
#define Login_ForgetSigUpBtn_BackgroundC [UIColor colorWithHex:@"2c2e36" Withalpha:0.5]
#define Login_ForgetSigUpBtn_TitleC [UIColor colorWithHex:@"dddddd"]
#define Login_LogoinBtn_BackgroundC [UIColor colorWithHex:@"ac1e2d"]
#define Login_LogoinBtn_TitleC [UIColor colorWithHex:@"eacd91"]


//正式服务器
//#define WEBIP [Person person].Information == YES ? @"https://app.zk01.cc/appEntry" : @"https://47.75.199.227:8001/appEntry"
//#define UPFILEIP [Person person].Information == YES ? @"http://uploadfile.zk01.cc/" : @"https://47.75.199.227:8061/"

//jack
//#define WEBIP @"http://192.168.0.47:8001/appEntry"
//nick
//#define WEBIP @"http://192.168.0.103:8001/appEntry"

//测试服务器
#define WEBIP [Person person].Information == YES ? @"http://d2vmbejfu5ovqd.cloudfront.net/appEntry" : @"http://47.75.199.227:8001/appEntry"
#define UPFILEIP [Person person].Information == YES ? @"https://d3cwssx3prxklr.cloudfront.net" : @"http://47.75.199.227:8061/"


//修改后
//#define WEBIP [Person person].Information == NO ? @"http://app.chengykj.com" : @"http://d2vmbejfu5ovqd.cloudfront.net/appEntry"//购彩
//#define UPFILEIP [Person person].Information == YES ? @"https://uploadfile.chengykj.com/" : @"https://uploadfile.chengykj.com/"

//#define WEBIP @"http://47.75.199.227:8001/appEntry"
//#define UPFILEIP @"http://47.75.199.227:8061/"

#define UMSHARE @"5be44c26f1f556a70100031f"
#define QQ_APPID @"101517011"
#define QQ_SECRET @"8b78d6d792872fff1b525b62505e747d"

#define Weichat_APPID @"wxb5985d7a813de973"
#define Weichat_KEY @"c66e86edc1e1403e1a48b86c1dabc779"

//极光推送
#define BUY_PUSH_KEY @"32cba445f5acec33abf2994e"
#define Info_push_key @"bdc914029a58caaacaf37e4a"

#endif

#define JPushChannel @"appStore"

@interface ProjectConfig : NSObject

@end

NS_ASSUME_NONNULL_END
