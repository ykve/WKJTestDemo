//
//  CPTThemeConfig.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/1/26.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTThemeConfig.h"
#import "UIImage+color.h"
#import "ColorTool.h"

@implementation CPTThemeConfig
static CPTThemeConfig *manager;
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

- (instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}


#pragma mark - 008 lightTheme
- (void)eightTheme {
    
    self.CO_Main_ThemeColorOne = [UIColor colorWithHex:@"FFFFFF"];   // 主题色1;  白色
    self.CO_Main_ThemeColorTwe = [UIColor colorWithHex:@"#C21632"];   // 主题色2;  红色
    self.CO_Main_LineViewColor = [UIColor colorWithHex:@"#CCCCCC"];   // 线条颜色
    self.CO_Main_LabelNo1 = [UIColor colorWithHex:@"#333333"];
    self.CO_Main_LabelNo2 = [UIColor colorWithHex:@"#CCCCCC"];
    self.CO_Main_LabelNo3 = [UIColor colorWithHex:@"#FFFFFF"];
    
    
    /// ****** TabBar ******
    self.IC_TabBar_Home = @"tw_tab_home";
    self.IC_TabBar_Home_Selected = @"tw_tab_home_selected";
    self.IC_TabBar_KJ_ = @"tw_tab_kj";
    self.IC_TabBar_KJ_Selected = @"tw_tab_kj_selected";
    self.IC_TabBar_GC = @"tw_tab_gc";
    self.IC_TabBar_GC_Selected = @"tw_tab_gc";
    self.IC_TabBar_QZ = @"tw_tab_qz";
    self.IC_TabBar_QZ_Selected = @"tw_tab_qz_selected";
    self.IC_TabBar_Me = @"tw_tab_me";
    self.IC_TabBar_Me_Selected = @"tw_tab_me_selected";
    self.CO_TabBarTitle_Normal = [UIColor colorWithHex:@"666666"];
    self.CO_TabBarTitle_Selected = self.CO_Main_ThemeColorTwe;
    self.CO_TabBarBackground = [UIColor colorWithHex:@"FFFFFF"];
    
    
    /// ****** Nav ******
    self.CO_Nav_Bar_NativeViewBack = self.CO_Main_ThemeColorTwe;
    self.CO_NavigationBar_TintColor = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_NavigationBar_Title = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Nav_Bar_CustViewBack = self.CO_Main_ThemeColorTwe;   // 主题色2
    
    self.IM_Nav_TitleImage_Logo = IMAGE(@"tw_nav_hometitle_logo");
    self.IC_Nav_ActivityImageStr = @"tw_activity_icon";
    self.IC_Nav_SideImageStr = @"tw_menu_icon";
    self.IC_Nav_CircleTitleImage = @"tw_nav_circle_center";
    self.IC_Nav_Setting_Icon = @"tw_nav_setting_icon";
    self.IC_Nav_Setting_Gear = @"td_nav_setting";
    self.IC_Nav_Kefu_Text = @"tw_nav_online_kf";
    
    
#pragma mark Home
    
    
    self.CO_Home_VC_NoticeView_Back = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_VC_NoticeView_LabelText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_NoticeView_LabelText = [UIColor colorWithHex:@"#4D4D4D"];
    self.CO_Home_CellCartCellSubtitleText = [UIColor colorWithHex:@"#999999"];
    self.CO_Home_VC_HeadView_Back = CLEAR;
    self.CO_Home_NewsTopViewBack = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Home_NewsBgViewBack = [UIColor colorWithHex:@"#eff2f5"];
    self.CO_Home_News_LineView = [UIColor colorWithHex:@"#CCCCCC"];
    self.CO_Home_News_HeadTitleText = [UIColor colorWithHex:@"#808080"];
    self.CO_Home_News_ScrollLabelText = [UIColor colorWithHex:@"#333333"];
    self.CO_Home_VC_HeadView_HotMessLabelText = [UIColor colorWithHex:@"#000000"];
    self.CO_Home_CollectionView_CartCellTitle = [UIColor colorWithHex:@"#333333"];
    self.CO_Home_VC_HeadView_NumbrLables_Text = [UIColor colorWithHex:@"FDFDFD"];
    self.CO_Home_News_HotHeadViewBack = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_VC_Cell_ViewBack = [UIColor colorWithHex:@"#eff2f5"];
    
    self.IM_Home_HeadlineImg = IMAGE(@"tw_CPT头条");
    self.CO_Home_HeadlineLabelText = [UIColor colorWithHex:@"#4D4D4D"];
    self.CO_Home_HeadlineLineView = [UIColor colorWithHex:@"#CCCCCC"];
    
    self.IM_Home_BottomBtnOne = IMAGE(@"tw_bottom_lxkf");
    self.IM_Home_BottomBtnTwo = IMAGE(@"tw_bottom_lts");
    self.IM_Home_BottomBtnThree = IMAGE(@"tw_bottom_wyb");
    
    self.CO_Home_VC_Cell_Titlelab_Text = [UIColor colorWithHex:@"333333"];
    self.CO_Home_VC_Cell_SubTitlelab_Text = [UIColor colorWithHex:@"#999999"];
    self.CO_Home_VC_ADCollectionViewCell_Back = CLEAR;
    self.CO_Home_CellBackgroundColor = [UIColor colorWithHex:@"#eff2f5"];
    self.CO_Home_CellContentView = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Home_VC_PCDanDan_ViewBack2 = [UIColor colorWithHex:@"FFFFFF"];
    
    self.CO_Home_VC_PCDanDan_line_ViewBack = [UIColor colorWithHex:@"999999"];
    
    self.CO_Home_SubHeaderTitleColor = [UIColor colorWithHex:@"333333"];;
    self.CO_Home_SubHeaderSubtitleColor = [UIColor colorWithHex:@"3B3A3C"];
    self.CO_Home_SubheaderTimeLblText = [UIColor colorWithHex:@"7f70dc"];;
    self.CO_Home_SubheaderLHCSubtitleText = self.KeyTitleColor;
    
    self.IC_Home_CQSSC = @"重庆时时彩";
    self.IC_Home_LHC = @"六合彩";
    self.IC_Home_BJPK10 = @"北京PK10";
    self.IC_Home_XJSSC = @"新疆时时彩";
    self.IC_Home_XYFT = @"幸运飞艇";
    self.IC_Home_TXFFC = @"比特币分分彩";
    self.IC_Home_PCDD = @"PC蛋蛋";
    self.IC_Home_ZCZX = @"足彩资讯";
    self.IC_Home_AZF1SC = @"六合彩";
    self.IC_Home_GDCZ = @"更多彩种";
    
    self.IC_Home_Icon_BeginName = @"tw_";
    
    
    self.IC_home_sub_SS = @"tw_home_sub_赛事";
    self.IC_home_sub_YC = @"tw_home_sub_预测";
    self.IC_home_sub_ZJ = @"tw_home_sub_专家";
    self.IC_home_sub_BF = @"tw_home_sub_比分";
    self.IC_home_sub_HMZS = @"tw_home_sub_号码走势";
    self.IC_home_sub_JRHM = @"tw_home_sub_今日号码";
    self.IC_home_sub_HMYL = @"tw_home_sub_号码遗漏";
    self.IC_home_sub_LRFX = @"tw_home_sub_冷热分析";
    self.IC_home_sub_GYHTJ = @"tw_home_sub_冠亚和统计";
    self.IC_home_sub_LMCL = @"tw_home_sub_两面长龙";
    self.IC_home_sub_LMLZ = @"tw_home_sub_两面路珠";
    self.IC_home_sub_LMYL = @"tw_home_sub_两面遗漏";
    self.IC_home_sub_QHLZ = @"tw_home_sub_前后路珠";
    self.IC_home_sub_LMLS = @"tw_home_sub_两面历史";
    self.IC_home_sub_GYHLZ = @"tw_home_sub_冠亚和路珠";
    self.IC_home_sub_HBZS = @"tw_home_sub_横版走势";
    self.IC_home_sub_History = @"tw_home_sub_历史开奖";
    self.IC_home_sub_XSTJ = @"tw_home_sub_免费推荐";
    self.IC_home_sub_LHTK = @"tw_home_sub_六合图库";
    self.IC_home_sub_CXZS = @"tw_home_sub_查询助手";
    self.IC_home_sub_ZXTJ = @"tw_home_sub_资讯统计";
    self.IC_home_sub_KJRL = @"tw_home_sub_开奖日历";
    self.IC_home_sub_GSSH = @"tw_home_sub_公式杀手";
    self.IC_home_sub_AIZNXH = @"tw_home_sub_AI智能选号";
    self.IC_home_sub_SXCZ = @"tw_home_sub_属性参考";
    self.IC_home_sub_TMLS = @"tw_home_sub_特码历史";
    self.IC_home_sub_ZMLS = @"tw_home_sub_正码历史";
    self.IC_home_sub_WSDX = @"tw_home_sub_尾数大小";
    self.IC_home_sub_SXTM = @"tw_home_sub_生肖特码";
    self.IC_home_sub_SXZM = @"tw_home_sub_生肖正码";
    self.IC_home_sub_BSTM = @"tw_home_sub_波色特码";
    self.IC_home_sub_BSZM = @"tw_home_sub_波色正码";
    self.IC_home_sub_TMLM = @"tw_home_sub_特码两面";
    self.IC_home_sub_TMWS = @"tw_home_sub_特码尾数";
    self.IC_home_sub_ZMWS = @"tw_home_sub_正码尾数";
    self.IC_home_sub_ZMZF = @"tw_home_sub_正码总分";
    self.IC_home_sub_HMBD = @"tw_home_sub_号码波段";
    self.IC_home_sub_JQYS = @"tw_home_sub_家禽野兽";
    self.IC_home_sub_LMZS = @"tw_home_sub_连码走势";
    self.IC_home_sub_LXZS = @"tw_home_sub_连肖走势";
    self.IC_home_sub_LHDS = @"tw_home_sub_六合大神";
    self.IC_home_sub_YLTJ = @"tw_home_sub_遗漏统计";
    self.IC_home_sub_JRTJ = @"tw_home_sub_今日统计";
    self.IC_home_sub_MFTJ = @"tw_home_sub_免费推荐";
    self.IC_home_sub_QXT = @"tw_home_sub_曲线图";
    self.IC_home_sub_TMZS = @"tw_home_sub_选号助手";
    
    self.IM_home_ZXTJImageName = @"homeZXTJImageName_eye";
    self.CO_home_SubCellTitleText = [UIColor colorWithHex:@"333333"];
    self.CO_home_SubheaderBallBtnBack = [UIColor colorWithHex:@"fe5049"];
    self.IM_home_XSTJImage = IMAGE(@"IM_home_XSTJImage");
    self.IM_home_LHDSImage = IMAGE(@"IM_home_LHDSImage");
    self.IM_home_LHTKImage = IMAGE(@"IM_home_LHTKImage");
    self.IM_home_GSSHImage = IMAGE(@"IM_home_GSSHImage");
    self.IC_home_ZBKJImageName = @"IC_home_ZBKJImageName";
    self.IC_home_LSKJImageName = @"IC_home_LSKJImageName";
    self.IC_home_CXZSImageName = @"IC_home_CXZSImageName";
    self.IM_home_hotNewsImageName = IMAGE(@"IM_home_hotNewsImageName");
    self.IM_home_SanJiaoImage = IMAGE(@"IM_home_SanJiaoImage");
    
    self.CO_Home_Buy_Footer_BtnBack = [UIColor colorWithHex:@"9C2D33"];
    self.CO_Home_Buy_Footer_Back = [UIColor colorWithHex:@"F0F0F0"];
    
#pragma mark 我的
    
    self.IM_topBackImageView = IMAGE(@"tw_ic_me_topback");
    self.Mine_ScrollViewBackgroundColor = [UIColor colorWithHex:@"3E94FF"];
    self.CO_Mine_setContentViewBackgroundColor = [UIColor colorWithHex:@"#F7F7F7"];
    self.CO_Me_NicknameLabel = [UIColor colorWithHex:@"333333"];
    self.CO_Me_SubTitleText = [UIColor colorWithHex:@"333333"];
    self.CO_Me_ItemTextcolor = [UIColor colorWithHex:@"#666666"];
    
    self.CO_LongDragonTopView = self.CO_Main_ThemeColorOne;
    self.CO_LongDragonTopViewBtn =  [UIColor colorWithHex:@"#FF870F"];
    
    self.IM_Home_cartBgImageView = IMAGE(@"circleHomeBgImage");
    self.CO_buyLotBgColor = [UIColor colorWithHex:@"F4F4F4"];
    self.OpenLotteryVC_ColorLabs_TextB = [UIColor colorWithHex:@"333333"];
    
    self.IM_Me_MoneyRefreshBtn = IMAGE(@"mine_moneyRef");
    self.IM_Me_ChargeImage = IMAGE(@"tw_me_top1");
    self.IM_Me_GetMoneyImage = IMAGE(@"tw_me_top2");
    self.IM_Me_MoneyDetailImage = IMAGE(@"tw_me_top3");
    
    self.IM_Me_MyWalletImage = IMAGE(@"tw_me_sro1");
    self.IM_Me_MyAccountImage = IMAGE(@"tw_me_sro2");
    self.IM_Me_SecurityCnterImage = IMAGE(@"tw_me_sro3");
    self.IM_Me_MyTableImage = IMAGE(@"tw_me_sro4");
    self.IM_Me_buyHistoryImage = IMAGE(@"tw_me_sro5");
    self.IM_Me_MessageCenterImage = IMAGE(@"tw_me_sro6");
    self.IM_Me_setCenterImage = IMAGE(@"tw_me_sro7");
    self.IM_Me_shareImage = IMAGE(@"tw_me_sro8");
    self.CO_Me_YuEText = [UIColor colorWithHex:@"333333"];
    
#pragma mark  AI智能选号
    self.IM_AI_BGroundcolorImage = IMAGE(@"tw_ai_top_bg_aiznxh");
    self.IM_AI_ShengXiaoNormalImage = IMAGE(@"tw_ai_sx");
    self.IM_AI_ShakeNormalImage = IMAGE(@"tw_ai_yyy");
    self.IM_AI_LoverNormalImage = IMAGE(@"tw_ai_ar");
    self.IM_AI_FamilyNormalImage = IMAGE(@"tw_ai_jr");
    self.IM_AI_BirthdayNormalImage = IMAGE(@"tw_ai_sr");
    self.IM_AI_ShengXiaoSeletImage = IMAGE(@"tw_ai_sx_selected");
    self.IM_AI_ShakeSeletImage = IMAGE(@"tw_ai_yyy_selected");
    self.IM_AI_LoverSeletImage = IMAGE(@"tw_ai_ar_selected");
    self.IM_AI_FamilySeletImage = IMAGE(@"tw_ai_jr_selected");
    self.IM_AI_BirthdaySeletImage = IMAGE(@"tw_ai_sr_selected");
    self.IM_AI_BirthdayImage = IMAGE(@"tw_ai_srdg");
    self.IM_AI_ShengXiaoBackImage = IMAGE(@"tw_ai_cpt");
    self.IM_AI_ShuImage = IMAGE(@"tw_ai_shu");
    self.IM_AI_GouImage = IMAGE(@"tw_ai_gou");
    self.IM_AI_HouImage = IMAGE(@"tw_ai_hou");
    self.IM_AI_HuImage = IMAGE(@"tw_ai_hu");
    self.IM_AI_JiImage = IMAGE(@"tw_ai_ji");
    self.IM_AI_LongImage = IMAGE(@"tw_ai_long");
    self.IM_AI_MaImage = IMAGE(@"tw_ai_ma");
    self.IM_AI_NiuImage = IMAGE(@"tw_ai_niu");
    self.IM_AI_SheImage = IMAGE(@"tw_ai_she");
    self.IM_AI_TuImage = IMAGE(@"tw_ai_tu");
    self.IM_AI_YangImage = IMAGE(@"tw_ai_yang");
    self.IM_AI_ZhuImage = IMAGE(@"tw_ai_zhu");
    self.IM_AI_AutoSelectLblNormalColor = [UIColor colorWithHex:@"#8BC4FF"];
    self.IM_AI_AutoSelectLblSelectColor = self.CO_Main_ThemeColorTwe;
    
    
    // 购彩侧边
    self.CO_BuyLot_Left_ViewBack = [UIColor colorWithHex:@"#F0F0F0"];
    self.CO_BuyLot_Left_LeftCellBack = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_BuyLot_Left_LeftCellTitleText = [UIColor colorWithHex:@"#333333"];
    self.CO_BuyLot_Left_LeftCellBack_Selected = [UIColor colorWithHex:@"#FE8D2C"];
    self.CO_BuyLot_Left_LeftCellTitleText_Selected = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_BuyLot_Left_CellBack = [UIColor colorWithHex:@"#F0F0F0"];
    self.CO_BuyLot_Left_CellTitleText = [UIColor colorWithHex:@"#666666"];
    
    // 设置中心
    self.IC_Me_SettingTopImageName = @"tw_topback";
    self.IC_Me_SettingTopHeadIcon = @"setting_icon";
    self.SettingPushImageName = @"tw_me_setcenter1";
    self.SettingShakeImageName = @"tw_me_setcenter2";
    self.SettingVoiceImageName = @"tw_me_setcenter3";
    self.SettingSwitchSkinImageName = @"tw_me_setcenter4";
    self.SettingServiceImageName = @"tw_me_setcenter5";
    self.SettingAboutUsImageName = @"tw_me_setcenter6";
    self.confirmBtnBackgroundColor = self.CO_Main_ThemeColorTwe;
    
    
    // 我的钱包
    self.MyWalletTopImage = IMAGE(@"tw_me_wdqb");
    // 安全中心
    self.safeCenterTopImage = IMAGE(@"tw_topback");
    self.CO_Me_TopLabelTitle = [UIColor colorWithHex:@"333333"];
    
    // 侧边
    self.Left_VC_ChargeBtnImage = IMAGE(@"tw_left_cz");
    self.Left_VC_GetMoneyBtnImage = IMAGE(@"tw_left_tx");
    self.Left_VC_KFBtnImage = IMAGE(@"tw_left_kf");
    self.Left_VC_MyWalletImage = @"tw_left_wdqb";
    self.Left_VC_SecurityCenterImage = @"tw_left_aqzx";
    self.Left_VC_MessageCenterImage = @"tw_left_xxzx";
    self.Left_VC_BuyHistoryImage = @"tw_left_tzjl";
    self.Left_VC_MyTableImage = @"tw_left_wdbb";
    self.Left_VC_SettingCenterImage = @"tw_left_szzx";
    self.Left_VC_BtnTitleColor = WHITE;
    
    self.Left_VC_CellBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.LeftCtrlCellTextColor = [UIColor colorWithHex:@"333333"];
    
    self.Left_VC_BtnBackgroundColor = CLEAR;
    self.leftBackViewImageColor = CLEAR;
    self.Left_VC_TopImage = IMAGE(@"jbbj");
    self.LeftControllerLineColor = [UIColor hexStringToColor:@"FFFFFF" andAlpha:0.5];
    
    
    // 长龙
    self.CO_buyBottomViewBtn = [UIColor colorWithHex:@"#FF870F"];
    self.CO_ScrMoneyNumBtnText = [UIColor colorWithHex:@"#FF870F"];
    self.CO_ScrMoneyNumViewBack = self.CO_Main_ThemeColorTwe;
    
    
    self.CO_LiveLot_BottomBtnBack = self.CO_Main_ThemeColorTwe;
    self.CO_LiveLot_CellLabelBack = [UIColor colorWithHex:@"#D2E4FF"];
    self.CO_LiveLot_CellLabelText = [UIColor colorWithHex:@"#076CD3"];
    
    self.CO_ChatRoomt_SendBtnBack = self.CO_Main_ThemeColorTwe;
    
    
    // 挑码助手
    self.CO_TM_HeadView = [UIColor colorWithHex:@"#F0F2F5"];
    self.CO_TM_HeadContentView = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_BackView = [UIColor colorWithHex:@"#F0F2F5"];
    self.CO_TM_Btn3TitleText = [UIColor colorWithHex:@"#333333"];
    self.CO_TM_Btn3Back = [UIColor colorWithHex:@"#E9F4FF"];
    self.CO_TM_Btn3BackSelected = [UIColor colorWithHex:@"#FF8610"];
    self.CO_TM_Btn3borderColor = self.CO_Main_ThemeColorTwe;
    self.CO_TM_smallBtnText = [UIColor colorWithHex:@"#333333"];
    self.CO_TM_smallBtnTextSelected = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_smallBtnborderColor = [UIColor colorWithHex:@"#999999"];
    self.CO_TM_smallBtnBackColor = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_smallBtnBackColorSelected = [UIColor colorWithHex:@"#FF8610"];
    
#pragma mark 支付相关
    self.CO_Pay_SubmitBtnBack = [UIColor colorWithHex:@"#FF8610"];
    
    
    self.OnlineBtnImage = @"tw_nav_online_kf";
    self.KeFuTopImageName = @"KeFuTop";
    self.ChatVcDeleteImage = @"cartclear_eye";
    
    self.ChangLongLblBorderColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.2];
    self.KJRLSelectCalendar4 = @"kjrq_xzlskj_selected";
    self.KJRLSelectCalendar2 = @"kjrq_xzkjrq_selected";
    self.AIShakeImageName = @"tw_ai_nor";
    self.confirmBtnTextColor = [UIColor whiteColor];
    self.ShareCopyBtnTitleColor = WHITE;
    self.PersonCountTextColor = [UIColor colorWithHex:@"eeeeee"];
    self.NextStepArrowImage = @"next_eye";
    self.OpenLotteryLblLayerColor = [UIColor colorWithHex:@"999999"];
    self.changLongEnableBtnBackgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    self.CartSimpleBottomViewDelBtnImage = @"tw_ic_delete";
    self.CO_BuyDelBtn = [UIColor colorWithHex:@"#333333"];;
    self.CartSimpleBottomViewDelBtnBackgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    self.CartSimpleBottomViewTopBackgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    
    
    self.loginHistoryTextColor = [UIColor colorWithHex:@"0076A3"];
    self.messageIconName = @"xiaoxizhongxin_eye";
    self.quanziLaBaImage = @"tw_circle_lb";
    self.xinshuiFollowBtnBackground = [UIColor colorWithHex:@"FB6A12"];
    self.LHDSBtnImage = @"xs_xf_六合大神";
    self.HomeViewBackgroundColor = [UIColor colorWithHex:@"#eff2f5"];
    self.OpenLotteryBottomNFullImage = @"img_red_eye";
    self.OpenLotteryBottomNormalImage = @"img_orange_eye";
    self.BuyLotteryQPDDZGrayImageName = @"buy_qp_ddz_eye";
    self.BuyLotteryQPBJLGrayImageName = @"buy_qp_bjl_eye";
    self.BuyLotteryQPSLWHGrayImageName = @"buy_qp_slwh_eye";
    self.BuyLotteryQPBRNNGrayImageName = @"buy_qp_brnn_eye";
    self.BuyLotteryQPWRZJHGrayImageName = @"buy_qp_wrzjh_eye";
    self.BuyLotteryQPXLCHGrayImageName = @"buy_qp_xlch_eye";
    self.AoZhouLotterySwitchBtnImage = @"icon_qhms";
    self.AoZhouLotterySwitchBtnTitleColor = [UIColor colorWithHex:@"FF8610"];
    self.bottomDefaultImageName = @"img_darkgrey_eye";
    self.ChangLongRightBtnTitleNormalColor = self.CO_Main_ThemeColorOne;
    self.ChangLongRightBtnSubtitleNormalColor = self.CO_Main_ThemeColorOne;
    self.ChangLongRightBtnBackgroundColor = self.CO_Main_ThemeColorTwe;
    self.AoZhouScrollviewBackgroundColor = CLEAR;
    self.AoZhouMiddleBtnNormalBackgroundColor = [UIColor colorWithHex:@"F0F0F0"];
    self.AoZhouMiddleBtnSelectBackgroundColor = [UIColor colorWithHex:@"#FF870F"];
    self.AoZhouLotterySeperatorLineColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.4];
    self.AoZhouLotteryBtnTitleSelectColor = [UIColor colorWithHex:@"FFFFFF"];
    self.AoZhouLotteryBtnSelectBackgroundColor = [UIColor colorWithHex:@"5DADFF"];
    self.AoZhouLotteryBtnSelectSubtitleColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.8];
    self.AoZhouLotteryBtnTitleNormalColor = [UIColor colorWithHex:@"333333"];
    self.AoZhouLotteryBtnNormalBackgroundColor = [UIColor colorWithHex:@"E9F4FF" ];
    self.AoZhouLotteryBtnNormalSubtitleColor = [UIColor colorWithHex:@"999999"];
    self.Buy_HomeView_BackgroundColor = CLEAR;
    self.ChangLongTitleColor = [UIColor colorWithHex:@"#333333"];
    self.ChangLongTimeLblColor = [UIColor colorWithHex:@"#EB0E24"];
    self.ChangLongTotalLblColor = [UIColor colorWithHex:@"28E223"];
    self.ChangLongIssueTextColor = [UIColor colorWithHex:@"888888"];
    self.ChangLongKindLblTextColor = [UIColor colorWithHex:@"888888"];
    self.ChangLongResultLblColor = [UIColor colorWithHex:@"FFC145"];
    
    
    self.CO_GD_SelectedTextNormal = [UIColor colorWithHex:@"#f7e222"];
    self.CO_GD_SelectedTextSelected = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_GD_Title_BtnBackSelected = self.CO_Main_ThemeColorTwe;
    
    self.WechatLoginImageName = @"tw_login_wx";
    self.QQLoginImageName = @"tw_login_QQ";
    self.xxncCheckBtnBackgroundColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.6];
    self.xxncImageName = @"tw_login_xgnc";
    self.ForgetPsdWhiteBackArrow = @"tw_login_back_white";
    self.LoginWhiteClose = @"tw_login_close";
    self.MimaEye = @"tw_login_mima";
    self.NicknameEye = @"tw_login_nickname";
    self.CodeEye = @"tw_login_code";
    self.InviteCodeEye = @"tw_login_invitecode";
    self.AccountEye = @"tw_login_account";
    self.ForgetPsdTitleTextColor = [UIColor colorWithHex:@"444444"];
    self.ForgetPsdBackgroundImage = @"tw_login_wjmm";
    self.LoginForgetPsdTextColor = [UIColor colorWithHex:@"999999"];
    self.RegistNoticeTextColor = [UIColor colorWithHex:@"#E44646"];
    self.RegistBackgroundImage = @"tw_login_zcbj";
    self.LoginBackgroundImage = @"tw_login_dlbj";
    self.LoginBtnBackgroundcolor = self.CO_Main_ThemeColorTwe;
    self.LoginBoardColor = [UIColor colorWithHex:@"#EEEEEE"];
    self.LoginSureBtnTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.LoginLinebBackgroundColor = [UIColor colorWithHex:@"BBBBBB"];
    self.LoginTextColor = [UIColor colorWithHex:@"666666"];
    self.QicCiDetailSixheadTitleColor = [UIColor colorWithHex:@"333333"];
    self.QiCiXQSixHeaderSubtitleTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.chongqinheadBackgroundColor = self.CO_Main_ThemeColorOne;
    self.QiCiDetailInfoColor = [UIColor colorWithHex:@"#FF8610"];
    self.QiCiDetailTitleColor = [UIColor colorWithHex:@"#333333"];
    self.QiCiDetailLineBackgroundColor = [UIColor colorWithHex:@"#D6D6D6"];
    self.QiCiDetailCellBackgroundColor = self.CO_Main_ThemeColorOne;
    self.CO_OpenLotHeaderInSectionView = [UIColor colorWithHex:@"#999999"];
    self.SixOpenHeaderSubtitleTextColor = [UIColor colorWithHex:@"#999999"];
    self.PK10_color1 = [UIColor colorWithHex:@"D542BB"];
    self.PK10_color2 = [UIColor colorWithHex:@"2F90DF"];
    self.PK10_color3 = [UIColor colorWithHex:@"FAB825"];
    self.PK10_color4 = [UIColor colorWithHex:@"11C368"];
    self.PK10_color5 = [UIColor colorWithHex:@"A36D55"];
    self.PK10_color6 = [UIColor colorWithHex:@"EF3C34"];
    self.PK10_color7 = [UIColor colorWithHex:@"66DBDD"];
    self.PK10_color8 = [UIColor colorWithHex:@"FF8244"];
    self.PK10_color9 = [UIColor colorWithHex:@"4EA3D9"];
    self.PK10_color10 = [UIColor colorWithHex:@"7060D1"];
    
    self.BuyLotteryZCjczqGrayImageName = @"zc_jczq";
    self.BuyLotteryZCjclqGrayImageName = @"zc_jclq";
    self.BuyLotteryZCzqsscGrayImageName = @"zc_zq14c";
    self.BuyLotteryZCrxjcGrayImageName = @"zc_rx9c";
    self.BuyLotteryQPdzGrayImageName = @"qp_dzpk_eye";
    self.BuyLotteryQPerBaGangGrayImageName = @"qp_ebg_eye";
    self.BuyLotteryQPqznnGrayImageName = @"qp_qznn_eye";
    self.BuyLotteryQPzjhGrayImageName = @"qp_zjh_eye";
    self.BuyLotteryQPsgGrayImageName = @"buy_qp_sg_eye";
    self.BuyLotteryQPyzlhGrayImageName = @"qp_yzlh_eye";
    self.BuyLotteryQPesydGrayImageName = @"buy_qp_21d_eye";
    self.BuyLotteryQPtbnnGrayImageName = @"qp_tbnn_eye";
    self.BuyLotteryQPjszjhGrayImageName = @"qp_jszjh_eye";
    self.BuyLotteryQPqzpjGrayImageName = @"qp_qzpj_eye";
    self.BuyLotteryQPsssGrayImageName = @"qp_sss_eye";
    self.BuyLotteryQPxywzGrayImageName = @"qp_xxwz_eye";
    self.CartSectionLineColor = [UIColor colorWithHex:@"#D6D6D6" Withalpha:0.5];
    
    
    self.SixGreenBallName = @"kj_sixgreen";
    self.SixBlueBallName = @"kj_sixblue";
    self.SixRedBallName = @"kj_sixred";
    self.SscBlueBallName = @"dlt_lsq";
    self.SscBallName = @"azact";
    self.PostCircleImageName = @"postcircle_white";
    self.PostCircleImage = IMAGE(@"postcircle_white");
    self.CircleUserCenterMiddleBtnBackgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.CircleUderCenterTopImage = IMAGE(@"jbbj");
    self.ApplyExpertPlaceholdColor = [UIColor colorWithHex:@"999999"];
    self.CO_Account_Info_BtnBack = self.CO_Main_ThemeColorTwe;
    self.ApplyExpertConfirmBtnTextColor = self.CO_Main_ThemeColorOne;
    self.applyExpertBackgroundColor = [UIColor colorWithHex:@"#F1F3F5"];
    self.ExpertInfoTextColorA = [UIColor colorWithHex:@"dddddd"];
    self.ExpertInfoTextColorB = [UIColor colorWithHex:@"FFFFFF"];
    self.WFSMImage = @"WFSMImage_eye";
    
    self.PrizeMessageTopbackViewTextColor = BLACK;
    self.CO_Home_Gonggao_TopBackViewStatus1 = [UIColor colorWithHex:@"B8B8B8"];
    self.CO_Home_Gonggao_TopBackViewStatus2 = self.CO_Main_ThemeColorTwe;
    self.GraphSetViewBckgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.XSTJSearchImage = @"XSTJSearchImage_eye";
    self.XSTJMyArticleImage = IMAGE(@"XSTJMyArticleImage_eye");
    
    
    
    self.TouZhuImage = IMAGE(@"xf_touzhu_button");
    
    
    self.AppFistguideUse1 = @"app_guide_1";
    self.AppFistguideUse2 = @"app_guide_2";
    self.AppFistguideUse3 = @"app_guide_3";
    self.registerVcPhotoImage = IMAGE(@"tw_login_registerVcPhotoImage");
    self.registerVcCodeImage = IMAGE(@"tw_login_registerVcCodeImage");
    self.registerVcPSDImage = IMAGE(@"tw_login_registerVcPSDImage");
    self.registerVcPSDAgainImage = IMAGE(@"registerVcPSDImage");
    self.registerVcInviteImage = IMAGE(@"tw_login_registerVcInviteImage");
    self.registerVcRegisterBtnBTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.registerVcRegisterBtnBckgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.LoginVcHiddenImage = IMAGE(@"tw_login_showPassword");
    self.LoginVcHiddenSelectImage = IMAGE(@"tw_login_hiddenPassword");
    self.LoginVcPhoneImage = IMAGE(@"tw_login_VcPhoneImage");
    self.loginVcQQimage = IMAGE(@"loginVcQQimage");
    self.loginVcWechatimage = IMAGE(@"loginVcWechatimage");
    self.loginLineBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.logoIconImage = IMAGE(@"");
    self.loginVcBgImage = IMAGE(@"loginBackgroundImage_eye");
    self.shareToLblTextColor = [UIColor colorWithHex:@"000000"];
    self.shareVcCopyBtnBackgroundColor = self.CO_Main_ThemeColorTwe;
    self.shareVcQQImage = IMAGE(@"me_qq");
    self.shareVcPYQImage = IMAGE(@"shareVcPYQImage_eye");
    self.shareVcWeChatImage = IMAGE(@"wx");
    self.shareLineImage = IMAGE(@"shareLineImage");
    self.OpenLotteryTimeLblTextColor = [UIColor colorWithHex:@"#FF001B"];
    self.CO_GD_TopBackgroundColor = [UIColor colorWithHex:@"#4a71c7"];
    self.CO_GD_TopBackHeadTitle = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_GD_AllPeople_BtnText = [UIColor colorWithHex:@"#333333"];
    
    self.IM_GD_DashenTableImgView = IMAGE(@"tw_gd_topback");
    
    self.expertContentLblTextcolor = [UIColor colorWithHex:@"EEEEEE"];
    self.expertWinlblTextcolor = WHITE;
    self.expertInfoTopImgView = IMAGE(@"jbbj");
    self.circleListDetailViewBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.IM_CircleDetailHeadImage = IMAGE(@"tw_circle_topback");
    self.MyWalletBankCartImage = IMAGE(@"td_me_wdqb_cell_cart");
    
    self.accountInfoNicknameTextColor = [UIColor colorWithHex:@"333333"];
    self.CO_MoneyTextColor = [UIColor colorWithHex:@"#FF870F"];
    self.accountInfoTopViewBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    
    
    self.shareInviteImage = IMAGE(@"shareInviteImage_eye");
    self.shareMainImage = IMAGE(@"tw_me_fxhyback");
    self.shareBackImage = IMAGE(@"tw_me_fxhy_bsbj");
    self.calendarLeftImage = IMAGE(@"kj_left");
    self.calendarRightImage = IMAGE(@"kj_right");
    self.calendarBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.KJRLSelectBackgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.IM_CalendarTopImage = IMAGE(@"tw_kj_kjrl");
    
    self.LHTKTextfieldBackgroundColor = [UIColor colorWithHex:@"E6E6E6"];
    self.LHTKRemarkTextFeildBorderColor = CLEAR;
    self.XSTJdetailZanImage = IMAGE(@"tw_xs_zan");
    self.attentionViewCloseImage = IMAGE(@"closeAttention_eye");
    self.backBtnImageName = @"tw_nav_return";
    self.HobbyCellImage = IMAGE(@"勾选_eye");
    
#pragma mark  六合图库
    self.CO_LHTK_SubmitBtnBack = self.CO_Main_ThemeColorTwe;
    
    
    self.mine_seperatorLineColor = CLEAR;
    self.openPrizePlusColor = [UIColor colorWithHex:@"#999999"];
    self.OpenPrizeWuXing = [UIColor colorWithHex:@"D6CFFF"];
    
    self.circleHomeCell1Bgcolor = @"circleHomeCell1";
    self.circleHomeCell2Bgcolor = @"circleHomeCell1";
    self.circleHomeCell3Bgcolor = @"circleHomeCell1";
    self.circleHomeCell4Bgcolor = @"circleHomeCell1";
    self.circleHomeCell5Bgcolor = @"circleHomeCell1";
    self.circleHomeSDQImageName = @"cirlceHomeSDQ";
    self.circleHomeGDDTImageName = @"cirlceHomeGDDT";
    self.circleHomeXWZXImageName = @"cirlceHomeXWZX";
    self.circleHomeDJZXImageName = @"cirlceHomeDJZX";
    self.circleHomeZCZXImageName = @"cirlceHomeZCZX";
    
    
    self.circleHomeBgImage = IMAGE(@"circleHomeBgImage");
    
    
    
    self.xinshuiDetailAttentionBtnNormalGroundColor = BASECOLOR;
    self.pushDanBarTitleSelectColot = BASECOLOR;
    self.pushDanSubBarNormalTitleColor = [UIColor colorWithHex:@"666666"];
    self.pushDanSubBarSelectTextColor = [UIColor colorWithHex:@"0076A3"];
    
    self.pushDanSubbarBackgroundcolor = [UIColor colorWithHex:@"EEEEEE"];
    self.CO_LongDragon_PushSetting_BtnBack = self.CO_Main_ThemeColorTwe;
    self.pushDanBarTitleNormalColor = [UIColor colorWithHex:@"EEEEEE"];
    self.CO_Circle_Cell2_TextLabel_BackgroundC = [UIColor colorWithHex:@"9e353c"];
    self.CO_Circle_Cell2_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"9e353c"];
    self.CO_Circle_Cell3_TextLabel_BackgroundC = [UIColor colorWithHex:@"647e24"];
    self.CO_Circle_Cell1_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"5649b3"];
    self.bettingBtnColor = WHITE;
    self.xinshuiDetailAttentionBtnBackGroundColor = MAINCOLOR;
    self.LoginNamePsdPlaceHoldColor = [UIColor colorWithHex:@"BBBBBB"];
    self.missCaculateBarNormalBackground = [UIColor colorWithHex:@"EEEEEE"];
    self.missCaculateBarselectColor = BASECOLOR;
    self.missCaculateBarNormalColor = WHITE;
    self.openLotteryCalendarBackgroundcolor = [UIColor colorWithHex:@"F7F7F7"];
    self.openLotteryCalendarTitleColor = [UIColor colorWithHex:@"EEEEEE"];
    self.openLotteryCalendarWeekTextColor = [UIColor colorWithHex:@"666666"];
    self.CO_OpenLot_BtnBack_Normal = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_OpenLot_BtnBack_Selected = self.CO_Main_ThemeColorTwe;
    self.CO_Home_Gonggao_TopTitleText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_Gonggao_Cell_MessageTopViewBack = self.CO_Main_ThemeColorTwe;
    self.KeyTitleColor = [UIColor colorWithHex:@"e76c29"];
    
    self.CO_Circle_TitleText = [UIColor colorWithHex:@"999999"];
    
    self.xinshuiRemarkTitleColor = WHITE;
    self.sixHeTuKuRemarkbarBackgroundcolor = WHITE;
    self.myCircleUserMiddleViewBackground = [UIColor colorWithHex:@"2C3036"];
    self.openCalendarTodayColor = [UIColor colorWithHex:@"#529DFF"];
    self.openCalendarTodayViewBackground = [UIColor colorWithHex:@"#FF9000"];
    self.LoginNamePsdTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.MineTitleStrColor = [UIColor colorWithHex:@"FFFFFF"];
    self.MessageTitleColor  = WHITE;
    
    self.xinshuiBottomViewTitleColor = WHITE;
    self.CO_KillNumber_LabelText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_KillNumber_LabelBack = self.CO_Main_ThemeColorTwe;
    
    self.TopUpViewTopViewBackgroundcolor = CLEAR;
    self.chargeMoneyLblSelectColor = [UIColor colorWithHex:@"FFFFFF"];
    self.chargeMoneyLblSelectBackgroundcolor = [UIColor colorWithHex:@"#FF8610"];
    self.chargeMoneyLblNormalColor = [UIColor colorWithHex:@"C48936"];
    self.tabbarItemTitleColor = [UIColor lightGrayColor];
    
    
    self.RootVC_ViewBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.tabbarItemTitleColor = [UIColor lightGrayColor];
    self.CO_Circle_Cell3_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"6d872f"];
    self.CO_Circle_Cell4_TextLabel_BackgroundC = [UIColor colorWithHex:@"3ea358"];
    self.CO_Circle_Cell4_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"3ea358"];
    self.tixianShuoMingColor = [UIColor colorWithHex:@"0076A3"];
    
    self.CircleVC_HeadView_BackgroundC = CLEAR;
    self.CO_Circle_Cell_BackgroundC = [UIColor colorWithHex:@"f0f2f5"];
    self.CO_Circle_Cell_TextLabel_BackgroundC = [UIColor colorWithHex:@"333333"];
    self.CO_Circle_Cell_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"999999"];
    
    
    self.CartBarBackgroundColor = self.CO_Main_ThemeColorOne;
    self.CartBarTitleNormalColor = [UIColor colorWithHex:@"#333333"];
    self.CartBarTitleSelectColor = [UIColor colorWithHex:@"FF8610"];
    self.CartHomeHeaderSeperatorColor = [UIColor colorWithHex:@"ff9711"];
    self.genDanHallTitleNormalColr = [UIColor colorWithHex:@"FFFFFF"];
    self.genDanHallTitleSelectColr = [UIColor colorWithHex:@"FFEA01"];;
    self.genDanHallTitleBackgroundColor = [UIColor colorWithHex:@"#4a71c7"];
    self.gongShiShaHaoFormuTitleNormalColor = [UIColor colorWithHex:@"333333"];
    self.gongShiShaHaoFormuTitleSelectColor = BASECOLOR;
    self.gongshiShaHaoFormuBtnBackgroundColor = BLACK;
    
    
    
    self.OpenLotteryVC_ColorLabs_TextC = [UIColor colorWithHex:@"#FF8610"];
    self.OpenLotteryVC_ColorLabs1_TextC = [UIColor colorWithHex:@"#333333"];
    self.OpenLotteryVC_SubTitle_TextC = [UIColor colorWithHex:@"#999999"];
    self.OpenLotteryVC_SubTitle_BorderC = [UIColor colorWithHex:@"8D8D8D"];
    self.OpenLotteryVC_Cell_BackgroundC = [UIColor colorWithHex:@"3a3b3f"];
    self.OpenLotteryVC_View_BackgroundC = [UIColor colorWithHex:@"F0F2F5"];
    self.CO_LongDragonCell = self.CO_Main_ThemeColorOne;
    self.OpenLotteryVC_TitleLabs_TextC = [UIColor colorWithHex:@"333333"];
    self.OpenLotteryVC_SeperatorLineBackgroundColor = [UIColor colorWithHex:@"#D6D6D6" Withalpha:0.5];
    self.CO_OpenLetBtnText_Normal = [UIColor colorWithHex:@"333333"];
    self.SixRecommendVC_View_BackgroundC = [UIColor colorWithHex:@"f4f4f4"];
    self.MineVC_Btn_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    
    self.HobbyVC_MessLab_BackgroundC = [UIColor colorWithHex:@"EEEEEE"];
    self.HobbyVC_MessLab_TextC = [UIColor colorWithHex:@"333333"];
    self.HobbyVC_View_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.HobbyVC_OKButton_BackgroundC = [UIColor colorWithHex:@"0076A3"];
    self.HobbyVC_OKButton_TitleBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Circle_Title_nameColor = [UIColor colorWithHex:@"333333"];
    self.HobbyVC_SelButton_TitleBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.HobbyVC_UnSelButton_TitleBackgroundC = [UIColor colorWithHex:@"999999"];
    self.CO_Circle_Cell1_TextLabel_BackgroundC = self.CO_Circle_Cell_TextLabel_BackgroundC;
    self.HobbyVC_SelButton_BackgroundC = [UIColor colorWithHex:@"0076A3"];
    self.HobbyVC_UnSelButton_BackgroundC = [UIColor colorWithHex:@"DDDDDD"];
    self.Circle_View_BackgroundC = [UIColor colorWithHex:@"#f0f2f5"];
    self.Circle_HeadView_Title_UnSelC = [UIColor colorWithHex:@"999999"];
    self.Circle_HeadView_Title_SelC = [UIColor colorWithHex:@"333333"];
    self.Circle_HeadView_BackgroundC = [UIColor colorWithHex:@"#1e4c7d"];
    self.Circle_HeadView_NoticeView_BackgroundC = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.2];
    self.Circle_HeadView_GuangBo_BackgroundC = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.8];
    self.Circle_Cell_BackgroundC = [UIColor colorWithHex:@"F7F7F7"];
    self.Circle_Cell_ContentlabC = [UIColor colorWithHex:@"666666"];
    self.Circle_Cell_Commit_BackgroundC = [UIColor colorWithHex:@"F7F7F7"];
    self.Circle_Cell_Commit_TitleC = [UIColor colorWithHex:@"666666"];
    self.Circle_Cell_AttentionBtn_TitleC = [UIColor colorWithHex:@"CFA753"];
    self.Circle_Line_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Circle_remark_nameColor = [UIColor colorWithHex:@"4e79c2"];
    self.getCodeBtnvBackgroundcolor = [UIColor colorWithHex:@"dddddd"];
    self.Circle_FooterViewLine_BackgroundC = [UIColor colorWithHex:@"dddddd" Withalpha:0.9];
    self.OpenLottery_S_Cell_BackgroundC = CLEAR;//[UIColor colorWithHex:@"8483F0"];
    self.OpenLottery_S_Cell_TitleC = [UIColor colorWithHex:@"333333"];
    self.Login_NamePasswordView_BackgroundC = CLEAR;//[UIColor colorWithHex:@"2c2e36"];
    self.Login_ForgetSigUpBtn_BackgroundC = [UIColor colorWithHex:@"2c2e36" Withalpha:0.5];
    self.Login_ForgetSigUpBtn_TitleC = [UIColor colorWithHex:@"DDDDDD"];
    self.Login_LogoinBtn_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Login_LogoinBtn_TitleC = [UIColor colorWithHex:@"0076A3"];
    self.Buy_LotteryMainBackgroundColor = [UIColor colorWithHex:@"1B1E23"];
    self.RootWhiteC = [UIColor colorWithHex:@"f4f4f4"];
    self.CO_OpenLetBtnText_Selected = [UIColor colorWithHex:@"FFFFFF"];
    self.loginSeperatorLineColor = [UIColor colorWithHex:@"EEEEEE"];
    self.getCodeBtnvTitlecolor = [UIColor colorWithHex:@"#888888"];
    self.LiuheTuKuLeftTableViewBackgroundColor = [UIColor colorWithHex:@"e0e0e0"];
    self.LiuheTuKuOrangeColor = self.CO_Main_ThemeColorTwe;
    self.LiuheTuKuLeftTableViewSeperatorLineColor = [UIColor colorWithHex:@"c2c2c2"];
    self.LiugheTuKuTopBtnGrayColor = [UIColor colorWithHex:@"dddddd"];
    self.LiuheTuKuProgressValueColor = [UIColor colorWithHex:@"0076A3"];
    self.LiuheTuKuTouPiaoBtnBackgroundColor = [UIColor colorWithHex:@"c60000"];
    self.LiuheDashendBackgroundColor = self.CO_Main_ThemeColorOne;
    
    self.xinShuiReconmentGoldColor = [UIColor colorWithHex:@"FFFFFF"];
    self.xinShuiReconmentRedColor = self.CO_Main_ThemeColorTwe;
    self.TouPiaoContentViewTopViewBackground = [UIColor colorWithHex:@"16171b"];
    self.LiuheTuKuRemarkBarBackgroundColor = [UIColor colorWithHex:@"16171b"];
    self.LiuheTuKuRemarkSendBackgroundColor = self.CO_Main_ThemeColorTwe;
    self.LiuheTuKuTextRedColor = self.CO_Main_ThemeColorTwe;
    self.XinshuiRecommentScrollBarBackgroundColor = [UIColor colorWithHex:@"f0f0f0"];
    self.xinshuiBottomVeiwSepeLineColor = [UIColor whiteColor];
    self.Circle_Post_titleSelectColor = [UIColor colorWithHex:@"#fff100"];
    self.Circle_Post_titleNormolColor = [UIColor colorWithHex:@"#d4d2cf"];
    
#pragma mark 购彩
    //购彩
    self.Buy_HeadView_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_HeadView_Footer_BackgroundC = [UIColor colorWithHex:@"F0F0F0"];
    self.Buy_HeadView_Title_C = [UIColor colorWithHex:@"333333"];
    self.Buy_HeadView_historyV_Cell1_C = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_HeadView_historyV_Cell2_C = [UIColor colorWithHex:@"F0F0F0"];
    
    self.Buy_LeftView_BackgroundC = CLEAR;//[UIColor colorWithHex:@"0076A3"];
    self.Buy_LeftView_Btn_BackgroundUnSel = IMAGE(@"FY_Buy_LeftView_Btn_BackgroundUnSel");
    self.Buy_LeftView_Btn_BackgroundSel = IMAGE(@"FY_Buy_LeftView_Btn_BackgroundSel");
    self.Buy_LeftView_Btn_TitleSelC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_LeftView_Btn_TitleUnSelC = [UIColor colorWithHex:@"333333"];
    self.Buy_LeftView_Btn_PointUnSelC = [UIColor colorWithHex:@"C21632"];
    self.Buy_LeftView_Btn_PointSelC = [UIColor colorWithHex:@"35EB62"];
    self.Buy_RightBtn_Title_UnSelC = [UIColor colorWithHex:@"333333"];
    self.Buy_RightBtn_Title_SelC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionHeadV_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionHeadV_ViewC = [UIColor colorWithHex:@"ff5d12"];
    self.CO_Bottom_LabelText = [UIColor colorWithHex:@"#333333"];
    
    self.Buy_CollectionCellButton_BackgroundSel = [UIColor colorWithHex:@"#C21632"];
    self.Buy_CollectionCellButton_BackgroundUnSel = CLEAR;
    self.Buy_CollectionCellButton_TitleCSel = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionCellButton_TitleCUnSel = [UIColor colorWithHex:@"333333"];
    self.Buy_CollectionCellButton_SubTitleCSel = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionCellButton_SubTitleCUnSel = [UIColor colorWithHex:@"999999"];
    self.Buy_CollectionViewLine_C = [UIColor colorWithHex:@"D6D6D6"];
    
    self.CO_BuyLot_HeadView_LabelText = [UIColor colorWithHex:@"666666"];
    self.CO_BuyLot_HeadView_Label_border = [UIColor colorWithHex:@"999999"];
    self.CO_BuyLot_Right_bcViewBack = [UIColor colorWithHex:@"#FFF9EE"];
    self.CO_BuyLot_Right_bcView_border = [UIColor colorWithHex:@"#FF8610"];
    
    
    self.CartHomeSelectSeperatorLine = [UIColor colorWithHex:@"ff9711"];
    
    self.grayColor999 = [UIColor colorWithHex:@"999999"];
    self.grayColor666 = [UIColor colorWithHex:@"666666"];
    self.grayColor333 = [UIColor colorWithHex:@"333333"];
    self.Mine_rightBtnTileColor = [UIColor colorWithHex:@"FFFFFF"];
    self.Mine_priceTextColor = [UIColor colorWithHex:@"#EACD91"];
    self.ChangePsdViewBackgroundcolor = [UIColor colorWithHex:@"F7F7F7"];
    self.CO_Me_MyWallerBalance_MoneyText = [UIColor colorWithHex:@"E83250"];
    self.CO_Me_MyWallerBalanceText = [UIColor colorWithHex:@"E83250"];
    self.MyWalletTotalBalanceColor = [UIColor colorWithHex:@"fff666"];
    self.mineInviteTextCiolor = [UIColor colorWithHex:@"888888"];
    self.CO_Me_MyWallerTitle = [UIColor colorWithHex:@"#333333"];
#pragma mark 番摊紫色
    self.NN_LinelColor = [UIColor colorWithHex:@"D6D6D6"];
    self.NN_xian_normalColor = [UIColor colorWithHex:@"565964"];
    self.NN_xian_selColor = [UIColor colorWithHex:@"8F601E"];
    self.NN_zhuang_normalColor = [UIColor colorWithHex:@"5140A1"];
    self.NN_zhuang_selColor = [UIColor colorWithHex:@"905F1B"];
    self.NN_Xian_normalImg = @"xianjia-gray_1";
    self.NN_Xian_selImg = @"xianjia-color_1";
    self.NN_zhuang_normalImg = @"zhuang_normal";
    self.NN_zhuang_selImg = @"zhuangjia-color_1";
    
    self.NN_XianBgImg = [UIImage imageNamed:@"xianjia-xuanzhong"];
    self.NN_XianBgImg_sel = [UIImage imageNamed:@"xianjia"];
    self.Buy_NNXianTxColor_normal = [UIColor colorWithHex:@"0E2B20"];
    self.Buy_NNXianTxColor_sel = [UIColor whiteColor];
    self.Fantan_headerLineColor = [UIColor colorWithHex:@"1F5C73"];
    self.Fantan_historyHeaderBgColor = [UIColor colorWithHex:@"8D7FE9"];
    self.Fantan_historyHeaderLabColor = [UIColor colorWithHex:@"333333"];
    self.Fantan_historycellColor1 = [UIColor colorWithHex:@"333333"];
    self.Fantan_historycellColor2 = [UIColor colorWithHex:@"D6D6D6"];
    self.Fantan_historycellColor3 = [UIColor colorWithHex:@"FFD116"];
    self.Fantan_historycellOddColor = [UIColor colorWithHex:@"AAA2F1"];
    self.Fantan_historycellEvenColor = [UIColor colorWithHex:@"9B8DE9"];
    self.CO_Fantan_HeadView_Label = [UIColor colorWithHex:@"666666"];
    
    self.RedballImg_normal = @"lessredball";
    self.RedballImg_sel = @"redball";
    self.BlueballImg_normal = @"lesswhiteball";
    self.BlueballImg_sel = @"blueball";
    
    self.Fantan_MoneyColor = [UIColor colorWithHex:@"C21632"];
    self.Fantan_CountDownBoderColor = [UIColor colorWithHex:@"999999"];
    self.Fantan_CountDownBgColor = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_fantanTimeColor = [UIColor colorWithHex:@"FF9F0F"];
    self.Fantan_DelImg = IMAGE(@"cartclear_1");
    self.Fantan_ShakeImg = IMAGE(@"cartrandom_1");
    self.Fantan_AddToBasketImg = IMAGE(@"cartset_1");
    self.Fantan_basketImg = IMAGE(@"cart_1");
    
    self.Fantan_FloatImgUp = IMAGE(@"buy_up_1");
    self.Fantan_FloatImgDown = IMAGE(@"buy_down_1");
    self.Fantan_AddImg = IMAGE(@"tw_add");
    self.Fantan_JianImg = IMAGE(@"tw_jianhao");
    self.Fantan_SpeakerImg = IMAGE(@"buy_music_1");
    self.Buy_fantanBgColor = [UIColor colorWithHex:@"2d2f37"];
    //    self.Buy_fantanCellBgColor = [UIColor colorWithHex:@"715FE3"];
    self.Buy_fantanCellBgColor = [UIColor colorWithHex:@"FFFFFF"];;
    self.Fantan_iconColor = [UIColor colorWithHex:@"FFD116"];
    self.FantanColor1 = [UIColor colorWithHex:@"#C21632"];
    self.FantanColor2 = [UIColor colorWithHex:@"#C21632"];
    self.FantanColor3 = [UIColor colorWithHex:@"F0F0F0"];
    self.FantanColor4 = [UIColor colorWithHex:@"F0F0F0"];
    self.Fantan_textFieldColor = self.CO_Main_ThemeColorOne;
    self.CO_Fantan_textFieldTextColor = [UIColor colorWithHex:@"FF8610"];
    self.CO_BuyLotBottomView_TopView3_BtnText = [UIColor colorWithHex:@"333333"];
    self.CO_BuyLotBottomView_BotView2_BtnBack = [UIColor colorWithHex:@"FF8610"];
    self.Fantan_tfPlaceholdColor = [UIColor colorWithHex:@"#333333"];
    self.CO_Buy_textFieldText = [UIColor colorWithHex:@"#333333"];
    self.Fantan_labelColor = [UIColor colorWithHex:@"#333333"];
    self.blackOrWhiteColor = [UIColor colorWithHex:@"000000"];
    self.MyWallerBalanceBottomViewColor = [UIColor colorWithHex:@"e9e9e9"];
    
}


#pragma mark - hkTheme
- (void)hkTheme {
    
    self.CO_Main_ThemeColorOne = [UIColor colorWithHex:@"FFFFFF"];   // 主题色1;  白色
    self.CO_Main_ThemeColorTwe = [UIColor colorWithHex:@"#6FACE2"];   // 主题色2;  蓝色
    self.CO_Main_LineViewColor = [UIColor colorWithHex:@"#CCCCCC"];   // 线条颜色
    self.CO_Main_LabelNo1 = [UIColor colorWithHex:@"#333333"];
    self.CO_Main_LabelNo2 = [UIColor colorWithHex:@"#CCCCCC"];
    self.CO_Main_LabelNo3 = [UIColor colorWithHex:@"#FFFFFF"];
    
    
    /// ****** TabBar ******
    self.IC_TabBar_Home = @"tw_tab_home";
    self.IC_TabBar_Home_Selected = @"tw_tab_home_selected";
    self.IC_TabBar_KJ_ = @"tw_tab_kj";
    self.IC_TabBar_KJ_Selected = @"tw_tab_kj_selected";
    self.IC_TabBar_GC = @"tw_tab_gc";
    self.IC_TabBar_GC_Selected = @"tw_tab_gc";
    self.IC_TabBar_QZ = @"tw_tab_qz";
    self.IC_TabBar_QZ_Selected = @"tw_tab_qz_selected";
    self.IC_TabBar_Me = @"tw_tab_me";
    self.IC_TabBar_Me_Selected = @"tw_tab_me_selected";
    self.CO_TabBarTitle_Normal = [UIColor colorWithHex:@"666666"];
    self.CO_TabBarTitle_Selected = self.CO_Main_ThemeColorTwe;
    self.CO_TabBarBackground = [UIColor colorWithHex:@"FFFFFF"];
    
    
    /// ****** Nav ******
    self.CO_Nav_Bar_NativeViewBack = self.CO_Main_ThemeColorTwe;
    self.CO_NavigationBar_TintColor = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_NavigationBar_Title = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Nav_Bar_CustViewBack = self.CO_Main_ThemeColorTwe;   // 主题色2
    
    self.IM_Nav_TitleImage_Logo = IMAGE(@"tw_nav_hometitle_logo");
    self.IC_Nav_ActivityImageStr = @"tw_activity_icon";
    self.IC_Nav_SideImageStr = @"tw_menu_icon";
    self.IC_Nav_CircleTitleImage = @"tw_nav_circle_center";
    self.IC_Nav_Setting_Icon = @"tw_nav_setting_icon";
    self.IC_Nav_Setting_Gear = @"td_nav_setting";
    self.IC_Nav_Kefu_Text = @"tw_nav_online_kf";
    
    
#pragma mark Home
    
    
    self.CO_Home_VC_NoticeView_Back = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_VC_NoticeView_LabelText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_NoticeView_LabelText = [UIColor colorWithHex:@"#4D4D4D"];
    self.CO_Home_CellCartCellSubtitleText = [UIColor colorWithHex:@"#999999"];
    self.CO_Home_VC_HeadView_Back = CLEAR;
    self.CO_Home_NewsTopViewBack = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Home_NewsBgViewBack = [UIColor colorWithHex:@"#eff2f5"];
    self.CO_Home_News_LineView = [UIColor colorWithHex:@"#CCCCCC"];
    self.CO_Home_News_HeadTitleText = [UIColor colorWithHex:@"#808080"];
    self.CO_Home_News_ScrollLabelText = [UIColor colorWithHex:@"#333333"];
    self.CO_Home_VC_HeadView_HotMessLabelText = [UIColor colorWithHex:@"#000000"];
    self.CO_Home_CollectionView_CartCellTitle = [UIColor colorWithHex:@"#333333"];
    self.CO_Home_VC_HeadView_NumbrLables_Text = [UIColor colorWithHex:@"FDFDFD"];
    self.CO_Home_News_HotHeadViewBack = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_VC_Cell_ViewBack = [UIColor colorWithHex:@"#eff2f5"];
    
    self.IM_Home_HeadlineImg = IMAGE(@"tw_CPT头条");
    self.CO_Home_HeadlineLabelText = [UIColor colorWithHex:@"#4D4D4D"];
    self.CO_Home_HeadlineLineView = [UIColor colorWithHex:@"#CCCCCC"];
    
    self.IM_Home_BottomBtnOne = IMAGE(@"tw_bottom_lxkf");
    self.IM_Home_BottomBtnTwo = IMAGE(@"tw_bottom_lts");
    self.IM_Home_BottomBtnThree = IMAGE(@"tw_bottom_wyb");
    
    self.CO_Home_VC_Cell_Titlelab_Text = [UIColor colorWithHex:@"333333"];
    self.CO_Home_VC_Cell_SubTitlelab_Text = [UIColor colorWithHex:@"#999999"];
    self.CO_Home_VC_ADCollectionViewCell_Back = CLEAR;
    self.CO_Home_CellBackgroundColor = [UIColor colorWithHex:@"#eff2f5"];
    self.CO_Home_CellContentView = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Home_VC_PCDanDan_ViewBack2 = [UIColor colorWithHex:@"FFFFFF"];
    
    self.CO_Home_VC_PCDanDan_line_ViewBack = [UIColor colorWithHex:@"999999"];
    
    self.CO_Home_SubHeaderTitleColor = [UIColor colorWithHex:@"333333"];;
    self.CO_Home_SubHeaderSubtitleColor = [UIColor colorWithHex:@"3B3A3C"];
    self.CO_Home_SubheaderTimeLblText = [UIColor colorWithHex:@"7f70dc"];;
    self.CO_Home_SubheaderLHCSubtitleText = self.KeyTitleColor;
    
    self.IC_Home_CQSSC = @"重庆时时彩";
    self.IC_Home_LHC = @"六合彩";
    self.IC_Home_BJPK10 = @"北京PK10";
    self.IC_Home_XJSSC = @"新疆时时彩";
    self.IC_Home_XYFT = @"幸运飞艇";
    self.IC_Home_TXFFC = @"比特币分分彩";
    self.IC_Home_PCDD = @"PC蛋蛋";
    self.IC_Home_ZCZX = @"足彩资讯";
    self.IC_Home_AZF1SC = @"六合彩";
    self.IC_Home_GDCZ = @"更多彩种";
    
    self.IC_Home_Icon_BeginName = @"tw_";
    
    
    self.IC_home_sub_SS = @"tw_home_sub_赛事";
    self.IC_home_sub_YC = @"tw_home_sub_预测";
    self.IC_home_sub_ZJ = @"tw_home_sub_专家";
    self.IC_home_sub_BF = @"tw_home_sub_比分";
    self.IC_home_sub_HMZS = @"tw_home_sub_号码走势";
    self.IC_home_sub_JRHM = @"tw_home_sub_今日号码";
    self.IC_home_sub_HMYL = @"tw_home_sub_号码遗漏";
    self.IC_home_sub_LRFX = @"tw_home_sub_冷热分析";
    self.IC_home_sub_GYHTJ = @"tw_home_sub_冠亚和统计";
    self.IC_home_sub_LMCL = @"tw_home_sub_两面长龙";
    self.IC_home_sub_LMLZ = @"tw_home_sub_两面路珠";
    self.IC_home_sub_LMYL = @"tw_home_sub_两面遗漏";
    self.IC_home_sub_QHLZ = @"tw_home_sub_前后路珠";
    self.IC_home_sub_LMLS = @"tw_home_sub_两面历史";
    self.IC_home_sub_GYHLZ = @"tw_home_sub_冠亚和路珠";
    self.IC_home_sub_HBZS = @"tw_home_sub_横版走势";
    self.IC_home_sub_History = @"tw_home_sub_历史开奖";
    self.IC_home_sub_XSTJ = @"tw_home_sub_免费推荐";
    self.IC_home_sub_LHTK = @"tw_home_sub_六合图库";
    self.IC_home_sub_CXZS = @"tw_home_sub_查询助手";
    self.IC_home_sub_ZXTJ = @"tw_home_sub_资讯统计";
    self.IC_home_sub_KJRL = @"tw_home_sub_开奖日历";
    self.IC_home_sub_GSSH = @"tw_home_sub_公式杀手";
    self.IC_home_sub_AIZNXH = @"tw_home_sub_AI智能选号";
    self.IC_home_sub_SXCZ = @"tw_home_sub_属性参考";
    self.IC_home_sub_TMLS = @"tw_home_sub_特码历史";
    self.IC_home_sub_ZMLS = @"tw_home_sub_正码历史";
    self.IC_home_sub_WSDX = @"tw_home_sub_尾数大小";
    self.IC_home_sub_SXTM = @"tw_home_sub_生肖特码";
    self.IC_home_sub_SXZM = @"tw_home_sub_生肖正码";
    self.IC_home_sub_BSTM = @"tw_home_sub_波色特码";
    self.IC_home_sub_BSZM = @"tw_home_sub_波色正码";
    self.IC_home_sub_TMLM = @"tw_home_sub_特码两面";
    self.IC_home_sub_TMWS = @"tw_home_sub_特码尾数";
    self.IC_home_sub_ZMWS = @"tw_home_sub_正码尾数";
    self.IC_home_sub_ZMZF = @"tw_home_sub_正码总分";
    self.IC_home_sub_HMBD = @"tw_home_sub_号码波段";
    self.IC_home_sub_JQYS = @"tw_home_sub_家禽野兽";
    self.IC_home_sub_LMZS = @"tw_home_sub_连码走势";
    self.IC_home_sub_LXZS = @"tw_home_sub_连肖走势";
    self.IC_home_sub_LHDS = @"tw_home_sub_六合大神";
    self.IC_home_sub_YLTJ = @"tw_home_sub_遗漏统计";
    self.IC_home_sub_JRTJ = @"tw_home_sub_今日统计";
    self.IC_home_sub_MFTJ = @"tw_home_sub_免费推荐";
    self.IC_home_sub_QXT = @"tw_home_sub_曲线图";
    self.IC_home_sub_TMZS = @"tw_home_sub_选号助手";
    
    self.IM_home_ZXTJImageName = @"homeZXTJImageName_eye";
    self.CO_home_SubCellTitleText = [UIColor colorWithHex:@"333333"];
    self.CO_home_SubheaderBallBtnBack = [UIColor colorWithHex:@"fe5049"];
    self.IM_home_XSTJImage = IMAGE(@"IM_home_XSTJImage");
    self.IM_home_LHDSImage = IMAGE(@"IM_home_LHDSImage");
    self.IM_home_LHTKImage = IMAGE(@"IM_home_LHTKImage");
    self.IM_home_GSSHImage = IMAGE(@"IM_home_GSSHImage");
    self.IC_home_ZBKJImageName = @"IC_home_ZBKJImageName";
    self.IC_home_LSKJImageName = @"IC_home_LSKJImageName";
    self.IC_home_CXZSImageName = @"IC_home_CXZSImageName";
    self.IM_home_hotNewsImageName = IMAGE(@"IM_home_hotNewsImageName");
    self.IM_home_SanJiaoImage = IMAGE(@"IM_home_SanJiaoImage");
    
    self.CO_Home_Buy_Footer_BtnBack = [UIColor colorWithHex:@"9C2D33"];
    self.CO_Home_Buy_Footer_Back = [UIColor colorWithHex:@"F0F0F0"];
    
#pragma mark 我的
    
    self.IM_topBackImageView = IMAGE(@"tw_ic_me_topback");
    self.Mine_ScrollViewBackgroundColor = [UIColor colorWithHex:@"3E94FF"];
    self.CO_Mine_setContentViewBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Me_NicknameLabel = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Me_SubTitleText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Me_ItemTextcolor = [UIColor colorWithHex:@"#666666"];
    
    self.CO_LongDragonTopView = self.CO_Main_ThemeColorOne;
    self.CO_LongDragonTopViewBtn =  [UIColor colorWithHex:@"#FF870F"];
    
    self.IM_Home_cartBgImageView = IMAGE(@"circleHomeBgImage");
    self.CO_buyLotBgColor = [UIColor colorWithHex:@"F4F4F4"];
    self.OpenLotteryVC_ColorLabs_TextB = [UIColor colorWithHex:@"333333"];
    
    self.IM_Me_MoneyRefreshBtn = IMAGE(@"mine_moneyRef");
    self.IM_Me_ChargeImage = IMAGE(@"tw_me_top1");
    self.IM_Me_GetMoneyImage = IMAGE(@"tw_me_top2");
    self.IM_Me_MoneyDetailImage = IMAGE(@"tw_me_top3");
    
    self.IM_Me_MyWalletImage = IMAGE(@"tw_me_sro1");
    self.IM_Me_MyAccountImage = IMAGE(@"tw_me_sro2");
    self.IM_Me_SecurityCnterImage = IMAGE(@"tw_me_sro3");
    self.IM_Me_MyTableImage = IMAGE(@"tw_me_sro4");
    self.IM_Me_buyHistoryImage = IMAGE(@"tw_me_sro5");
    self.IM_Me_MessageCenterImage = IMAGE(@"tw_me_sro6");
    self.IM_Me_setCenterImage = IMAGE(@"tw_me_sro7");
    self.IM_Me_shareImage = IMAGE(@"tw_me_sro8");
    self.CO_Me_YuEText = [UIColor colorWithHex:@"FFFFFF"];
    
#pragma mark  AI智能选号
    self.IM_AI_BGroundcolorImage = IMAGE(@"tw_ai_top_bg_aiznxh");
    self.IM_AI_ShengXiaoNormalImage = IMAGE(@"tw_ai_sx");
    self.IM_AI_ShakeNormalImage = IMAGE(@"tw_ai_yyy");
    self.IM_AI_LoverNormalImage = IMAGE(@"tw_ai_ar");
    self.IM_AI_FamilyNormalImage = IMAGE(@"tw_ai_jr");
    self.IM_AI_BirthdayNormalImage = IMAGE(@"tw_ai_sr");
    self.IM_AI_ShengXiaoSeletImage = IMAGE(@"tw_ai_sx_selected");
    self.IM_AI_ShakeSeletImage = IMAGE(@"tw_ai_yyy_selected");
    self.IM_AI_LoverSeletImage = IMAGE(@"tw_ai_ar_selected");
    self.IM_AI_FamilySeletImage = IMAGE(@"tw_ai_jr_selected");
    self.IM_AI_BirthdaySeletImage = IMAGE(@"tw_ai_sr_selected");
    self.IM_AI_BirthdayImage = IMAGE(@"tw_ai_srdg");
    self.IM_AI_ShengXiaoBackImage = IMAGE(@"tw_ai_cpt");
    self.IM_AI_ShuImage = IMAGE(@"tw_ai_shu");
    self.IM_AI_GouImage = IMAGE(@"tw_ai_gou");
    self.IM_AI_HouImage = IMAGE(@"tw_ai_hou");
    self.IM_AI_HuImage = IMAGE(@"tw_ai_hu");
    self.IM_AI_JiImage = IMAGE(@"tw_ai_ji");
    self.IM_AI_LongImage = IMAGE(@"tw_ai_long");
    self.IM_AI_MaImage = IMAGE(@"tw_ai_ma");
    self.IM_AI_NiuImage = IMAGE(@"tw_ai_niu");
    self.IM_AI_SheImage = IMAGE(@"tw_ai_she");
    self.IM_AI_TuImage = IMAGE(@"tw_ai_tu");
    self.IM_AI_YangImage = IMAGE(@"tw_ai_yang");
    self.IM_AI_ZhuImage = IMAGE(@"tw_ai_zhu");
    self.IM_AI_AutoSelectLblNormalColor = [UIColor colorWithHex:@"#8BC4FF"];
    self.IM_AI_AutoSelectLblSelectColor = self.CO_Main_ThemeColorTwe;
    
    
    // 购彩侧边
    self.CO_BuyLot_Left_ViewBack = [UIColor colorWithHex:@"#F0F0F0"];
    self.CO_BuyLot_Left_LeftCellBack = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_BuyLot_Left_LeftCellTitleText = [UIColor colorWithHex:@"#333333"];
    self.CO_BuyLot_Left_LeftCellBack_Selected = [UIColor colorWithHex:@"#FE8D2C"];
    self.CO_BuyLot_Left_LeftCellTitleText_Selected = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_BuyLot_Left_CellBack = [UIColor colorWithHex:@"#F0F0F0"];
    self.CO_BuyLot_Left_CellTitleText = [UIColor colorWithHex:@"#666666"];
    
    // 设置中心
    self.IC_Me_SettingTopImageName = @"tw_topback";
    self.IC_Me_SettingTopHeadIcon = @"setting_icon";
    self.SettingPushImageName = @"tw_me_setcenter1";
    self.SettingShakeImageName = @"tw_me_setcenter2";
    self.SettingVoiceImageName = @"tw_me_setcenter3";
    self.SettingSwitchSkinImageName = @"tw_me_setcenter4";
    self.SettingServiceImageName = @"tw_me_setcenter5";
    self.SettingAboutUsImageName = @"tw_me_setcenter6";
    self.confirmBtnBackgroundColor = self.CO_Main_ThemeColorTwe;
    
    
    // 我的钱包
    self.MyWalletTopImage = IMAGE(@"tw_me_wdqb");
    // 安全中心
    self.safeCenterTopImage = IMAGE(@"tw_topback");
    self.CO_Me_TopLabelTitle = [UIColor colorWithHex:@"333333"];
    // 侧边
    self.Left_VC_ChargeBtnImage = IMAGE(@"tw_left_cz");
    self.Left_VC_GetMoneyBtnImage = IMAGE(@"tw_left_tx");
    self.Left_VC_KFBtnImage = IMAGE(@"tw_left_kf");
    self.Left_VC_MyWalletImage = @"tw_left_wdqb";
    self.Left_VC_SecurityCenterImage = @"tw_left_aqzx";
    self.Left_VC_MessageCenterImage = @"tw_left_xxzx";
    self.Left_VC_BuyHistoryImage = @"tw_left_tzjl";
    self.Left_VC_MyTableImage = @"tw_left_wdbb";
    self.Left_VC_SettingCenterImage = @"tw_left_szzx";
    self.Left_VC_BtnTitleColor = WHITE;
    
    self.Left_VC_CellBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.LeftCtrlCellTextColor = [UIColor colorWithHex:@"333333"];
    
    self.Left_VC_BtnBackgroundColor = CLEAR;
    self.leftBackViewImageColor = CLEAR;
    self.Left_VC_TopImage = IMAGE(@"jbbj");
    self.LeftControllerLineColor = [UIColor hexStringToColor:@"FFFFFF" andAlpha:0.5];
    
    
    // 长龙
    self.CO_buyBottomViewBtn = [UIColor colorWithHex:@"#FF870F"];
    self.CO_ScrMoneyNumBtnText = [UIColor colorWithHex:@"#FF870F"];
    self.CO_ScrMoneyNumViewBack = self.CO_Main_ThemeColorTwe;
    
    
    self.CO_LiveLot_BottomBtnBack = self.CO_Main_ThemeColorTwe;
    self.CO_LiveLot_CellLabelBack = [UIColor colorWithHex:@"#D2E4FF"];
    self.CO_LiveLot_CellLabelText = [UIColor colorWithHex:@"#076CD3"];
    
    self.CO_ChatRoomt_SendBtnBack = self.CO_Main_ThemeColorTwe;
    
    
    // 挑码助手
    self.CO_TM_HeadView = [UIColor colorWithHex:@"#F0F2F5"];
    self.CO_TM_HeadContentView = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_BackView = [UIColor colorWithHex:@"#F0F2F5"];
    self.CO_TM_Btn3TitleText = [UIColor colorWithHex:@"#333333"];
    self.CO_TM_Btn3Back = [UIColor colorWithHex:@"#E9F4FF"];
    self.CO_TM_Btn3BackSelected = [UIColor colorWithHex:@"#FF8610"];
    self.CO_TM_Btn3borderColor = self.CO_Main_ThemeColorTwe;
    self.CO_TM_smallBtnText = [UIColor colorWithHex:@"#333333"];
    self.CO_TM_smallBtnTextSelected = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_smallBtnborderColor = [UIColor colorWithHex:@"#999999"];
    self.CO_TM_smallBtnBackColor = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_smallBtnBackColorSelected = [UIColor colorWithHex:@"#FF8610"];
    
#pragma mark 支付相关
    self.CO_Pay_SubmitBtnBack = [UIColor colorWithHex:@"#FF8610"];
    
    
    self.OnlineBtnImage = @"tw_nav_online_kf";
    self.KeFuTopImageName = @"KeFuTop";
    self.ChatVcDeleteImage = @"cartclear_eye";
    
    self.ChangLongLblBorderColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.2];
    self.KJRLSelectCalendar4 = @"kjrq_xzlskj_selected";
    self.KJRLSelectCalendar2 = @"kjrq_xzkjrq_selected";
    self.AIShakeImageName = @"tw_ai_nor";
    self.confirmBtnTextColor = [UIColor whiteColor];
    self.ShareCopyBtnTitleColor = WHITE;
    self.PersonCountTextColor = [UIColor colorWithHex:@"eeeeee"];
    self.NextStepArrowImage = @"next_eye";
    self.OpenLotteryLblLayerColor = [UIColor colorWithHex:@"999999"];
    self.changLongEnableBtnBackgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    self.CartSimpleBottomViewDelBtnImage = @"tw_ic_delete";
    self.CO_BuyDelBtn = [UIColor colorWithHex:@"#333333"];;
    self.CartSimpleBottomViewDelBtnBackgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    self.CartSimpleBottomViewTopBackgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    
    
    self.loginHistoryTextColor = [UIColor colorWithHex:@"0076A3"];
    self.messageIconName = @"xiaoxizhongxin_eye";
    self.quanziLaBaImage = @"tw_circle_lb";
    self.xinshuiFollowBtnBackground = [UIColor colorWithHex:@"FB6A12"];
    self.LHDSBtnImage = @"xs_xf_yuan_六合大神";
    self.HomeViewBackgroundColor = [UIColor colorWithHex:@"#eff2f5"];
    self.OpenLotteryBottomNFullImage = @"img_red_eye";
    self.OpenLotteryBottomNormalImage = @"img_orange_eye";
    self.BuyLotteryQPDDZGrayImageName = @"buy_qp_ddz_eye";
    self.BuyLotteryQPBJLGrayImageName = @"buy_qp_bjl_eye";
    self.BuyLotteryQPSLWHGrayImageName = @"buy_qp_slwh_eye";
    self.BuyLotteryQPBRNNGrayImageName = @"buy_qp_brnn_eye";
    self.BuyLotteryQPWRZJHGrayImageName = @"buy_qp_wrzjh_eye";
    self.BuyLotteryQPXLCHGrayImageName = @"buy_qp_xlch_eye";
    self.AoZhouLotterySwitchBtnImage = @"icon_qhms";
    self.AoZhouLotterySwitchBtnTitleColor = [UIColor colorWithHex:@"FF8610"];
    self.bottomDefaultImageName = @"img_darkgrey_eye";
    self.ChangLongRightBtnTitleNormalColor = self.CO_Main_ThemeColorOne;
    self.ChangLongRightBtnSubtitleNormalColor = self.CO_Main_ThemeColorOne;
    self.ChangLongRightBtnBackgroundColor = self.CO_Main_ThemeColorTwe;
    self.AoZhouScrollviewBackgroundColor = CLEAR;
    self.AoZhouMiddleBtnNormalBackgroundColor = [UIColor colorWithHex:@"F0F0F0"];
    self.AoZhouMiddleBtnSelectBackgroundColor = [UIColor colorWithHex:@"#FF870F"];
    self.AoZhouLotterySeperatorLineColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.4];
    self.AoZhouLotteryBtnTitleSelectColor = [UIColor colorWithHex:@"FFFFFF"];
    self.AoZhouLotteryBtnSelectBackgroundColor = [UIColor colorWithHex:@"5DADFF"];
    self.AoZhouLotteryBtnSelectSubtitleColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.8];
    self.AoZhouLotteryBtnTitleNormalColor = [UIColor colorWithHex:@"333333"];
    self.AoZhouLotteryBtnNormalBackgroundColor = [UIColor colorWithHex:@"E9F4FF" ];
    self.AoZhouLotteryBtnNormalSubtitleColor = [UIColor colorWithHex:@"999999"];
    self.Buy_HomeView_BackgroundColor = self.CO_Main_ThemeColorOne;
    self.ChangLongTitleColor = [UIColor colorWithHex:@"#333333"];
    self.ChangLongTimeLblColor = [UIColor colorWithHex:@"#EB0E24"];
    self.ChangLongTotalLblColor = [UIColor colorWithHex:@"28E223"];
    self.ChangLongIssueTextColor = [UIColor colorWithHex:@"888888"];
    self.ChangLongKindLblTextColor = [UIColor colorWithHex:@"888888"];
    self.ChangLongResultLblColor = [UIColor colorWithHex:@"FFC145"];
    
    
    self.CO_GD_SelectedTextNormal = [UIColor colorWithHex:@"#f7e222"];
    self.CO_GD_SelectedTextSelected = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_GD_Title_BtnBackSelected = self.CO_Main_ThemeColorTwe;
    
    self.WechatLoginImageName = @"tw_login_wx";
    self.QQLoginImageName = @"tw_login_QQ";
    self.xxncCheckBtnBackgroundColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.6];
    self.xxncImageName = @"tw_login_xgnc";
    self.ForgetPsdWhiteBackArrow = @"tw_login_back_white";
    self.LoginWhiteClose = @"tw_login_close";
    self.MimaEye = @"tw_login_mima";
    self.NicknameEye = @"tw_login_nickname";
    self.CodeEye = @"tw_login_code";
    self.InviteCodeEye = @"tw_login_invitecode";
    self.AccountEye = @"tw_login_account";
    self.ForgetPsdTitleTextColor = [UIColor colorWithHex:@"444444"];
    self.ForgetPsdBackgroundImage = @"tw_login_wjmm";
    self.LoginForgetPsdTextColor = [UIColor colorWithHex:@"999999"];
    self.RegistNoticeTextColor = [UIColor colorWithHex:@"#E44646"];
    self.RegistBackgroundImage = @"tw_login_zcbj";
    self.LoginBackgroundImage = @"tw_login_dlbj";
    self.LoginBtnBackgroundcolor = self.CO_Main_ThemeColorTwe;
    self.LoginBoardColor = [UIColor colorWithHex:@"#EEEEEE"];
    self.LoginSureBtnTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.LoginLinebBackgroundColor = [UIColor colorWithHex:@"BBBBBB"];
    self.LoginTextColor = [UIColor colorWithHex:@"666666"];
    self.QicCiDetailSixheadTitleColor = [UIColor colorWithHex:@"333333"];
    self.QiCiXQSixHeaderSubtitleTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.chongqinheadBackgroundColor = self.CO_Main_ThemeColorOne;
    self.QiCiDetailInfoColor = [UIColor colorWithHex:@"#FF8610"];
    self.QiCiDetailTitleColor = [UIColor colorWithHex:@"#333333"];
    self.QiCiDetailLineBackgroundColor = [UIColor colorWithHex:@"#D6D6D6"];
    self.QiCiDetailCellBackgroundColor = self.CO_Main_ThemeColorOne;
    self.CO_OpenLotHeaderInSectionView = [UIColor colorWithHex:@"#999999"];
    self.SixOpenHeaderSubtitleTextColor = [UIColor colorWithHex:@"#999999"];
    self.PK10_color1 = [UIColor colorWithHex:@"D542BB"];
    self.PK10_color2 = [UIColor colorWithHex:@"2F90DF"];
    self.PK10_color3 = [UIColor colorWithHex:@"FAB825"];
    self.PK10_color4 = [UIColor colorWithHex:@"11C368"];
    self.PK10_color5 = [UIColor colorWithHex:@"A36D55"];
    self.PK10_color6 = [UIColor colorWithHex:@"EF3C34"];
    self.PK10_color7 = [UIColor colorWithHex:@"66DBDD"];
    self.PK10_color8 = [UIColor colorWithHex:@"FF8244"];
    self.PK10_color9 = [UIColor colorWithHex:@"4EA3D9"];
    self.PK10_color10 = [UIColor colorWithHex:@"7060D1"];
    
    self.BuyLotteryZCjczqGrayImageName = @"zc_jczq";
    self.BuyLotteryZCjclqGrayImageName = @"zc_jclq";
    self.BuyLotteryZCzqsscGrayImageName = @"zc_zq14c";
    self.BuyLotteryZCrxjcGrayImageName = @"zc_rx9c";
    self.BuyLotteryQPdzGrayImageName = @"qp_dzpk_eye";
    self.BuyLotteryQPerBaGangGrayImageName = @"qp_ebg_eye";
    self.BuyLotteryQPqznnGrayImageName = @"qp_qznn_eye";
    self.BuyLotteryQPzjhGrayImageName = @"qp_zjh_eye";
    self.BuyLotteryQPsgGrayImageName = @"buy_qp_sg_eye";
    self.BuyLotteryQPyzlhGrayImageName = @"qp_yzlh_eye";
    self.BuyLotteryQPesydGrayImageName = @"buy_qp_21d_eye";
    self.BuyLotteryQPtbnnGrayImageName = @"qp_tbnn_eye";
    self.BuyLotteryQPjszjhGrayImageName = @"qp_jszjh_eye";
    self.BuyLotteryQPqzpjGrayImageName = @"qp_qzpj_eye";
    self.BuyLotteryQPsssGrayImageName = @"qp_sss_eye";
    self.BuyLotteryQPxywzGrayImageName = @"qp_xxwz_eye";
    self.CartSectionLineColor = [UIColor colorWithHex:@"#D6D6D6" Withalpha:0.5];
    
    
    self.SixGreenBallName = @"kj_sixgreen";
    self.SixBlueBallName = @"kj_sixblue";
    self.SixRedBallName = @"kj_sixred";
    self.SscBlueBallName = @"dlt_lsq";
    self.SscBallName = @"azact";
    self.PostCircleImageName = @"postcircle_white";
    self.PostCircleImage = IMAGE(@"postcircle_white");
    self.CircleUserCenterMiddleBtnBackgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.CircleUderCenterTopImage = IMAGE(@"jbbj");
    self.ApplyExpertPlaceholdColor = [UIColor colorWithHex:@"999999"];
    self.CO_Account_Info_BtnBack = self.CO_Main_ThemeColorTwe;
    self.ApplyExpertConfirmBtnTextColor = self.CO_Main_ThemeColorOne;
    self.applyExpertBackgroundColor = [UIColor colorWithHex:@"#F1F3F5"];
    self.ExpertInfoTextColorA = [UIColor colorWithHex:@"dddddd"];
    self.ExpertInfoTextColorB = [UIColor colorWithHex:@"FFFFFF"];
    self.WFSMImage = @"WFSMImage_eye";
    
    self.PrizeMessageTopbackViewTextColor = BLACK;
    self.CO_Home_Gonggao_TopBackViewStatus1 = [UIColor colorWithHex:@"B8B8B8"];
    self.CO_Home_Gonggao_TopBackViewStatus2 = self.CO_Main_ThemeColorTwe;
    self.GraphSetViewBckgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.XSTJSearchImage = @"XSTJSearchImage_eye";
    self.XSTJMyArticleImage = IMAGE(@"XSTJMyArticleImage_eye");
    
    
    
    self.TouZhuImage = IMAGE(@"xf_touzhu_button");
    
    
    self.AppFistguideUse1 = @"app_guide_1";
    self.AppFistguideUse2 = @"app_guide_2";
    self.AppFistguideUse3 = @"app_guide_3";
    self.registerVcPhotoImage = IMAGE(@"tw_login_registerVcPhotoImage");
    self.registerVcCodeImage = IMAGE(@"tw_login_registerVcCodeImage");
    self.registerVcPSDImage = IMAGE(@"tw_login_registerVcPSDImage");
    self.registerVcPSDAgainImage = IMAGE(@"registerVcPSDImage");
    self.registerVcInviteImage = IMAGE(@"tw_login_registerVcInviteImage");
    self.registerVcRegisterBtnBTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.registerVcRegisterBtnBckgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.LoginVcHiddenImage = IMAGE(@"tw_login_showPassword");
    self.LoginVcHiddenSelectImage = IMAGE(@"tw_login_hiddenPassword");
    self.LoginVcPhoneImage = IMAGE(@"tw_login_VcPhoneImage");
    self.loginVcQQimage = IMAGE(@"loginVcQQimage");
    self.loginVcWechatimage = IMAGE(@"loginVcWechatimage");
    self.loginLineBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.logoIconImage = IMAGE(@"");
    self.loginVcBgImage = IMAGE(@"loginBackgroundImage_eye");
    self.shareToLblTextColor = [UIColor colorWithHex:@"000000"];
    self.shareVcCopyBtnBackgroundColor = self.CO_Main_ThemeColorTwe;
    self.shareVcQQImage = IMAGE(@"me_qq");
    self.shareVcPYQImage = IMAGE(@"shareVcPYQImage_eye");
    self.shareVcWeChatImage = IMAGE(@"wx");
    self.shareLineImage = IMAGE(@"shareLineImage");
    self.OpenLotteryTimeLblTextColor = [UIColor colorWithHex:@"#FF001B"];
    self.CO_GD_TopBackgroundColor = [UIColor colorWithHex:@"#4a71c7"];
    self.CO_GD_TopBackHeadTitle = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_GD_AllPeople_BtnText = [UIColor colorWithHex:@"#333333"];
    
    self.IM_GD_DashenTableImgView = IMAGE(@"tw_gd_topback");
    
    self.expertContentLblTextcolor = [UIColor colorWithHex:@"EEEEEE"];
    self.expertWinlblTextcolor = WHITE;
    self.expertInfoTopImgView = IMAGE(@"jbbj");
    self.circleListDetailViewBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.IM_CircleDetailHeadImage = IMAGE(@"tw_circle_topback");
    self.MyWalletBankCartImage = IMAGE(@"td_me_wdqb_cell_cart");
    
    self.accountInfoNicknameTextColor = [UIColor colorWithHex:@"333333"];
    self.CO_MoneyTextColor = [UIColor colorWithHex:@"#FF870F"];
    self.accountInfoTopViewBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    
    
    self.shareInviteImage = IMAGE(@"shareInviteImage_eye");
    self.shareMainImage = IMAGE(@"tw_me_fxhyback");
    self.shareBackImage = IMAGE(@"tw_me_fxhy_bsbj");
    self.calendarLeftImage = IMAGE(@"kj_left");
    self.calendarRightImage = IMAGE(@"kj_right");
    self.calendarBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.KJRLSelectBackgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.IM_CalendarTopImage = IMAGE(@"tw_kj_kjrl");
    
    self.LHTKTextfieldBackgroundColor = [UIColor colorWithHex:@"E6E6E6"];
    self.LHTKRemarkTextFeildBorderColor = CLEAR;
    self.XSTJdetailZanImage = IMAGE(@"tw_xs_zan");
    self.attentionViewCloseImage = IMAGE(@"closeAttention_eye");
    self.backBtnImageName = @"tw_nav_return";
    self.HobbyCellImage = IMAGE(@"勾选_eye");
    
#pragma mark  六合图库
    self.CO_LHTK_SubmitBtnBack = self.CO_Main_ThemeColorTwe;
    
    
    self.mine_seperatorLineColor = CLEAR;
    self.openPrizePlusColor = [UIColor colorWithHex:@"#999999"];
    self.OpenPrizeWuXing = [UIColor colorWithHex:@"D6CFFF"];
    
    self.circleHomeCell1Bgcolor = @"circleHomeCell1";
    self.circleHomeCell2Bgcolor = @"circleHomeCell1";
    self.circleHomeCell3Bgcolor = @"circleHomeCell1";
    self.circleHomeCell4Bgcolor = @"circleHomeCell1";
    self.circleHomeCell5Bgcolor = @"circleHomeCell1";
    self.circleHomeSDQImageName = @"cirlceHomeSDQ";
    self.circleHomeGDDTImageName = @"cirlceHomeGDDT";
    self.circleHomeXWZXImageName = @"cirlceHomeXWZX";
    self.circleHomeDJZXImageName = @"cirlceHomeDJZX";
    self.circleHomeZCZXImageName = @"cirlceHomeZCZX";
    
    
    self.circleHomeBgImage = IMAGE(@"circleHomeBgImage");
    
    
    
    self.xinshuiDetailAttentionBtnNormalGroundColor = BASECOLOR;
    self.pushDanBarTitleSelectColot = BASECOLOR;
    self.pushDanSubBarNormalTitleColor = [UIColor colorWithHex:@"666666"];
    self.pushDanSubBarSelectTextColor = [UIColor colorWithHex:@"0076A3"];
    
    self.pushDanSubbarBackgroundcolor = [UIColor colorWithHex:@"EEEEEE"];
    self.CO_LongDragon_PushSetting_BtnBack = self.CO_Main_ThemeColorTwe;
    self.pushDanBarTitleNormalColor = [UIColor colorWithHex:@"EEEEEE"];
    self.CO_Circle_Cell2_TextLabel_BackgroundC = [UIColor colorWithHex:@"9e353c"];
    self.CO_Circle_Cell2_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"9e353c"];
    self.CO_Circle_Cell3_TextLabel_BackgroundC = [UIColor colorWithHex:@"647e24"];
    self.CO_Circle_Cell1_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"5649b3"];
    self.bettingBtnColor = WHITE;
    self.xinshuiDetailAttentionBtnBackGroundColor = MAINCOLOR;
    self.LoginNamePsdPlaceHoldColor = [UIColor colorWithHex:@"BBBBBB"];
    self.missCaculateBarNormalBackground = [UIColor colorWithHex:@"EEEEEE"];
    self.missCaculateBarselectColor = BASECOLOR;
    self.missCaculateBarNormalColor = WHITE;
    self.openLotteryCalendarBackgroundcolor = [UIColor colorWithHex:@"F7F7F7"];
    self.openLotteryCalendarTitleColor = [UIColor colorWithHex:@"EEEEEE"];
    self.openLotteryCalendarWeekTextColor = [UIColor colorWithHex:@"666666"];
    self.CO_OpenLot_BtnBack_Normal = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_OpenLot_BtnBack_Selected = self.CO_Main_ThemeColorTwe;
    self.CO_Home_Gonggao_TopTitleText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_Gonggao_Cell_MessageTopViewBack = self.CO_Main_ThemeColorTwe;
    self.KeyTitleColor = [UIColor colorWithHex:@"e76c29"];
    
    self.CO_Circle_TitleText = [UIColor colorWithHex:@"999999"];
    
    self.xinshuiRemarkTitleColor = WHITE;
    self.sixHeTuKuRemarkbarBackgroundcolor = WHITE;
    self.myCircleUserMiddleViewBackground = [UIColor colorWithHex:@"2C3036"];
    self.openCalendarTodayColor = [UIColor colorWithHex:@"#529DFF"];
    self.openCalendarTodayViewBackground = [UIColor colorWithHex:@"#FF9000"];
    self.LoginNamePsdTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.MineTitleStrColor = [UIColor colorWithHex:@"FFFFFF"];
    self.MessageTitleColor  = WHITE;
    
    self.xinshuiBottomViewTitleColor = WHITE;
    self.CO_KillNumber_LabelText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_KillNumber_LabelBack = self.CO_Main_ThemeColorTwe;
    
    self.TopUpViewTopViewBackgroundcolor = CLEAR;
    self.chargeMoneyLblSelectColor = [UIColor colorWithHex:@"FFFFFF"];
    self.chargeMoneyLblSelectBackgroundcolor = [UIColor colorWithHex:@"#FF8610"];
    self.chargeMoneyLblNormalColor = [UIColor colorWithHex:@"C48936"];
    self.tabbarItemTitleColor = [UIColor lightGrayColor];
    
    
    self.RootVC_ViewBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.tabbarItemTitleColor = [UIColor lightGrayColor];
    self.CO_Circle_Cell3_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"6d872f"];
    self.CO_Circle_Cell4_TextLabel_BackgroundC = [UIColor colorWithHex:@"3ea358"];
    self.CO_Circle_Cell4_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"3ea358"];
    self.tixianShuoMingColor = [UIColor colorWithHex:@"0076A3"];
    
    self.CircleVC_HeadView_BackgroundC = CLEAR;
    self.CO_Circle_Cell_BackgroundC = [UIColor colorWithHex:@"f0f2f5"];
    self.CO_Circle_Cell_TextLabel_BackgroundC = [UIColor colorWithHex:@"333333"];
    self.CO_Circle_Cell_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"999999"];
    
    
    self.CartBarBackgroundColor = self.CO_Main_ThemeColorOne;
    self.CartBarTitleNormalColor = [UIColor colorWithHex:@"#333333"];
    self.CartBarTitleSelectColor = [UIColor colorWithHex:@"FF8610"];
    self.CartHomeHeaderSeperatorColor = [UIColor colorWithHex:@"ff9711"];
    self.genDanHallTitleNormalColr = [UIColor colorWithHex:@"FFFFFF"];
    self.genDanHallTitleSelectColr = [UIColor colorWithHex:@"FFEA01"];;
    self.genDanHallTitleBackgroundColor = [UIColor colorWithHex:@"#4a71c7"];
    self.gongShiShaHaoFormuTitleNormalColor = [UIColor colorWithHex:@"333333"];
    self.gongShiShaHaoFormuTitleSelectColor = BASECOLOR;
    self.gongshiShaHaoFormuBtnBackgroundColor = BLACK;
    
    
    
    self.OpenLotteryVC_ColorLabs_TextC = [UIColor colorWithHex:@"#FF8610"];
    self.OpenLotteryVC_ColorLabs1_TextC = [UIColor colorWithHex:@"#333333"];
    self.OpenLotteryVC_SubTitle_TextC = [UIColor colorWithHex:@"#999999"];
    self.OpenLotteryVC_SubTitle_BorderC = [UIColor colorWithHex:@"8D8D8D"];
    self.OpenLotteryVC_Cell_BackgroundC = [UIColor colorWithHex:@"3a3b3f"];
    self.OpenLotteryVC_View_BackgroundC = [UIColor colorWithHex:@"F0F2F5"];
    self.CO_LongDragonCell = self.CO_Main_ThemeColorOne;
    self.OpenLotteryVC_TitleLabs_TextC = [UIColor colorWithHex:@"333333"];
    self.OpenLotteryVC_SeperatorLineBackgroundColor = [UIColor colorWithHex:@"#D6D6D6" Withalpha:0.5];
    self.CO_OpenLetBtnText_Normal = [UIColor colorWithHex:@"333333"];
    self.SixRecommendVC_View_BackgroundC = [UIColor colorWithHex:@"f4f4f4"];
    self.MineVC_Btn_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    
    self.HobbyVC_MessLab_BackgroundC = [UIColor colorWithHex:@"EEEEEE"];
    self.HobbyVC_MessLab_TextC = [UIColor colorWithHex:@"333333"];
    self.HobbyVC_View_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.HobbyVC_OKButton_BackgroundC = [UIColor colorWithHex:@"0076A3"];
    self.HobbyVC_OKButton_TitleBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Circle_Title_nameColor = [UIColor colorWithHex:@"333333"];
    self.HobbyVC_SelButton_TitleBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.HobbyVC_UnSelButton_TitleBackgroundC = [UIColor colorWithHex:@"999999"];
    self.CO_Circle_Cell1_TextLabel_BackgroundC = self.CO_Circle_Cell_TextLabel_BackgroundC;
    self.HobbyVC_SelButton_BackgroundC = [UIColor colorWithHex:@"0076A3"];
    self.HobbyVC_UnSelButton_BackgroundC = [UIColor colorWithHex:@"DDDDDD"];
    self.Circle_View_BackgroundC = [UIColor colorWithHex:@"#f0f2f5"];
    self.Circle_HeadView_Title_UnSelC = [UIColor colorWithHex:@"999999"];
    self.Circle_HeadView_Title_SelC = [UIColor colorWithHex:@"333333"];
    self.Circle_HeadView_BackgroundC = [UIColor colorWithHex:@"#1e4c7d"];
    self.Circle_HeadView_NoticeView_BackgroundC = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.2];
    self.Circle_HeadView_GuangBo_BackgroundC = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.8];
    self.Circle_Cell_BackgroundC = [UIColor colorWithHex:@"F7F7F7"];
    self.Circle_Cell_ContentlabC = [UIColor colorWithHex:@"666666"];
    self.Circle_Cell_Commit_BackgroundC = [UIColor colorWithHex:@"F7F7F7"];
    self.Circle_Cell_Commit_TitleC = [UIColor colorWithHex:@"666666"];
    self.Circle_Cell_AttentionBtn_TitleC = [UIColor colorWithHex:@"CFA753"];
    self.Circle_Line_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Circle_remark_nameColor = [UIColor colorWithHex:@"4e79c2"];
    self.getCodeBtnvBackgroundcolor = [UIColor colorWithHex:@"dddddd"];
    self.Circle_FooterViewLine_BackgroundC = [UIColor colorWithHex:@"dddddd" Withalpha:0.9];
    self.OpenLottery_S_Cell_BackgroundC = CLEAR;//[UIColor colorWithHex:@"8483F0"];
    self.OpenLottery_S_Cell_TitleC = [UIColor colorWithHex:@"333333"];
    self.Login_NamePasswordView_BackgroundC = CLEAR;//[UIColor colorWithHex:@"2c2e36"];
    self.Login_ForgetSigUpBtn_BackgroundC = [UIColor colorWithHex:@"2c2e36" Withalpha:0.5];
    self.Login_ForgetSigUpBtn_TitleC = [UIColor colorWithHex:@"DDDDDD"];
    self.Login_LogoinBtn_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Login_LogoinBtn_TitleC = [UIColor colorWithHex:@"0076A3"];
    self.Buy_LotteryMainBackgroundColor = [UIColor colorWithHex:@"1B1E23"];
    self.RootWhiteC = [UIColor colorWithHex:@"f4f4f4"];
    self.CO_OpenLetBtnText_Selected = [UIColor colorWithHex:@"FFFFFF"];
    self.loginSeperatorLineColor = [UIColor colorWithHex:@"EEEEEE"];
    self.getCodeBtnvTitlecolor = [UIColor colorWithHex:@"#888888"];
    self.LiuheTuKuLeftTableViewBackgroundColor = [UIColor colorWithHex:@"e0e0e0"];
    self.LiuheTuKuOrangeColor = self.CO_Main_ThemeColorTwe;
    self.LiuheTuKuLeftTableViewSeperatorLineColor = [UIColor colorWithHex:@"c2c2c2"];
    self.LiugheTuKuTopBtnGrayColor = [UIColor colorWithHex:@"dddddd"];
    self.LiuheTuKuProgressValueColor = [UIColor colorWithHex:@"0076A3"];
    self.LiuheTuKuTouPiaoBtnBackgroundColor = [UIColor colorWithHex:@"c60000"];
    self.LiuheDashendBackgroundColor = self.CO_Main_ThemeColorOne;
    
    self.xinShuiReconmentGoldColor = [UIColor colorWithHex:@"FFFFFF"];
    self.xinShuiReconmentRedColor = self.CO_Main_ThemeColorTwe;
    self.TouPiaoContentViewTopViewBackground = [UIColor colorWithHex:@"16171b"];
    self.LiuheTuKuRemarkBarBackgroundColor = [UIColor colorWithHex:@"16171b"];
    self.LiuheTuKuRemarkSendBackgroundColor = self.CO_Main_ThemeColorTwe;
    self.LiuheTuKuTextRedColor = self.CO_Main_ThemeColorTwe;
    self.XinshuiRecommentScrollBarBackgroundColor = [UIColor colorWithHex:@"f0f0f0"];
    self.xinshuiBottomVeiwSepeLineColor = [UIColor whiteColor];
    self.Circle_Post_titleSelectColor = [UIColor colorWithHex:@"#fff100"];
    self.Circle_Post_titleNormolColor = [UIColor colorWithHex:@"#d4d2cf"];
    
#pragma mark 购彩
    //购彩
    self.Buy_HeadView_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_HeadView_Footer_BackgroundC = [UIColor colorWithHex:@"F0F0F0"];
    self.Buy_HeadView_Title_C = [UIColor colorWithHex:@"333333"];
    self.Buy_HeadView_historyV_Cell1_C = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_HeadView_historyV_Cell2_C = [UIColor colorWithHex:@"F0F0F0"];
    
    self.Buy_LeftView_BackgroundC = CLEAR;//[UIColor colorWithHex:@"0076A3"];
    self.Buy_LeftView_Btn_BackgroundUnSel = IMAGE(@"FY_Buy_LeftView_Btn_BackgroundUnSel");
    self.Buy_LeftView_Btn_BackgroundSel = IMAGE(@"FY_Buy_LeftView_Btn_BackgroundSel");
    self.Buy_LeftView_Btn_TitleSelC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_LeftView_Btn_TitleUnSelC = [UIColor colorWithHex:@"333333"];
    self.Buy_LeftView_Btn_PointUnSelC = [UIColor colorWithHex:@"5DADFF"];
    self.Buy_LeftView_Btn_PointSelC = [UIColor colorWithHex:@"01ae00"];
    self.Buy_RightBtn_Title_UnSelC = [UIColor colorWithHex:@"333333"];
    self.Buy_RightBtn_Title_SelC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionHeadV_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionHeadV_ViewC = [UIColor colorWithHex:@"ff5d12"];
    self.CO_Bottom_LabelText = [UIColor colorWithHex:@"#333333"];
    
    self.Buy_CollectionCellButton_BackgroundSel = [UIColor colorWithHex:@"5DADFF"];
    self.Buy_CollectionCellButton_BackgroundUnSel = CLEAR;
    self.Buy_CollectionCellButton_TitleCSel = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionCellButton_TitleCUnSel = [UIColor colorWithHex:@"333333"];
    self.Buy_CollectionCellButton_SubTitleCSel = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionCellButton_SubTitleCUnSel = [UIColor colorWithHex:@"999999"];
    self.Buy_CollectionViewLine_C = [UIColor colorWithHex:@"D6D6D6"];
    
    self.CO_BuyLot_HeadView_LabelText = [UIColor colorWithHex:@"666666"];
    self.CO_BuyLot_HeadView_Label_border = [UIColor colorWithHex:@"999999"];
    self.CO_BuyLot_Right_bcViewBack = [UIColor colorWithHex:@"E9F4FF"];
    self.CO_BuyLot_Right_bcView_border = [UIColor colorWithHex:@"BBBBBB"];
    
    
    self.CartHomeSelectSeperatorLine = [UIColor colorWithHex:@"ff9711"];
    
    self.grayColor999 = [UIColor colorWithHex:@"999999"];
    self.grayColor666 = [UIColor colorWithHex:@"666666"];
    self.grayColor333 = [UIColor colorWithHex:@"333333"];
    self.Mine_rightBtnTileColor = [UIColor colorWithHex:@"FFFFFF"];
    self.Mine_priceTextColor = [UIColor colorWithHex:@"FFE955"];
    self.ChangePsdViewBackgroundcolor = [UIColor colorWithHex:@"F7F7F7"];
    self.CO_Me_MyWallerBalance_MoneyText = [UIColor colorWithHex:@"#FFEA00"];
    self.CO_Me_MyWallerBalanceText = [UIColor colorWithHex:@"FFFFFF"];
    self.MyWalletTotalBalanceColor = [UIColor colorWithHex:@"fff666"];
    self.mineInviteTextCiolor = [UIColor colorWithHex:@"888888"];
    self.CO_Me_MyWallerTitle = [UIColor colorWithHex:@"#E9E9E9"];
#pragma mark 番摊紫色
    self.NN_LinelColor = [UIColor colorWithHex:@"D6D6D6"];
    self.NN_xian_normalColor = [UIColor colorWithHex:@"565964"];
    self.NN_xian_selColor = [UIColor colorWithHex:@"8F601E"];
    self.NN_zhuang_normalColor = [UIColor colorWithHex:@"5140A1"];
    self.NN_zhuang_selColor = [UIColor colorWithHex:@"905F1B"];
    self.NN_Xian_normalImg = @"xianjia-gray_1";
    self.NN_Xian_selImg = @"xianjia-color_1";
    self.NN_zhuang_normalImg = @"zhuang_normal";
    self.NN_zhuang_selImg = @"zhuangjia-color_1";
    
    self.NN_XianBgImg = [UIImage imageNamed:@"xianjia-xuanzhong"];
    self.NN_XianBgImg_sel = [UIImage imageNamed:@"xianjia"];
    self.Buy_NNXianTxColor_normal = [UIColor colorWithHex:@"0E2B20"];
    self.Buy_NNXianTxColor_sel = [UIColor whiteColor];
    self.Fantan_headerLineColor = [UIColor colorWithHex:@"1F5C73"];
    self.Fantan_historyHeaderBgColor = [UIColor colorWithHex:@"8D7FE9"];
    self.Fantan_historyHeaderLabColor = [UIColor colorWithHex:@"333333"];
    self.Fantan_historycellColor1 = [UIColor colorWithHex:@"333333"];
    self.Fantan_historycellColor2 = [UIColor colorWithHex:@"D6D6D6"];
    self.Fantan_historycellColor3 = [UIColor colorWithHex:@"FFD116"];
    self.Fantan_historycellOddColor = [UIColor colorWithHex:@"AAA2F1"];
    self.Fantan_historycellEvenColor = [UIColor colorWithHex:@"9B8DE9"];
    self.CO_Fantan_HeadView_Label = [UIColor colorWithHex:@"666666"];
    
    self.RedballImg_normal = @"lessredball";
    self.RedballImg_sel = @"redball";
    self.BlueballImg_normal = @"lesswhiteball";
    self.BlueballImg_sel = @"blueball";
    
    self.Fantan_MoneyColor = [UIColor colorWithHex:@"FF8610"];
    self.Fantan_CountDownBoderColor = [UIColor colorWithHex:@"999999"];
    self.Fantan_CountDownBgColor = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_fantanTimeColor = [UIColor colorWithHex:@"FF9F0F"];
    self.Fantan_DelImg = IMAGE(@"cartclear_1");
    self.Fantan_ShakeImg = IMAGE(@"cartrandom_1");
    self.Fantan_AddToBasketImg = IMAGE(@"cartset_1");
    self.Fantan_basketImg = IMAGE(@"cart_1");
    
    self.Fantan_FloatImgUp = IMAGE(@"buy_up_1");
    self.Fantan_FloatImgDown = IMAGE(@"buy_down_1");
    self.Fantan_AddImg = IMAGE(@"tw_add");
    self.Fantan_JianImg = IMAGE(@"tw_jianhao");
    self.Fantan_SpeakerImg = IMAGE(@"buy_music_1");
    self.Buy_fantanBgColor = [UIColor colorWithHex:@"2d2f37"];
    //    self.Buy_fantanCellBgColor = [UIColor colorWithHex:@"715FE3"];
    self.Buy_fantanCellBgColor = [UIColor colorWithHex:@"FFFFFF"];;
    self.Fantan_iconColor = [UIColor colorWithHex:@"FFD116"];
    self.FantanColor1 = [UIColor colorWithHex:@"5DADFF"];
    self.FantanColor2 = [UIColor colorWithHex:@"5DADFF"];
    self.FantanColor3 = [UIColor colorWithHex:@"F0F0F0"];
    self.FantanColor4 = [UIColor colorWithHex:@"F0F0F0"];
    self.Fantan_textFieldColor = self.CO_Main_ThemeColorOne;
    self.CO_Fantan_textFieldTextColor = [UIColor colorWithHex:@"FF8610"];
    self.CO_BuyLotBottomView_TopView3_BtnText = [UIColor colorWithHex:@"333333"];
    self.CO_BuyLotBottomView_BotView2_BtnBack = [UIColor colorWithHex:@"FF8610"];
    self.Fantan_tfPlaceholdColor = [UIColor colorWithHex:@"#808080"];
    self.CO_Buy_textFieldText = [UIColor colorWithHex:@"#333333"];
    self.Fantan_labelColor = [UIColor colorWithHex:@"#333333"];
    self.blackOrWhiteColor = [UIColor colorWithHex:@"000000"];
    self.MyWallerBalanceBottomViewColor = [UIColor colorWithHex:@"e9e9e9"];
    
}



#pragma mark - LitterFish_whiteTheme 白色版
- (void)LitterFish_whiteTheme {
    
    self.CO_Main_ThemeColorOne = [UIColor colorWithHex:@"FFFFFF"];   // 主题色1;  白色
    self.CO_Main_ThemeColorTwe = [UIColor colorWithHex:@"0EC99B"];   // 主题色2;
    self.CO_Main_LineViewColor = [UIColor colorWithHex:@"#CCCCCC"];   // 线条颜色
    self.CO_Main_LabelNo1 = [UIColor colorWithHex:@"#333333"];
    self.CO_Main_LabelNo2 = [UIColor colorWithHex:@"#CCCCCC"];
    self.CO_Main_LabelNo3 = [UIColor colorWithHex:@"#FFFFFF"];
    
    
    /// ****** TabBar ******
    self.IC_TabBar_Home = @"tw_tab_home";
    self.IC_TabBar_Home_Selected = @"tw_tab_home_selected";
    self.IC_TabBar_KJ_ = @"tw_tab_kj";
    self.IC_TabBar_KJ_Selected = @"tw_tab_kj_selected";
    self.IC_TabBar_GC = @"tw_tab_gc";
    self.IC_TabBar_GC_Selected = @"tw_tab_gc";
    self.IC_TabBar_QZ = @"tw_tab_qz";
    self.IC_TabBar_QZ_Selected = @"tw_tab_qz_selected";
    self.IC_TabBar_Me = @"tw_tab_me";
    self.IC_TabBar_Me_Selected = @"tw_tab_me_selected";
    self.CO_TabBarTitle_Normal = [UIColor colorWithHex:@"666666"];
    self.CO_TabBarTitle_Selected = [UIColor colorWithHex:@"0EC99B"];
    self.CO_TabBarBackground = [UIColor colorWithHex:@"FFFFFF"];
    
    
    /// ****** Nav ******
    self.CO_Nav_Bar_NativeViewBack = [UIColor colorWithHex:@"#0EC99B"];
    self.CO_NavigationBar_TintColor = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_NavigationBar_Title = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Nav_Bar_CustViewBack = self.CO_Main_ThemeColorTwe;   // 主题色2
    
    self.IM_Nav_TitleImage_Logo = IMAGE(@"tw_nav_hometitle_logo");
    self.IC_Nav_ActivityImageStr = @"tw_activity_icon";
    self.IC_Nav_SideImageStr = @"tw_menu_icon";
    self.IC_Nav_CircleTitleImage = @"tw_nav_circle_center";
    self.IC_Nav_Setting_Icon = @"tw_nav_setting_gear";
    self.IC_Nav_Setting_Gear = @"td_nav_setting";
    self.IC_Nav_Kefu_Text = @"tw_nav_online_kf";
    
#pragma mark Home
    
    
    self.CO_Home_VC_NoticeView_Back = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_VC_NoticeView_LabelText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_NoticeView_LabelText = [UIColor colorWithHex:@"#4D4D4D"];
    self.CO_Home_CellCartCellSubtitleText = [UIColor colorWithHex:@"#999999"];
    self.CO_Home_VC_HeadView_Back = CLEAR;
    self.CO_Home_NewsTopViewBack = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Home_NewsBgViewBack = [UIColor colorWithHex:@"#eff2f5"];
    self.CO_Home_News_LineView = [UIColor colorWithHex:@"#CCCCCC"];
    self.CO_Home_News_HeadTitleText = [UIColor colorWithHex:@"#808080"];
    self.CO_Home_News_ScrollLabelText = [UIColor colorWithHex:@"#333333"];
    self.CO_Home_VC_HeadView_HotMessLabelText = [UIColor colorWithHex:@"#000000"];
    self.CO_Home_CollectionView_CartCellTitle = [UIColor colorWithHex:@"#333333"];
    self.CO_Home_VC_HeadView_NumbrLables_Text = [UIColor colorWithHex:@"FDFDFD"];
    self.CO_Home_News_HotHeadViewBack = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_VC_Cell_ViewBack = [UIColor colorWithHex:@"#eff2f5"];
    
    self.IM_Home_HeadlineImg = IMAGE(@"tw_CPT头条");
    self.CO_Home_HeadlineLabelText = [UIColor colorWithHex:@"#4D4D4D"];
    self.CO_Home_HeadlineLineView = [UIColor colorWithHex:@"#CCCCCC"];
    
    self.IM_Home_BottomBtnOne = IMAGE(@"tw_bottom_lxkf");
    self.IM_Home_BottomBtnTwo = IMAGE(@"tw_bottom_lts");
    self.IM_Home_BottomBtnThree = IMAGE(@"tw_bottom_wyb");
    
    self.CO_Home_VC_Cell_Titlelab_Text = [UIColor colorWithHex:@"333333"];
    self.CO_Home_VC_Cell_SubTitlelab_Text = [UIColor colorWithHex:@"#999999"];
    self.CO_Home_VC_ADCollectionViewCell_Back = CLEAR;
    self.CO_Home_CellBackgroundColor = [UIColor colorWithHex:@"#eff2f5"];
    self.CO_Home_CellContentView = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Home_VC_PCDanDan_ViewBack2 = [UIColor colorWithHex:@"FFFFFF"];
    
    self.CO_Home_VC_PCDanDan_line_ViewBack = [UIColor colorWithHex:@"999999"];
    
    self.CO_Home_SubHeaderTitleColor = [UIColor colorWithHex:@"333333"];;
    self.CO_Home_SubHeaderSubtitleColor = [UIColor colorWithHex:@"3B3A3C"];
    self.CO_Home_SubheaderTimeLblText = [UIColor colorWithHex:@"7f70dc"];;
    self.CO_Home_SubheaderLHCSubtitleText = self.KeyTitleColor;
    
    self.IC_Home_CQSSC = @"重庆时时彩";
    self.IC_Home_LHC = @"六合彩";
    self.IC_Home_BJPK10 = @"北京PK10";
    self.IC_Home_XJSSC = @"新疆时时彩";
    self.IC_Home_XYFT = @"幸运飞艇";
    self.IC_Home_TXFFC = @"比特币分分彩";
    self.IC_Home_PCDD = @"PC蛋蛋";
    self.IC_Home_ZCZX = @"足彩资讯";
    self.IC_Home_AZF1SC = @"六合彩";
    self.IC_Home_GDCZ = @"更多彩种";
    
    self.IC_Home_Icon_BeginName = @"tw_";
    
    
    self.IC_home_sub_SS = @"tw_home_sub_赛事";
    self.IC_home_sub_YC = @"tw_home_sub_预测";
    self.IC_home_sub_ZJ = @"tw_home_sub_专家";
    self.IC_home_sub_BF = @"tw_home_sub_比分";
    self.IC_home_sub_HMZS = @"tw_home_sub_号码走势";
    self.IC_home_sub_JRHM = @"tw_home_sub_今日号码";
    self.IC_home_sub_HMYL = @"tw_home_sub_号码遗漏";
    self.IC_home_sub_LRFX = @"tw_home_sub_冷热分析";
    self.IC_home_sub_GYHTJ = @"tw_home_sub_冠亚和统计";
    self.IC_home_sub_LMCL = @"tw_home_sub_两面长龙";
    self.IC_home_sub_LMLZ = @"tw_home_sub_两面路珠";
    self.IC_home_sub_LMYL = @"tw_home_sub_两面遗漏";
    self.IC_home_sub_QHLZ = @"tw_home_sub_前后路珠";
    self.IC_home_sub_LMLS = @"tw_home_sub_两面历史";
    self.IC_home_sub_GYHLZ = @"tw_home_sub_冠亚和路珠";
    self.IC_home_sub_HBZS = @"tw_home_sub_横版走势";
    self.IC_home_sub_History = @"tw_home_sub_历史开奖";
    self.IC_home_sub_XSTJ = @"tw_home_sub_免费推荐";
    self.IC_home_sub_LHTK = @"tw_home_sub_六合图库";
    self.IC_home_sub_CXZS = @"tw_home_sub_查询助手";
    self.IC_home_sub_ZXTJ = @"tw_home_sub_资讯统计";
    self.IC_home_sub_KJRL = @"tw_home_sub_开奖日历";
    self.IC_home_sub_GSSH = @"tw_home_sub_公式杀手";
    self.IC_home_sub_AIZNXH = @"tw_home_sub_AI智能选号";
    self.IC_home_sub_SXCZ = @"tw_home_sub_属性参考";
    self.IC_home_sub_TMLS = @"tw_home_sub_特码历史";
    self.IC_home_sub_ZMLS = @"tw_home_sub_正码历史";
    self.IC_home_sub_WSDX = @"tw_home_sub_尾数大小";
    self.IC_home_sub_SXTM = @"tw_home_sub_生肖特码";
    self.IC_home_sub_SXZM = @"tw_home_sub_生肖正码";
    self.IC_home_sub_BSTM = @"tw_home_sub_波色特码";
    self.IC_home_sub_BSZM = @"tw_home_sub_波色正码";
    self.IC_home_sub_TMLM = @"tw_home_sub_特码两面";
    self.IC_home_sub_TMWS = @"tw_home_sub_特码尾数";
    self.IC_home_sub_ZMWS = @"tw_home_sub_正码尾数";
    self.IC_home_sub_ZMZF = @"tw_home_sub_正码总分";
    self.IC_home_sub_HMBD = @"tw_home_sub_号码波段";
    self.IC_home_sub_JQYS = @"tw_home_sub_家禽野兽";
    self.IC_home_sub_LMZS = @"tw_home_sub_连码走势";
    self.IC_home_sub_LXZS = @"tw_home_sub_连肖走势";
    self.IC_home_sub_LHDS = @"tw_home_sub_六合大神";
    self.IC_home_sub_YLTJ = @"tw_home_sub_遗漏统计";
    self.IC_home_sub_JRTJ = @"tw_home_sub_今日统计";
    self.IC_home_sub_MFTJ = @"tw_home_sub_免费推荐";
    self.IC_home_sub_QXT = @"tw_home_sub_曲线图";
    self.IC_home_sub_TMZS = @"tw_home_sub_选号助手";
    
    self.IM_home_ZXTJImageName = @"homeZXTJImageName_eye";
    self.CO_home_SubCellTitleText = [UIColor colorWithHex:@"333333"];
    self.CO_home_SubheaderBallBtnBack = [UIColor colorWithHex:@"fe5049"];
    
    self.IM_home_XSTJImage = IMAGE(@"IM_home_XSTJImage");
    self.IM_home_LHDSImage = IMAGE(@"IM_home_LHDSImage");
    self.IM_home_LHTKImage = IMAGE(@"IM_home_LHTKImage");
    self.IM_home_GSSHImage = IMAGE(@"IM_home_GSSHImage");
    self.IC_home_ZBKJImageName = @"IC_home_ZBKJImageName";
    self.IC_home_LSKJImageName = @"IC_home_LSKJImageName";
    self.IC_home_CXZSImageName = @"IC_home_CXZSImageName";
    self.IM_home_hotNewsImageName = IMAGE(@"IM_home_hotNewsImageName");
    self.IM_home_SanJiaoImage = IMAGE(@"IM_home_SanJiaoImage");
    
    self.CO_Home_Buy_Footer_BtnBack = [UIColor colorWithHex:@"9C2D33"];
    self.CO_Home_Buy_Footer_Back = [UIColor colorWithHex:@"F0F0F0"];
    
#pragma mark 我的
    
    self.IM_topBackImageView = IMAGE(@"tw_ic_me_topback");
    self.Mine_ScrollViewBackgroundColor = [UIColor colorWithHex:@"3E94FF"];
    self.CO_Mine_setContentViewBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Me_NicknameLabel = [UIColor colorWithHex:@"333333"];
    self.CO_Me_SubTitleText = [UIColor colorWithHex:@"333333"];
    self.CO_Me_ItemTextcolor = [UIColor colorWithHex:@"#666666"];
    
    self.CO_LongDragonTopView = self.CO_Main_ThemeColorOne;
    self.CO_LongDragonTopViewBtn =  [UIColor colorWithHex:@"#FF870F"];
    
    self.IM_Home_cartBgImageView = IMAGE(@"circleHomeBgImage");
    self.CO_buyLotBgColor = [UIColor colorWithHex:@"F4F4F4"];
    self.OpenLotteryVC_ColorLabs_TextB = [UIColor colorWithHex:@"333333"];
    
    self.IM_Me_MoneyRefreshBtn = IMAGE(@"tw_me_moneyrefresh");
    self.IM_Me_ChargeImage = IMAGE(@"tw_me_top1");
    self.IM_Me_GetMoneyImage = IMAGE(@"tw_me_top2");
    self.IM_Me_MoneyDetailImage = IMAGE(@"tw_me_top3");
    
    self.IM_Me_MyWalletImage = IMAGE(@"tw_me_sro1");
    self.IM_Me_MyAccountImage = IMAGE(@"tw_me_sro2");
    self.IM_Me_SecurityCnterImage = IMAGE(@"tw_me_sro3");
    self.IM_Me_MyTableImage = IMAGE(@"tw_me_sro4");
    self.IM_Me_buyHistoryImage = IMAGE(@"tw_me_sro5");
    self.IM_Me_MessageCenterImage = IMAGE(@"tw_me_sro6");
    self.IM_Me_setCenterImage = IMAGE(@"tw_me_sro7");
    self.IM_Me_shareImage = IMAGE(@"tw_me_sro8");
    self.CO_Me_YuEText = [UIColor colorWithHex:@"333333"];
    
#pragma mark  AI智能选号
    self.IM_AI_BGroundcolorImage = IMAGE(@"tw_ai_top_bg_aiznxh");
    self.IM_AI_ShengXiaoNormalImage = IMAGE(@"tw_ai_sx");
    self.IM_AI_ShakeNormalImage = IMAGE(@"tw_ai_yyy");
    self.IM_AI_LoverNormalImage = IMAGE(@"tw_ai_ar");
    self.IM_AI_FamilyNormalImage = IMAGE(@"tw_ai_jr");
    self.IM_AI_BirthdayNormalImage = IMAGE(@"tw_ai_sr");
    self.IM_AI_ShengXiaoSeletImage = IMAGE(@"tw_ai_sx_selected");
    self.IM_AI_ShakeSeletImage = IMAGE(@"tw_ai_yyy_selected");
    self.IM_AI_LoverSeletImage = IMAGE(@"tw_ai_ar_selected");
    self.IM_AI_FamilySeletImage = IMAGE(@"tw_ai_jr_selected");
    self.IM_AI_BirthdaySeletImage = IMAGE(@"tw_ai_sr_selected");
    self.IM_AI_BirthdayImage = IMAGE(@"tw_ai_srdg");
    self.IM_AI_ShengXiaoBackImage = IMAGE(@"tw_ai_cpt");
    self.IM_AI_ShuImage = IMAGE(@"tw_ai_shu");
    self.IM_AI_GouImage = IMAGE(@"tw_ai_gou");
    self.IM_AI_HouImage = IMAGE(@"tw_ai_hou");
    self.IM_AI_HuImage = IMAGE(@"tw_ai_hu");
    self.IM_AI_JiImage = IMAGE(@"tw_ai_ji");
    self.IM_AI_LongImage = IMAGE(@"tw_ai_long");
    self.IM_AI_MaImage = IMAGE(@"tw_ai_ma");
    self.IM_AI_NiuImage = IMAGE(@"tw_ai_niu");
    self.IM_AI_SheImage = IMAGE(@"tw_ai_she");
    self.IM_AI_TuImage = IMAGE(@"tw_ai_tu");
    self.IM_AI_YangImage = IMAGE(@"tw_ai_yang");
    self.IM_AI_ZhuImage = IMAGE(@"tw_ai_zhu");
    self.IM_AI_AutoSelectLblNormalColor = [UIColor colorWithHex:@"#8BC4FF"];
    self.IM_AI_AutoSelectLblSelectColor = self.CO_Main_ThemeColorTwe;
    
    
    // 购彩侧边
    self.CO_BuyLot_Left_ViewBack = [UIColor colorWithHex:@"#F0F0F0"];
    self.CO_BuyLot_Left_LeftCellBack = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_BuyLot_Left_LeftCellTitleText = [UIColor colorWithHex:@"#333333"];
    self.CO_BuyLot_Left_LeftCellBack_Selected = [UIColor colorWithHex:@"#FE8D2C"];
    self.CO_BuyLot_Left_LeftCellTitleText_Selected = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_BuyLot_Left_CellBack = [UIColor colorWithHex:@"#F0F0F0"];
    self.CO_BuyLot_Left_CellTitleText = [UIColor colorWithHex:@"#666666"];
    
    // 设置中心
    self.IC_Me_SettingTopImageName = @"tw_topback";
    self.IC_Me_SettingTopHeadIcon = @"setting_icon";
    self.SettingPushImageName = @"tw_me_setcenter1";
    self.SettingShakeImageName = @"tw_me_setcenter2";
    self.SettingVoiceImageName = @"tw_me_setcenter3";
    self.SettingSwitchSkinImageName = @"tw_me_setcenter4";
    self.SettingServiceImageName = @"tw_me_setcenter5";
    self.SettingAboutUsImageName = @"tw_me_setcenter6";
    self.confirmBtnBackgroundColor = self.CO_Main_ThemeColorTwe;
    
    
    // 我的钱包
    self.MyWalletTopImage = IMAGE(@"tw_me_wdqb");
    // 安全中心
    self.safeCenterTopImage = IMAGE(@"tw_topback");
    self.CO_Me_TopLabelTitle = [UIColor colorWithHex:@"333333"];
    // 侧边
    self.Left_VC_ChargeBtnImage = IMAGE(@"tw_left_cz");
    self.Left_VC_GetMoneyBtnImage = IMAGE(@"tw_left_tx");
    self.Left_VC_KFBtnImage = IMAGE(@"tw_left_kf");
    self.Left_VC_MyWalletImage = @"tw_left_wdqb";
    self.Left_VC_SecurityCenterImage = @"tw_left_aqzx";
    self.Left_VC_MessageCenterImage = @"tw_left_xxzx";
    self.Left_VC_BuyHistoryImage = @"tw_left_tzjl";
    self.Left_VC_MyTableImage = @"tw_left_wdbb";
    self.Left_VC_SettingCenterImage = @"tw_left_szzx";
    self.Left_VC_BtnTitleColor = WHITE;
    
    self.Left_VC_CellBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.LeftCtrlCellTextColor = [UIColor colorWithHex:@"333333"];
    
    self.Left_VC_BtnBackgroundColor = CLEAR;
    self.leftBackViewImageColor = CLEAR;
    self.Left_VC_TopImage = IMAGE(@"jbbj");
    self.LeftControllerLineColor = [UIColor hexStringToColor:@"FFFFFF" andAlpha:0.5];
    
    
    // 长龙
    self.CO_buyBottomViewBtn = [UIColor colorWithHex:@"#FF870F"];
    self.CO_ScrMoneyNumBtnText = [UIColor colorWithHex:@"#FF870F"];
    self.CO_ScrMoneyNumViewBack = self.CO_Main_ThemeColorTwe;
    
    
    self.CO_LiveLot_BottomBtnBack = self.CO_Main_ThemeColorTwe;
    self.CO_LiveLot_CellLabelBack = [UIColor colorWithHex:@"#D2E4FF"];
    self.CO_LiveLot_CellLabelText = [UIColor colorWithHex:@"#076CD3"];
    
    self.CO_ChatRoomt_SendBtnBack = self.CO_Main_ThemeColorTwe;
    
    
    // 挑码助手
    self.CO_TM_HeadView = [UIColor colorWithHex:@"#F0F2F5"];
    self.CO_TM_HeadContentView = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_BackView = [UIColor colorWithHex:@"#F0F2F5"];
    self.CO_TM_Btn3TitleText = [UIColor colorWithHex:@"#333333"];
    self.CO_TM_Btn3Back = [UIColor colorWithHex:@"#E9F4FF"];
    self.CO_TM_Btn3BackSelected = [UIColor colorWithHex:@"#FF8610"];
    self.CO_TM_Btn3borderColor = self.CO_Main_ThemeColorTwe;
    self.CO_TM_smallBtnText = [UIColor colorWithHex:@"#333333"];
    self.CO_TM_smallBtnTextSelected = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_smallBtnborderColor = [UIColor colorWithHex:@"#999999"];
    self.CO_TM_smallBtnBackColor = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_smallBtnBackColorSelected = [UIColor colorWithHex:@"#FF8610"];
    
#pragma mark 支付相关
    self.CO_Pay_SubmitBtnBack = [UIColor colorWithHex:@"#FF8610"];
    
    
    self.OnlineBtnImage = @"tw_nav_online_kf";
    self.KeFuTopImageName = @"KeFuTop";
    self.ChatVcDeleteImage = @"cartclear_eye";
    
    self.ChangLongLblBorderColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.2];
    self.KJRLSelectCalendar4 = @"kjrq_xzlskj_selected";
    self.KJRLSelectCalendar2 = @"kjrq_xzkjrq_selected";
    self.AIShakeImageName = @"tw_ai_nor";
    self.confirmBtnTextColor = [UIColor whiteColor];
    self.ShareCopyBtnTitleColor = WHITE;
    self.PersonCountTextColor = [UIColor colorWithHex:@"eeeeee"];
    self.NextStepArrowImage = @"next_eye";
    self.OpenLotteryLblLayerColor = [UIColor colorWithHex:@"999999"];
    self.changLongEnableBtnBackgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    self.CartSimpleBottomViewDelBtnImage = @"tw_ic_delete";
    self.CO_BuyDelBtn = [UIColor colorWithHex:@"#333333"];;
    self.CartSimpleBottomViewDelBtnBackgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    self.CartSimpleBottomViewTopBackgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    
    
    self.loginHistoryTextColor = [UIColor colorWithHex:@"0076A3"];
    self.messageIconName = @"xiaoxizhongxin_eye";
    self.quanziLaBaImage = @"tw_circle_lb";
    self.xinshuiFollowBtnBackground = [UIColor colorWithHex:@"FB6A12"];
    self.LHDSBtnImage = @"xs_xf_yuan_六合大神";
    self.HomeViewBackgroundColor = [UIColor colorWithHex:@"#eff2f5"];
    self.OpenLotteryBottomNFullImage = @"img_red_eye";
    self.OpenLotteryBottomNormalImage = @"img_orange_eye";
    self.BuyLotteryQPDDZGrayImageName = @"buy_qp_ddz_eye";
    self.BuyLotteryQPBJLGrayImageName = @"buy_qp_bjl_eye";
    self.BuyLotteryQPSLWHGrayImageName = @"buy_qp_slwh_eye";
    self.BuyLotteryQPBRNNGrayImageName = @"buy_qp_brnn_eye";
    self.BuyLotteryQPWRZJHGrayImageName = @"buy_qp_wrzjh_eye";
    self.BuyLotteryQPXLCHGrayImageName = @"buy_qp_xlch_eye";
    self.AoZhouLotterySwitchBtnImage = @"icon_qhms";
    self.AoZhouLotterySwitchBtnTitleColor = [UIColor colorWithHex:@"FF8610"];
    self.bottomDefaultImageName = @"img_darkgrey_eye";
    self.ChangLongRightBtnTitleNormalColor = self.CO_Main_ThemeColorOne;
    self.ChangLongRightBtnSubtitleNormalColor = self.CO_Main_ThemeColorOne;
    self.ChangLongRightBtnBackgroundColor = self.CO_Main_ThemeColorTwe;
    self.AoZhouScrollviewBackgroundColor = CLEAR;
    self.AoZhouMiddleBtnNormalBackgroundColor = [UIColor colorWithHex:@"F0F0F0"];
    self.AoZhouMiddleBtnSelectBackgroundColor = [UIColor colorWithHex:@"#FF870F"];
    self.AoZhouLotterySeperatorLineColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.4];
    self.AoZhouLotteryBtnTitleSelectColor = [UIColor colorWithHex:@"FFFFFF"];
    self.AoZhouLotteryBtnSelectBackgroundColor = [UIColor colorWithHex:@"5DADFF"];
    self.AoZhouLotteryBtnSelectSubtitleColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.8];
    self.AoZhouLotteryBtnTitleNormalColor = [UIColor colorWithHex:@"333333"];
    self.AoZhouLotteryBtnNormalBackgroundColor = [UIColor colorWithHex:@"E9F4FF" ];
    self.AoZhouLotteryBtnNormalSubtitleColor = [UIColor colorWithHex:@"999999"];
    self.Buy_HomeView_BackgroundColor = self.CO_Main_ThemeColorOne;
    self.ChangLongTitleColor = [UIColor colorWithHex:@"#333333"];
    self.ChangLongTimeLblColor = [UIColor colorWithHex:@"#EB0E24"];
    self.ChangLongTotalLblColor = [UIColor colorWithHex:@"28E223"];
    self.ChangLongIssueTextColor = [UIColor colorWithHex:@"888888"];
    self.ChangLongKindLblTextColor = [UIColor colorWithHex:@"888888"];
    self.ChangLongResultLblColor = [UIColor colorWithHex:@"FFC145"];
    
    
    self.CO_GD_SelectedTextNormal = [UIColor colorWithHex:@"#333333"];
    self.CO_GD_SelectedTextSelected = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_GD_Title_BtnBackSelected = self.CO_Main_ThemeColorTwe;
    
    self.WechatLoginImageName = @"tw_login_wx";
    self.QQLoginImageName = @"tw_login_QQ";
    self.xxncCheckBtnBackgroundColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.6];
    self.xxncImageName = @"tw_login_xgnc";
    self.ForgetPsdWhiteBackArrow = @"tw_login_back_white";
    self.LoginWhiteClose = @"tw_login_close";
    self.MimaEye = @"tw_login_mima";
    self.NicknameEye = @"tw_login_nickname";
    self.CodeEye = @"tw_login_code";
    self.InviteCodeEye = @"tw_login_invitecode";
    self.AccountEye = @"tw_login_account";
    self.ForgetPsdTitleTextColor = [UIColor colorWithHex:@"333333"];
    self.ForgetPsdBackgroundImage = @"tw_login_wjmm";
    self.LoginForgetPsdTextColor = [UIColor colorWithHex:@"999999"];
    self.RegistNoticeTextColor = [UIColor colorWithHex:@"144A4F"];
    self.RegistBackgroundImage = @"tw_login_zcbj";
    self.LoginBackgroundImage = @"tw_login_dlbj";
    self.LoginBtnBackgroundcolor = self.CO_Main_ThemeColorTwe;
    self.LoginBoardColor = [UIColor colorWithHex:@"#CDCDCD"];
    self.LoginSureBtnTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.LoginLinebBackgroundColor = [UIColor colorWithHex:@"#CDCDCD"];
    self.LoginTextColor = [UIColor colorWithHex:@"333333"];
    self.QicCiDetailSixheadTitleColor = [UIColor colorWithHex:@"333333"];
    self.QiCiXQSixHeaderSubtitleTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.chongqinheadBackgroundColor = self.CO_Main_ThemeColorOne;
    self.QiCiDetailInfoColor = [UIColor colorWithHex:@"#FF8610"];
    self.QiCiDetailTitleColor = [UIColor colorWithHex:@"#333333"];
    self.QiCiDetailLineBackgroundColor = [UIColor colorWithHex:@"#D6D6D6"];
    self.QiCiDetailCellBackgroundColor = self.CO_Main_ThemeColorOne;
    self.CO_OpenLotHeaderInSectionView = [UIColor colorWithHex:@"#999999"];
    self.SixOpenHeaderSubtitleTextColor = [UIColor colorWithHex:@"#999999"];
    self.PK10_color1 = [UIColor colorWithHex:@"D542BB"];
    self.PK10_color2 = [UIColor colorWithHex:@"2F90DF"];
    self.PK10_color3 = [UIColor colorWithHex:@"FAB825"];
    self.PK10_color4 = [UIColor colorWithHex:@"11C368"];
    self.PK10_color5 = [UIColor colorWithHex:@"A36D55"];
    self.PK10_color6 = [UIColor colorWithHex:@"EF3C34"];
    self.PK10_color7 = [UIColor colorWithHex:@"66DBDD"];
    self.PK10_color8 = [UIColor colorWithHex:@"FF8244"];
    self.PK10_color9 = [UIColor colorWithHex:@"4EA3D9"];
    self.PK10_color10 = [UIColor colorWithHex:@"7060D1"];
    
    self.BuyLotteryZCjczqGrayImageName = @"zc_jczq";
    self.BuyLotteryZCjclqGrayImageName = @"zc_jclq";
    self.BuyLotteryZCzqsscGrayImageName = @"zc_zq14c";
    self.BuyLotteryZCrxjcGrayImageName = @"zc_rx9c";
    self.BuyLotteryQPdzGrayImageName = @"qp_dzpk_eye";
    self.BuyLotteryQPerBaGangGrayImageName = @"qp_ebg_eye";
    self.BuyLotteryQPqznnGrayImageName = @"qp_qznn_eye";
    self.BuyLotteryQPzjhGrayImageName = @"qp_zjh_eye";
    self.BuyLotteryQPsgGrayImageName = @"buy_qp_sg_eye";
    self.BuyLotteryQPyzlhGrayImageName = @"qp_yzlh_eye";
    self.BuyLotteryQPesydGrayImageName = @"buy_qp_21d_eye";
    self.BuyLotteryQPtbnnGrayImageName = @"qp_tbnn_eye";
    self.BuyLotteryQPjszjhGrayImageName = @"qp_jszjh_eye";
    self.BuyLotteryQPqzpjGrayImageName = @"qp_qzpj_eye";
    self.BuyLotteryQPsssGrayImageName = @"qp_sss_eye";
    self.BuyLotteryQPxywzGrayImageName = @"qp_xxwz_eye";
    self.CartSectionLineColor = [UIColor colorWithHex:@"#D6D6D6" Withalpha:0.5];
    
    
    self.SixGreenBallName = @"kj_sixgreen";
    self.SixBlueBallName = @"kj_sixblue";
    self.SixRedBallName = @"kj_sixred";
    self.SscBlueBallName = @"dlt_lsq";
    self.SscBallName = @"azact";
    self.PostCircleImageName = @"postcircle_white";
    self.PostCircleImage = IMAGE(@"postcircle_white");
    self.CircleUserCenterMiddleBtnBackgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.CircleUderCenterTopImage = IMAGE(@"jbbj");
    self.ApplyExpertPlaceholdColor = [UIColor colorWithHex:@"999999"];
    self.CO_Account_Info_BtnBack = self.CO_Main_ThemeColorTwe;
    self.ApplyExpertConfirmBtnTextColor = self.CO_Main_ThemeColorOne;
    self.applyExpertBackgroundColor = [UIColor colorWithHex:@"#F1F3F5"];
    self.ExpertInfoTextColorA = [UIColor colorWithHex:@"dddddd"];
    self.ExpertInfoTextColorB = [UIColor colorWithHex:@"FFFFFF"];
    self.WFSMImage = @"WFSMImage_eye";
    
    self.PrizeMessageTopbackViewTextColor = BLACK;
    self.CO_Home_Gonggao_TopBackViewStatus1 = [UIColor colorWithHex:@"B8B8B8"];
    self.CO_Home_Gonggao_TopBackViewStatus2 = self.CO_Main_ThemeColorTwe;
    self.GraphSetViewBckgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.XSTJSearchImage = @"XSTJSearchImage_eye";
    self.XSTJMyArticleImage = IMAGE(@"XSTJMyArticleImage_eye");
    
    
    
    self.TouZhuImage = IMAGE(@"xf_touzhu_button");
    
    
    self.AppFistguideUse1 = @"app_guide_1";
    self.AppFistguideUse2 = @"app_guide_2";
    self.AppFistguideUse3 = @"app_guide_3";
    self.registerVcPhotoImage = IMAGE(@"tw_login_registerVcPhotoImage");
    self.registerVcCodeImage = IMAGE(@"tw_login_registerVcCodeImage");
    self.registerVcPSDImage = IMAGE(@"tw_login_registerVcPSDImage");
    self.registerVcPSDAgainImage = IMAGE(@"registerVcPSDImage");
    self.registerVcInviteImage = IMAGE(@"tw_login_registerVcInviteImage");
    self.registerVcRegisterBtnBTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.registerVcRegisterBtnBckgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.LoginVcHiddenImage = IMAGE(@"tw_login_showPassword");
    self.LoginVcHiddenSelectImage = IMAGE(@"tw_login_hiddenPassword");
    self.LoginVcPhoneImage = IMAGE(@"tw_login_VcPhoneImage");
    self.loginVcQQimage = IMAGE(@"loginVcQQimage");
    self.loginVcWechatimage = IMAGE(@"loginVcWechatimage");
    self.loginLineBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.logoIconImage = IMAGE(@"");
    self.loginVcBgImage = IMAGE(@"loginBackgroundImage_eye");
    self.shareToLblTextColor = [UIColor colorWithHex:@"000000"];
    self.shareVcCopyBtnBackgroundColor = self.CO_Main_ThemeColorTwe;
    self.shareVcQQImage = IMAGE(@"me_qq");
    self.shareVcPYQImage = IMAGE(@"shareVcPYQImage_eye");
    self.shareVcWeChatImage = IMAGE(@"wx");
    self.shareLineImage = IMAGE(@"shareLineImage");
    self.OpenLotteryTimeLblTextColor = [UIColor colorWithHex:@"#FF001B"];
    self.CO_GD_TopBackgroundColor = [UIColor colorWithHex:@"#E7F1F8"];
    self.CO_GD_TopBackHeadTitle = [UIColor colorWithHex:@"#333333"];
    self.CO_GD_AllPeople_BtnText = [UIColor colorWithHex:@"#333333"];
    
    self.IM_GD_DashenTableImgView = IMAGE(@"tw_gd_topback");
    
    self.expertContentLblTextcolor = [UIColor colorWithHex:@"EEEEEE"];
    self.expertWinlblTextcolor = WHITE;
    self.expertInfoTopImgView = IMAGE(@"jbbj");
    self.circleListDetailViewBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.IM_CircleDetailHeadImage = IMAGE(@"tw_circle_topback");
    self.MyWalletBankCartImage = IMAGE(@"td_me_wdqb_cell_cart");
    
    self.accountInfoNicknameTextColor = [UIColor colorWithHex:@"333333"];
    self.CO_MoneyTextColor = [UIColor colorWithHex:@"#FF870F"];
    self.accountInfoTopViewBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    
    
    self.shareInviteImage = IMAGE(@"shareInviteImage_eye");
    self.shareMainImage = IMAGE(@"tw_me_fxhyback");
    self.shareBackImage = IMAGE(@"tw_me_fxhy_bsbj");
    self.calendarLeftImage = IMAGE(@"kj_left");
    self.calendarRightImage = IMAGE(@"kj_right");
    self.calendarBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.KJRLSelectBackgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.IM_CalendarTopImage = IMAGE(@"tw_kj_kjrl");
    
    self.LHTKTextfieldBackgroundColor = [UIColor colorWithHex:@"E6E6E6"];
    self.LHTKRemarkTextFeildBorderColor = CLEAR;
    self.XSTJdetailZanImage = IMAGE(@"tw_xs_zan");
    self.attentionViewCloseImage = IMAGE(@"closeAttention_eye");
    self.backBtnImageName = @"tw_nav_return";
    self.HobbyCellImage = IMAGE(@"勾选_eye");
    
#pragma mark  六合图库
    self.CO_LHTK_SubmitBtnBack = self.CO_Main_ThemeColorTwe;
    
    
    self.mine_seperatorLineColor = CLEAR;
    self.openPrizePlusColor = [UIColor colorWithHex:@"#999999"];
    self.OpenPrizeWuXing = [UIColor colorWithHex:@"D6CFFF"];
    
    self.circleHomeCell1Bgcolor = @"circleHomeCell1";
    self.circleHomeCell2Bgcolor = @"circleHomeCell1";
    self.circleHomeCell3Bgcolor = @"circleHomeCell1";
    self.circleHomeCell4Bgcolor = @"circleHomeCell1";
    self.circleHomeCell5Bgcolor = @"circleHomeCell1";
    self.circleHomeSDQImageName = @"cirlceHomeSDQ";
    self.circleHomeGDDTImageName = @"cirlceHomeGDDT";
    self.circleHomeXWZXImageName = @"cirlceHomeXWZX";
    self.circleHomeDJZXImageName = @"cirlceHomeDJZX";
    self.circleHomeZCZXImageName = @"cirlceHomeZCZX";
    
    
    self.circleHomeBgImage = IMAGE(@"circleHomeBgImage");
    
    
    
    self.xinshuiDetailAttentionBtnNormalGroundColor = BASECOLOR;
    self.pushDanBarTitleSelectColot = BASECOLOR;
    self.pushDanSubBarNormalTitleColor = [UIColor colorWithHex:@"666666"];
    self.pushDanSubBarSelectTextColor = [UIColor colorWithHex:@"0076A3"];
    
    self.pushDanSubbarBackgroundcolor = [UIColor colorWithHex:@"EEEEEE"];
    self.CO_LongDragon_PushSetting_BtnBack = self.CO_Main_ThemeColorTwe;
    self.pushDanBarTitleNormalColor = [UIColor colorWithHex:@"EEEEEE"];
    self.CO_Circle_Cell2_TextLabel_BackgroundC = [UIColor colorWithHex:@"9e353c"];
    self.CO_Circle_Cell2_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"9e353c"];
    self.CO_Circle_Cell3_TextLabel_BackgroundC = [UIColor colorWithHex:@"647e24"];
    self.CO_Circle_Cell1_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"5649b3"];
    self.bettingBtnColor = WHITE;
    self.xinshuiDetailAttentionBtnBackGroundColor = MAINCOLOR;
    self.LoginNamePsdPlaceHoldColor = [UIColor colorWithHex:@"#CDCDCD"];
    self.missCaculateBarNormalBackground = [UIColor colorWithHex:@"EEEEEE"];
    self.missCaculateBarselectColor = BASECOLOR;
    self.missCaculateBarNormalColor = WHITE;
    self.openLotteryCalendarBackgroundcolor = [UIColor colorWithHex:@"F7F7F7"];
    self.openLotteryCalendarTitleColor = [UIColor colorWithHex:@"EEEEEE"];
    self.openLotteryCalendarWeekTextColor = [UIColor colorWithHex:@"666666"];
    self.CO_OpenLot_BtnBack_Normal = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_OpenLot_BtnBack_Selected = self.CO_Main_ThemeColorTwe;
    self.CO_Home_Gonggao_TopTitleText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_Gonggao_Cell_MessageTopViewBack = self.CO_Main_ThemeColorTwe;
    self.KeyTitleColor = [UIColor colorWithHex:@"e76c29"];
    
    self.CO_Circle_TitleText = [UIColor colorWithHex:@"999999"];
    
    self.xinshuiRemarkTitleColor = WHITE;
    self.sixHeTuKuRemarkbarBackgroundcolor = WHITE;
    self.myCircleUserMiddleViewBackground = [UIColor colorWithHex:@"2C3036"];
    self.openCalendarTodayColor = [UIColor colorWithHex:@"#529DFF"];
    self.openCalendarTodayViewBackground = [UIColor colorWithHex:@"#FF9000"];
    self.LoginNamePsdTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.MineTitleStrColor = [UIColor colorWithHex:@"FFFFFF"];
    self.MessageTitleColor  = WHITE;
    
    self.xinshuiBottomViewTitleColor = WHITE;
    self.CO_KillNumber_LabelText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_KillNumber_LabelBack = self.CO_Main_ThemeColorTwe;
    
    self.TopUpViewTopViewBackgroundcolor = CLEAR;
    self.chargeMoneyLblSelectColor = [UIColor colorWithHex:@"FFFFFF"];
    self.chargeMoneyLblSelectBackgroundcolor = [UIColor colorWithHex:@"#FF8610"];
    self.chargeMoneyLblNormalColor = [UIColor colorWithHex:@"C48936"];
    self.tabbarItemTitleColor = [UIColor lightGrayColor];
    
    
    self.RootVC_ViewBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.tabbarItemTitleColor = [UIColor lightGrayColor];
    self.CO_Circle_Cell3_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"6d872f"];
    self.CO_Circle_Cell4_TextLabel_BackgroundC = [UIColor colorWithHex:@"3ea358"];
    self.CO_Circle_Cell4_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"3ea358"];
    self.tixianShuoMingColor = [UIColor colorWithHex:@"0076A3"];
    
    self.CircleVC_HeadView_BackgroundC = CLEAR;
    self.CO_Circle_Cell_BackgroundC = [UIColor colorWithHex:@"f0f2f5"];
    self.CO_Circle_Cell_TextLabel_BackgroundC = [UIColor colorWithHex:@"333333"];
    self.CO_Circle_Cell_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"999999"];
    
    
    self.CartBarBackgroundColor = self.CO_Main_ThemeColorOne;
    self.CartBarTitleNormalColor = [UIColor colorWithHex:@"#333333"];
    self.CartBarTitleSelectColor = [UIColor colorWithHex:@"FF8610"];
    self.CartHomeHeaderSeperatorColor = [UIColor colorWithHex:@"ff9711"];
    self.genDanHallTitleNormalColr = [UIColor colorWithHex:@"333333"];
    self.genDanHallTitleSelectColr = [UIColor colorWithHex:@"#F4106B"];;
    self.genDanHallTitleBackgroundColor = [UIColor colorWithHex:@"#E7F1F8"];
    self.gongShiShaHaoFormuTitleNormalColor = [UIColor colorWithHex:@"333333"];
    self.gongShiShaHaoFormuTitleSelectColor = BASECOLOR;
    self.gongshiShaHaoFormuBtnBackgroundColor = BLACK;
    
    
    
    self.OpenLotteryVC_ColorLabs_TextC = [UIColor colorWithHex:@"#FF8610"];
    self.OpenLotteryVC_ColorLabs1_TextC = [UIColor colorWithHex:@"#333333"];
    self.OpenLotteryVC_SubTitle_TextC = [UIColor colorWithHex:@"#999999"];
    self.OpenLotteryVC_SubTitle_BorderC = [UIColor colorWithHex:@"8D8D8D"];
    self.OpenLotteryVC_Cell_BackgroundC = [UIColor colorWithHex:@"3a3b3f"];
    self.OpenLotteryVC_View_BackgroundC = [UIColor colorWithHex:@"F0F2F5"];
    self.CO_LongDragonCell = self.CO_Main_ThemeColorOne;
    self.OpenLotteryVC_TitleLabs_TextC = [UIColor colorWithHex:@"333333"];
    self.OpenLotteryVC_SeperatorLineBackgroundColor = [UIColor colorWithHex:@"#D6D6D6" Withalpha:0.5];
    self.CO_OpenLetBtnText_Normal = [UIColor colorWithHex:@"333333"];
    self.SixRecommendVC_View_BackgroundC = [UIColor colorWithHex:@"f4f4f4"];
    self.MineVC_Btn_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    
    self.HobbyVC_MessLab_BackgroundC = [UIColor colorWithHex:@"EEEEEE"];
    self.HobbyVC_MessLab_TextC = [UIColor colorWithHex:@"333333"];
    self.HobbyVC_View_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.HobbyVC_OKButton_BackgroundC = [UIColor colorWithHex:@"0076A3"];
    self.HobbyVC_OKButton_TitleBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Circle_Title_nameColor = [UIColor colorWithHex:@"333333"];
    self.HobbyVC_SelButton_TitleBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.HobbyVC_UnSelButton_TitleBackgroundC = [UIColor colorWithHex:@"999999"];
    self.CO_Circle_Cell1_TextLabel_BackgroundC = self.CO_Circle_Cell_TextLabel_BackgroundC;
    self.HobbyVC_SelButton_BackgroundC = [UIColor colorWithHex:@"0076A3"];
    self.HobbyVC_UnSelButton_BackgroundC = [UIColor colorWithHex:@"DDDDDD"];
    self.Circle_View_BackgroundC = [UIColor colorWithHex:@"#f0f2f5"];
    self.Circle_HeadView_Title_UnSelC = [UIColor colorWithHex:@"999999"];
    self.Circle_HeadView_Title_SelC = [UIColor colorWithHex:@"333333"];
    self.Circle_HeadView_BackgroundC = [UIColor colorWithHex:@"#E7F1F8"];
    self.Circle_HeadView_NoticeView_BackgroundC = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.2];
    self.Circle_HeadView_GuangBo_BackgroundC = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.8];
    self.Circle_Cell_BackgroundC = [UIColor colorWithHex:@"F7F7F7"];
    self.Circle_Cell_ContentlabC = [UIColor colorWithHex:@"666666"];
    self.Circle_Cell_Commit_BackgroundC = [UIColor colorWithHex:@"F7F7F7"];
    self.Circle_Cell_Commit_TitleC = [UIColor colorWithHex:@"666666"];
    self.Circle_Cell_AttentionBtn_TitleC = [UIColor colorWithHex:@"CFA753"];
    self.Circle_Line_BackgroundC = [UIColor colorWithHex:@"#F4106B"];
    self.Circle_remark_nameColor = [UIColor colorWithHex:@"4e79c2"];
    self.getCodeBtnvBackgroundcolor = [UIColor colorWithHex:@"dddddd"];
    self.Circle_FooterViewLine_BackgroundC = [UIColor colorWithHex:@"dddddd" Withalpha:0.9];
    self.OpenLottery_S_Cell_BackgroundC = CLEAR;//[UIColor colorWithHex:@"8483F0"];
    self.OpenLottery_S_Cell_TitleC = [UIColor colorWithHex:@"333333"];
    self.Login_NamePasswordView_BackgroundC = CLEAR;//[UIColor colorWithHex:@"2c2e36"];
    self.Login_ForgetSigUpBtn_BackgroundC = [UIColor colorWithHex:@"2c2e36" Withalpha:0.5];
    self.Login_ForgetSigUpBtn_TitleC = [UIColor colorWithHex:@"DDDDDD"];
    self.Login_LogoinBtn_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Login_LogoinBtn_TitleC = [UIColor colorWithHex:@"0076A3"];
    self.Buy_LotteryMainBackgroundColor = [UIColor colorWithHex:@"1B1E23"];
    self.RootWhiteC = [UIColor colorWithHex:@"f4f4f4"];
    self.CO_OpenLetBtnText_Selected = [UIColor colorWithHex:@"FFFFFF"];
    self.loginSeperatorLineColor = [UIColor colorWithHex:@"EEEEEE"];
    self.getCodeBtnvTitlecolor = [UIColor colorWithHex:@"#888888"];
    self.LiuheTuKuLeftTableViewBackgroundColor = [UIColor colorWithHex:@"e0e0e0"];
    self.LiuheTuKuOrangeColor = self.CO_Main_ThemeColorTwe;
    self.LiuheTuKuLeftTableViewSeperatorLineColor = [UIColor colorWithHex:@"c2c2c2"];
    self.LiugheTuKuTopBtnGrayColor = [UIColor colorWithHex:@"dddddd"];
    self.LiuheTuKuProgressValueColor = [UIColor colorWithHex:@"0076A3"];
    self.LiuheTuKuTouPiaoBtnBackgroundColor = [UIColor colorWithHex:@"c60000"];
    self.LiuheDashendBackgroundColor = self.CO_Main_ThemeColorOne;
    
    self.xinShuiReconmentGoldColor = [UIColor colorWithHex:@"FFFFFF"];
    self.xinShuiReconmentRedColor = self.CO_Main_ThemeColorTwe;
    self.TouPiaoContentViewTopViewBackground = [UIColor colorWithHex:@"16171b"];
    self.LiuheTuKuRemarkBarBackgroundColor = [UIColor colorWithHex:@"16171b"];
    self.LiuheTuKuRemarkSendBackgroundColor = self.CO_Main_ThemeColorTwe;
    self.LiuheTuKuTextRedColor = self.CO_Main_ThemeColorTwe;
    self.XinshuiRecommentScrollBarBackgroundColor = [UIColor colorWithHex:@"f0f0f0"];
    self.xinshuiBottomVeiwSepeLineColor = [UIColor whiteColor];
    self.Circle_Post_titleSelectColor = [UIColor colorWithHex:@"F4106B"];
    self.Circle_Post_titleNormolColor = [UIColor colorWithHex:@"#333333"];
    
#pragma mark 购彩
    //购彩
    self.Buy_HeadView_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_HeadView_Footer_BackgroundC = [UIColor colorWithHex:@"F0F0F0"];
    self.Buy_HeadView_Title_C = [UIColor colorWithHex:@"333333"];
    self.Buy_HeadView_historyV_Cell1_C = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_HeadView_historyV_Cell2_C = [UIColor colorWithHex:@"F0F0F0"];
    
    self.Buy_LeftView_BackgroundC = CLEAR;//[UIColor colorWithHex:@"0076A3"];
    self.Buy_LeftView_Btn_BackgroundUnSel = IMAGE(@"FY_Buy_LeftView_Btn_BackgroundUnSel");
    self.Buy_LeftView_Btn_BackgroundSel = IMAGE(@"FY_Buy_LeftView_Btn_BackgroundSel");
    self.Buy_LeftView_Btn_TitleSelC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_LeftView_Btn_TitleUnSelC = [UIColor colorWithHex:@"333333"];
    self.Buy_LeftView_Btn_PointUnSelC = [UIColor colorWithHex:@"5DADFF"];
    self.Buy_LeftView_Btn_PointSelC = [UIColor colorWithHex:@"01ae00"];
    self.Buy_RightBtn_Title_UnSelC = [UIColor colorWithHex:@"333333"];
    self.Buy_RightBtn_Title_SelC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionHeadV_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionHeadV_ViewC = [UIColor colorWithHex:@"ff5d12"];
    self.CO_Bottom_LabelText = [UIColor colorWithHex:@"#333333"];
    
    self.Buy_CollectionCellButton_BackgroundSel = [UIColor colorWithHex:@"5DADFF"];
    self.Buy_CollectionCellButton_BackgroundUnSel = CLEAR;
    self.Buy_CollectionCellButton_TitleCSel = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionCellButton_TitleCUnSel = [UIColor colorWithHex:@"333333"];
    self.Buy_CollectionCellButton_SubTitleCSel = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionCellButton_SubTitleCUnSel = [UIColor colorWithHex:@"999999"];
    self.Buy_CollectionViewLine_C = [UIColor colorWithHex:@"D6D6D6"];
    
    self.CO_BuyLot_HeadView_LabelText = [UIColor colorWithHex:@"999999"];
    self.CO_BuyLot_HeadView_Label_border = [UIColor colorWithHex:@"999999"];
    self.CO_BuyLot_Right_bcViewBack = [UIColor colorWithHex:@"E9F4FF"];
    self.CO_BuyLot_Right_bcView_border = [UIColor colorWithHex:@"BEDEFF"];
    
    
    self.CartHomeSelectSeperatorLine = [UIColor colorWithHex:@"ff9711"];
    
    self.grayColor999 = [UIColor colorWithHex:@"999999"];
    self.grayColor666 = [UIColor colorWithHex:@"666666"];
    self.grayColor333 = [UIColor colorWithHex:@"333333"];
    self.Mine_rightBtnTileColor = [UIColor colorWithHex:@"FFFFFF"];
    self.Mine_priceTextColor = [UIColor colorWithHex:@"#F4106B"];
    self.ChangePsdViewBackgroundcolor = [UIColor colorWithHex:@"F7F7F7"];
    self.CO_Me_MyWallerBalance_MoneyText = [UIColor colorWithHex:@"#F4106B"];
    self.CO_Me_MyWallerBalanceText = [UIColor colorWithHex:@"#F4106B"];
    self.MyWalletTotalBalanceColor = [UIColor colorWithHex:@"fff666"];
    self.mineInviteTextCiolor = [UIColor colorWithHex:@"888888"];
    self.CO_Me_MyWallerTitle = [UIColor colorWithHex:@"#333333"];
#pragma mark 番摊紫色
    self.NN_LinelColor = [UIColor colorWithHex:@"D6D6D6"];
    self.NN_xian_normalColor = [UIColor colorWithHex:@"565964"];
    self.NN_xian_selColor = [UIColor colorWithHex:@"8F601E"];
    self.NN_zhuang_normalColor = [UIColor colorWithHex:@"5140A1"];
    self.NN_zhuang_selColor = [UIColor colorWithHex:@"905F1B"];
    self.NN_Xian_normalImg = @"xianjia-gray_1";
    self.NN_Xian_selImg = @"xianjia-color_1";
    self.NN_zhuang_normalImg = @"zhuang_normal";
    self.NN_zhuang_selImg = @"zhuangjia-color_1";
    
    self.NN_XianBgImg = [UIImage imageNamed:@"xianjia-xuanzhong"];
    self.NN_XianBgImg_sel = [UIImage imageNamed:@"xianjia"];
    self.Buy_NNXianTxColor_normal = [UIColor colorWithHex:@"0E2B20"];
    self.Buy_NNXianTxColor_sel = [UIColor whiteColor];
    self.Fantan_headerLineColor = [UIColor colorWithHex:@"1F5C73"];
    self.Fantan_historyHeaderBgColor = [UIColor colorWithHex:@"8D7FE9"];
    self.Fantan_historyHeaderLabColor = [UIColor colorWithHex:@"333333"];
    self.Fantan_historycellColor1 = [UIColor colorWithHex:@"333333"];
    self.Fantan_historycellColor2 = [UIColor colorWithHex:@"D6D6D6"];
    self.Fantan_historycellColor3 = [UIColor colorWithHex:@"FFD116"];
    self.Fantan_historycellOddColor = [UIColor colorWithHex:@"AAA2F1"];
    self.Fantan_historycellEvenColor = [UIColor colorWithHex:@"9B8DE9"];
    self.CO_Fantan_HeadView_Label = [UIColor colorWithHex:@"999999"];
    
    
    self.RedballImg_normal = @"lessredball";
    self.RedballImg_sel = @"redball";
    self.BlueballImg_normal = @"lesswhiteball";
    self.BlueballImg_sel = @"blueball";
    
    self.Fantan_MoneyColor = [UIColor colorWithHex:@"FF8610"];
    self.Fantan_CountDownBoderColor = [UIColor colorWithHex:@"999999"];
    self.Fantan_CountDownBgColor = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_fantanTimeColor = [UIColor colorWithHex:@"FF9F0F"];
    self.Fantan_DelImg = IMAGE(@"cartclear_1");
    self.Fantan_ShakeImg = IMAGE(@"cartrandom_1");
    self.Fantan_AddToBasketImg = IMAGE(@"cartset_1");
    self.Fantan_basketImg = IMAGE(@"cart_1");
    
    self.Fantan_FloatImgUp = IMAGE(@"buy_up_1");
    self.Fantan_FloatImgDown = IMAGE(@"buy_down_1");
    self.Fantan_AddImg = IMAGE(@"tw_add");
    self.Fantan_JianImg = IMAGE(@"tw_jianhao");
    self.Fantan_SpeakerImg = IMAGE(@"buy_music_1");
    self.Buy_fantanBgColor = [UIColor colorWithHex:@"2d2f37"];
    //    self.Buy_fantanCellBgColor = [UIColor colorWithHex:@"715FE3"];
    self.Buy_fantanCellBgColor = [UIColor colorWithHex:@"FFFFFF"];;
    self.Fantan_iconColor = [UIColor colorWithHex:@"FFD116"];
    self.FantanColor1 = [UIColor colorWithHex:@"5DADFF"];
    self.FantanColor2 = [UIColor colorWithHex:@"5DADFF"];
    self.FantanColor3 = [UIColor colorWithHex:@"F0F0F0"];
    self.FantanColor4 = [UIColor colorWithHex:@"F0F0F0"];
    self.Fantan_textFieldColor = self.CO_Main_ThemeColorOne;
    self.CO_Fantan_textFieldTextColor = [UIColor colorWithHex:@"FF8610"];
    self.CO_BuyLotBottomView_TopView3_BtnText = [UIColor colorWithHex:@"333333"];
    self.CO_BuyLotBottomView_BotView2_BtnBack = [UIColor colorWithHex:@"FF8610"];
    self.Fantan_tfPlaceholdColor = [UIColor colorWithHex:@"#808080"];
    self.CO_Buy_textFieldText = [UIColor colorWithHex:@"#333333"];
    self.Fantan_labelColor = [UIColor colorWithHex:@"#333333"];
    self.blackOrWhiteColor = [UIColor colorWithHex:@"000000"];
    self.MyWallerBalanceBottomViewColor = [UIColor colorWithHex:@"e9e9e9"];
    
}




// 默认黑色版本
#pragma mark - LitterFish_darkTheme 默认黑色版本
- (void)LitterFish_darkTheme {
    
    self.CO_Main_ThemeColorOne = [UIColor colorWithHex:@"1D1E23"];   // 主题色1;   黑色
    self.CO_Main_ThemeColorTwe = [UIColor colorWithHex:@"#AC1E2D"];   // 主题色2;  红色
    self.CO_Main_LineViewColor = [UIColor colorWithHex:@"#3F424C"];   // 分割线条颜色
    self.CO_Main_LabelNo1 = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Main_LabelNo2 = [UIColor colorWithHex:@"#CCCCCC"];
    self.CO_Main_LabelNo3 = [UIColor colorWithHex:@"#CCCCCC"];
    
    self.IC_TabBar_Home = @"tab1_1";
    self.IC_TabBar_Home_Selected = @"tab1_2";
    self.IC_TabBar_KJ_ = @"tab2_1";
    self.IC_TabBar_KJ_Selected = @"tab2_2";
    self.IC_TabBar_GC = @"tab3_1";
    self.IC_TabBar_GC_Selected = @"tab3_2";
    self.IC_TabBar_QZ = @"tab4_1";
    self.IC_TabBar_QZ_Selected = @"tab4_2";
    self.IC_TabBar_Me = @"tab5_1";
    self.IC_TabBar_Me_Selected = @"tab5_2";
    self.CO_TabBarTitle_Normal = [UIColor colorWithHex:@"666666"];
    self.CO_TabBarTitle_Selected = [UIColor colorWithHex:@"fed696"];
    self.CO_TabBarBackground = [UIColor colorWithHex:@"1D1E24"];
    
    self.CO_Nav_Bar_NativeViewBack = [UIColor colorWithHex:@"1D1E24"];
    self.CO_NavigationBar_TintColor = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_NavigationBar_Title = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Nav_Bar_CustViewBack = [UIColor colorWithHex:@"18191D"];
    
    self.IM_Nav_TitleImage_Logo = IMAGE(@"td_nav_home_logo");
    self.IC_Nav_ActivityImageStr = @"td_nav_activity_icon";
    self.IC_Nav_SideImageStr = @"td_nav_home_menu";
    self.IC_Nav_CircleTitleImage = @"td_nav_circle_icon";
    self.IC_Nav_Setting_Icon = @"tw_nav_setting_gear";
    self.IC_Nav_Setting_Gear = @"td_nav_setting";
    self.IC_Nav_Kefu_Text = @"tw_nav_online_kf";
    
#pragma mark Home
    
    self.OnlineBtnImage = @"tw_nav_online_kf";
    self.KeFuTopImageName = @"KeFuTop";
    self.ChatVcDeleteImage = @"ljt";
    
    self.ChangLongLblBorderColor = CLEAR;
    self.KJRLSelectCalendar4 = @"calendar_4";
    self.KJRLSelectCalendar2 = @"calendar_2";
    self.AIShakeImageName = @"AIshake";
    self.confirmBtnTextColor = WHITE;
    self.ShareCopyBtnTitleColor = BLACK;
    self.PersonCountTextColor = [UIColor lightGrayColor];
    self.NextStepArrowImage = @"next";
    self.OpenLotteryLblLayerColor = [UIColor colorWithHex:@"d8d9d6"];
    self.changLongEnableBtnBackgroundColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.2];
    self.CartSimpleBottomViewDelBtnImage = @"cartclear_dark";
    self.CO_BuyDelBtn = [UIColor colorWithHex:@"FFFFFF"];
    self.CartSimpleBottomViewDelBtnBackgroundColor = [UIColor colorWithHex:@"2D2F37"];
    self.CartSimpleBottomViewTopBackgroundColor = [UIColor colorWithHex:@"000000"];
    self.IM_home_ZXTJImageName = @"zxtj";
    
    self.CO_Circle_TitleText = [UIColor colorWithHex:@"FFFFFF"];
    
    // 长龙
    self.CO_buyBottomViewBtn = self.CO_Main_ThemeColorTwe;
    self.CO_ScrMoneyNumBtnText = [UIColor colorWithHex:@"#fed696"];
    self.CO_ScrMoneyNumViewBack = self.CO_Main_ThemeColorOne;
    
    self.CO_Pay_SubmitBtnBack = [UIColor colorWithHex:@"#AC1E2D"];
    
    // 挑码助手
    self.CO_TM_HeadView = [UIColor colorWithHex:@"#22252b"];
    self.CO_TM_HeadContentView = [UIColor colorWithHex:@"#26282e"];
    self.CO_TM_BackView = [UIColor colorWithHex:@"#1d1e25"];
    self.CO_TM_Btn3TitleText = [UIColor colorWithHex:@"#333333"];
    self.CO_TM_Btn3Back = [UIColor colorWithHex:@"#EBEBEB"];
    self.CO_TM_Btn3BackSelected = [UIColor colorWithHex:@"#FF5B10"];
    self.CO_TM_Btn3borderColor = [UIColor colorWithHex:@"#FFFFFF" Withalpha:0.5];
    self.CO_TM_smallBtnText = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_smallBtnTextSelected = [UIColor colorWithHex:@"#FFE292"];
    self.CO_TM_smallBtnborderColor = [UIColor colorWithHex:@"#2D2F37"];
    self.CO_TM_smallBtnBackColor = [UIColor colorWithHex:@"#2D2F37"];
    self.CO_TM_smallBtnBackColorSelected = [UIColor colorWithHex:@"#AC1E2D"];
    
    self.Buy_HomeView_BackgroundColor = [UIColor colorWithHex:@"#2E3038"];
    
    self.loginHistoryTextColor = [UIColor colorWithHex:@"999999"];
    self.messageIconName = @"xiaoxizhongxin";
    self.quanziLaBaImage = @"消息通知";
    self.xinshuiFollowBtnBackground = BASECOLOR;
    self.LHDSBtnImage = @"xs_xf_六合大神";
    self.HomeViewBackgroundColor = [UIColor colorWithHex:@"1D1E24"];
    self.OpenLotteryBottomNFullImage = @"img_red";
    self.OpenLotteryBottomNormalImage = @"img_orange";
    self.BuyLotteryQPDDZGrayImageName = @"buy_qp_ddz";
    self.BuyLotteryQPBJLGrayImageName = @"buy_qp_bjl";
    self.BuyLotteryQPSLWHGrayImageName = @"buy_qp_slwh";
    self.BuyLotteryQPBRNNGrayImageName = @"buy_qp_brnn";
    self.BuyLotteryQPWRZJHGrayImageName = @"buy_qp_wrzjh";
    self.BuyLotteryQPXLCHGrayImageName = @"buy_qp_xlch";
    self.AoZhouLotterySwitchBtnImage = @"icon_qhms";
    self.AoZhouLotterySwitchBtnTitleColor = [UIColor colorWithHex:@"D5A864"];
    self.bottomDefaultImageName = @"img_darkgrey";
    self.ChangLongRightBtnTitleNormalColor = [UIColor colorWithHex:@"FFFFFF"];
    self.ChangLongRightBtnSubtitleNormalColor = [UIColor colorWithHex:@"999999"];
    self.ChangLongRightBtnBackgroundColor = [UIColor colorWithHex:@"40434F"];
    self.AoZhouScrollviewBackgroundColor = [UIColor colorWithHex:@"1D1E23"];
    self.AoZhouMiddleBtnNormalBackgroundColor = [UIColor colorWithHex:@"2D2F37"];
    self.AoZhouMiddleBtnSelectBackgroundColor = [UIColor colorWithHex:@"FF1637"];
    self.AoZhouLotterySeperatorLineColor = [UIColor colorWithHex:@"2D2F37"];
    self.AoZhouLotteryBtnTitleSelectColor = [UIColor colorWithHex:@"FFE292"];
    self.AoZhouLotteryBtnSelectBackgroundColor = [UIColor colorWithHex:@"AC1E2D"];
    self.AoZhouLotteryBtnSelectSubtitleColor = [UIColor colorWithHex:@"F2B68A"];
    self.AoZhouLotteryBtnTitleNormalColor = [UIColor colorWithHex:@"FFFFFF"];
    self.AoZhouLotteryBtnNormalBackgroundColor = [UIColor colorWithHex:@"2D2F37"];
    self.AoZhouLotteryBtnNormalSubtitleColor = [UIColor colorWithHex:@"999999"];
    self.CartSectionLineColor = [UIColor colorWithHex:@"18191D"];
    self.ChangLongTitleColor = [UIColor colorWithHex:@"FFFFFF"];
    self.ChangLongTimeLblColor = [UIColor colorWithHex:@"FF5B10"];
    self.ChangLongTotalLblColor = [UIColor colorWithHex:@"11C368"];
    self.ChangLongIssueTextColor = [UIColor colorWithHex:@"999999"];
    self.ChangLongKindLblTextColor = [UIColor colorWithHex:@"3FDCFE"];
    self.ChangLongResultLblColor = [UIColor colorWithHex:@"FFC145"];
    self.CO_Me_NicknameLabel = [UIColor colorWithHex:@"FFFFFF"];
    self.WechatLoginImageName = @"td_login_wx";
    self.QQLoginImageName = @"td_login_QQ";
    self.xxncCheckBtnBackgroundColor = [UIColor colorWithHex:@"A3905C"];
    self.xxncImageName = @"td_login_xgnc";
    self.ForgetPsdWhiteBackArrow = @"td_login_return_icon";
    self.LoginWhiteClose = @"td_login_xx";
    self.MimaEye = @"td_login_lock";
    self.NicknameEye = @"td_login_red";
    self.CodeEye = @"td_login_confirm";
    self.InviteCodeEye = @"td_login_invcode";
    self.AccountEye = @"td_login_phone";
    self.ForgetPsdTitleTextColor = [UIColor colorWithHex:@"E6BB85"];
    self.ForgetPsdBackgroundImage = @"td_login_wjmm";
    self.LoginForgetPsdTextColor = [UIColor colorWithHex:@"6A614D"];
    self.RegistNoticeTextColor = [UIColor colorWithHex:@"9E2D32"];
    self.RegistBackgroundImage = @"td_reg_back";
    self.LoginBackgroundImage = @"td_login_back";
    self.LoginBtnBackgroundcolor = [UIColor colorWithHex:@"9E2D32"];
    self.LoginBoardColor = [UIColor colorWithHex:@"C2955D"];
    self.LoginSureBtnTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.LoginLinebBackgroundColor = [UIColor colorWithHex:@"A3905C"];
    self.LoginTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.SixOpenHeaderSubtitleTextColor = [UIColor colorWithHex:@"BBBBBB"];
    self.QicCiDetailSixheadTitleColor = [UIColor colorWithHex:@"999999"];
    self.QiCiXQSixHeaderSubtitleTextColor = [UIColor colorWithHex:@"999999"];
    
    self.chongqinheadBackgroundColor = [UIColor colorWithHex:@"2D2F37"];
    self.QiCiDetailInfoColor = [UIColor colorWithHex:@"E5C570"];
    self.QiCiDetailLineBackgroundColor = [UIColor colorWithHex:@"3C3E48"];
    self.QiCiDetailTitleColor = [UIColor colorWithHex:@"999999"];
    self.QiCiDetailCellBackgroundColor = [UIColor colorWithHex:@"2D2F37"];
    self.CO_OpenLotHeaderInSectionView = [UIColor colorWithHex:@"#811F29"];
    self.XSTJSearchImage = @"sousuo";
    self.XSTJMyArticleImage = IMAGE(@"wode");
    self.PK10_color1 = [UIColor colorWithHex:@"e5de14"];
    self.PK10_color2 = [UIColor colorWithHex:@"106ced"];
    self.PK10_color3 = [UIColor colorWithHex:@"4c4a4a"];
    self.PK10_color4 = [UIColor colorWithHex:@"ec6412"];
    self.PK10_color5 = [UIColor colorWithHex:@"1ed0d3"];
    self.PK10_color6 = [UIColor colorWithHex:@"1e0df4"];
    self.PK10_color7 = [UIColor colorWithHex:@"a6a6a6"];
    self.PK10_color8 = [UIColor colorWithHex:@"e9281f"];
    self.PK10_color9 = [UIColor colorWithHex:@"770800"];
    self.PK10_color10 = [UIColor colorWithHex:@"2e9c18"];
    
    self.CO_GD_SelectedTextNormal = [UIColor colorWithHex:@"#f7e222"];
    self.CO_GD_SelectedTextSelected = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_GD_Title_BtnBackSelected = self.CO_Main_ThemeColorTwe;
    
    self.BuyLotteryZCjczqGrayImageName = @"buy_zc_jczq";
    self.BuyLotteryZCjclqGrayImageName = @"buy_zc_jclq";
    self.BuyLotteryZCzqsscGrayImageName = @"buy_zc_zq14c";
    self.BuyLotteryZCrxjcGrayImageName = @"buy_zc_rx9c";
    self.BuyLotteryQPdzGrayImageName = @"buy_qp_dz";
    self.BuyLotteryQPerBaGangGrayImageName = @"buy_qp_ebg";
    self.BuyLotteryQPqznnGrayImageName = @"buy_qp_qznn";
    self.BuyLotteryQPzjhGrayImageName = @"buy_qp_zjh";
    self.BuyLotteryQPsgGrayImageName = @"buy_qp_sg";
    self.BuyLotteryQPyzlhGrayImageName = @"buy_qp_yzlh";
    self.BuyLotteryQPesydGrayImageName = @"buy_qp_21d";
    self.BuyLotteryQPtbnnGrayImageName = @"buy_qp_tbnn";
    self.BuyLotteryQPjszjhGrayImageName = @"buy_qp_jszjh";
    self.BuyLotteryQPqzpjGrayImageName = @"buy_qp_qjpj";
    self.BuyLotteryQPsssGrayImageName = @"buy_qp_sss";
    self.BuyLotteryQPxywzGrayImageName = @"buy_qp_xywz";
    
    self.SettingPushImageName = @"setting_tuisong";
    self.SettingShakeImageName = @"setting_yaoyiyao";
    self.SettingVoiceImageName = @"setting_voice";
    self.SettingSwitchSkinImageName = @"setting_caizhonglan";
    self.SettingServiceImageName = @"setting_fuwuxieyi";
    self.SettingAboutUsImageName = @"setting_aboutme";
    self.IC_Me_SettingTopImageName = @"mine_topview_bg";
    self.IC_Me_SettingTopHeadIcon = @"setting_icon";
    
    self.SixGreenBallName = @"kj_sixgreen";
    self.SixBlueBallName = @"kj_sixblue";
    self.SixRedBallName = @"kj_sixred";
    self.SscBlueBallName = @"kj_lq";
    self.SscBallName = @"kj_hq";
    self.PostCircleImageName = @"postcircle";
    self.PostCircleImage = IMAGE(@"postcircle");
    self.CircleUserCenterMiddleBtnBackgroundColor = MAINCOLOR;
    self.CircleUderCenterTopImage = IMAGE(@"circleuserback");
    self.ApplyExpertPlaceholdColor = [UIColor colorWithHex:@"dddddd"];
    self.CO_Account_Info_BtnBack = [UIColor colorWithHex:@"F6C544"];
    self.ApplyExpertConfirmBtnTextColor = [UIColor colorWithHex:@"333333"];
    self.applyExpertBackgroundColor = MAINCOLOR;
    self.ExpertInfoTextColorA = [UIColor colorWithHex:@"dddddd"];
    self.ExpertInfoTextColorB = [UIColor colorWithHex:@"FFFFFF"];
    self.WFSMImage = @"玩法说明";
    
    self.PrizeMessageTopbackViewTextColor = BLACK;
    self.CO_Home_Gonggao_TopBackViewStatus1 = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_Gonggao_TopBackViewStatus2 = [UIColor colorWithHex:@"FFFFFF"];
    self.GraphSetViewBckgroundColor = [UIColor colorWithHex:@"C2A444"];
    
    
    self.IM_AI_BirthdayImage = IMAGE(@"AIbirthday");
    self.IM_AI_ShengXiaoBackImage = IMAGE(@"背面");
    self.IM_AI_ShuImage = IMAGE(@"鼠正面");
    self.IM_AI_GouImage = IMAGE(@"狗正面");
    self.IM_AI_HouImage = IMAGE(@"猴正面");
    self.IM_AI_HuImage = IMAGE(@"虎正面");
    self.IM_AI_JiImage = IMAGE(@"鸡正面");
    self.IM_AI_LongImage = IMAGE(@"龙正面");
    self.IM_AI_MaImage = IMAGE(@"马正面");
    self.IM_AI_NiuImage = IMAGE(@"牛正面");
    self.IM_AI_SheImage = IMAGE(@"蛇正面");
    self.IM_AI_TuImage = IMAGE(@"兔正面");
    self.IM_AI_YangImage = IMAGE(@"羊正面");
    self.IM_AI_ZhuImage = IMAGE(@"猪正面");
    self.TouZhuImage = IMAGE(@"td_xf_button");
    self.IM_AI_ShakeNormalImage = IMAGE(@"摇一摇");
    self.IM_AI_ShengXiaoNormalImage = IMAGE(@"生肖");
    self.IM_AI_LoverNormalImage = IMAGE(@"爱人");
    self.IM_AI_FamilyNormalImage = IMAGE(@"家人");
    self.IM_AI_BirthdayNormalImage = IMAGE(@"生日");
    self.IM_AI_ShakeSeletImage = IMAGE(@"摇一摇2");
    self.IM_AI_ShengXiaoSeletImage = IMAGE(@"生肖2");
    self.IM_AI_LoverSeletImage = IMAGE(@"爱人2");
    self.IM_AI_FamilySeletImage = IMAGE(@"家人2");
    self.IM_AI_BirthdaySeletImage = IMAGE(@"生日2");
    self.IM_AI_BGroundcolorImage = IMAGE(@"爱人生日");
    self.IM_AI_AutoSelectLblNormalColor = [UIColor colorWithHex:@"000000"];
    self.IM_AI_AutoSelectLblSelectColor = [UIColor colorWithHex:@"C6AC7B"];
    
    
    self.AppFistguideUse1 = @"app_guide_1";
    self.AppFistguideUse2 = @"app_guide_2";
    self.AppFistguideUse3 = @"app_guide_3";
    self.registerVcPhotoImage = IMAGE(@"phone");
    self.registerVcCodeImage = IMAGE(@"td_login_confirm");
    self.registerVcPSDImage = IMAGE(@"td_login_lock");
    self.registerVcPSDAgainImage = IMAGE(@"td_login_lock");
    self.registerVcInviteImage = IMAGE(@"td_login_message");
    self.registerVcRegisterBtnBTextColor = BASECOLOR;
    self.registerVcRegisterBtnBckgroundColor = [UIColor colorWithHex:@"ac1e2d"];
    self.LoginVcHiddenImage = IMAGE(@"td_login_show_password");
    self.LoginVcHiddenSelectImage = IMAGE(@"td_login_hid_password");
    self.LoginVcPhoneImage = IMAGE(@"td_login_phone");
    self.loginVcQQimage = IMAGE(@"td_login_QQ");
    self.loginVcWechatimage = IMAGE(@"td_login_wx");
    self.loginLineBackgroundColor = [UIColor colorWithHex:@"666666"];
    self.logoIconImage = IMAGE(@"彩票宝典");
    self.loginVcBgImage = IMAGE(@"td_login_vs_back");
    self.shareToLblTextColor = [UIColor colorWithHex:@"666666"];
    self.shareVcCopyBtnBackgroundColor = [UIColor colorWithHex:@"E5CD98"];
    self.shareVcQQImage = IMAGE(@"shareVcQQImage");
    self.shareVcPYQImage = IMAGE(@"shareVcPYQImage");
    self.shareVcWeChatImage = IMAGE(@"shareVcWeChatImage");
    self.shareLineImage = IMAGE(@"shareLineImage");
    self.OpenLotteryTimeLblTextColor = [UIColor colorWithHex:@"DC612F"];
    self.CO_GD_TopBackgroundColor = [UIColor colorWithHex:@"2E2F33"];
    self.CO_GD_TopBackHeadTitle = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_GD_AllPeople_BtnText = [UIColor colorWithHex:@"#FFFFFF"];
    
    self.IM_GD_DashenTableImgView = IMAGE(@"table");
    self.expertContentLblTextcolor = [UIColor colorWithHex:@"dddddd"];
    self.expertWinlblTextcolor = WHITE;
    self.expertInfoTopImgView = IMAGE(@"zjxq");
    self.circleListDetailViewBackgroundColor = MAINCOLOR;
    self.IM_CircleDetailHeadImage = IMAGE(@"圈子顶部背景图");
    self.MyWalletBankCartImage = IMAGE(@"td_me_wdqb_cell_cart");
    self.MyWalletTopImage = IMAGE(@"mine_topview_bg_hight");
    
    self.CO_MoneyTextColor = [UIColor colorWithHex:@"#c9a974"];
    self.accountInfoNicknameTextColor = [UIColor colorWithHex:@"FFFFFF"];
    
    self.accountInfoTopViewBackgroundColor = MAINCOLOR;
    self.confirmBtnBackgroundColor = [UIColor colorWithHex:@"AC1E2D"];
    self.safeCenterTopImage = IMAGE(@"mine_topview_bg");
    self.CO_Me_TopLabelTitle = [UIColor colorWithHex:@"FFFFFF"];
    self.shareInviteImage = IMAGE(@"fxhy_yqmwz");
    self.shareMainImage = IMAGE(@"shareMainImage");
    self.shareBackImage = IMAGE(@"");
    self.calendarLeftImage = IMAGE(@"");
    self.calendarRightImage = IMAGE(@"");
    self.calendarBackgroundColor = [UIColor groupTableViewBackgroundColor];
    self.KJRLSelectBackgroundColor = CLEAR;
    self.IM_CalendarTopImage = IMAGE(@"td_kj_kjrl");
    self.LHTKTextfieldBackgroundColor = WHITE;
    self.LHTKRemarkTextFeildBorderColor = BLACK;
    self.XSTJdetailZanImage = IMAGE(@"td_xs_zan");
    self.attentionViewCloseImage = IMAGE(@"closeAttention");
    self.backBtnImageName = @"tw_nav_return";
    self.HobbyCellImage = IMAGE(@"勾选");
    
    self.Left_VC_MyWalletImage = @"cdh_wdqb";
    self.Left_VC_SecurityCenterImage = @"cdh_aqzx";
    self.Left_VC_MessageCenterImage = @"cdh_xxzx";
    self.Left_VC_BuyHistoryImage = @"cdh_tzjl";
    self.Left_VC_MyTableImage = @"cdh_wdbb";
    self.Left_VC_SettingCenterImage = @"cdh_szzx";
    
    self.Left_VC_BtnTitleColor = [UIColor colorWithHex:@"ffd994"];
    
    self.Left_VC_ChargeBtnImage = IMAGE(@"cdh_cz");
    self.Left_VC_GetMoneyBtnImage = IMAGE(@"cdh_tx");
    self.Left_VC_KFBtnImage = IMAGE(@"cdh_kf");
    
    self.Left_VC_CellBackgroundColor = [UIColor hexStringToColor:@"1d1e23"];
    self.LeftCtrlCellTextColor = WHITE;
    self.Left_VC_BtnBackgroundColor = [UIColor colorWithHex:@"1D1E24"];
    self.LeftControllerLineColor = [UIColor hexStringToColor:@"FFFFFF" andAlpha:0.5];
    
    self.leftBackViewImageColor = CLEAR;
    self.Left_VC_TopImage = [ColorTool imageWithColor:MAINCOLOR];
    self.mine_seperatorLineColor = [UIColor colorWithHex:@"c8ab7f"];
    self.openPrizePlusColor = [UIColor grayColor];
    self.OpenPrizeWuXing = [UIColor colorWithHex:@"FFFFFF"];
    self.IC_home_sub_SS = @"icon_ss";
    self.IC_home_sub_YC = @"icon_yc";
    self.IC_home_sub_ZJ = @"icon_zj";
    self.IC_home_sub_BF = @"icon_bf";
    self.IC_home_sub_HMZS = @"homesub_1_5";
    self.IC_home_sub_JRHM = @"homesub_3_3";
    self.IC_home_sub_HMYL = @"homesub_3_2";
    self.IC_home_sub_LRFX = @"homesub_3_5";
    self.IC_home_sub_GYHTJ = @"homesub_3_7";
    self.IC_home_sub_LMCL = @"homesub_3_8";
    self.IC_home_sub_LMLZ = @"homesub_3_9";
    self.IC_home_sub_LMYL = @"homesub_3_10";
    self.IC_home_sub_QHLZ = @"homesub_3_11";
    self.IC_home_sub_LMLS = @"homesub_3_12";
    self.IC_home_sub_GYHLZ = @"homesub_3_13";
    self.IC_home_sub_HBZS = @"homesub_3_141";
    self.IC_home_sub_YLTJ = @"homesub_1_2";
    self.IC_home_sub_JRTJ = @"homesub_3_15";
    self.IC_home_sub_MFTJ = @"homesub_3_4";
    self.IC_home_sub_QXT = @"td_sub_曲线图";
    self.IC_home_sub_TMZS = @"td_sub_tmzs";
    self.IC_home_sub_GSSH = @"homesub_3_6";
    self.IC_home_sub_History = @"homesub_3_1";
    self.IC_home_sub_XSTJ = @"homesub_3_4";
    self.IC_home_sub_LHTK = @"homesub_2_2";
    self.IC_home_sub_CXZS = @"homesub_2_4";
    self.IC_home_sub_ZXTJ = @"homesub_2_5";
    self.IC_home_sub_KJRL = @"homesub_2_6";
    self.IC_home_sub_AIZNXH = @"homesub_2_8";
    self.IC_home_sub_SXCZ = @"homesub_2_9";
    self.IC_home_sub_TMLS = @"homesub_2_10";
    self.IC_home_sub_ZMLS = @"homesub_2_11";
    self.IC_home_sub_WSDX = @"homesub_2_12";
    self.IC_home_sub_SXTM = @"homesub_2_13";
    self.IC_home_sub_SXZM = @"homesub_2_14";
    self.IC_home_sub_BSTM = @"homesub_2_15";
    self.IC_home_sub_BSZM = @"homesub_2_16";
    self.IC_home_sub_TMLM = @"homesub_2_17";
    self.IC_home_sub_TMWS = @"homesub_2_18";
    self.IC_home_sub_ZMWS = @"homesub_2_19";
    self.IC_home_sub_ZMZF = @"homesub_2_20";
    self.IC_home_sub_HMBD = @"homesub_2_21";
    self.IC_home_sub_JQYS = @"homesub_2_22";
    self.IC_home_sub_LMZS = @"homesub_3_14";
    self.IC_home_sub_LXZS = @"homesub_2_24";
    self.IC_home_sub_LHDS = @"icon_sy_lhds";
    self.IC_home_sub_History = @"homesub_3_1";
    self.IM_Home_cartBgImageView = IMAGE(@"");
    self.CO_buyLotBgColor = [UIColor colorWithHex:@"#2E3038"];
    
    self.OpenLotteryVC_ColorLabs_TextB = [UIColor colorWithHex:@"666666"];
    self.CO_Me_ItemTextcolor = [UIColor colorWithHex:@"999999"];
    
    //我的
    self.IM_Me_MyWalletImage = IMAGE(@"wdqb");
    self.IM_Me_MyAccountImage = IMAGE(@"账户信息");
    self.IM_Me_SecurityCnterImage = IMAGE(@"我的我的安全中心");
    self.IM_Me_MyTableImage = IMAGE(@"wdbb");
    self.IM_Me_buyHistoryImage = IMAGE(@"tzjl");
    self.IM_Me_MessageCenterImage = IMAGE(@"消息中心");
    self.IM_Me_setCenterImage = IMAGE(@"我的设置icon");
    self.IM_Me_shareImage = IMAGE(@"wd_fxicon");
    self.CO_Me_SubTitleText = [UIColor colorWithHex:@"FFFFFF"];
    
    
    self.IM_Me_MoneyRefreshBtn = IMAGE(@"mine_moneyRef");
    self.IM_Me_ChargeImage = IMAGE(@"td_me_wycz");
    self.IM_Me_GetMoneyImage = IMAGE(@"td_me_mstx");
    self.IM_Me_MoneyDetailImage = IMAGE(@"td_me_zjmx");
    
    
    self.CO_BuyLot_Left_ViewBack = [UIColor colorWithHex:@"#27282d"];
    self.CO_BuyLot_Left_LeftCellBack = [UIColor colorWithHex:@"#27282D"];
    self.CO_BuyLot_Left_LeftCellTitleText = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_BuyLot_Left_LeftCellBack_Selected = [UIColor colorWithHex:@"#ac1e2d"];
    self.CO_BuyLot_Left_LeftCellTitleText_Selected = [UIColor colorWithHex:@"#EACD91"];
    self.CO_BuyLot_Left_CellBack = [UIColor colorWithHex:@"#27282D"];
    self.CO_BuyLot_Left_CellTitleText = [UIColor colorWithHex:@"#EACD91"];
    
    
    self.IM_topBackImageView = IMAGE(@"wd_bj");
    self.CO_Me_YuEText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Mine_setContentViewBackgroundColor = [UIColor colorWithHex:@"1D1E24"];
    //圈子
    self.circleHomeCell1Bgcolor = @"";
    self.circleHomeCell2Bgcolor = @"";
    self.circleHomeCell3Bgcolor = @"";
    self.circleHomeCell4Bgcolor = @"";
    self.circleHomeCell5Bgcolor = @"";
    self.circleHomeSDQImageName = @"icon_sdq";
    self.circleHomeGDDTImageName = @"icon_gddt";
    self.circleHomeXWZXImageName = @"icon_xwzx";
    self.circleHomeDJZXImageName = @"icon_djzx";
    self.circleHomeZCZXImageName = @"icon_zczx";
    self.circleHomeBgImage = IMAGE(@"");
    self.CO_LongDragonTopView = [UIColor colorWithHex:@"1D1E23"];
    self.CO_LongDragonTopViewBtn =  [UIColor colorWithHex:@"#B39660"];
    
    //首页
    self.CO_home_SubCellTitleText = [UIColor colorWithHex:@"999999"];
    self.IM_home_SanJiaoImage = IMAGE(@"三角形箭头");
    self.IM_home_hotNewsImageName = IMAGE(@"热门资讯");
    self.CO_home_SubheaderBallBtnBack = [UIColor colorWithHex:@"c22122"];
    
    self.IM_home_XSTJImage = IMAGE(@"心水推荐");
    self.IM_home_LHDSImage = IMAGE(@"icon_lhds");
    self.IM_home_LHTKImage = IMAGE(@"六合图库home");
    self.IM_home_GSSHImage = IMAGE(@"公式杀号home");
    self.IC_home_ZBKJImageName = @"homeZBKJ";
    self.IC_home_LSKJImageName = @"img_lskj";
    self.IC_home_CXZSImageName = @"homeCXZS";
    
    
    
    self.IC_Home_CQSSC = @"重庆时时彩";
    self.IC_Home_LHC = @"六合彩";
    self.IC_Home_BJPK10 = @"北京PK10";
    self.IC_Home_XJSSC = @"新疆时时彩";
    self.IC_Home_XYFT = @"幸运飞艇";
    self.IC_Home_TXFFC = @"比特币分分彩";
    self.IC_Home_PCDD = @"PC蛋蛋";
    self.IC_Home_ZCZX = @"足彩资讯";
    self.IC_Home_AZF1SC = @"六合彩";
    self.IC_Home_GDCZ = @"更多彩种";
    
    self.IC_Home_Icon_BeginName = @"td_";
    
    self.CO_LiveLot_BottomBtnBack = [UIColor colorWithHex:@"#AC1E2D"];
    self.CO_LiveLot_CellLabelBack = [UIColor colorWithHex:@"#BAA069"];
    self.CO_LiveLot_CellLabelText = [UIColor colorWithHex:@"#FFFFFF"];
    
    self.CO_ChatRoomt_SendBtnBack = self.CO_Main_ThemeColorTwe;
    
    
    self.xinshuiDetailAttentionBtnNormalGroundColor = BASECOLOR;
    self.pushDanBarTitleSelectColot = BASECOLOR;
    self.pushDanSubBarNormalTitleColor = [UIColor colorWithHex:@"666666"];
    self.pushDanSubBarSelectTextColor = BASECOLOR;
    
    self.pushDanSubbarBackgroundcolor = [UIColor colorWithHex:@"000000"];
    self.CO_LongDragon_PushSetting_BtnBack = self.CO_Main_ThemeColorTwe;
    self.pushDanBarTitleNormalColor = [UIColor colorWithHex:@"EEEEEE"];
    self.CO_Circle_Cell2_TextLabel_BackgroundC = [UIColor colorWithHex:@"9e353c"];
    self.CO_Circle_Cell2_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"9e353c"];
    self.CO_Circle_Cell3_TextLabel_BackgroundC = [UIColor colorWithHex:@"647e24"];
    self.CO_Circle_Cell1_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"5649b3"];
    self.bettingBtnColor = BUTTONCOLOR;
    self.xinshuiDetailAttentionBtnBackGroundColor = MAINCOLOR;
    self.LoginNamePsdPlaceHoldColor = [UIColor colorWithHex:@"7a6d4c"];
    self.missCaculateBarNormalBackground = MAINCOLOR;
    self.missCaculateBarselectColor = BASECOLOR;
    self.missCaculateBarNormalColor = WHITE;
    self.openLotteryCalendarBackgroundcolor = MAINCOLOR;
    self.openLotteryCalendarTitleColor = kColor(43, 43, 43);
    self.openLotteryCalendarWeekTextColor = WHITE;
    self.CO_OpenLot_BtnBack_Normal = [UIColor groupTableViewBackgroundColor];
    self.CO_OpenLot_BtnBack_Selected = [UIColor colorWithHex:@"EACD91"];
    self.CO_Home_Gonggao_TopTitleText = [UIColor colorWithHex:@"333333"];
    self.CO_Home_Gonggao_Cell_MessageTopViewBack = [UIColor colorWithHex:@"FFFFFF"];
    self.KeyTitleColor = [UIColor colorWithHex:@"fed696"];
    
    
    self.xinshuiRemarkTitleColor = BASECOLOR;
    
    self.sixHeTuKuRemarkbarBackgroundcolor = MAINCOLOR;
    self.myCircleUserMiddleViewBackground = [UIColor colorWithHex:@"2C3036"];
    self.openCalendarTodayColor = [UIColor redColor];
    self.openCalendarTodayViewBackground = [UIColor colorWithHex:@"C6AC7B"];
    self.LoginNamePsdTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.MineTitleStrColor = [UIColor colorWithHex:@"eacd91"];
    self.MessageTitleColor  = WHITE;
    
    self.xinshuiBottomViewTitleColor = BASECOLOR;
    self.CO_KillNumber_LabelText = [UIColor colorWithHex:@"00008B"];
    self.CO_KillNumber_LabelBack = [UIColor colorWithHex:@"F9EBD5"];
    self.CO_Home_SubHeaderTitleColor = [UIColor colorWithHex:@"FFFFFF"];;
    self.CO_Home_SubHeaderSubtitleColor = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_SubheaderTimeLblText = [UIColor colorWithHex:@"F4D958"];;
    self.CO_Home_SubheaderLHCSubtitleText = [UIColor colorWithHex:@"dddddd"];
    self.TopUpViewTopViewBackgroundcolor = CLEAR;
    self.chargeMoneyLblSelectColor = [UIColor colorWithHex:@"FFFFFF"];
    self.chargeMoneyLblSelectBackgroundcolor = [UIColor colorWithHex:@"ac1e2d"];
    self.chargeMoneyLblNormalColor = [UIColor colorWithHex:@"C48936"];
    self.tabbarItemTitleColor = [UIColor lightGrayColor];
    
    self.RootVC_ViewBackgroundC = [UIColor colorWithHex:@"1D1E24"];
    self.tabbarItemTitleColor = [UIColor lightGrayColor];
    self.CO_Circle_Cell3_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"6d872f"];
    self.CO_Circle_Cell4_TextLabel_BackgroundC = [UIColor colorWithHex:@"3ea358"];
    self.CO_Circle_Cell4_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"3ea358"];
    self.tixianShuoMingColor = BUTTONCOLOR;
    
    self.CircleVC_HeadView_BackgroundC = [UIColor colorWithHex:@"303136"];
    self.CO_Circle_Cell_BackgroundC = [UIColor colorWithHex:@"3a3b40"];
    self.CO_Circle_Cell_TextLabel_BackgroundC = [UIColor colorWithHex:@"fed696"];
    self.CO_Circle_Cell_DetailTextLabel_BackgroundC = [UIColor whiteColor];
    self.CO_Home_VC_NoticeView_Back = [UIColor colorWithHex:@"#2B2E37"];
    self.CO_Home_VC_NoticeView_LabelText = [UIColor colorWithHex:@"8D8D8D"];
    self.CO_Home_NoticeView_LabelText = [UIColor colorWithHex:@"#DDDDDD"];
    self.CO_Home_CellCartCellSubtitleText = [UIColor colorWithHex:@"aaaaaa"];
    self.CO_Home_VC_HeadView_Back = [UIColor colorWithHex:@"1D1E24"];
    self.CO_Home_NewsTopViewBack = [UIColor colorWithHex:@"#2C2E36"];
    self.CO_Home_NewsBgViewBack = [UIColor colorWithHex:@"1D1E24"];
    self.CO_Home_News_LineView = [UIColor blackColor];
    self.CO_Home_News_HeadTitleText = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Home_News_ScrollLabelText = [UIColor colorWithHex:@"#FDF8F8"];
    self.CO_Home_VC_HeadView_HotMessLabelText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_CollectionView_CartCellTitle = [UIColor colorWithHex:@"FFFFFF"];
    
    self.CartBarBackgroundColor = [UIColor colorWithHex:@"1d1e24"];
    self.CartBarTitleNormalColor = [UIColor colorWithHex:@"FFFFFF"];
    self.CartBarTitleSelectColor = self.CO_NavigationBar_Title;
    self.CartHomeHeaderSeperatorColor = [UIColor colorWithHex:@"ff9711"];
    self.genDanHallTitleNormalColr = [UIColor colorWithRed:0.612 green:0.612 blue:0.616 alpha:1.000];
    self.genDanHallTitleSelectColr = [UIColor colorWithRed:0.773 green:0.651 blue:0.427 alpha:1.000];;
    self.genDanHallTitleBackgroundColor = [UIColor colorWithRed:0.180 green:0.184 blue:0.200 alpha:1.000];;
    self.gongShiShaHaoFormuTitleNormalColor = [UIColor colorWithHex:@"FFFFFF"];
    self.gongShiShaHaoFormuTitleSelectColor = BASECOLOR;
    self.gongshiShaHaoFormuBtnBackgroundColor = BLACK;
    
    self.CO_Home_VC_HeadView_NumbrLables_Text = [UIColor colorWithHex:@"FDFDFD"];
    self.CO_Home_News_HotHeadViewBack = [UIColor colorWithHex:@"#2C2E36"];
    self.CO_Home_VC_Cell_ViewBack = [UIColor colorWithHex:@"2E3238"];
    self.IM_Home_HeadlineImg = IMAGE(@"td_CPT头条");
    self.CO_Home_HeadlineLabelText = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Home_HeadlineLineView = [UIColor colorWithHex:@"#CCCCCC"];
    self.IM_Home_BottomBtnOne = IMAGE(@"home_bottom_联系客服");
    self.IM_Home_BottomBtnTwo = IMAGE(@"home_bottom_聊天室");
    self.IM_Home_BottomBtnThree = IMAGE(@"home_bottom_网页版");
    self.CO_Home_VC_Cell_Titlelab_Text = [UIColor colorWithHex:@"FDFDFD"];
    self.CO_Home_VC_Cell_SubTitlelab_Text = [UIColor colorWithHex:@"8D8D8D"];
    self.CO_Home_VC_ADCollectionViewCell_Back = [UIColor colorWithHex:@"1D1E24"];
    self.CO_Home_CellBackgroundColor = [UIColor colorWithHex:@"#1d1e25"];
    
    self.CO_Home_CellContentView = [UIColor colorWithHex:@"#2C2E36"];
    self.CO_Home_VC_PCDanDan_ViewBack2 = [UIColor colorWithHex:@"1D1E24"];
    
    self.CO_Home_VC_PCDanDan_line_ViewBack = [UIColor colorWithHex:@"666666"];
    self.OpenLotteryVC_ColorLabs_TextC = [UIColor colorWithHex:@"DC612F"];
    self.OpenLotteryVC_ColorLabs1_TextC = [UIColor colorWithHex:@"8D8D8D"];
    self.OpenLotteryVC_SubTitle_TextC = [UIColor colorWithHex:@"D6D6D6"];
    self.OpenLotteryVC_SubTitle_BorderC = [UIColor colorWithHex:@"8D8D8D"];
    self.OpenLotteryVC_Cell_BackgroundC = [UIColor colorWithHex:@"3a3b3f"];
    self.OpenLotteryVC_View_BackgroundC = [UIColor colorWithHex:@"1D1E24"];
    self.CO_LongDragonCell = CLEAR;
    self.OpenLotteryVC_TitleLabs_TextC = [UIColor colorWithHex:@"333333"];
    self.OpenLotteryVC_SeperatorLineBackgroundColor = [UIColor colorWithHex:@"333333"];
    self.CO_OpenLetBtnText_Normal = [UIColor colorWithHex:@"#737373"];
    self.SixRecommendVC_View_BackgroundC = [UIColor colorWithHex:@"f4f4f4"];
    self.MineVC_Btn_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    
    self.HobbyVC_MessLab_BackgroundC = [UIColor colorWithHex:@"1D1E24"];
    self.HobbyVC_MessLab_TextC = [UIColor lightGrayColor];
    self.HobbyVC_View_BackgroundC = [UIColor colorWithHex:@"2C2E35"];
    self.HobbyVC_OKButton_BackgroundC = [UIColor colorWithHex:@"9E2D32"];
    self.HobbyVC_OKButton_TitleBackgroundC = [UIColor colorWithHex:@"FDFDFD"];
    self.Circle_Title_nameColor = [UIColor colorWithHex:@"4e79c2"];
    self.HobbyVC_SelButton_TitleBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.HobbyVC_UnSelButton_TitleBackgroundC = [UIColor lightGrayColor];
    self.CO_Circle_Cell1_TextLabel_BackgroundC = self.CO_Circle_Cell_TextLabel_BackgroundC;
    self.HobbyVC_SelButton_BackgroundC = [UIColor colorWithHex:@"9E2D32"];
    self.HobbyVC_UnSelButton_BackgroundC = [UIColor colorWithHex:@"1D1E24"];
    self.Circle_View_BackgroundC = [UIColor colorWithHex:@"1D1E24"];
    self.Circle_HeadView_Title_UnSelC = [UIColor colorWithHex:@"999999"];
    self.Circle_HeadView_Title_SelC = [UIColor colorWithHex:@"333333"];
    self.Circle_HeadView_BackgroundC = [UIColor colorWithHex:@"393B44"];
    self.Circle_HeadView_NoticeView_BackgroundC = [UIColor colorWithHex:@"2D2D32"];
    self.Circle_HeadView_GuangBo_BackgroundC = [UIColor colorWithHex:@"8D8D8D"];
    self.Circle_Cell_BackgroundC = [UIColor colorWithHex:@"2C3036"];
    self.Circle_Cell_ContentlabC = [UIColor whiteColor];
    self.Circle_Cell_Commit_BackgroundC = [UIColor colorWithHex:@"2D2F36"];
    self.Circle_Cell_Commit_TitleC = [UIColor whiteColor];
    self.Circle_Cell_AttentionBtn_TitleC = [UIColor lightGrayColor];
    self.Circle_Line_BackgroundC = [UIColor colorWithHex:@"fed696"];
    self.Circle_remark_nameColor = [UIColor colorWithHex:@"4e79c2"];
    self.getCodeBtnvBackgroundcolor = [UIColor colorWithHex:@"dddddd"];
    self.Circle_FooterViewLine_BackgroundC = [UIColor darkGrayColor];
    self.OpenLottery_S_Cell_BackgroundC = [UIColor colorWithHex:@"3A3B40"];
    self.OpenLottery_S_Cell_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    self.Login_NamePasswordView_BackgroundC = CLEAR;//[UIColor colorWithHex:@"2c2e36"];
    self.Login_ForgetSigUpBtn_BackgroundC = [UIColor colorWithHex:@"2c2e36" Withalpha:0.5];
    self.Login_ForgetSigUpBtn_TitleC = [UIColor colorWithHex:@"a3905c"];
    self.Login_LogoinBtn_BackgroundC = [UIColor colorWithHex:@"ac1e2d"];
    self.Login_LogoinBtn_TitleC = [UIColor colorWithHex:@"eacd91"];
    self.Buy_LotteryMainBackgroundColor = [UIColor colorWithHex:@"1B1E23"];
    self.RootWhiteC = [UIColor colorWithHex:@"f4f4f4"];
    self.CO_OpenLetBtnText_Selected = [UIColor colorWithHex:@"#333333"];
    self.loginSeperatorLineColor = [UIColor colorWithHex:@"887c5a"];
    self.getCodeBtnvTitlecolor = [UIColor colorWithHex:@"#888888"];
    self.LiuheTuKuLeftTableViewBackgroundColor = [UIColor colorWithHex:@"e0e0e0"];
    self.LiuheTuKuOrangeColor = [UIColor colorWithHex:@"c9a356"];
    self.LiuheTuKuLeftTableViewSeperatorLineColor = [UIColor colorWithHex:@"c2c2c2"];
    self.LiugheTuKuTopBtnGrayColor = [UIColor colorWithHex:@"dddddd"];
    self.LiuheTuKuProgressValueColor = [UIColor colorWithHex:@"f5222d"];
    self.LiuheTuKuTouPiaoBtnBackgroundColor = [UIColor colorWithHex:@"c60000"];
    self.LiuheDashendBackgroundColor = MAINCOLOR;
    
    self.xinShuiReconmentGoldColor = [UIColor colorWithHex:@"ffd994"];
    self.xinShuiReconmentRedColor = [UIColor colorWithHex:@"C01833"];
    self.TouPiaoContentViewTopViewBackground = [UIColor colorWithHex:@"16171b"];
    self.LiuheTuKuRemarkBarBackgroundColor = [UIColor colorWithHex:@"16171b"];
    self.LiuheTuKuRemarkSendBackgroundColor = [UIColor colorWithHex:@"e51c23"];
    self.LiuheTuKuTextRedColor = [UIColor colorWithHex:@"d71820"];
    self.XinshuiRecommentScrollBarBackgroundColor = [UIColor colorWithHex:@"f0f0f0"];
    self.xinshuiBottomVeiwSepeLineColor = [UIColor lightGrayColor];
    self.Circle_Post_titleSelectColor = [UIColor colorWithHex:@"FFFFFF"];
    self.Circle_Post_titleNormolColor = [UIColor lightGrayColor];
    
#pragma mark 购彩
    //购彩
    self.Buy_HeadView_BackgroundC = [UIColor colorWithHex:@"2D2F37"];
    self.Buy_HeadView_Footer_BackgroundC = [UIColor colorWithHex:@"1D1E24"];
    
    self.Buy_HeadView_Title_C = [UIColor colorWithHex:@"999999"];
    
    self.Buy_LeftView_BackgroundC = [UIColor colorWithHex:@"1c1e23"];
    self.Buy_LeftView_Btn_BackgroundUnSel = IMAGE(@"Buy_LeftView_Btn_BackgroundUnSel");
    self.Buy_LeftView_Btn_BackgroundSel = IMAGE(@"Buy_LeftView_Btn_BackgroundSel");
    self.Buy_LeftView_Btn_TitleSelC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_LeftView_Btn_TitleUnSelC = [UIColor colorWithHex:@"999999"];
    self.Buy_LeftView_Btn_PointUnSelC = [UIColor colorWithHex:@"ff5d10"];
    self.Buy_LeftView_Btn_PointSelC = [UIColor colorWithHex:@"01ae00"];
    self.Buy_RightBtn_Title_UnSelC = [UIColor colorWithHex:@"333333"];
    self.Buy_RightBtn_Title_SelC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionHeadV_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionHeadV_ViewC = [UIColor colorWithHex:@"ff5d12"];
    self.CO_Bottom_LabelText = [UIColor colorWithHex:@"#FFFFFF"];
    
    self.Buy_CollectionCellButton_BackgroundSel = [UIColor colorWithHex:@"AC1E2D"];
    self.Buy_HeadView_historyV_Cell1_C = [UIColor colorWithHex:@"222429"];
    self.Buy_HeadView_historyV_Cell2_C = [UIColor colorWithHex:@"1D1E24"];
    self.Buy_CollectionCellButton_TitleCSel = [UIColor colorWithHex:@"FFE292"];
    self.Buy_CollectionCellButton_TitleCUnSel = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionViewLine_C = [UIColor colorWithHex:@"43464F"];
    self.Buy_CollectionCellButton_SubTitleCSel = [UIColor colorWithHex:@"F2B68A"];
    self.Buy_CollectionCellButton_SubTitleCUnSel = [UIColor colorWithHex:@"999999"];
    
    self.CO_BuyLot_HeadView_LabelText = [UIColor colorWithHex:@"d8d9d6"];
    self.CO_BuyLot_HeadView_Label_border = [UIColor colorWithHex:@"666666"];
    self.CO_BuyLot_Right_bcViewBack = [UIColor colorWithHex:@"999999"];
    self.CO_BuyLot_Right_bcView_border = [UIColor colorWithHex:@"999999"];
    
    self.Buy_CollectionCellButton_BackgroundUnSel = [UIColor colorWithHex:@"2c3036"];
    self.CO_Home_Buy_Footer_BtnBack = [UIColor colorWithHex:@"9C2D33"];
    self.CO_Home_Buy_Footer_Back = [UIColor colorWithHex:@"1B1E23"];
    self.CartHomeSelectSeperatorLine = [UIColor colorWithHex:@"ff9711"];
    //我的
    self.Mine_ScrollViewBackgroundColor = [UIColor colorWithHex:@"1D1E24"];
    self.grayColor999 = [UIColor colorWithHex:@"999999"];
    self.grayColor666 = [UIColor colorWithHex:@"666666"];
    self.grayColor333 = [UIColor colorWithHex:@"333333"];
    self.Mine_rightBtnTileColor = [UIColor colorWithHex:@"FFFFFF"];
    self.Mine_priceTextColor = [UIColor colorWithHex:@"ffe822"];
    self.ChangePsdViewBackgroundcolor = [UIColor colorWithHex:@"F7F7F7"];
    self.CO_Me_MyWallerBalance_MoneyText = [UIColor colorWithHex:@"#FFEA00"];
    self.CO_Me_MyWallerBalanceText = [UIColor colorWithHex:@"#FFFFFF"];
    self.MyWalletTotalBalanceColor = [UIColor colorWithHex:@"fff666"];
    self.mineInviteTextCiolor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.6];
    self.CO_Me_MyWallerTitle = [UIColor colorWithHex:@"#E9E9E9"];
    //购彩 番摊 dark
    
#pragma mark番摊 dark
    self.NN_LinelColor = [UIColor colorWithHex:@"282B31"];
    self.NN_xian_normalColor = [UIColor colorWithHex:@"79787B"];
    self.NN_xian_selColor = [UIColor colorWithHex:@"E01932"];
    self.NN_Xian_normalImg = @"xianjia-gray";
    self.NN_Xian_selImg = @"xianjia-color";
    self.NN_zhuang_normalColor = [UIColor colorWithHex:@"79787B"];
    self.NN_zhuang_selColor = [UIColor colorWithHex:@"926B29"];
    self.NN_zhuang_normalImg = @"xianjia-gray";
    
    self.NN_zhuang_selImg = @"zhuangjia-color";
    
    self.NN_XianBgImg = [UIImage imageNamed:@"xianjia-xuanzhong"];
    self.NN_XianBgImg_sel = [UIImage imageNamed:@"xianjia"];
    self.Buy_NNXianTxColor_normal = [UIColor blackColor];
    self.Buy_NNXianTxColor_sel = [UIColor whiteColor];
    self.Fantan_headerLineColor = [UIColor colorWithHex:@"43464E"];
    self.Fantan_historyHeaderBgColor = [UIColor colorWithHex:@"181B20"];
    self.Fantan_historyHeaderLabColor = [UIColor colorWithHex:@"949596"];
    self.Fantan_historycellColor1 = [UIColor colorWithHex:@"979899"];
    self.Fantan_historycellColor2 = [UIColor colorWithHex:@"40454C"];
    self.Fantan_historycellColor3 = [UIColor colorWithHex:@"EB6730"];
    self.Fantan_historycellOddColor = [UIColor blackColor];
    self.Fantan_historycellEvenColor = [UIColor blackColor];
    self.CO_Fantan_HeadView_Label = [UIColor colorWithHex:@"FFFFFF"];
    
    
    
    self.RedballImg_normal = @"img_redball_normal";
    self.RedballImg_sel = @"img_redball_selected";
    self.BlueballImg_normal = @"img_blueball_normal";
    self.BlueballImg_sel = @"img_blueball_selected";
    
    self.Fantan_MoneyColor = [UIColor colorWithHex:@"D55D2D"];
    self.Fantan_CountDownBoderColor = [UIColor colorWithHex:@"20252C"];
    self.Fantan_CountDownBgColor = [UIColor colorWithHex:@"21252B"];
    self.Buy_fantanTimeColor = [UIColor colorWithHex:@"EB6831"];
    self.Fantan_DelImg = IMAGE(@"cartclear");
    self.Fantan_ShakeImg = IMAGE(@"cartrandom");
    self.Fantan_AddToBasketImg = IMAGE(@"cartset");
    self.Fantan_basketImg = IMAGE(@"cart");
    
    self.Fantan_FloatImgUp = IMAGE(@"buy_up");
    self.Fantan_FloatImgDown = IMAGE(@"buy_down");
    self.Fantan_AddImg = IMAGE(@"buy_add");
    self.Fantan_JianImg = IMAGE(@"buy_jj");
    self.Buy_fantanBgColor = [UIColor colorWithHex:@"2d2f37"];
    self.Fantan_SpeakerImg = IMAGE(@"buy_music");
    //    self.Buy_fantanCellBgColor = [UIColor colorWithHex:@"715FE3"];
    self.Buy_fantanCellBgColor = [UIColor colorWithHex:@"000000"];
    self.Fantan_iconColor = [UIColor colorWithHex:@"BB342B"];
    self.FantanColor1 = [UIColor colorWithHex:@"282830"];
    self.FantanColor2 = [UIColor colorWithHex:@"28292E"];
    self.FantanColor3 = [UIColor colorWithHex:@"20252C"];
    self.FantanColor4 = [UIColor colorWithHex:@"22242b"];
    self.Fantan_textFieldColor = [UIColor colorWithHex:@"16191D"];
    self.CO_Fantan_textFieldTextColor = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_BuyLotBottomView_TopView3_BtnText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_BuyLotBottomView_BotView2_BtnBack = self.CO_Main_ThemeColorTwe;
    self.Fantan_tfPlaceholdColor = [UIColor grayColor];
    self.CO_Buy_textFieldText = [UIColor colorWithHex:@"#FFFFFF"];
    self.Fantan_labelColor = [UIColor colorWithHex:@"909192"];
    
    self.blackOrWhiteColor = [UIColor colorWithHex:@"1d1e23"];
    self.CO_LHTK_SubmitBtnBack = [UIColor colorWithHex:@"C6312C"];
    
    self.MyWallerBalanceBottomViewColor = [UIColor colorWithHex:@"e9e9e9"];
}





















#pragma mark - whiteTheme 白色版
- (void)whiteTheme {
    
    self.CO_Main_ThemeColorOne = [UIColor colorWithHex:@"FFFFFF"];   // 主题色1;  白色
    self.CO_Main_ThemeColorTwe = [UIColor colorWithHex:@"5DADFF"];   // 主题色2;  蓝色
    self.CO_Main_LineViewColor = [UIColor colorWithHex:@"#CCCCCC"];   // 线条颜色
    self.CO_Main_LabelNo1 = [UIColor colorWithHex:@"#333333"];
    self.CO_Main_LabelNo2 = [UIColor colorWithHex:@"#CCCCCC"];
    self.CO_Main_LabelNo3 = [UIColor colorWithHex:@"#FFFFFF"];
    
    
    /// ****** TabBar ******
    self.IC_TabBar_Home = @"tw_tab_home";
    self.IC_TabBar_Home_Selected = @"tw_tab_home_selected";
    self.IC_TabBar_KJ_ = @"tw_tab_kj";
    self.IC_TabBar_KJ_Selected = @"tw_tab_kj_selected";
    self.IC_TabBar_GC = @"tw_tab_gc";
    self.IC_TabBar_GC_Selected = @"tw_tab_gc";
    self.IC_TabBar_QZ = @"tw_tab_qz";
    self.IC_TabBar_QZ_Selected = @"tw_tab_qz_selected";
    self.IC_TabBar_Me = @"tw_tab_me";
    self.IC_TabBar_Me_Selected = @"tw_tab_me_selected";
    self.CO_TabBarTitle_Normal = [UIColor colorWithHex:@"666666"];
    self.CO_TabBarTitle_Selected = [UIColor colorWithHex:@"5DADFF"];
    self.CO_TabBarBackground = [UIColor colorWithHex:@"FFFFFF"];
    
    
    /// ****** Nav ******
    self.CO_Nav_Bar_NativeViewBack = [UIColor colorWithHex:@"5DADFF"];  // 无效
    self.CO_NavigationBar_TintColor = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_NavigationBar_Title = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Nav_Bar_CustViewBack = self.CO_Main_ThemeColorTwe;   // 主题色2
    
    self.IM_Nav_TitleImage_Logo = IMAGE(@"tw_nav_hometitle_logo");
    self.IC_Nav_ActivityImageStr = @"tw_activity_icon";
    self.IC_Nav_SideImageStr = @"tw_menu_icon";
    self.IC_Nav_CircleTitleImage = @"tw_nav_circle_center";
    self.IC_Nav_Setting_Icon = @"tw_nav_setting_icon";
    self.IC_Nav_Setting_Gear = @"td_nav_setting";
    self.IC_Nav_Kefu_Text = @"tw_nav_online_kf";
    
    
#pragma mark Home
    
    
    self.CO_Home_VC_NoticeView_Back = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_VC_NoticeView_LabelText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_NoticeView_LabelText = [UIColor colorWithHex:@"#4D4D4D"];
    self.CO_Home_CellCartCellSubtitleText = [UIColor colorWithHex:@"#999999"];
    self.CO_Home_VC_HeadView_Back = CLEAR;
    self.CO_Home_NewsTopViewBack = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Home_NewsBgViewBack = [UIColor colorWithHex:@"#eff2f5"];
    self.CO_Home_News_LineView = [UIColor colorWithHex:@"#CCCCCC"];
    self.CO_Home_News_HeadTitleText = [UIColor colorWithHex:@"#808080"];
    self.CO_Home_News_ScrollLabelText = [UIColor colorWithHex:@"#333333"];
    self.CO_Home_VC_HeadView_HotMessLabelText = [UIColor colorWithHex:@"#000000"];
    self.CO_Home_CollectionView_CartCellTitle = [UIColor colorWithHex:@"#333333"];
    self.CO_Home_VC_HeadView_NumbrLables_Text = [UIColor colorWithHex:@"FDFDFD"];
    self.CO_Home_News_HotHeadViewBack = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_VC_Cell_ViewBack = [UIColor colorWithHex:@"#eff2f5"];
    
    self.IM_Home_HeadlineImg = IMAGE(@"tw_CPT头条");
    self.CO_Home_HeadlineLabelText = [UIColor colorWithHex:@"#4D4D4D"];
    self.CO_Home_HeadlineLineView = [UIColor colorWithHex:@"#CCCCCC"];
    
    self.IM_Home_BottomBtnOne = IMAGE(@"tw_bottom_lxkf");
    self.IM_Home_BottomBtnTwo = IMAGE(@"tw_bottom_lts");
    self.IM_Home_BottomBtnThree = IMAGE(@"tw_bottom_wyb");
    
    self.CO_Home_VC_Cell_Titlelab_Text = [UIColor colorWithHex:@"333333"];
    self.CO_Home_VC_Cell_SubTitlelab_Text = [UIColor colorWithHex:@"#999999"];
    self.CO_Home_VC_ADCollectionViewCell_Back = CLEAR;
    self.CO_Home_CellBackgroundColor = [UIColor colorWithHex:@"#eff2f5"];
    self.CO_Home_CellContentView = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Home_VC_PCDanDan_ViewBack2 = [UIColor colorWithHex:@"FFFFFF"];
    
    self.CO_Home_VC_PCDanDan_line_ViewBack = [UIColor colorWithHex:@"999999"];
    
    self.CO_Home_SubHeaderTitleColor = [UIColor colorWithHex:@"333333"];;
    self.CO_Home_SubHeaderSubtitleColor = [UIColor colorWithHex:@"3B3A3C"];
    self.CO_Home_SubheaderTimeLblText = [UIColor colorWithHex:@"7f70dc"];;
    self.CO_Home_SubheaderLHCSubtitleText = self.KeyTitleColor;
    
    self.IC_Home_CQSSC = @"重庆时时彩";
    self.IC_Home_LHC = @"六合彩";
    self.IC_Home_BJPK10 = @"北京PK10";
    self.IC_Home_XJSSC = @"新疆时时彩";
    self.IC_Home_XYFT = @"幸运飞艇";
    self.IC_Home_TXFFC = @"比特币分分彩";
    self.IC_Home_PCDD = @"PC蛋蛋";
    self.IC_Home_ZCZX = @"足彩资讯";
    self.IC_Home_AZF1SC = @"六合彩";
    self.IC_Home_GDCZ = @"更多彩种";
    
    self.IC_Home_Icon_BeginName = @"tw_";
    
    
    self.IC_home_sub_SS = @"tw_home_sub_赛事";
    self.IC_home_sub_YC = @"tw_home_sub_预测";
    self.IC_home_sub_ZJ = @"tw_home_sub_专家";
    self.IC_home_sub_BF = @"tw_home_sub_比分";
    self.IC_home_sub_HMZS = @"tw_home_sub_号码走势";
    self.IC_home_sub_JRHM = @"tw_home_sub_今日号码";
    self.IC_home_sub_HMYL = @"tw_home_sub_号码遗漏";
    self.IC_home_sub_LRFX = @"tw_home_sub_冷热分析";
    self.IC_home_sub_GYHTJ = @"tw_home_sub_冠亚和统计";
    self.IC_home_sub_LMCL = @"tw_home_sub_两面长龙";
    self.IC_home_sub_LMLZ = @"tw_home_sub_两面路珠";
    self.IC_home_sub_LMYL = @"tw_home_sub_两面遗漏";
    self.IC_home_sub_QHLZ = @"tw_home_sub_前后路珠";
    self.IC_home_sub_LMLS = @"tw_home_sub_两面历史";
    self.IC_home_sub_GYHLZ = @"tw_home_sub_冠亚和路珠";
    self.IC_home_sub_HBZS = @"tw_home_sub_横版走势";
    self.IC_home_sub_History = @"tw_home_sub_历史开奖";
    self.IC_home_sub_XSTJ = @"tw_home_sub_免费推荐";
    self.IC_home_sub_LHTK = @"tw_home_sub_六合图库";
    self.IC_home_sub_CXZS = @"tw_home_sub_查询助手";
    self.IC_home_sub_ZXTJ = @"tw_home_sub_资讯统计";
    self.IC_home_sub_KJRL = @"tw_home_sub_开奖日历";
    self.IC_home_sub_GSSH = @"tw_home_sub_公式杀手";
    self.IC_home_sub_AIZNXH = @"tw_home_sub_AI智能选号";
    self.IC_home_sub_SXCZ = @"tw_home_sub_属性参考";
    self.IC_home_sub_TMLS = @"tw_home_sub_特码历史";
    self.IC_home_sub_ZMLS = @"tw_home_sub_正码历史";
    self.IC_home_sub_WSDX = @"tw_home_sub_尾数大小";
    self.IC_home_sub_SXTM = @"tw_home_sub_生肖特码";
    self.IC_home_sub_SXZM = @"tw_home_sub_生肖正码";
    self.IC_home_sub_BSTM = @"tw_home_sub_波色特码";
    self.IC_home_sub_BSZM = @"tw_home_sub_波色正码";
    self.IC_home_sub_TMLM = @"tw_home_sub_特码两面";
    self.IC_home_sub_TMWS = @"tw_home_sub_特码尾数";
    self.IC_home_sub_ZMWS = @"tw_home_sub_正码尾数";
    self.IC_home_sub_ZMZF = @"tw_home_sub_正码总分";
    self.IC_home_sub_HMBD = @"tw_home_sub_号码波段";
    self.IC_home_sub_JQYS = @"tw_home_sub_家禽野兽";
    self.IC_home_sub_LMZS = @"tw_home_sub_连码走势";
    self.IC_home_sub_LXZS = @"tw_home_sub_连肖走势";
    self.IC_home_sub_LHDS = @"tw_home_sub_六合大神";
    self.IC_home_sub_YLTJ = @"tw_home_sub_遗漏统计";
    self.IC_home_sub_JRTJ = @"tw_home_sub_今日统计";
    self.IC_home_sub_MFTJ = @"tw_home_sub_免费推荐";
    self.IC_home_sub_QXT = @"tw_home_sub_曲线图";
    self.IC_home_sub_TMZS = @"tw_home_sub_选号助手";
    
    self.IM_home_ZXTJImageName = @"homeZXTJImageName_eye";
    self.CO_home_SubCellTitleText = [UIColor colorWithHex:@"333333"];
    self.CO_home_SubheaderBallBtnBack = [UIColor colorWithHex:@"fe5049"];
    self.IM_home_XSTJImage = IMAGE(@"IM_home_XSTJImage");
    self.IM_home_LHDSImage = IMAGE(@"IM_home_LHDSImage");
    self.IM_home_LHTKImage = IMAGE(@"IM_home_LHTKImage");
    self.IM_home_GSSHImage = IMAGE(@"IM_home_GSSHImage");
    self.IC_home_ZBKJImageName = @"IC_home_ZBKJImageName";
    self.IC_home_LSKJImageName = @"IC_home_LSKJImageName";
    self.IC_home_CXZSImageName = @"IC_home_CXZSImageName";
    self.IM_home_hotNewsImageName = IMAGE(@"IM_home_hotNewsImageName");
    self.IM_home_SanJiaoImage = IMAGE(@"IM_home_SanJiaoImage");
    
    self.CO_Home_Buy_Footer_BtnBack = [UIColor colorWithHex:@"9C2D33"];
    self.CO_Home_Buy_Footer_Back = [UIColor colorWithHex:@"F0F0F0"];
    
#pragma mark 我的
    
    self.IM_topBackImageView = IMAGE(@"tw_ic_me_topback");
    self.Mine_ScrollViewBackgroundColor = [UIColor colorWithHex:@"3E94FF"];
    self.CO_Mine_setContentViewBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Me_NicknameLabel = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Me_SubTitleText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Me_ItemTextcolor = [UIColor colorWithHex:@"#666666"];
    
    self.CO_LongDragonTopView = self.CO_Main_ThemeColorOne;
    self.CO_LongDragonTopViewBtn =  [UIColor colorWithHex:@"#FF870F"];
    
    self.IM_Home_cartBgImageView = IMAGE(@"circleHomeBgImage");
    self.CO_buyLotBgColor = [UIColor colorWithHex:@"F4F4F4"];
    self.OpenLotteryVC_ColorLabs_TextB = [UIColor colorWithHex:@"333333"];
    
    self.IM_Me_MoneyRefreshBtn = IMAGE(@"mine_moneyRef");
    self.IM_Me_ChargeImage = IMAGE(@"tw_me_top1");
    self.IM_Me_GetMoneyImage = IMAGE(@"tw_me_top2");
    self.IM_Me_MoneyDetailImage = IMAGE(@"tw_me_top3");
    
    self.IM_Me_MyWalletImage = IMAGE(@"tw_me_sro1");
    self.IM_Me_MyAccountImage = IMAGE(@"tw_me_sro2");
    self.IM_Me_SecurityCnterImage = IMAGE(@"tw_me_sro3");
    self.IM_Me_MyTableImage = IMAGE(@"tw_me_sro4");
    self.IM_Me_buyHistoryImage = IMAGE(@"tw_me_sro5");
    self.IM_Me_MessageCenterImage = IMAGE(@"tw_me_sro6");
    self.IM_Me_setCenterImage = IMAGE(@"tw_me_sro7");
    self.IM_Me_shareImage = IMAGE(@"tw_me_sro8");
    self.CO_Me_YuEText = [UIColor colorWithHex:@"FFFFFF"];
    
#pragma mark  AI智能选号
    self.IM_AI_BGroundcolorImage = IMAGE(@"tw_ai_top_bg_aiznxh");
    self.IM_AI_ShengXiaoNormalImage = IMAGE(@"tw_ai_sx");
    self.IM_AI_ShakeNormalImage = IMAGE(@"tw_ai_yyy");
    self.IM_AI_LoverNormalImage = IMAGE(@"tw_ai_ar");
    self.IM_AI_FamilyNormalImage = IMAGE(@"tw_ai_jr");
    self.IM_AI_BirthdayNormalImage = IMAGE(@"tw_ai_sr");
    self.IM_AI_ShengXiaoSeletImage = IMAGE(@"tw_ai_sx_selected");
    self.IM_AI_ShakeSeletImage = IMAGE(@"tw_ai_yyy_selected");
    self.IM_AI_LoverSeletImage = IMAGE(@"tw_ai_ar_selected");
    self.IM_AI_FamilySeletImage = IMAGE(@"tw_ai_jr_selected");
    self.IM_AI_BirthdaySeletImage = IMAGE(@"tw_ai_sr_selected");
    self.IM_AI_BirthdayImage = IMAGE(@"tw_ai_srdg");
    self.IM_AI_ShengXiaoBackImage = IMAGE(@"tw_ai_cpt");
    self.IM_AI_ShuImage = IMAGE(@"tw_ai_shu");
    self.IM_AI_GouImage = IMAGE(@"tw_ai_gou");
    self.IM_AI_HouImage = IMAGE(@"tw_ai_hou");
    self.IM_AI_HuImage = IMAGE(@"tw_ai_hu");
    self.IM_AI_JiImage = IMAGE(@"tw_ai_ji");
    self.IM_AI_LongImage = IMAGE(@"tw_ai_long");
    self.IM_AI_MaImage = IMAGE(@"tw_ai_ma");
    self.IM_AI_NiuImage = IMAGE(@"tw_ai_niu");
    self.IM_AI_SheImage = IMAGE(@"tw_ai_she");
    self.IM_AI_TuImage = IMAGE(@"tw_ai_tu");
    self.IM_AI_YangImage = IMAGE(@"tw_ai_yang");
    self.IM_AI_ZhuImage = IMAGE(@"tw_ai_zhu");
    self.IM_AI_AutoSelectLblNormalColor = [UIColor colorWithHex:@"#8BC4FF"];
    self.IM_AI_AutoSelectLblSelectColor = self.CO_Main_ThemeColorTwe;
    
    
    // 购彩侧边
    self.CO_BuyLot_Left_ViewBack = [UIColor colorWithHex:@"#F0F0F0"];
    self.CO_BuyLot_Left_LeftCellBack = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_BuyLot_Left_LeftCellTitleText = [UIColor colorWithHex:@"#333333"];
    self.CO_BuyLot_Left_LeftCellBack_Selected = [UIColor colorWithHex:@"#FE8D2C"];
    self.CO_BuyLot_Left_LeftCellTitleText_Selected = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_BuyLot_Left_CellBack = [UIColor colorWithHex:@"#F0F0F0"];
    self.CO_BuyLot_Left_CellTitleText = [UIColor colorWithHex:@"#666666"];
    
    // 设置中心
    self.IC_Me_SettingTopImageName = @"tw_topback";
    self.IC_Me_SettingTopHeadIcon = @"setting_icon";
    self.SettingPushImageName = @"tw_me_setcenter1";
    self.SettingShakeImageName = @"tw_me_setcenter2";
    self.SettingVoiceImageName = @"tw_me_setcenter3";
    self.SettingSwitchSkinImageName = @"tw_me_setcenter4";
    self.SettingServiceImageName = @"tw_me_setcenter5";
    self.SettingAboutUsImageName = @"tw_me_setcenter6";
    self.confirmBtnBackgroundColor = self.CO_Main_ThemeColorTwe;
    
    
    // 我的钱包
    self.MyWalletTopImage = IMAGE(@"tw_me_wdqb");
    // 安全中心
    self.safeCenterTopImage = IMAGE(@"tw_topback");
    self.CO_Me_TopLabelTitle = [UIColor colorWithHex:@"333333"];
    // 侧边
    self.Left_VC_ChargeBtnImage = IMAGE(@"tw_left_cz");
    self.Left_VC_GetMoneyBtnImage = IMAGE(@"tw_left_tx");
    self.Left_VC_KFBtnImage = IMAGE(@"tw_left_kf");
    self.Left_VC_MyWalletImage = @"tw_left_wdqb";
    self.Left_VC_SecurityCenterImage = @"tw_left_aqzx";
    self.Left_VC_MessageCenterImage = @"tw_left_xxzx";
    self.Left_VC_BuyHistoryImage = @"tw_left_tzjl";
    self.Left_VC_MyTableImage = @"tw_left_wdbb";
    self.Left_VC_SettingCenterImage = @"tw_left_szzx";
    self.Left_VC_BtnTitleColor = WHITE;
    
    self.Left_VC_CellBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.LeftCtrlCellTextColor = [UIColor colorWithHex:@"333333"];
    
    self.Left_VC_BtnBackgroundColor = CLEAR;
    self.leftBackViewImageColor = CLEAR;
    self.Left_VC_TopImage = IMAGE(@"jbbj");
    self.LeftControllerLineColor = [UIColor hexStringToColor:@"FFFFFF" andAlpha:0.5];
    
    
    // 长龙
    self.CO_buyBottomViewBtn = [UIColor colorWithHex:@"#FF870F"];
    self.CO_ScrMoneyNumBtnText = [UIColor colorWithHex:@"#FF870F"];
    self.CO_ScrMoneyNumViewBack = self.CO_Main_ThemeColorTwe;
    
    
    self.CO_LiveLot_BottomBtnBack = self.CO_Main_ThemeColorTwe;
    self.CO_LiveLot_CellLabelBack = [UIColor colorWithHex:@"#D2E4FF"];
    self.CO_LiveLot_CellLabelText = [UIColor colorWithHex:@"#076CD3"];
    
    self.CO_ChatRoomt_SendBtnBack = self.CO_Main_ThemeColorTwe;
    
    
    // 挑码助手
    self.CO_TM_HeadView = [UIColor colorWithHex:@"#F0F2F5"];
    self.CO_TM_HeadContentView = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_BackView = [UIColor colorWithHex:@"#F0F2F5"];
    self.CO_TM_Btn3TitleText = [UIColor colorWithHex:@"#333333"];
    self.CO_TM_Btn3Back = [UIColor colorWithHex:@"#E9F4FF"];
    self.CO_TM_Btn3BackSelected = [UIColor colorWithHex:@"#FF8610"];
    self.CO_TM_Btn3borderColor = self.CO_Main_ThemeColorTwe;
    self.CO_TM_smallBtnText = [UIColor colorWithHex:@"#333333"];
    self.CO_TM_smallBtnTextSelected = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_smallBtnborderColor = [UIColor colorWithHex:@"#999999"];
    self.CO_TM_smallBtnBackColor = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_smallBtnBackColorSelected = [UIColor colorWithHex:@"#FF8610"];
    
#pragma mark 支付相关
    self.CO_Pay_SubmitBtnBack = [UIColor colorWithHex:@"#FF8610"];
    
    
    self.OnlineBtnImage = @"tw_nav_online_kf";
    self.KeFuTopImageName = @"KeFuTop";
    self.ChatVcDeleteImage = @"cartclear_eye";
    
    self.ChangLongLblBorderColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.2];
    self.KJRLSelectCalendar4 = @"kjrq_xzlskj_selected";
    self.KJRLSelectCalendar2 = @"kjrq_xzkjrq_selected";
    self.AIShakeImageName = @"tw_ai_nor";
    self.confirmBtnTextColor = [UIColor whiteColor];
    self.ShareCopyBtnTitleColor = WHITE;
    self.PersonCountTextColor = [UIColor colorWithHex:@"eeeeee"];
    self.NextStepArrowImage = @"next_eye";
    self.OpenLotteryLblLayerColor = [UIColor colorWithHex:@"999999"];
    self.changLongEnableBtnBackgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    self.CartSimpleBottomViewDelBtnImage = @"tw_ic_delete";
    self.CO_BuyDelBtn = [UIColor colorWithHex:@"#333333"];;
    self.CartSimpleBottomViewDelBtnBackgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    self.CartSimpleBottomViewTopBackgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    
    
    self.loginHistoryTextColor = [UIColor colorWithHex:@"0076A3"];
    self.messageIconName = @"xiaoxizhongxin_eye";
    self.quanziLaBaImage = @"tw_circle_lb";
    self.xinshuiFollowBtnBackground = [UIColor colorWithHex:@"FB6A12"];
    self.LHDSBtnImage = @"xs_xf_yuan_六合大神";
    self.HomeViewBackgroundColor = [UIColor colorWithHex:@"#eff2f5"];
    self.OpenLotteryBottomNFullImage = @"img_red_eye";
    self.OpenLotteryBottomNormalImage = @"img_orange_eye";
    self.BuyLotteryQPDDZGrayImageName = @"buy_qp_ddz_eye";
    self.BuyLotteryQPBJLGrayImageName = @"buy_qp_bjl_eye";
    self.BuyLotteryQPSLWHGrayImageName = @"buy_qp_slwh_eye";
    self.BuyLotteryQPBRNNGrayImageName = @"buy_qp_brnn_eye";
    self.BuyLotteryQPWRZJHGrayImageName = @"buy_qp_wrzjh_eye";
    self.BuyLotteryQPXLCHGrayImageName = @"buy_qp_xlch_eye";
    self.AoZhouLotterySwitchBtnImage = @"icon_qhms";
    self.AoZhouLotterySwitchBtnTitleColor = [UIColor colorWithHex:@"FF8610"];
    self.bottomDefaultImageName = @"img_darkgrey_eye";
    self.ChangLongRightBtnTitleNormalColor = self.CO_Main_ThemeColorOne;
    self.ChangLongRightBtnSubtitleNormalColor = self.CO_Main_ThemeColorOne;
    self.ChangLongRightBtnBackgroundColor = self.CO_Main_ThemeColorTwe;
    self.AoZhouScrollviewBackgroundColor = CLEAR;
    self.AoZhouMiddleBtnNormalBackgroundColor = [UIColor colorWithHex:@"F0F0F0"];
    self.AoZhouMiddleBtnSelectBackgroundColor = [UIColor colorWithHex:@"#FF870F"];
    self.AoZhouLotterySeperatorLineColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.4];
    self.AoZhouLotteryBtnTitleSelectColor = [UIColor colorWithHex:@"FFFFFF"];
    self.AoZhouLotteryBtnSelectBackgroundColor = [UIColor colorWithHex:@"5DADFF"];
    self.AoZhouLotteryBtnSelectSubtitleColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.8];
    self.AoZhouLotteryBtnTitleNormalColor = [UIColor colorWithHex:@"333333"];
    self.AoZhouLotteryBtnNormalBackgroundColor = [UIColor colorWithHex:@"E9F4FF" ];
    self.AoZhouLotteryBtnNormalSubtitleColor = [UIColor colorWithHex:@"999999"];
    self.Buy_HomeView_BackgroundColor = self.CO_Main_ThemeColorOne;
    self.ChangLongTitleColor = [UIColor colorWithHex:@"#333333"];
    self.ChangLongTimeLblColor = [UIColor colorWithHex:@"#EB0E24"];
    self.ChangLongTotalLblColor = [UIColor colorWithHex:@"28E223"];
    self.ChangLongIssueTextColor = [UIColor colorWithHex:@"888888"];
    self.ChangLongKindLblTextColor = [UIColor colorWithHex:@"888888"];
    self.ChangLongResultLblColor = [UIColor colorWithHex:@"FFC145"];
    
    
    self.CO_GD_SelectedTextNormal = [UIColor colorWithHex:@"#FFEA00"];
    self.CO_GD_SelectedTextSelected = [UIColor colorWithHex:@"4B75C8"];
    self.CO_GD_Title_BtnBackSelected = [UIColor whiteColor];
    
    self.WechatLoginImageName = @"tw_login_wx";
    self.QQLoginImageName = @"tw_login_QQ";
    self.xxncCheckBtnBackgroundColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.6];
    self.xxncImageName = @"tw_login_xgnc";
    self.ForgetPsdWhiteBackArrow = @"tw_login_back_white";
    self.LoginWhiteClose = @"tw_login_close";
    self.MimaEye = @"tw_login_mima";
    self.NicknameEye = @"tw_login_nickname";
    self.CodeEye = @"tw_login_code";
    self.InviteCodeEye = @"tw_login_invitecode";
    self.AccountEye = @"tw_login_account";
    self.ForgetPsdTitleTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.ForgetPsdBackgroundImage = @"tw_login_wjmm";
    self.LoginForgetPsdTextColor = [UIColor colorWithHex:@"fefefe"];
    self.RegistNoticeTextColor = [UIColor colorWithHex:@"144A4F"];
    self.RegistBackgroundImage = @"tw_login_zcbj";
    self.LoginBackgroundImage = @"tw_login_dlbj";
    self.LoginBtnBackgroundcolor = [UIColor colorWithHex:@"FFFFFF"];
    self.LoginBoardColor = [UIColor colorWithHex:@"FFFFFF"];
    self.LoginSureBtnTextColor = [UIColor colorWithHex:@"4B89A5"];
    self.LoginLinebBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.LoginTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.QicCiDetailSixheadTitleColor = [UIColor colorWithHex:@"333333"];
    self.QiCiXQSixHeaderSubtitleTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.chongqinheadBackgroundColor = self.CO_Main_ThemeColorOne;
    self.QiCiDetailInfoColor = [UIColor colorWithHex:@"#FF8610"];
    self.QiCiDetailTitleColor = [UIColor colorWithHex:@"#333333"];
    self.QiCiDetailLineBackgroundColor = [UIColor colorWithHex:@"#D6D6D6"];
    self.QiCiDetailCellBackgroundColor = self.CO_Main_ThemeColorOne;
    self.CO_OpenLotHeaderInSectionView = [UIColor colorWithHex:@"#999999"];
    self.SixOpenHeaderSubtitleTextColor = [UIColor colorWithHex:@"#999999"];
    self.PK10_color1 = [UIColor colorWithHex:@"D542BB"];
    self.PK10_color2 = [UIColor colorWithHex:@"2F90DF"];
    self.PK10_color3 = [UIColor colorWithHex:@"FAB825"];
    self.PK10_color4 = [UIColor colorWithHex:@"11C368"];
    self.PK10_color5 = [UIColor colorWithHex:@"A36D55"];
    self.PK10_color6 = [UIColor colorWithHex:@"EF3C34"];
    self.PK10_color7 = [UIColor colorWithHex:@"66DBDD"];
    self.PK10_color8 = [UIColor colorWithHex:@"FF8244"];
    self.PK10_color9 = [UIColor colorWithHex:@"4EA3D9"];
    self.PK10_color10 = [UIColor colorWithHex:@"7060D1"];
    
    self.BuyLotteryZCjczqGrayImageName = @"zc_jczq";
    self.BuyLotteryZCjclqGrayImageName = @"zc_jclq";
    self.BuyLotteryZCzqsscGrayImageName = @"zc_zq14c";
    self.BuyLotteryZCrxjcGrayImageName = @"zc_rx9c";
    self.BuyLotteryQPdzGrayImageName = @"qp_dzpk_eye";
    self.BuyLotteryQPerBaGangGrayImageName = @"qp_ebg_eye";
    self.BuyLotteryQPqznnGrayImageName = @"qp_qznn_eye";
    self.BuyLotteryQPzjhGrayImageName = @"qp_zjh_eye";
    self.BuyLotteryQPsgGrayImageName = @"buy_qp_sg_eye";
    self.BuyLotteryQPyzlhGrayImageName = @"qp_yzlh_eye";
    self.BuyLotteryQPesydGrayImageName = @"buy_qp_21d_eye";
    self.BuyLotteryQPtbnnGrayImageName = @"qp_tbnn_eye";
    self.BuyLotteryQPjszjhGrayImageName = @"qp_jszjh_eye";
    self.BuyLotteryQPqzpjGrayImageName = @"qp_qzpj_eye";
    self.BuyLotteryQPsssGrayImageName = @"qp_sss_eye";
    self.BuyLotteryQPxywzGrayImageName = @"qp_xxwz_eye";
    self.CartSectionLineColor = [UIColor colorWithHex:@"#D6D6D6" Withalpha:0.5];
    
    
    self.SixGreenBallName = @"kj_sixgreen";
    self.SixBlueBallName = @"kj_sixblue";
    self.SixRedBallName = @"kj_sixred";
    self.SscBlueBallName = @"dlt_lsq";
    self.SscBallName = @"azact";
    self.PostCircleImageName = @"postcircle_white";
    self.PostCircleImage = IMAGE(@"postcircle_white");
    self.CircleUserCenterMiddleBtnBackgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.CircleUderCenterTopImage = IMAGE(@"jbbj");
    self.ApplyExpertPlaceholdColor = [UIColor colorWithHex:@"999999"];
    self.CO_Account_Info_BtnBack = self.CO_Main_ThemeColorTwe;
    self.ApplyExpertConfirmBtnTextColor = self.CO_Main_ThemeColorOne;
    self.applyExpertBackgroundColor = [UIColor colorWithHex:@"#F1F3F5"];
    self.ExpertInfoTextColorA = [UIColor colorWithHex:@"dddddd"];
    self.ExpertInfoTextColorB = [UIColor colorWithHex:@"FFFFFF"];
    self.WFSMImage = @"WFSMImage_eye";
    
    self.PrizeMessageTopbackViewTextColor = BLACK;
    self.CO_Home_Gonggao_TopBackViewStatus1 = [UIColor colorWithHex:@"B8B8B8"];
    self.CO_Home_Gonggao_TopBackViewStatus2 = self.CO_Main_ThemeColorTwe;
    self.GraphSetViewBckgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.XSTJSearchImage = @"XSTJSearchImage_eye";
    self.XSTJMyArticleImage = IMAGE(@"XSTJMyArticleImage_eye");
    
    
    
    self.TouZhuImage = IMAGE(@"xf_touzhu_button");
    
    
    self.AppFistguideUse1 = @"app_guide_1";
    self.AppFistguideUse2 = @"app_guide_2";
    self.AppFistguideUse3 = @"app_guide_3";
    self.registerVcPhotoImage = IMAGE(@"tw_login_registerVcPhotoImage");
    self.registerVcCodeImage = IMAGE(@"tw_login_registerVcCodeImage");
    self.registerVcPSDImage = IMAGE(@"tw_login_registerVcPSDImage");
    self.registerVcPSDAgainImage = IMAGE(@"registerVcPSDImage");
    self.registerVcInviteImage = IMAGE(@"tw_login_registerVcInviteImage");
    self.registerVcRegisterBtnBTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.registerVcRegisterBtnBckgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.LoginVcHiddenImage = IMAGE(@"tw_login_showPassword");
    self.LoginVcHiddenSelectImage = IMAGE(@"tw_login_hiddenPassword");
    self.LoginVcPhoneImage = IMAGE(@"tw_login_VcPhoneImage");
    self.loginVcQQimage = IMAGE(@"loginVcQQimage");
    self.loginVcWechatimage = IMAGE(@"loginVcWechatimage");
    self.loginLineBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.logoIconImage = IMAGE(@"");
    self.loginVcBgImage = IMAGE(@"loginBackgroundImage_eye");
    self.shareToLblTextColor = [UIColor colorWithHex:@"000000"];
    self.shareVcCopyBtnBackgroundColor = self.CO_Main_ThemeColorTwe;
    self.shareVcQQImage = IMAGE(@"me_qq");
    self.shareVcPYQImage = IMAGE(@"shareVcPYQImage_eye");
    self.shareVcWeChatImage = IMAGE(@"wx");
    self.shareLineImage = IMAGE(@"shareLineImage");
    self.OpenLotteryTimeLblTextColor = [UIColor colorWithHex:@"#FF001B"];
    self.CO_GD_TopBackgroundColor = [UIColor clearColor];
    self.CO_GD_TopBackHeadTitle = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_GD_AllPeople_BtnText = [UIColor colorWithHex:@"#333333"];
    
    self.IM_GD_DashenTableImgView = IMAGE(@"tw_gd_topback");
    
    self.expertContentLblTextcolor = [UIColor colorWithHex:@"EEEEEE"];
    self.expertWinlblTextcolor = WHITE;
    self.expertInfoTopImgView = IMAGE(@"jbbj");
    self.circleListDetailViewBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.IM_CircleDetailHeadImage = IMAGE(@"tw_circle_topback");
    self.MyWalletBankCartImage = IMAGE(@"td_me_wdqb_cell_cart");
    
    self.accountInfoNicknameTextColor = [UIColor colorWithHex:@"333333"];
    self.CO_MoneyTextColor = [UIColor colorWithHex:@"#FF870F"];
    self.accountInfoTopViewBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    
    
    self.shareInviteImage = IMAGE(@"shareInviteImage_eye");
    self.shareMainImage = IMAGE(@"tw_me_fxhyback");
    self.shareBackImage = IMAGE(@"tw_me_fxhy_bsbj");
    self.calendarLeftImage = IMAGE(@"kj_left");
    self.calendarRightImage = IMAGE(@"kj_right");
    self.calendarBackgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    self.KJRLSelectBackgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.IM_CalendarTopImage = IMAGE(@"tw_kj_kjrl");
    
    self.LHTKTextfieldBackgroundColor = [UIColor colorWithHex:@"E6E6E6"];
    self.LHTKRemarkTextFeildBorderColor = CLEAR;
    self.XSTJdetailZanImage = IMAGE(@"tw_xs_zan");
    self.attentionViewCloseImage = IMAGE(@"closeAttention_eye");
    self.backBtnImageName = @"tw_nav_return";
    self.HobbyCellImage = IMAGE(@"勾选_eye");
    
#pragma mark  六合图库
    self.CO_LHTK_SubmitBtnBack = self.CO_Main_ThemeColorTwe;
    
    
    self.mine_seperatorLineColor = CLEAR;
    self.openPrizePlusColor = [UIColor colorWithHex:@"#999999"];
    self.OpenPrizeWuXing = [UIColor colorWithHex:@"D6CFFF"];
    
    self.circleHomeCell1Bgcolor = @"circleHomeCell1";
    self.circleHomeCell2Bgcolor = @"circleHomeCell1";
    self.circleHomeCell3Bgcolor = @"circleHomeCell1";
    self.circleHomeCell4Bgcolor = @"circleHomeCell1";
    self.circleHomeCell5Bgcolor = @"circleHomeCell1";
    self.circleHomeSDQImageName = @"cirlceHomeSDQ";
    self.circleHomeGDDTImageName = @"cirlceHomeGDDT";
    self.circleHomeXWZXImageName = @"cirlceHomeXWZX";
    self.circleHomeDJZXImageName = @"cirlceHomeDJZX";
    self.circleHomeZCZXImageName = @"cirlceHomeZCZX";
    
    
    self.circleHomeBgImage = IMAGE(@"circleHomeBgImage");
    
    
    
    self.xinshuiDetailAttentionBtnNormalGroundColor = BASECOLOR;
    self.pushDanBarTitleSelectColot = BASECOLOR;
    self.pushDanSubBarNormalTitleColor = [UIColor colorWithHex:@"666666"];
    self.pushDanSubBarSelectTextColor = [UIColor colorWithHex:@"0076A3"];
    
    self.pushDanSubbarBackgroundcolor = [UIColor colorWithHex:@"EEEEEE"];
    self.CO_LongDragon_PushSetting_BtnBack = self.CO_Main_ThemeColorTwe;
    self.pushDanBarTitleNormalColor = [UIColor colorWithHex:@"EEEEEE"];
    self.CO_Circle_Cell2_TextLabel_BackgroundC = [UIColor colorWithHex:@"9e353c"];
    self.CO_Circle_Cell2_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"9e353c"];
    self.CO_Circle_Cell3_TextLabel_BackgroundC = [UIColor colorWithHex:@"647e24"];
    self.CO_Circle_Cell1_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"5649b3"];
    self.bettingBtnColor = WHITE;
    self.xinshuiDetailAttentionBtnBackGroundColor = MAINCOLOR;
    self.LoginNamePsdPlaceHoldColor = [UIColor colorWithHex:@"FFFFFF"];
    self.missCaculateBarNormalBackground = [UIColor colorWithHex:@"EEEEEE"];
    self.missCaculateBarselectColor = BASECOLOR;
    self.missCaculateBarNormalColor = WHITE;
    self.openLotteryCalendarBackgroundcolor = [UIColor colorWithHex:@"F7F7F7"];
    self.openLotteryCalendarTitleColor = [UIColor colorWithHex:@"EEEEEE"];
    self.openLotteryCalendarWeekTextColor = [UIColor colorWithHex:@"666666"];
    self.CO_OpenLot_BtnBack_Normal = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_OpenLot_BtnBack_Selected = self.CO_Main_ThemeColorTwe;
    self.CO_Home_Gonggao_TopTitleText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_Gonggao_Cell_MessageTopViewBack = self.CO_Main_ThemeColorTwe;
    self.KeyTitleColor = [UIColor colorWithHex:@"e76c29"];
    
    self.CO_Circle_TitleText = [UIColor colorWithHex:@"999999"];
    
    self.xinshuiRemarkTitleColor = WHITE;
    self.sixHeTuKuRemarkbarBackgroundcolor = WHITE;
    self.myCircleUserMiddleViewBackground = [UIColor colorWithHex:@"2C3036"];
    self.openCalendarTodayColor = [UIColor colorWithHex:@"#529DFF"];
    self.openCalendarTodayViewBackground = [UIColor colorWithHex:@"#FF9000"];
    self.LoginNamePsdTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.MineTitleStrColor = [UIColor colorWithHex:@"FFFFFF"];
    self.MessageTitleColor  = WHITE;
    
    self.xinshuiBottomViewTitleColor = WHITE;
    self.CO_KillNumber_LabelText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_KillNumber_LabelBack = self.CO_Main_ThemeColorTwe;
    
    self.TopUpViewTopViewBackgroundcolor = CLEAR;
    self.chargeMoneyLblSelectColor = [UIColor colorWithHex:@"FFFFFF"];
    self.chargeMoneyLblSelectBackgroundcolor = [UIColor colorWithHex:@"#FF8610"];
    self.chargeMoneyLblNormalColor = [UIColor colorWithHex:@"C48936"];
    self.tabbarItemTitleColor = [UIColor lightGrayColor];
    
    
    self.RootVC_ViewBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.tabbarItemTitleColor = [UIColor lightGrayColor];
    self.CO_Circle_Cell3_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"6d872f"];
    self.CO_Circle_Cell4_TextLabel_BackgroundC = [UIColor colorWithHex:@"3ea358"];
    self.CO_Circle_Cell4_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"3ea358"];
    self.tixianShuoMingColor = [UIColor colorWithHex:@"0076A3"];
    
    self.CircleVC_HeadView_BackgroundC = CLEAR;
    self.CO_Circle_Cell_BackgroundC = [UIColor colorWithHex:@"f0f2f5"];
    self.CO_Circle_Cell_TextLabel_BackgroundC = [UIColor colorWithHex:@"333333"];
    self.CO_Circle_Cell_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"999999"];
    
    
    self.CartBarBackgroundColor = self.CO_Main_ThemeColorOne;
    self.CartBarTitleNormalColor = [UIColor colorWithHex:@"#333333"];
    self.CartBarTitleSelectColor = [UIColor colorWithHex:@"FF8610"];
    self.CartHomeHeaderSeperatorColor = [UIColor colorWithHex:@"ff9711"];
    self.genDanHallTitleNormalColr = [UIColor colorWithHex:@"FFFFFF"];
    self.genDanHallTitleSelectColr = [UIColor colorWithHex:@"FFEA01"];;
    self.genDanHallTitleBackgroundColor = [UIColor colorWithHex:@"#4a71c7"];
    self.gongShiShaHaoFormuTitleNormalColor = [UIColor colorWithHex:@"333333"];
    self.gongShiShaHaoFormuTitleSelectColor = BASECOLOR;
    self.gongshiShaHaoFormuBtnBackgroundColor = BLACK;
    
    
    
    self.OpenLotteryVC_ColorLabs_TextC = [UIColor colorWithHex:@"#FF8610"];
    self.OpenLotteryVC_ColorLabs1_TextC = [UIColor colorWithHex:@"#333333"];
    self.OpenLotteryVC_SubTitle_TextC = [UIColor colorWithHex:@"#999999"];
    self.OpenLotteryVC_SubTitle_BorderC = [UIColor colorWithHex:@"8D8D8D"];
    self.OpenLotteryVC_Cell_BackgroundC = [UIColor colorWithHex:@"3a3b3f"];
    self.OpenLotteryVC_View_BackgroundC = [UIColor colorWithHex:@"F0F2F5"];
    self.CO_LongDragonCell = self.CO_Main_ThemeColorOne;
    self.OpenLotteryVC_TitleLabs_TextC = [UIColor colorWithHex:@"333333"];
    self.OpenLotteryVC_SeperatorLineBackgroundColor = [UIColor colorWithHex:@"#D6D6D6" Withalpha:0.5];
    self.CO_OpenLetBtnText_Normal = [UIColor colorWithHex:@"333333"];
    self.SixRecommendVC_View_BackgroundC = [UIColor colorWithHex:@"f4f4f4"];
    self.MineVC_Btn_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    
    self.HobbyVC_MessLab_BackgroundC = [UIColor colorWithHex:@"EEEEEE"];
    self.HobbyVC_MessLab_TextC = [UIColor colorWithHex:@"333333"];
    self.HobbyVC_View_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.HobbyVC_OKButton_BackgroundC = [UIColor colorWithHex:@"0076A3"];
    self.HobbyVC_OKButton_TitleBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Circle_Title_nameColor = [UIColor colorWithHex:@"333333"];
    self.HobbyVC_SelButton_TitleBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.HobbyVC_UnSelButton_TitleBackgroundC = [UIColor colorWithHex:@"999999"];
    self.CO_Circle_Cell1_TextLabel_BackgroundC = self.CO_Circle_Cell_TextLabel_BackgroundC;
    self.HobbyVC_SelButton_BackgroundC = [UIColor colorWithHex:@"0076A3"];
    self.HobbyVC_UnSelButton_BackgroundC = [UIColor colorWithHex:@"DDDDDD"];
    self.Circle_View_BackgroundC = [UIColor colorWithHex:@"#f0f2f5"];
    self.Circle_HeadView_Title_UnSelC = [UIColor colorWithHex:@"999999"];
    self.Circle_HeadView_Title_SelC = [UIColor colorWithHex:@"333333"];
    self.Circle_HeadView_BackgroundC = [UIColor colorWithHex:@"#1e4c7d"];
    self.Circle_HeadView_NoticeView_BackgroundC = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.2];
    self.Circle_HeadView_GuangBo_BackgroundC = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.8];
    self.Circle_Cell_BackgroundC = [UIColor colorWithHex:@"F7F7F7"];
    self.Circle_Cell_ContentlabC = [UIColor colorWithHex:@"666666"];
    self.Circle_Cell_Commit_BackgroundC = [UIColor colorWithHex:@"F7F7F7"];
    self.Circle_Cell_Commit_TitleC = [UIColor colorWithHex:@"666666"];
    self.Circle_Cell_AttentionBtn_TitleC = [UIColor colorWithHex:@"CFA753"];
    self.Circle_Line_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Circle_remark_nameColor = [UIColor colorWithHex:@"4e79c2"];
    self.getCodeBtnvBackgroundcolor = [UIColor colorWithHex:@"dddddd"];
    self.Circle_FooterViewLine_BackgroundC = [UIColor colorWithHex:@"dddddd" Withalpha:0.9];
    self.OpenLottery_S_Cell_BackgroundC = CLEAR;//[UIColor colorWithHex:@"8483F0"];
    self.OpenLottery_S_Cell_TitleC = [UIColor colorWithHex:@"333333"];
    self.Login_NamePasswordView_BackgroundC = CLEAR;//[UIColor colorWithHex:@"2c2e36"];
    self.Login_ForgetSigUpBtn_BackgroundC = [UIColor colorWithHex:@"2c2e36" Withalpha:0.5];
    self.Login_ForgetSigUpBtn_TitleC = [UIColor colorWithHex:@"DDDDDD"];
    self.Login_LogoinBtn_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Login_LogoinBtn_TitleC = [UIColor colorWithHex:@"0076A3"];
    self.Buy_LotteryMainBackgroundColor = [UIColor colorWithHex:@"1B1E23"];
    self.RootWhiteC = [UIColor colorWithHex:@"f4f4f4"];
    self.CO_OpenLetBtnText_Selected = [UIColor colorWithHex:@"FFFFFF"];
    self.loginSeperatorLineColor = [UIColor colorWithHex:@"EEEEEE"];
    self.getCodeBtnvTitlecolor = [UIColor colorWithHex:@"#888888"];
    self.LiuheTuKuLeftTableViewBackgroundColor = [UIColor colorWithHex:@"e0e0e0"];
    self.LiuheTuKuOrangeColor = self.CO_Main_ThemeColorTwe;
    self.LiuheTuKuLeftTableViewSeperatorLineColor = [UIColor colorWithHex:@"c2c2c2"];
    self.LiugheTuKuTopBtnGrayColor = [UIColor colorWithHex:@"dddddd"];
    self.LiuheTuKuProgressValueColor = [UIColor colorWithHex:@"0076A3"];
    self.LiuheTuKuTouPiaoBtnBackgroundColor = [UIColor colorWithHex:@"c60000"];
    self.LiuheDashendBackgroundColor = self.CO_Main_ThemeColorOne;
    
    self.xinShuiReconmentGoldColor = [UIColor colorWithHex:@"FFFFFF"];
    self.xinShuiReconmentRedColor = self.CO_Main_ThemeColorTwe;
    self.TouPiaoContentViewTopViewBackground = [UIColor colorWithHex:@"16171b"];
    self.LiuheTuKuRemarkBarBackgroundColor = [UIColor colorWithHex:@"16171b"];
    self.LiuheTuKuRemarkSendBackgroundColor = self.CO_Main_ThemeColorTwe;
    self.LiuheTuKuTextRedColor = self.CO_Main_ThemeColorTwe;
    self.XinshuiRecommentScrollBarBackgroundColor = [UIColor colorWithHex:@"f0f0f0"];
    self.xinshuiBottomVeiwSepeLineColor = [UIColor whiteColor];
    self.Circle_Post_titleSelectColor = [UIColor colorWithHex:@"#fff100"];
    self.Circle_Post_titleNormolColor = [UIColor colorWithHex:@"#d4d2cf"];
    
#pragma mark 购彩
    //购彩
    self.Buy_HeadView_BackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_HeadView_Footer_BackgroundC = [UIColor colorWithHex:@"F0F0F0"];
    self.Buy_HeadView_Title_C = [UIColor colorWithHex:@"333333"];
    self.Buy_HeadView_historyV_Cell1_C = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_HeadView_historyV_Cell2_C = [UIColor colorWithHex:@"F0F0F0"];
    
    self.Buy_LeftView_BackgroundC = CLEAR;//[UIColor colorWithHex:@"0076A3"];
    self.Buy_LeftView_Btn_BackgroundUnSel = IMAGE(@"FY_Buy_LeftView_Btn_BackgroundUnSel");
    self.Buy_LeftView_Btn_BackgroundSel = IMAGE(@"FY_Buy_LeftView_Btn_BackgroundSel");
    self.Buy_LeftView_Btn_TitleSelC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_LeftView_Btn_TitleUnSelC = [UIColor colorWithHex:@"333333"];
    self.Buy_LeftView_Btn_PointUnSelC = [UIColor colorWithHex:@"5DADFF"];
    self.Buy_LeftView_Btn_PointSelC = [UIColor colorWithHex:@"01ae00"];
    self.Buy_RightBtn_Title_UnSelC = [UIColor colorWithHex:@"333333"];
    self.Buy_RightBtn_Title_SelC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionHeadV_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionHeadV_ViewC = [UIColor colorWithHex:@"ff5d12"];
    self.CO_Bottom_LabelText = [UIColor colorWithHex:@"#333333"];
    
    self.Buy_CollectionCellButton_BackgroundSel = [UIColor colorWithHex:@"5DADFF"];
    self.Buy_CollectionCellButton_BackgroundUnSel = CLEAR;
    self.Buy_CollectionCellButton_TitleCSel = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionCellButton_TitleCUnSel = [UIColor colorWithHex:@"333333"];
    self.Buy_CollectionCellButton_SubTitleCSel = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionCellButton_SubTitleCUnSel = [UIColor colorWithHex:@"999999"];
    self.Buy_CollectionViewLine_C = [UIColor colorWithHex:@"D6D6D6"];
    
    self.CO_BuyLot_HeadView_LabelText = [UIColor colorWithHex:@"999999"];
    self.CO_BuyLot_HeadView_Label_border = [UIColor colorWithHex:@"999999"];
    self.CO_BuyLot_Right_bcViewBack = [UIColor colorWithHex:@"E9F4FF"];
    self.CO_BuyLot_Right_bcView_border = [UIColor colorWithHex:@"BEDEFF"];
    
    
    self.CartHomeSelectSeperatorLine = [UIColor colorWithHex:@"ff9711"];
    
    self.grayColor999 = [UIColor colorWithHex:@"999999"];
    self.grayColor666 = [UIColor colorWithHex:@"666666"];
    self.grayColor333 = [UIColor colorWithHex:@"333333"];
    self.Mine_rightBtnTileColor = [UIColor colorWithHex:@"FFFFFF"];
    self.Mine_priceTextColor = [UIColor colorWithHex:@"FFE955"];
    self.ChangePsdViewBackgroundcolor = [UIColor colorWithHex:@"F7F7F7"];
    self.CO_Me_MyWallerBalance_MoneyText = [UIColor colorWithHex:@"#FFEA00"];
    self.CO_Me_MyWallerBalanceText = [UIColor colorWithHex:@"FFFFFF"];
    self.MyWalletTotalBalanceColor = [UIColor colorWithHex:@"fff666"];
    self.mineInviteTextCiolor = [UIColor colorWithHex:@"888888"];
    self.CO_Me_MyWallerTitle = [UIColor colorWithHex:@"#E9E9E9"];
#pragma mark 番摊紫色
    self.NN_LinelColor = [UIColor colorWithHex:@"D6D6D6"];
    self.NN_xian_normalColor = [UIColor colorWithHex:@"565964"];
    self.NN_xian_selColor = [UIColor colorWithHex:@"8F601E"];
    self.NN_zhuang_normalColor = [UIColor colorWithHex:@"5140A1"];
    self.NN_zhuang_selColor = [UIColor colorWithHex:@"905F1B"];
    self.NN_Xian_normalImg = @"xianjia-gray_1";
    self.NN_Xian_selImg = @"xianjia-color_1";
    self.NN_zhuang_normalImg = @"zhuang_normal";
    self.NN_zhuang_selImg = @"zhuangjia-color_1";
    
    self.NN_XianBgImg = [UIImage imageNamed:@"xianjia-xuanzhong"];
    self.NN_XianBgImg_sel = [UIImage imageNamed:@"xianjia"];
    self.Buy_NNXianTxColor_normal = [UIColor colorWithHex:@"0E2B20"];
    self.Buy_NNXianTxColor_sel = [UIColor whiteColor];
    self.Fantan_headerLineColor = [UIColor colorWithHex:@"1F5C73"];
    self.Fantan_historyHeaderBgColor = [UIColor colorWithHex:@"8D7FE9"];
    self.Fantan_historyHeaderLabColor = [UIColor colorWithHex:@"333333"];
    self.Fantan_historycellColor1 = [UIColor colorWithHex:@"333333"];
    self.Fantan_historycellColor2 = [UIColor colorWithHex:@"D6D6D6"];
    self.Fantan_historycellColor3 = [UIColor colorWithHex:@"FFD116"];
    self.Fantan_historycellOddColor = [UIColor colorWithHex:@"AAA2F1"];
    self.Fantan_historycellEvenColor = [UIColor colorWithHex:@"9B8DE9"];
    self.CO_Fantan_HeadView_Label = [UIColor colorWithHex:@"999999"];
    
    
    self.RedballImg_normal = @"lessredball";
    self.RedballImg_sel = @"redball";
    self.BlueballImg_normal = @"lesswhiteball";
    self.BlueballImg_sel = @"blueball";
    
    self.Fantan_MoneyColor = [UIColor colorWithHex:@"FF8610"];
    self.Fantan_CountDownBoderColor = [UIColor colorWithHex:@"999999"];
    self.Fantan_CountDownBgColor = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_fantanTimeColor = [UIColor colorWithHex:@"FF9F0F"];
    self.Fantan_DelImg = IMAGE(@"cartclear_1");
    self.Fantan_ShakeImg = IMAGE(@"cartrandom_1");
    self.Fantan_AddToBasketImg = IMAGE(@"cartset_1");
    self.Fantan_basketImg = IMAGE(@"cart_1");
    
    self.Fantan_FloatImgUp = IMAGE(@"buy_up_1");
    self.Fantan_FloatImgDown = IMAGE(@"buy_down_1");
    self.Fantan_AddImg = IMAGE(@"tw_add");
    self.Fantan_JianImg = IMAGE(@"tw_jianhao");
    self.Fantan_SpeakerImg = IMAGE(@"buy_music_1");
    self.Buy_fantanBgColor = [UIColor colorWithHex:@"2d2f37"];
    //    self.Buy_fantanCellBgColor = [UIColor colorWithHex:@"715FE3"];
    self.Buy_fantanCellBgColor = [UIColor colorWithHex:@"FFFFFF"];;
    self.Fantan_iconColor = [UIColor colorWithHex:@"FFD116"];
    self.FantanColor1 = [UIColor colorWithHex:@"5DADFF"];
    self.FantanColor2 = [UIColor colorWithHex:@"5DADFF"];
    self.FantanColor3 = [UIColor colorWithHex:@"F0F0F0"];
    self.FantanColor4 = [UIColor colorWithHex:@"F0F0F0"];
    self.Fantan_textFieldColor = self.CO_Main_ThemeColorOne;
    self.CO_Fantan_textFieldTextColor = [UIColor colorWithHex:@"FF8610"];
    self.CO_BuyLotBottomView_TopView3_BtnText = [UIColor colorWithHex:@"333333"];
    self.CO_BuyLotBottomView_BotView2_BtnBack = [UIColor colorWithHex:@"FF8610"];
    self.Fantan_tfPlaceholdColor = [UIColor colorWithHex:@"#808080"];
    self.CO_Buy_textFieldText = [UIColor colorWithHex:@"#333333"];
    self.Fantan_labelColor = [UIColor colorWithHex:@"#333333"];
    self.blackOrWhiteColor = [UIColor colorWithHex:@"000000"];
    self.MyWallerBalanceBottomViewColor = [UIColor colorWithHex:@"e9e9e9"];
    
}




// 默认黑色版本
#pragma mark - darkTheme 默认黑色版本
- (void)darkTheme {
    
    self.CO_Main_ThemeColorOne = [UIColor colorWithHex:@"1D1E23"];   // 主题色1;   黑色
    self.CO_Main_ThemeColorTwe = [UIColor colorWithHex:@"#AC1E2D"];   // 主题色2;  红色
    self.CO_Main_LineViewColor = [UIColor colorWithHex:@"#3F424C"];   // 分割线条颜色
    self.CO_Main_LabelNo1 = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Main_LabelNo2 = [UIColor colorWithHex:@"#CCCCCC"];
    self.CO_Main_LabelNo3 = [UIColor colorWithHex:@"#CCCCCC"];
    
    self.IC_TabBar_Home = @"tab1_1";
    self.IC_TabBar_Home_Selected = @"tab1_2";
    self.IC_TabBar_KJ_ = @"tab2_1";
    self.IC_TabBar_KJ_Selected = @"tab2_2";
    self.IC_TabBar_GC = @"tab3_1";
    self.IC_TabBar_GC_Selected = @"tab3_2";
    self.IC_TabBar_QZ = @"tab4_1";
    self.IC_TabBar_QZ_Selected = @"tab4_2";
    self.IC_TabBar_Me = @"tab5_1";
    self.IC_TabBar_Me_Selected = @"tab5_2";
    self.CO_TabBarTitle_Normal = [UIColor colorWithHex:@"666666"];
    self.CO_TabBarTitle_Selected = [UIColor colorWithHex:@"fed696"];
    self.CO_TabBarBackground = [UIColor colorWithHex:@"1D1E24"];
    
    self.CO_Nav_Bar_NativeViewBack = [UIColor colorWithHex:@"1D1E24"];
    self.CO_NavigationBar_TintColor = [UIColor colorWithHex:@"fed696"];
    self.CO_NavigationBar_Title = [UIColor colorWithHex:@"fed696"];
    self.CO_Nav_Bar_CustViewBack = [UIColor colorWithHex:@"18191D"];
    
    self.IM_Nav_TitleImage_Logo = IMAGE(@"td_nav_home_logo");
    self.IC_Nav_ActivityImageStr = @"td_nav_activity_icon";
    self.IC_Nav_SideImageStr = @"td_nav_home_menu";
    self.IC_Nav_CircleTitleImage = @"td_nav_circle_icon";
    self.IC_Nav_Setting_Icon = @"td_nav_setting_icon";
    self.IC_Nav_Setting_Gear = @"td_nav_setting";
    self.IC_Nav_Kefu_Text = @"td_me_kf";
    
    
#pragma mark Home
    
    
    self.OnlineBtnImage = @"tw_nav_online_kf";
    self.KeFuTopImageName = @"KeFuTop";
    self.ChatVcDeleteImage = @"ljt";
    
    self.ChangLongLblBorderColor = CLEAR;
    self.KJRLSelectCalendar4 = @"calendar_4";
    self.KJRLSelectCalendar2 = @"calendar_2";
    self.AIShakeImageName = @"AIshake";
    self.confirmBtnTextColor = WHITE;
    self.ShareCopyBtnTitleColor = BLACK;
    self.PersonCountTextColor = [UIColor lightGrayColor];
    self.NextStepArrowImage = @"next";
    self.OpenLotteryLblLayerColor = [UIColor colorWithHex:@"d8d9d6"];
    self.changLongEnableBtnBackgroundColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.2];
    self.CartSimpleBottomViewDelBtnImage = @"cartclear_dark";
    self.CO_BuyDelBtn = [UIColor colorWithHex:@"FFFFFF"];
    self.CartSimpleBottomViewDelBtnBackgroundColor = [UIColor colorWithHex:@"2D2F37"];
    self.CartSimpleBottomViewTopBackgroundColor = [UIColor colorWithHex:@"000000"];
    self.IM_home_ZXTJImageName = @"zxtj";
    
    self.CO_Circle_TitleText = [UIColor colorWithHex:@"FFFFFF"];
    
    // 长龙
    self.CO_buyBottomViewBtn = self.CO_Main_ThemeColorTwe;
    self.CO_ScrMoneyNumBtnText = [UIColor colorWithHex:@"#fed696"];
    self.CO_ScrMoneyNumViewBack = self.CO_Main_ThemeColorOne;
    
    self.CO_Pay_SubmitBtnBack = [UIColor colorWithHex:@"#AC1E2D"];
    
    // 挑码助手
    self.CO_TM_HeadView = [UIColor colorWithHex:@"#22252b"];
    self.CO_TM_HeadContentView = [UIColor colorWithHex:@"#26282e"];
    self.CO_TM_BackView = [UIColor colorWithHex:@"#1d1e25"];
    self.CO_TM_Btn3TitleText = [UIColor colorWithHex:@"#333333"];
    self.CO_TM_Btn3Back = [UIColor colorWithHex:@"#EBEBEB"];
    self.CO_TM_Btn3BackSelected = [UIColor colorWithHex:@"#FF5B10"];
    self.CO_TM_Btn3borderColor = [UIColor colorWithHex:@"#FFFFFF" Withalpha:0.5];
    self.CO_TM_smallBtnText = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_TM_smallBtnTextSelected = [UIColor colorWithHex:@"#FFE292"];
    self.CO_TM_smallBtnborderColor = [UIColor colorWithHex:@"#2D2F37"];
    self.CO_TM_smallBtnBackColor = [UIColor colorWithHex:@"#2D2F37"];
    self.CO_TM_smallBtnBackColorSelected = [UIColor colorWithHex:@"#AC1E2D"];
    
    self.Buy_HomeView_BackgroundColor = [UIColor colorWithHex:@"#2E3038"];
    
    self.loginHistoryTextColor = [UIColor colorWithHex:@"999999"];
    self.messageIconName = @"xiaoxizhongxin";
    self.quanziLaBaImage = @"消息通知";
    self.xinshuiFollowBtnBackground = BASECOLOR;
    self.LHDSBtnImage = @"xs_xf_六合大神";
    self.HomeViewBackgroundColor = [UIColor colorWithHex:@"1D1E24"];
    self.OpenLotteryBottomNFullImage = @"img_red";
    self.OpenLotteryBottomNormalImage = @"img_orange";
    self.BuyLotteryQPDDZGrayImageName = @"buy_qp_ddz";
    self.BuyLotteryQPBJLGrayImageName = @"buy_qp_bjl";
    self.BuyLotteryQPSLWHGrayImageName = @"buy_qp_slwh";
    self.BuyLotteryQPBRNNGrayImageName = @"buy_qp_brnn";
    self.BuyLotteryQPWRZJHGrayImageName = @"buy_qp_wrzjh";
    self.BuyLotteryQPXLCHGrayImageName = @"buy_qp_xlch";
    self.AoZhouLotterySwitchBtnImage = @"icon_qhms";
    self.AoZhouLotterySwitchBtnTitleColor = [UIColor colorWithHex:@"D5A864"];
    self.bottomDefaultImageName = @"img_darkgrey";
    self.ChangLongRightBtnTitleNormalColor = [UIColor colorWithHex:@"FFFFFF"];
    self.ChangLongRightBtnSubtitleNormalColor = [UIColor colorWithHex:@"999999"];
    self.ChangLongRightBtnBackgroundColor = [UIColor colorWithHex:@"40434F"];
    self.AoZhouScrollviewBackgroundColor = [UIColor colorWithHex:@"1D1E23"];
    self.AoZhouMiddleBtnNormalBackgroundColor = [UIColor colorWithHex:@"2D2F37"];
    self.AoZhouMiddleBtnSelectBackgroundColor = [UIColor colorWithHex:@"FF1637"];
    self.AoZhouLotterySeperatorLineColor = [UIColor colorWithHex:@"2D2F37"];
    self.AoZhouLotteryBtnTitleSelectColor = [UIColor colorWithHex:@"FFE292"];
    self.AoZhouLotteryBtnSelectBackgroundColor = [UIColor colorWithHex:@"AC1E2D"];
    self.AoZhouLotteryBtnSelectSubtitleColor = [UIColor colorWithHex:@"F2B68A"];
    self.AoZhouLotteryBtnTitleNormalColor = [UIColor colorWithHex:@"FFFFFF"];
    self.AoZhouLotteryBtnNormalBackgroundColor = [UIColor colorWithHex:@"2D2F37"];
    self.AoZhouLotteryBtnNormalSubtitleColor = [UIColor colorWithHex:@"999999"];
    self.CartSectionLineColor = [UIColor colorWithHex:@"18191D"];
    self.ChangLongTitleColor = [UIColor colorWithHex:@"FFFFFF"];
    self.ChangLongTimeLblColor = [UIColor colorWithHex:@"FF5B10"];
    self.ChangLongTotalLblColor = [UIColor colorWithHex:@"11C368"];
    self.ChangLongIssueTextColor = [UIColor colorWithHex:@"999999"];
    self.ChangLongKindLblTextColor = [UIColor colorWithHex:@"3FDCFE"];
    self.ChangLongResultLblColor = [UIColor colorWithHex:@"FFC145"];
    self.CO_Me_NicknameLabel = [UIColor colorWithHex:@"FFFFFF"];
    self.WechatLoginImageName = @"td_login_wx";
    self.QQLoginImageName = @"td_login_QQ";
    self.xxncCheckBtnBackgroundColor = [UIColor colorWithHex:@"A3905C"];
    self.xxncImageName = @"td_login_xgnc";
    self.ForgetPsdWhiteBackArrow = @"td_login_return_icon";
    self.LoginWhiteClose = @"td_login_xx";
    self.MimaEye = @"td_login_lock";
    self.NicknameEye = @"td_login_red";
    self.CodeEye = @"td_login_confirm";
    self.InviteCodeEye = @"td_login_invcode";
    self.AccountEye = @"td_login_phone";
    self.ForgetPsdTitleTextColor = [UIColor colorWithHex:@"E6BB85"];
    self.ForgetPsdBackgroundImage = @"td_login_wjmm";
    self.LoginForgetPsdTextColor = [UIColor colorWithHex:@"6A614D"];
    self.RegistNoticeTextColor = [UIColor colorWithHex:@"9E2D32"];
    self.RegistBackgroundImage = @"td_reg_back";
    self.LoginBackgroundImage = @"td_login_back";
    self.LoginBtnBackgroundcolor = [UIColor colorWithHex:@"9E2D32"];
    self.LoginBoardColor = [UIColor colorWithHex:@"C2955D"];
    self.LoginSureBtnTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.LoginLinebBackgroundColor = [UIColor colorWithHex:@"A3905C"];
    self.LoginTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.SixOpenHeaderSubtitleTextColor = [UIColor colorWithHex:@"BBBBBB"];
    self.QicCiDetailSixheadTitleColor = [UIColor colorWithHex:@"999999"];
    self.QiCiXQSixHeaderSubtitleTextColor = [UIColor colorWithHex:@"999999"];
    
    self.chongqinheadBackgroundColor = [UIColor colorWithHex:@"2D2F37"];
    self.QiCiDetailInfoColor = [UIColor colorWithHex:@"E5C570"];
    self.QiCiDetailLineBackgroundColor = [UIColor colorWithHex:@"3C3E48"];
    self.QiCiDetailTitleColor = [UIColor colorWithHex:@"999999"];
    self.QiCiDetailCellBackgroundColor = [UIColor colorWithHex:@"2D2F37"];
    self.CO_OpenLotHeaderInSectionView = [UIColor colorWithHex:@"#811F29"];
    self.XSTJSearchImage = @"sousuo";
    self.XSTJMyArticleImage = IMAGE(@"wode");
    self.PK10_color1 = [UIColor colorWithHex:@"e5de14"];
    self.PK10_color2 = [UIColor colorWithHex:@"106ced"];
    self.PK10_color3 = [UIColor colorWithHex:@"4c4a4a"];
    self.PK10_color4 = [UIColor colorWithHex:@"ec6412"];
    self.PK10_color5 = [UIColor colorWithHex:@"1ed0d3"];
    self.PK10_color6 = [UIColor colorWithHex:@"1e0df4"];
    self.PK10_color7 = [UIColor colorWithHex:@"a6a6a6"];
    self.PK10_color8 = [UIColor colorWithHex:@"e9281f"];
    self.PK10_color9 = [UIColor colorWithHex:@"770800"];
    self.PK10_color10 = [UIColor colorWithHex:@"2e9c18"];
    
    self.CO_GD_SelectedTextNormal = [UIColor colorWithHex:@"#f7e222"];
    self.CO_GD_SelectedTextSelected = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_GD_Title_BtnBackSelected = self.CO_Main_ThemeColorTwe;
    
    self.BuyLotteryZCjczqGrayImageName = @"buy_zc_jczq";
    self.BuyLotteryZCjclqGrayImageName = @"buy_zc_jclq";
    self.BuyLotteryZCzqsscGrayImageName = @"buy_zc_zq14c";
    self.BuyLotteryZCrxjcGrayImageName = @"buy_zc_rx9c";
    self.BuyLotteryQPdzGrayImageName = @"buy_qp_dz";
    self.BuyLotteryQPerBaGangGrayImageName = @"buy_qp_ebg";
    self.BuyLotteryQPqznnGrayImageName = @"buy_qp_qznn";
    self.BuyLotteryQPzjhGrayImageName = @"buy_qp_zjh";
    self.BuyLotteryQPsgGrayImageName = @"buy_qp_sg";
    self.BuyLotteryQPyzlhGrayImageName = @"buy_qp_yzlh";
    self.BuyLotteryQPesydGrayImageName = @"buy_qp_21d";
    self.BuyLotteryQPtbnnGrayImageName = @"buy_qp_tbnn";
    self.BuyLotteryQPjszjhGrayImageName = @"buy_qp_jszjh";
    self.BuyLotteryQPqzpjGrayImageName = @"buy_qp_qjpj";
    self.BuyLotteryQPsssGrayImageName = @"buy_qp_sss";
    self.BuyLotteryQPxywzGrayImageName = @"buy_qp_xywz";
    
    self.SettingPushImageName = @"setting_tuisong";
    self.SettingShakeImageName = @"setting_yaoyiyao";
    self.SettingVoiceImageName = @"setting_voice";
    self.SettingSwitchSkinImageName = @"setting_caizhonglan";
    self.SettingServiceImageName = @"setting_fuwuxieyi";
    self.SettingAboutUsImageName = @"setting_aboutme";
    self.IC_Me_SettingTopImageName = @"mine_topview_bg";
    self.IC_Me_SettingTopHeadIcon = @"setting_icon";
    
    self.SixGreenBallName = @"kj_sixgreen";
    self.SixBlueBallName = @"kj_sixblue";
    self.SixRedBallName = @"kj_sixred";
    self.SscBlueBallName = @"kj_lq";
    self.SscBallName = @"kj_hq";
    self.PostCircleImageName = @"postcircle";
    self.PostCircleImage = IMAGE(@"postcircle");
    self.CircleUserCenterMiddleBtnBackgroundColor = MAINCOLOR;
    self.CircleUderCenterTopImage = IMAGE(@"circleuserback");
    self.ApplyExpertPlaceholdColor = [UIColor colorWithHex:@"dddddd"];
    self.CO_Account_Info_BtnBack = [UIColor colorWithHex:@"F6C544"];
    self.ApplyExpertConfirmBtnTextColor = [UIColor colorWithHex:@"333333"];
    self.applyExpertBackgroundColor = MAINCOLOR;
    self.ExpertInfoTextColorA = [UIColor colorWithHex:@"dddddd"];
    self.ExpertInfoTextColorB = [UIColor colorWithHex:@"FFFFFF"];
    self.WFSMImage = @"玩法说明";
    
    self.PrizeMessageTopbackViewTextColor = BLACK;
    self.CO_Home_Gonggao_TopBackViewStatus1 = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_Gonggao_TopBackViewStatus2 = [UIColor colorWithHex:@"FFFFFF"];
    self.GraphSetViewBckgroundColor = [UIColor colorWithHex:@"C2A444"];
    
    
    self.IM_AI_BirthdayImage = IMAGE(@"AIbirthday");
    self.IM_AI_ShengXiaoBackImage = IMAGE(@"背面");
    self.IM_AI_ShuImage = IMAGE(@"鼠正面");
    self.IM_AI_GouImage = IMAGE(@"狗正面");
    self.IM_AI_HouImage = IMAGE(@"猴正面");
    self.IM_AI_HuImage = IMAGE(@"虎正面");
    self.IM_AI_JiImage = IMAGE(@"鸡正面");
    self.IM_AI_LongImage = IMAGE(@"龙正面");
    self.IM_AI_MaImage = IMAGE(@"马正面");
    self.IM_AI_NiuImage = IMAGE(@"牛正面");
    self.IM_AI_SheImage = IMAGE(@"蛇正面");
    self.IM_AI_TuImage = IMAGE(@"兔正面");
    self.IM_AI_YangImage = IMAGE(@"羊正面");
    self.IM_AI_ZhuImage = IMAGE(@"猪正面");
    self.TouZhuImage = IMAGE(@"td_xf_button");
    self.IM_AI_ShakeNormalImage = IMAGE(@"摇一摇");
    self.IM_AI_ShengXiaoNormalImage = IMAGE(@"生肖");
    self.IM_AI_LoverNormalImage = IMAGE(@"爱人");
    self.IM_AI_FamilyNormalImage = IMAGE(@"家人");
    self.IM_AI_BirthdayNormalImage = IMAGE(@"生日");
    self.IM_AI_ShakeSeletImage = IMAGE(@"摇一摇2");
    self.IM_AI_ShengXiaoSeletImage = IMAGE(@"生肖2");
    self.IM_AI_LoverSeletImage = IMAGE(@"爱人2");
    self.IM_AI_FamilySeletImage = IMAGE(@"家人2");
    self.IM_AI_BirthdaySeletImage = IMAGE(@"生日2");
    self.IM_AI_BGroundcolorImage = IMAGE(@"爱人生日");
    self.IM_AI_AutoSelectLblNormalColor = [UIColor colorWithHex:@"000000"];
    self.IM_AI_AutoSelectLblSelectColor = [UIColor colorWithHex:@"C6AC7B"];
    
    
    self.AppFistguideUse1 = @"app_guide_1";
    self.AppFistguideUse2 = @"app_guide_2";
    self.AppFistguideUse3 = @"app_guide_3";
    
    self.registerVcPhotoImage = IMAGE(@"phone");
    self.registerVcCodeImage = IMAGE(@"td_login_confirm");
    self.registerVcPSDImage = IMAGE(@"td_login_lock");
    self.registerVcPSDAgainImage = IMAGE(@"td_login_lock");
    self.registerVcInviteImage = IMAGE(@"td_login_message");
    self.registerVcRegisterBtnBTextColor = BASECOLOR;
    self.registerVcRegisterBtnBckgroundColor = [UIColor colorWithHex:@"ac1e2d"];
    self.LoginVcHiddenImage = IMAGE(@"td_login_show_password");
    self.LoginVcHiddenSelectImage = IMAGE(@"td_login_hid_password");
    self.LoginVcPhoneImage = IMAGE(@"td_login_phone");
    self.loginVcQQimage = IMAGE(@"td_login_QQ");
    self.loginVcWechatimage = IMAGE(@"td_login_wx");
    self.loginLineBackgroundColor = [UIColor colorWithHex:@"666666"];
    self.logoIconImage = IMAGE(@"彩票宝典");
    self.loginVcBgImage = IMAGE(@"td_login_vs_back");
    self.shareToLblTextColor = [UIColor colorWithHex:@"666666"];
    self.shareVcCopyBtnBackgroundColor = [UIColor colorWithHex:@"E5CD98"];
    self.shareVcQQImage = IMAGE(@"shareVcQQImage");
    self.shareVcPYQImage = IMAGE(@"shareVcPYQImage");
    self.shareVcWeChatImage = IMAGE(@"shareVcWeChatImage");
    self.shareLineImage = IMAGE(@"shareLineImage");
    self.OpenLotteryTimeLblTextColor = [UIColor colorWithHex:@"DC612F"];
    self.CO_GD_TopBackgroundColor = [UIColor colorWithHex:@"2E2F33"];
    self.CO_GD_TopBackHeadTitle = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_GD_AllPeople_BtnText = [UIColor colorWithHex:@"#333333"];
    
    self.IM_GD_DashenTableImgView = IMAGE(@"table");
    self.expertContentLblTextcolor = [UIColor colorWithHex:@"dddddd"];
    self.expertWinlblTextcolor = WHITE;
    self.expertInfoTopImgView = IMAGE(@"zjxq");
    self.circleListDetailViewBackgroundColor = MAINCOLOR;
    self.IM_CircleDetailHeadImage = IMAGE(@"圈子顶部背景图");
    self.MyWalletBankCartImage = IMAGE(@"wallet_card_icon");
    self.MyWalletTopImage = IMAGE(@"mine_topview_bg_hight");
    
    self.CO_MoneyTextColor = [UIColor colorWithHex:@"#c9a974"];
    self.accountInfoNicknameTextColor = [UIColor colorWithHex:@"FFFFFF"];
    
    self.accountInfoTopViewBackgroundColor = MAINCOLOR;
    self.confirmBtnBackgroundColor = [UIColor colorWithHex:@"AC1E2D"];
    self.safeCenterTopImage = IMAGE(@"mine_topview_bg");
    self.CO_Me_TopLabelTitle = [UIColor colorWithHex:@"FFFFFF"];
    self.shareInviteImage = IMAGE(@"fxhy_yqmwz");
    self.shareMainImage = IMAGE(@"shareMainImage");
    self.shareBackImage = IMAGE(@"");
    self.calendarLeftImage = IMAGE(@"");
    self.calendarRightImage = IMAGE(@"");
    self.calendarBackgroundColor = [UIColor groupTableViewBackgroundColor];
    self.KJRLSelectBackgroundColor = CLEAR;
    self.IM_CalendarTopImage = IMAGE(@"td_kj_kjrl");
    self.LHTKTextfieldBackgroundColor = WHITE;
    self.LHTKRemarkTextFeildBorderColor = BLACK;
    self.XSTJdetailZanImage = IMAGE(@"td_xs_zan");
    self.attentionViewCloseImage = IMAGE(@"closeAttention");
    self.backBtnImageName = @"tw_nav_return";
    self.HobbyCellImage = IMAGE(@"勾选");
    
    self.Left_VC_MyWalletImage = @"cdh_wdqb";
    self.Left_VC_SecurityCenterImage = @"cdh_aqzx";
    self.Left_VC_MessageCenterImage = @"cdh_xxzx";
    self.Left_VC_BuyHistoryImage = @"cdh_tzjl";
    self.Left_VC_MyTableImage = @"cdh_wdbb";
    self.Left_VC_SettingCenterImage = @"cdh_szzx";
    
    self.Left_VC_BtnTitleColor = [UIColor colorWithHex:@"ffd994"];
    
    self.Left_VC_ChargeBtnImage = IMAGE(@"cdh_cz");
    self.Left_VC_GetMoneyBtnImage = IMAGE(@"cdh_tx");
    self.Left_VC_KFBtnImage = IMAGE(@"cdh_kf");
    
    self.Left_VC_CellBackgroundColor = [UIColor hexStringToColor:@"1d1e23"];
    self.LeftCtrlCellTextColor = WHITE;
    self.Left_VC_BtnBackgroundColor = [UIColor colorWithHex:@"1D1E24"];
    self.LeftControllerLineColor = [UIColor hexStringToColor:@"FFFFFF" andAlpha:0.5];
    
    self.leftBackViewImageColor = CLEAR;
    self.Left_VC_TopImage = [ColorTool imageWithColor:MAINCOLOR];
    self.mine_seperatorLineColor = [UIColor colorWithHex:@"c8ab7f"];
    self.openPrizePlusColor = [UIColor grayColor];
    self.OpenPrizeWuXing = [UIColor colorWithHex:@"FFFFFF"];
    self.IC_home_sub_SS = @"icon_ss";
    self.IC_home_sub_YC = @"icon_yc";
    self.IC_home_sub_ZJ = @"icon_zj";
    self.IC_home_sub_BF = @"icon_bf";
    self.IC_home_sub_HMZS = @"homesub_1_5";
    self.IC_home_sub_JRHM = @"homesub_3_3";
    self.IC_home_sub_HMYL = @"homesub_3_2";
    self.IC_home_sub_LRFX = @"homesub_3_5";
    self.IC_home_sub_GYHTJ = @"homesub_3_7";
    self.IC_home_sub_LMCL = @"homesub_3_8";
    self.IC_home_sub_LMLZ = @"homesub_3_9";
    self.IC_home_sub_LMYL = @"homesub_3_10";
    self.IC_home_sub_QHLZ = @"homesub_3_11";
    self.IC_home_sub_LMLS = @"homesub_3_12";
    self.IC_home_sub_GYHLZ = @"homesub_3_13";
    self.IC_home_sub_HBZS = @"homesub_3_141";
    self.IC_home_sub_YLTJ = @"homesub_1_2";
    self.IC_home_sub_JRTJ = @"homesub_3_15";
    self.IC_home_sub_MFTJ = @"homesub_3_4";
    self.IC_home_sub_QXT = @"td_sub_曲线图";
    self.IC_home_sub_TMZS = @"td_sub_tmzs";
    self.IC_home_sub_GSSH = @"homesub_3_6";
    self.IC_home_sub_History = @"homesub_3_1";
    self.IC_home_sub_XSTJ = @"homesub_3_4";
    self.IC_home_sub_LHTK = @"homesub_2_2";
    self.IC_home_sub_CXZS = @"homesub_2_4";
    self.IC_home_sub_ZXTJ = @"homesub_2_5";
    self.IC_home_sub_KJRL = @"homesub_2_6";
    self.IC_home_sub_AIZNXH = @"homesub_2_8";
    self.IC_home_sub_SXCZ = @"homesub_2_9";
    self.IC_home_sub_TMLS = @"homesub_2_10";
    self.IC_home_sub_ZMLS = @"homesub_2_11";
    self.IC_home_sub_WSDX = @"homesub_2_12";
    self.IC_home_sub_SXTM = @"homesub_2_13";
    self.IC_home_sub_SXZM = @"homesub_2_14";
    self.IC_home_sub_BSTM = @"homesub_2_15";
    self.IC_home_sub_BSZM = @"homesub_2_16";
    self.IC_home_sub_TMLM = @"homesub_2_17";
    self.IC_home_sub_TMWS = @"homesub_2_18";
    self.IC_home_sub_ZMWS = @"homesub_2_19";
    self.IC_home_sub_ZMZF = @"homesub_2_20";
    self.IC_home_sub_HMBD = @"homesub_2_21";
    self.IC_home_sub_JQYS = @"homesub_2_22";
    self.IC_home_sub_LMZS = @"homesub_3_14";
    self.IC_home_sub_LXZS = @"homesub_2_24";
    self.IC_home_sub_LHDS = @"icon_sy_lhds";
    self.IC_home_sub_History = @"homesub_3_1";
    self.IM_Home_cartBgImageView = IMAGE(@"");
    self.CO_buyLotBgColor = [UIColor colorWithHex:@"#2E3038"];
    
    self.OpenLotteryVC_ColorLabs_TextB = [UIColor colorWithHex:@"666666"];
    self.CO_Me_ItemTextcolor = [UIColor colorWithHex:@"999999"];
    
    //我的
    self.IM_Me_MyWalletImage = IMAGE(@"wdqb");
    self.IM_Me_MyAccountImage = IMAGE(@"账户信息");
    self.IM_Me_SecurityCnterImage = IMAGE(@"我的我的安全中心");
    self.IM_Me_MyTableImage = IMAGE(@"wdbb");
    self.IM_Me_buyHistoryImage = IMAGE(@"tzjl");
    self.IM_Me_MessageCenterImage = IMAGE(@"消息中心");
    self.IM_Me_setCenterImage = IMAGE(@"我的设置icon");
    self.IM_Me_shareImage = IMAGE(@"wd_fxicon");
    self.CO_Me_SubTitleText = [UIColor colorWithHex:@"FFFFFF"];
    
    self.IM_Me_MoneyRefreshBtn = IMAGE(@"mine_moneyRef");
    self.IM_Me_ChargeImage = IMAGE(@"td_me_wycz");
    self.IM_Me_GetMoneyImage = IMAGE(@"td_me_mstx");
    self.IM_Me_MoneyDetailImage = IMAGE(@"td_me_zjmx");
    
    
    self.CO_BuyLot_Left_ViewBack = [UIColor colorWithHex:@"#27282d"];
    self.CO_BuyLot_Left_LeftCellBack = [UIColor colorWithHex:@"#27282D"];
    self.CO_BuyLot_Left_LeftCellTitleText = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_BuyLot_Left_LeftCellBack_Selected = [UIColor colorWithHex:@"#ac1e2d"];
    self.CO_BuyLot_Left_LeftCellTitleText_Selected = [UIColor colorWithHex:@"#EACD91"];
    self.CO_BuyLot_Left_CellBack = [UIColor colorWithHex:@"#27282D"];
    self.CO_BuyLot_Left_CellTitleText = [UIColor colorWithHex:@"#EACD91"];
    
    self.IM_topBackImageView = IMAGE(@"wd_bj");
    self.CO_Me_YuEText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Mine_setContentViewBackgroundColor = [UIColor colorWithHex:@"1D1E24"];
    //圈子
    self.circleHomeCell1Bgcolor = @"";
    self.circleHomeCell2Bgcolor = @"";
    self.circleHomeCell3Bgcolor = @"";
    self.circleHomeCell4Bgcolor = @"";
    self.circleHomeCell5Bgcolor = @"";
    self.circleHomeSDQImageName = @"icon_sdq";
    self.circleHomeGDDTImageName = @"icon_gddt";
    self.circleHomeXWZXImageName = @"icon_xwzx";
    self.circleHomeDJZXImageName = @"icon_djzx";
    self.circleHomeZCZXImageName = @"icon_zczx";
    self.circleHomeBgImage = IMAGE(@"");
    self.CO_LongDragonTopView = [UIColor colorWithHex:@"1D1E23"];
    self.CO_LongDragonTopViewBtn =  [UIColor colorWithHex:@"#B39660"];
    
    //首页
    self.CO_home_SubCellTitleText = [UIColor colorWithHex:@"999999"];
    self.IM_home_SanJiaoImage = IMAGE(@"三角形箭头");
    self.IM_home_hotNewsImageName = IMAGE(@"热门资讯");
    self.CO_home_SubheaderBallBtnBack = [UIColor colorWithHex:@"c22122"];
    
    self.IM_home_XSTJImage = IMAGE(@"心水推荐");
    self.IM_home_LHDSImage = IMAGE(@"icon_lhds");
    self.IM_home_LHTKImage = IMAGE(@"六合图库home");
    self.IM_home_GSSHImage = IMAGE(@"公式杀号home");
    self.IC_home_ZBKJImageName = @"homeZBKJ";
    self.IC_home_LSKJImageName = @"img_lskj";
    self.IC_home_CXZSImageName = @"homeCXZS";
    
    
    
    self.IC_Home_CQSSC = @"重庆时时彩";
    self.IC_Home_LHC = @"六合彩";
    self.IC_Home_BJPK10 = @"北京PK10";
    self.IC_Home_XJSSC = @"新疆时时彩";
    self.IC_Home_XYFT = @"幸运飞艇";
    self.IC_Home_TXFFC = @"比特币分分彩";
    self.IC_Home_PCDD = @"PC蛋蛋";
    self.IC_Home_ZCZX = @"足彩资讯";
    self.IC_Home_AZF1SC = @"六合彩";
    self.IC_Home_GDCZ = @"更多彩种";
    
    self.IC_Home_Icon_BeginName = @"td_";
    
    self.CO_LiveLot_BottomBtnBack = [UIColor colorWithHex:@"#AC1E2D"];
    self.CO_LiveLot_CellLabelBack = [UIColor colorWithHex:@"#BAA069"];
    self.CO_LiveLot_CellLabelText = [UIColor colorWithHex:@"#FFFFFF"];
    
    self.CO_ChatRoomt_SendBtnBack = self.CO_Main_ThemeColorTwe;
    
    
    self.xinshuiDetailAttentionBtnNormalGroundColor = BASECOLOR;
    self.pushDanBarTitleSelectColot = BASECOLOR;
    self.pushDanSubBarNormalTitleColor = [UIColor colorWithHex:@"666666"];
    self.pushDanSubBarSelectTextColor = BASECOLOR;
    
    self.pushDanSubbarBackgroundcolor = [UIColor colorWithHex:@"000000"];
    self.CO_LongDragon_PushSetting_BtnBack = self.CO_Main_ThemeColorTwe;
    self.pushDanBarTitleNormalColor = [UIColor colorWithHex:@"EEEEEE"];
    self.CO_Circle_Cell2_TextLabel_BackgroundC = [UIColor colorWithHex:@"9e353c"];
    self.CO_Circle_Cell2_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"9e353c"];
    self.CO_Circle_Cell3_TextLabel_BackgroundC = [UIColor colorWithHex:@"647e24"];
    self.CO_Circle_Cell1_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"5649b3"];
    self.bettingBtnColor = BUTTONCOLOR;
    self.xinshuiDetailAttentionBtnBackGroundColor = MAINCOLOR;
    self.LoginNamePsdPlaceHoldColor = [UIColor colorWithHex:@"7a6d4c"];
    self.missCaculateBarNormalBackground = MAINCOLOR;
    self.missCaculateBarselectColor = BASECOLOR;
    self.missCaculateBarNormalColor = WHITE;
    self.openLotteryCalendarBackgroundcolor = MAINCOLOR;
    self.openLotteryCalendarTitleColor = kColor(43, 43, 43);
    self.openLotteryCalendarWeekTextColor = WHITE;
    self.CO_OpenLot_BtnBack_Normal = [UIColor groupTableViewBackgroundColor];
    self.CO_OpenLot_BtnBack_Selected = [UIColor colorWithHex:@"EACD91"];
    self.CO_Home_Gonggao_TopTitleText = [UIColor colorWithHex:@"333333"];
    self.CO_Home_Gonggao_Cell_MessageTopViewBack = [UIColor colorWithHex:@"FFFFFF"];
    self.KeyTitleColor = [UIColor colorWithHex:@"fed696"];
    
    
    self.xinshuiRemarkTitleColor = BASECOLOR;
    
    self.sixHeTuKuRemarkbarBackgroundcolor = MAINCOLOR;
    self.myCircleUserMiddleViewBackground = [UIColor colorWithHex:@"2C3036"];
    self.openCalendarTodayColor = [UIColor redColor];
    self.openCalendarTodayViewBackground = [UIColor colorWithHex:@"C6AC7B"];
    self.LoginNamePsdTextColor = [UIColor colorWithHex:@"FFFFFF"];
    self.MineTitleStrColor = [UIColor colorWithHex:@"eacd91"];
    self.MessageTitleColor  = WHITE;
    
    self.xinshuiBottomViewTitleColor = BASECOLOR;
    self.CO_KillNumber_LabelText = [UIColor colorWithHex:@"00008B"];
    self.CO_KillNumber_LabelBack = [UIColor colorWithHex:@"F9EBD5"];
    self.CO_Home_SubHeaderTitleColor = [UIColor colorWithHex:@"FFFFFF"];;
    self.CO_Home_SubHeaderSubtitleColor = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_SubheaderTimeLblText = [UIColor colorWithHex:@"F4D958"];;
    self.CO_Home_SubheaderLHCSubtitleText = [UIColor colorWithHex:@"dddddd"];
    self.TopUpViewTopViewBackgroundcolor = CLEAR;
    self.chargeMoneyLblSelectColor = [UIColor colorWithHex:@"FFFFFF"];
    self.chargeMoneyLblSelectBackgroundcolor = [UIColor colorWithHex:@"ac1e2d"];
    self.chargeMoneyLblNormalColor = [UIColor colorWithHex:@"C48936"];
    self.tabbarItemTitleColor = [UIColor lightGrayColor];
    
    self.RootVC_ViewBackgroundC = [UIColor colorWithHex:@"1D1E24"];
    self.tabbarItemTitleColor = [UIColor lightGrayColor];
    self.CO_Circle_Cell3_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"6d872f"];
    self.CO_Circle_Cell4_TextLabel_BackgroundC = [UIColor colorWithHex:@"3ea358"];
    self.CO_Circle_Cell4_DetailTextLabel_BackgroundC = [UIColor colorWithHex:@"3ea358"];
    self.tixianShuoMingColor = BUTTONCOLOR;
    
    self.CircleVC_HeadView_BackgroundC = [UIColor colorWithHex:@"303136"];
    self.CO_Circle_Cell_BackgroundC = [UIColor colorWithHex:@"3a3b40"];
    self.CO_Circle_Cell_TextLabel_BackgroundC = [UIColor colorWithHex:@"fed696"];
    self.CO_Circle_Cell_DetailTextLabel_BackgroundC = [UIColor whiteColor];
    self.CO_Home_VC_NoticeView_Back = [UIColor colorWithHex:@"#2B2E37"];
    self.CO_Home_VC_NoticeView_LabelText = [UIColor colorWithHex:@"8D8D8D"];
    self.CO_Home_NoticeView_LabelText = [UIColor colorWithHex:@"#DDDDDD"];
    self.CO_Home_CellCartCellSubtitleText = [UIColor colorWithHex:@"aaaaaa"];
    self.CO_Home_VC_HeadView_Back = [UIColor colorWithHex:@"1D1E24"];
    self.CO_Home_NewsTopViewBack = [UIColor colorWithHex:@"#2C2E36"];
    self.CO_Home_NewsBgViewBack = [UIColor colorWithHex:@"1D1E24"];
    self.CO_Home_News_LineView = [UIColor blackColor];
    self.CO_Home_News_HeadTitleText = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Home_News_ScrollLabelText = [UIColor colorWithHex:@"#FDF8F8"];
    self.CO_Home_VC_HeadView_HotMessLabelText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_Home_CollectionView_CartCellTitle = [UIColor colorWithHex:@"FFFFFF"];
    
    self.CartBarBackgroundColor = [UIColor colorWithHex:@"1d1e24"];
    self.CartBarTitleNormalColor = [UIColor colorWithHex:@"FFFFFF"];
    self.CartBarTitleSelectColor = self.CO_NavigationBar_Title;
    self.CartHomeHeaderSeperatorColor = [UIColor colorWithHex:@"ff9711"];
    self.genDanHallTitleNormalColr = [UIColor colorWithRed:0.612 green:0.612 blue:0.616 alpha:1.000];
    self.genDanHallTitleSelectColr = [UIColor colorWithRed:0.773 green:0.651 blue:0.427 alpha:1.000];;
    self.genDanHallTitleBackgroundColor = [UIColor colorWithRed:0.180 green:0.184 blue:0.200 alpha:1.000];;
    self.gongShiShaHaoFormuTitleNormalColor = [UIColor colorWithHex:@"FFFFFF"];
    self.gongShiShaHaoFormuTitleSelectColor = BASECOLOR;
    self.gongshiShaHaoFormuBtnBackgroundColor = BLACK;
    
    self.CO_Home_VC_HeadView_NumbrLables_Text = [UIColor colorWithHex:@"FDFDFD"];
    self.CO_Home_News_HotHeadViewBack = [UIColor colorWithHex:@"#2C2E36"];
    self.CO_Home_VC_Cell_ViewBack = [UIColor colorWithHex:@"2E3238"];
    self.IM_Home_HeadlineImg = IMAGE(@"td_CPT头条");
    self.CO_Home_HeadlineLabelText = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_Home_HeadlineLineView = [UIColor colorWithHex:@"#CCCCCC"];
    self.IM_Home_BottomBtnOne = IMAGE(@"home_bottom_联系客服");
    self.IM_Home_BottomBtnTwo = IMAGE(@"home_bottom_聊天室");
    self.IM_Home_BottomBtnThree = IMAGE(@"home_bottom_网页版");
    self.CO_Home_VC_Cell_Titlelab_Text = [UIColor colorWithHex:@"FDFDFD"];
    self.CO_Home_VC_Cell_SubTitlelab_Text = [UIColor colorWithHex:@"8D8D8D"];
    self.CO_Home_VC_ADCollectionViewCell_Back = [UIColor colorWithHex:@"1D1E24"];
    self.CO_Home_CellBackgroundColor = [UIColor colorWithHex:@"#1d1e25"];
    
    self.CO_Home_CellContentView = [UIColor colorWithHex:@"#2C2E36"];
    self.CO_Home_VC_PCDanDan_ViewBack2 = [UIColor colorWithHex:@"1D1E24"];
    
    self.CO_Home_VC_PCDanDan_line_ViewBack = [UIColor colorWithHex:@"666666"];
    self.OpenLotteryVC_ColorLabs_TextC = [UIColor colorWithHex:@"DC612F"];
    self.OpenLotteryVC_ColorLabs1_TextC = [UIColor colorWithHex:@"8D8D8D"];
    self.OpenLotteryVC_SubTitle_TextC = [UIColor colorWithHex:@"D6D6D6"];
    self.OpenLotteryVC_SubTitle_BorderC = [UIColor colorWithHex:@"8D8D8D"];
    self.OpenLotteryVC_Cell_BackgroundC = [UIColor colorWithHex:@"3a3b3f"];
    self.OpenLotteryVC_View_BackgroundC = [UIColor colorWithHex:@"1D1E24"];
    self.CO_LongDragonCell = CLEAR;
    self.OpenLotteryVC_TitleLabs_TextC = [UIColor colorWithHex:@"333333"];
    self.OpenLotteryVC_SeperatorLineBackgroundColor = [UIColor colorWithHex:@"333333"];
    self.CO_OpenLetBtnText_Normal = [UIColor colorWithHex:@"#737373"];
    self.SixRecommendVC_View_BackgroundC = [UIColor colorWithHex:@"f4f4f4"];
    self.MineVC_Btn_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    
    self.HobbyVC_MessLab_BackgroundC = [UIColor colorWithHex:@"1D1E24"];
    self.HobbyVC_MessLab_TextC = [UIColor lightGrayColor];
    self.HobbyVC_View_BackgroundC = [UIColor colorWithHex:@"2C2E35"];
    self.HobbyVC_OKButton_BackgroundC = [UIColor colorWithHex:@"9E2D32"];
    self.HobbyVC_OKButton_TitleBackgroundC = [UIColor colorWithHex:@"FDFDFD"];
    self.Circle_Title_nameColor = [UIColor colorWithHex:@"4e79c2"];
    self.HobbyVC_SelButton_TitleBackgroundC = [UIColor colorWithHex:@"FFFFFF"];
    self.HobbyVC_UnSelButton_TitleBackgroundC = [UIColor lightGrayColor];
    self.CO_Circle_Cell1_TextLabel_BackgroundC = self.CO_Circle_Cell_TextLabel_BackgroundC;
    self.HobbyVC_SelButton_BackgroundC = [UIColor colorWithHex:@"9E2D32"];
    self.HobbyVC_UnSelButton_BackgroundC = [UIColor colorWithHex:@"1D1E24"];
    self.Circle_View_BackgroundC = [UIColor colorWithHex:@"1D1E24"];
    self.Circle_HeadView_Title_UnSelC = [UIColor colorWithHex:@"999999"];
    self.Circle_HeadView_Title_SelC = [UIColor colorWithHex:@"333333"];
    self.Circle_HeadView_BackgroundC = [UIColor colorWithHex:@"393B44"];
    self.Circle_HeadView_NoticeView_BackgroundC = [UIColor colorWithHex:@"2D2D32"];
    self.Circle_HeadView_GuangBo_BackgroundC = [UIColor colorWithHex:@"8D8D8D"];
    self.Circle_Cell_BackgroundC = [UIColor colorWithHex:@"2C3036"];
    self.Circle_Cell_ContentlabC = [UIColor whiteColor];
    self.Circle_Cell_Commit_BackgroundC = [UIColor colorWithHex:@"2D2F36"];
    self.Circle_Cell_Commit_TitleC = [UIColor whiteColor];
    self.Circle_Cell_AttentionBtn_TitleC = [UIColor lightGrayColor];
    self.Circle_Line_BackgroundC = [UIColor colorWithHex:@"fed696"];
    self.Circle_remark_nameColor = [UIColor colorWithHex:@"4e79c2"];
    self.getCodeBtnvBackgroundcolor = [UIColor colorWithHex:@"dddddd"];
    self.Circle_FooterViewLine_BackgroundC = [UIColor darkGrayColor];
    self.OpenLottery_S_Cell_BackgroundC = [UIColor colorWithHex:@"3A3B40"];
    self.OpenLottery_S_Cell_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    self.Login_NamePasswordView_BackgroundC = CLEAR;//[UIColor colorWithHex:@"2c2e36"];
    self.Login_ForgetSigUpBtn_BackgroundC = [UIColor colorWithHex:@"2c2e36" Withalpha:0.5];
    self.Login_ForgetSigUpBtn_TitleC = [UIColor colorWithHex:@"a3905c"];
    self.Login_LogoinBtn_BackgroundC = [UIColor colorWithHex:@"ac1e2d"];
    self.Login_LogoinBtn_TitleC = [UIColor colorWithHex:@"eacd91"];
    self.Buy_LotteryMainBackgroundColor = [UIColor colorWithHex:@"1B1E23"];
    self.RootWhiteC = [UIColor colorWithHex:@"f4f4f4"];
    self.CO_OpenLetBtnText_Selected = [UIColor colorWithHex:@"#333333"];
    self.loginSeperatorLineColor = [UIColor colorWithHex:@"887c5a"];
    self.getCodeBtnvTitlecolor = [UIColor colorWithHex:@"#888888"];
    self.LiuheTuKuLeftTableViewBackgroundColor = [UIColor colorWithHex:@"e0e0e0"];
    self.LiuheTuKuOrangeColor = [UIColor colorWithHex:@"c9a356"];
    self.LiuheTuKuLeftTableViewSeperatorLineColor = [UIColor colorWithHex:@"c2c2c2"];
    self.LiugheTuKuTopBtnGrayColor = [UIColor colorWithHex:@"dddddd"];
    self.LiuheTuKuProgressValueColor = [UIColor colorWithHex:@"f5222d"];
    self.LiuheTuKuTouPiaoBtnBackgroundColor = [UIColor colorWithHex:@"c60000"];
    self.LiuheDashendBackgroundColor = MAINCOLOR;
    
    self.xinShuiReconmentGoldColor = [UIColor colorWithHex:@"ffd994"];
    self.xinShuiReconmentRedColor = [UIColor colorWithHex:@"C01833"];
    self.TouPiaoContentViewTopViewBackground = [UIColor colorWithHex:@"16171b"];
    self.LiuheTuKuRemarkBarBackgroundColor = [UIColor colorWithHex:@"16171b"];
    self.LiuheTuKuRemarkSendBackgroundColor = [UIColor colorWithHex:@"e51c23"];
    self.LiuheTuKuTextRedColor = [UIColor colorWithHex:@"d71820"];
    self.XinshuiRecommentScrollBarBackgroundColor = [UIColor colorWithHex:@"f0f0f0"];
    self.xinshuiBottomVeiwSepeLineColor = [UIColor lightGrayColor];
    self.Circle_Post_titleSelectColor = [UIColor colorWithHex:@"FFFFFF"];
    self.Circle_Post_titleNormolColor = [UIColor lightGrayColor];
    
#pragma mark 购彩
    //购彩
    self.Buy_HeadView_BackgroundC = [UIColor colorWithHex:@"2D2F37"];
    self.Buy_HeadView_Footer_BackgroundC = [UIColor colorWithHex:@"1D1E24"];
    
    self.Buy_HeadView_Title_C = [UIColor colorWithHex:@"999999"];
    
    self.Buy_LeftView_BackgroundC = [UIColor colorWithHex:@"1c1e23"];
    self.Buy_LeftView_Btn_BackgroundUnSel = IMAGE(@"Buy_LeftView_Btn_BackgroundUnSel");
    self.Buy_LeftView_Btn_BackgroundSel = IMAGE(@"Buy_LeftView_Btn_BackgroundSel");
    self.Buy_LeftView_Btn_TitleSelC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_LeftView_Btn_TitleUnSelC = [UIColor colorWithHex:@"999999"];
    self.Buy_LeftView_Btn_PointUnSelC = [UIColor colorWithHex:@"ff5d10"];
    self.Buy_LeftView_Btn_PointSelC = [UIColor colorWithHex:@"01ae00"];
    self.Buy_RightBtn_Title_UnSelC = [UIColor colorWithHex:@"333333"];
    self.Buy_RightBtn_Title_SelC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionHeadV_TitleC = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionHeadV_ViewC = [UIColor colorWithHex:@"ff5d12"];
    self.CO_Bottom_LabelText = [UIColor colorWithHex:@"#FFFFFF"];
    
    self.Buy_CollectionCellButton_BackgroundSel = [UIColor colorWithHex:@"AC1E2D"];
    self.Buy_HeadView_historyV_Cell1_C = [UIColor colorWithHex:@"222429"];
    self.Buy_HeadView_historyV_Cell2_C = [UIColor colorWithHex:@"1D1E24"];
    self.Buy_CollectionCellButton_TitleCSel = [UIColor colorWithHex:@"FFE292"];
    self.Buy_CollectionCellButton_TitleCUnSel = [UIColor colorWithHex:@"FFFFFF"];
    self.Buy_CollectionViewLine_C = [UIColor colorWithHex:@"43464F"];
    self.Buy_CollectionCellButton_SubTitleCSel = [UIColor colorWithHex:@"F2B68A"];
    self.Buy_CollectionCellButton_SubTitleCUnSel = [UIColor colorWithHex:@"999999"];
    
    self.CO_BuyLot_HeadView_LabelText = [UIColor colorWithHex:@"d8d9d6"];
    self.CO_BuyLot_HeadView_Label_border = [UIColor colorWithHex:@"666666"];
    self.CO_BuyLot_Right_bcViewBack = [UIColor colorWithHex:@"999999"];
    self.CO_BuyLot_Right_bcView_border = [UIColor colorWithHex:@"999999"];
    
    self.Buy_CollectionCellButton_BackgroundUnSel = [UIColor colorWithHex:@"2c3036"];
    self.CO_Home_Buy_Footer_BtnBack = [UIColor colorWithHex:@"9C2D33"];
    self.CO_Home_Buy_Footer_Back = [UIColor colorWithHex:@"1B1E23"];
    self.CartHomeSelectSeperatorLine = [UIColor colorWithHex:@"ff9711"];
    //我的
    self.Mine_ScrollViewBackgroundColor = [UIColor colorWithHex:@"1D1E24"];
    self.grayColor999 = [UIColor colorWithHex:@"999999"];
    self.grayColor666 = [UIColor colorWithHex:@"666666"];
    self.grayColor333 = [UIColor colorWithHex:@"333333"];
    self.Mine_rightBtnTileColor = [UIColor colorWithHex:@"FFFFFF"];
    self.Mine_priceTextColor = [UIColor colorWithHex:@"ffe822"];
    self.ChangePsdViewBackgroundcolor = [UIColor colorWithHex:@"F7F7F7"];
    self.CO_Me_MyWallerBalance_MoneyText = [UIColor colorWithHex:@"#FFEA00"];
    self.CO_Me_MyWallerBalanceText = [UIColor colorWithHex:@"#e34b5d"];
    self.MyWalletTotalBalanceColor = [UIColor colorWithHex:@"fff666"];
    self.mineInviteTextCiolor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.6];
    self.CO_Me_MyWallerTitle = [UIColor colorWithHex:@"#E9E9E9"];
    //购彩 番摊 dark
    
#pragma mark番摊 dark
    self.NN_LinelColor = [UIColor colorWithHex:@"282B31"];
    self.NN_xian_normalColor = [UIColor colorWithHex:@"79787B"];
    self.NN_xian_selColor = [UIColor colorWithHex:@"E01932"];
    self.NN_Xian_normalImg = @"xianjia-gray";
    self.NN_Xian_selImg = @"xianjia-color";
    self.NN_zhuang_normalColor = [UIColor colorWithHex:@"79787B"];
    self.NN_zhuang_selColor = [UIColor colorWithHex:@"926B29"];
    self.NN_zhuang_normalImg = @"xianjia-gray";
    
    self.NN_zhuang_selImg = @"zhuangjia-color";
    
    self.NN_XianBgImg = [UIImage imageNamed:@"xianjia-xuanzhong"];
    self.NN_XianBgImg_sel = [UIImage imageNamed:@"xianjia"];
    self.Buy_NNXianTxColor_normal = [UIColor blackColor];
    self.Buy_NNXianTxColor_sel = [UIColor whiteColor];
    self.Fantan_headerLineColor = [UIColor colorWithHex:@"43464E"];
    self.Fantan_historyHeaderBgColor = [UIColor colorWithHex:@"181B20"];
    self.Fantan_historyHeaderLabColor = [UIColor colorWithHex:@"949596"];
    self.Fantan_historycellColor1 = [UIColor colorWithHex:@"979899"];
    self.Fantan_historycellColor2 = [UIColor colorWithHex:@"40454C"];
    self.Fantan_historycellColor3 = [UIColor colorWithHex:@"EB6730"];
    self.Fantan_historycellOddColor = [UIColor blackColor];
    self.Fantan_historycellEvenColor = [UIColor blackColor];
    self.CO_Fantan_HeadView_Label = [UIColor colorWithHex:@"FFFFFF"];
    
    
    
    
    self.RedballImg_normal = @"img_redball_normal";
    self.RedballImg_sel = @"img_redball_selected";
    self.BlueballImg_normal = @"img_blueball_normal";
    self.BlueballImg_sel = @"img_blueball_selected";
    
    self.Fantan_MoneyColor = [UIColor colorWithHex:@"D55D2D"];
    self.Fantan_CountDownBoderColor = [UIColor colorWithHex:@"20252C"];
    self.Fantan_CountDownBgColor = [UIColor colorWithHex:@"21252B"];
    self.Buy_fantanTimeColor = [UIColor colorWithHex:@"EB6831"];
    self.Fantan_DelImg = IMAGE(@"cartclear");
    self.Fantan_ShakeImg = IMAGE(@"cartrandom");
    self.Fantan_AddToBasketImg = IMAGE(@"cartset");
    self.Fantan_basketImg = IMAGE(@"cart");
    
    self.Fantan_FloatImgUp = IMAGE(@"buy_up");
    self.Fantan_FloatImgDown = IMAGE(@"buy_down");
    self.Fantan_AddImg = IMAGE(@"buy_add");
    self.Fantan_JianImg = IMAGE(@"buy_jj");
    self.Buy_fantanBgColor = [UIColor colorWithHex:@"2d2f37"];
    self.Fantan_SpeakerImg = IMAGE(@"buy_music");
    //    self.Buy_fantanCellBgColor = [UIColor colorWithHex:@"715FE3"];
    self.Buy_fantanCellBgColor = [UIColor colorWithHex:@"000000"];
    self.Fantan_iconColor = [UIColor colorWithHex:@"BB342B"];
    self.FantanColor1 = [UIColor colorWithHex:@"282830"];
    self.FantanColor2 = [UIColor colorWithHex:@"28292E"];
    self.FantanColor3 = [UIColor colorWithHex:@"20252C"];
    self.FantanColor4 = [UIColor colorWithHex:@"22242b"];
    self.Fantan_textFieldColor = [UIColor colorWithHex:@"16191D"];
    self.CO_Fantan_textFieldTextColor = [UIColor colorWithHex:@"#FFFFFF"];
    self.CO_BuyLotBottomView_TopView3_BtnText = [UIColor colorWithHex:@"FFFFFF"];
    self.CO_BuyLotBottomView_BotView2_BtnBack = self.CO_Main_ThemeColorTwe;
    self.Fantan_tfPlaceholdColor = [UIColor grayColor];
    self.CO_Buy_textFieldText = [UIColor colorWithHex:@"#FFFFFF"];
    self.Fantan_labelColor = [UIColor colorWithHex:@"909192"];
    
    self.blackOrWhiteColor = [UIColor colorWithHex:@"1d1e23"];
    self.CO_LHTK_SubmitBtnBack = [UIColor colorWithHex:@"C6312C"];
    
    self.MyWallerBalanceBottomViewColor = [UIColor colorWithHex:@"e9e9e9"];
}


@end
