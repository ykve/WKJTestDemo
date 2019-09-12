//
//  CPTThemeConfig.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/1/26.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPTThemeConfig : NSObject

#pragma mark - UIColor

/// *************** 主要共用 ***************
@property (nonatomic, strong) UIColor *CO_Main_ThemeColorOne;
@property (nonatomic, strong) UIColor *CO_Main_ThemeColorTwe;
@property (nonatomic, strong) UIColor *CO_Main_LineViewColor;
@property (nonatomic, strong) UIColor *CO_Main_LabelNo1;
@property (nonatomic, strong) UIColor *CO_Main_LabelNo2;
@property (nonatomic, strong) UIColor *CO_Main_LabelNo3;

/// ****** TabBar ******
@property (nonatomic, copy) NSString *IC_TabBar_Home;
@property (nonatomic, copy) NSString *IC_TabBar_Home_Selected;
@property (nonatomic, copy) NSString *IC_TabBar_KJ_;
@property (nonatomic, copy) NSString *IC_TabBar_KJ_Selected;
@property (nonatomic, copy) NSString *IC_TabBar_GC;
@property (nonatomic, copy) NSString *IC_TabBar_GC_Selected;
@property (nonatomic, copy) NSString *IC_TabBar_QZ;
@property (nonatomic, copy) NSString *IC_TabBar_QZ_Selected;
@property (nonatomic, copy) NSString *IC_TabBar_Me;
@property (nonatomic, copy) NSString *IC_TabBar_Me_Selected;
@property (nonatomic, strong) UIColor *CO_TabBarTitle_Normal;
@property (nonatomic, strong) UIColor *CO_TabBarTitle_Selected;
@property (nonatomic, strong) UIColor *CO_TabBarBackground;

/// ****** Nav ******
@property (nonatomic, strong) UIColor *CO_Nav_Bar_NativeViewBack;
@property (nonatomic, strong) UIColor *CO_NavigationBar_TintColor;
@property (nonatomic, strong) UIColor *CO_NavigationBar_Title;
@property (nonatomic, strong) UIColor *CO_Nav_Bar_CustViewBack;
@property (nonatomic, copy) NSString *IC_Nav_Setting_Icon;
@property (nonatomic, copy) NSString *IC_Nav_Setting_Gear;
@property (nonatomic, copy) NSString *IC_Nav_Kefu_Text;

#pragma mark 首页
@property (nonatomic, copy) NSString *IC_Home_CQSSC;
@property (nonatomic, copy) NSString *IC_Home_LHC;
@property (nonatomic, copy) NSString *IC_Home_BJPK10;
@property (nonatomic, copy) NSString *IC_Home_XJSSC;
@property (nonatomic, copy) NSString *IC_Home_XYFT;
@property (nonatomic, copy) NSString *IC_Home_TXFFC;
@property (nonatomic, copy) NSString *IC_Home_PCDD;
@property (nonatomic, copy) NSString *IC_Home_ZCZX;
@property (nonatomic, copy) NSString *IC_Home_AZF1SC;
@property (nonatomic, copy) NSString *IC_Home_GDCZ;

@property (nonatomic, copy) NSString *IC_Home_Icon_BeginName;
@property (nonatomic, strong) UIImage *IM_home_SanJiaoImage;
@property (nonatomic, strong) UIImage *IM_home_hotNewsImageName;
@property (nonatomic, strong) UIColor *CO_home_SubheaderBallBtnBack;
@property (nonatomic, strong) UIImage * IM_Nav_TitleImage_Logo;
@property (nonatomic, copy) NSString * IC_Nav_SideImageStr;
@property (nonatomic, copy) NSString * IC_Nav_ActivityImageStr;
@property (nonatomic, copy) NSString * IC_Nav_CircleTitleImage;


@property (nonatomic, strong) UIImage *IM_home_XSTJImage;
@property (nonatomic, strong) UIImage *IM_home_LHDSImage;
@property (nonatomic, strong) UIImage *IM_home_LHTKImage;
@property (nonatomic, strong) UIImage *IM_home_GSSHImage;
@property (nonatomic, copy) NSString *IC_home_ZBKJImageName;
@property (nonatomic, copy) NSString *IC_home_LSKJImageName;
@property (nonatomic, copy) NSString *IC_home_CXZSImageName;
@property (nonatomic, copy) NSString *IM_home_ZXTJImageName;


@property (nonatomic, copy) NSString *IC_home_sub_SS;
@property (nonatomic, copy) NSString *IC_home_sub_YC;
@property (nonatomic, copy) NSString *IC_home_sub_ZJ;
@property (nonatomic, copy) NSString *IC_home_sub_BF;
@property (nonatomic, strong) UIColor *openPrizePlusColor;

@property (nonatomic, copy) NSString *IC_home_sub_HMZS;
@property (nonatomic, copy) NSString *IC_home_sub_GYHTJ;
@property (nonatomic, copy) NSString *IC_home_sub_LMCL;
@property (nonatomic, copy) NSString *IC_home_sub_LMLZ;
@property (nonatomic, copy) NSString *IC_home_sub_LMYL;
@property (nonatomic, copy) NSString *IC_home_sub_QHLZ;
@property (nonatomic, copy) NSString *IC_home_sub_LMLS;
@property (nonatomic, copy) NSString *IC_home_sub_HBZS;
@property (nonatomic, copy) NSString *IC_home_sub_GYHLZ;
@property (nonatomic, copy) NSString *IC_home_sub_LRFX;
@property (nonatomic, copy) NSString *IC_home_sub_JRHM;
@property (nonatomic, copy) NSString *IC_home_sub_HMYL;
@property (nonatomic, copy) NSString *IC_home_sub_History;
@property (nonatomic, copy) NSString *IC_home_sub_LHTK;
@property (nonatomic, copy) NSString *IC_home_sub_XSTJ;
@property (nonatomic, copy) NSString *IC_home_sub_TMZS;

@property (nonatomic, copy) NSString *IC_home_sub_CXZS;
@property (nonatomic, copy) NSString *IC_home_sub_ZXTJ;
@property (nonatomic, copy) NSString *IC_home_sub_KJRL;
@property (nonatomic, copy) NSString *IC_home_sub_GSSH;
@property (nonatomic, copy) NSString *IC_home_sub_AIZNXH;
@property (nonatomic, copy) NSString *IC_home_sub_SXCZ;
@property (nonatomic, copy) NSString *IC_home_sub_TMLS;
@property (nonatomic, copy) NSString *IC_home_sub_ZMLS;
@property (nonatomic, copy) NSString *IC_home_sub_WSDX;
@property (nonatomic, copy) NSString *IC_home_sub_SXTM;
@property (nonatomic, copy) NSString *IC_home_sub_SXZM;
@property (nonatomic, copy) NSString *IC_home_sub_BSTM;
@property (nonatomic, copy) NSString *IC_home_sub_BSZM;
@property (nonatomic, copy) NSString *IC_home_sub_TMLM;
@property (nonatomic, copy) NSString *IC_home_sub_TMWS;
@property (nonatomic, copy) NSString *IC_home_sub_ZMWS;
@property (nonatomic, copy) NSString *IC_home_sub_ZMZF;
@property (nonatomic, copy) NSString *IC_home_sub_HMBD;
@property (nonatomic, copy) NSString *IC_home_sub_JQYS;
@property (nonatomic, copy) NSString *IC_home_sub_LMZS;
@property (nonatomic, copy) NSString *IC_home_sub_LXZS;
@property (nonatomic, copy) NSString *IC_home_sub_LHDS;
@property (nonatomic, copy) NSString *IC_home_sub_YLTJ;
@property (nonatomic, copy) NSString *IC_home_sub_JRTJ;
@property (nonatomic, copy) NSString *IC_home_sub_MFTJ;
@property (nonatomic, copy) NSString *IC_home_sub_QXT;

@property (nonatomic, strong) UIImage *IM_Home_HeadlineImg;
@property (nonatomic, strong) UIColor *CO_Home_HeadlineLabelText;
@property (nonatomic, strong) UIColor *CO_Home_HeadlineLineView;

@property (nonatomic, strong) UIColor *CO_Home_VC_NoticeView_Back;
@property (nonatomic, strong) UIColor *CO_Home_VC_NoticeView_LabelText;
@property (nonatomic, strong) UIColor *CO_Home_NoticeView_LabelText;
@property (nonatomic, strong) UIColor *CO_Home_VC_HeadView_Back;
@property (nonatomic, strong) UIColor *CO_Home_NewsTopViewBack;
@property (nonatomic, strong) UIColor *CO_Home_NewsBgViewBack;
@property (nonatomic, strong) UIColor *CO_Home_News_LineView;
@property (nonatomic, strong) UIColor *CO_Home_News_HeadTitleText;
@property (nonatomic, strong) UIColor *CO_Home_News_ScrollLabelText;

@property (nonatomic, strong) UIColor *CO_Home_VC_HeadView_HotMessLabelText;
@property (nonatomic, strong) UIColor *CO_Home_VC_HeadView_NumbrLables_Text;
@property (nonatomic, strong) UIColor *CO_Home_News_HotHeadViewBack;
@property (nonatomic, strong) UIColor *CO_Home_VC_Cell_ViewBack;
@property (nonatomic, strong) UIImage *IM_Home_BottomBtnOne;
@property (nonatomic, strong) UIImage *IM_Home_BottomBtnTwo;
@property (nonatomic, strong) UIImage *IM_Home_BottomBtnThree;
@property (nonatomic, strong) UIColor *CO_Home_VC_Cell_Titlelab_Text;
@property (nonatomic, strong) UIColor *CO_Home_VC_Cell_SubTitlelab_Text;
@property (nonatomic, strong) UIColor *CO_Home_VC_ADCollectionViewCell_Back;
@property (nonatomic, strong) UIColor *CO_Home_CellBackgroundColor;
@property (nonatomic, strong) UIColor *CO_Home_CellContentView;

@property (nonatomic, strong) UIColor *CO_Home_VC_PCDanDan_ViewBack2;
@property (nonatomic, strong) UIColor *CO_Home_VC_PCDanDan_line_ViewBack;
@property (nonatomic, strong) UIColor *CO_Home_Gonggao_TopBackViewStatus1;
@property (nonatomic, strong) UIColor *CO_Home_Gonggao_TopBackViewStatus2;

@property (nonatomic, strong) UIColor *CO_Home_Gonggao_TopTitleText;
@property (nonatomic, strong) UIColor *CO_Home_SubHeaderTitleColor;
@property (nonatomic, strong) UIColor *CO_Home_SubHeaderSubtitleColor;
@property (nonatomic, strong) UIColor *CO_Home_Gonggao_Cell_MessageTopViewBack;

@property (nonatomic, strong) UIColor *CO_Home_SubheaderTimeLblText;
@property (nonatomic, strong) UIColor *CO_Home_SubheaderLHCSubtitleText;

@property (nonatomic, strong) UIColor *Buy_HomeView_BackgroundColor;
@property (nonatomic, strong) UIColor *CO_Home_Buy_Footer_BtnBack;
@property (nonatomic, strong) UIColor *CO_Home_Buy_Footer_Back;

@property (nonatomic, strong) UIColor *CO_Home_CollectionView_CartCellTitle;
@property (nonatomic, strong) UIColor *CO_Home_CellCartCellSubtitleText;
@property (nonatomic, strong) UIColor *CO_home_SubCellTitleText;
@property (nonatomic, strong) UIImage *IM_Home_cartBgImageView;

#pragma mark - 我的
@property (nonatomic, strong) UIImage *IM_topBackImageView;
@property (nonatomic, strong) UIColor *MineVC_Btn_TitleC;
@property (nonatomic, strong) UIColor *CO_Me_NicknameLabel;
@property (nonatomic, strong) UIColor *CO_Mine_setContentViewBackgroundColor;
@property (nonatomic, strong) UIColor *CO_Me_SubTitleText;

@property (nonatomic, strong) UIColor *MineTitleStrColor;
@property (nonatomic, strong) UIColor *Mine_ScrollViewBackgroundColor;
@property (nonatomic, strong) UIColor *Mine_rightBtnTileColor;
@property (nonatomic, strong) UIColor *Mine_priceTextColor;
@property (nonatomic, strong) UIColor *ChangePsdViewBackgroundcolor;
@property (nonatomic, strong) UIColor *CO_Me_MyWallerBalance_MoneyText;
@property (nonatomic, strong) UIColor *CO_Me_MyWallerBalanceText;
@property (nonatomic, strong) UIColor *MyWallerBalanceBottomViewColor;
@property (nonatomic, strong) UIColor *MyWalletTotalBalanceColor;
@property (nonatomic, strong) UIColor *CO_Me_MyWallerTitle;

@property (nonatomic, strong) UIImage *IM_Me_MoneyRefreshBtn;
@property (nonatomic, strong) UIColor *CO_Me_YuEText;
@property (nonatomic, strong) UIColor *mineInviteTextCiolor;
@property (nonatomic, strong) UIImage *IM_Me_ChargeImage;
@property (nonatomic, strong) UIImage *IM_Me_GetMoneyImage;
@property (nonatomic, strong) UIImage *IM_Me_MoneyDetailImage;

@property (nonatomic, strong) UIImage *IM_Me_MyWalletImage;
@property (nonatomic, strong) UIImage *IM_Me_MyAccountImage;
@property (nonatomic, strong) UIImage *IM_Me_SecurityCnterImage;
@property (nonatomic, strong) UIImage *IM_Me_MyTableImage;
@property (nonatomic, strong) UIImage *IM_Me_buyHistoryImage;
@property (nonatomic, strong) UIImage *IM_Me_MessageCenterImage;
@property (nonatomic, strong) UIImage *IM_Me_setCenterImage;
@property (nonatomic, strong) UIImage *IM_Me_shareImage;
@property (nonatomic, strong) UIColor *CO_Me_ItemTextcolor;
@property (nonatomic, strong) UIColor *mine_seperatorLineColor;

@property (nonatomic, copy) NSString *IC_Me_SettingTopImageName;
@property (nonatomic, copy) NSString *IC_Me_SettingTopHeadIcon;


// 侧边视图
@property (nonatomic, copy) NSString *Left_VC_MyWalletImage;
@property (nonatomic, copy) NSString *Left_VC_SecurityCenterImage;
@property (nonatomic, copy) NSString *Left_VC_MessageCenterImage;
@property (nonatomic, copy) NSString *Left_VC_BuyHistoryImage;
@property (nonatomic, copy) NSString *Left_VC_MyTableImage;
@property (nonatomic, copy) NSString *Left_VC_SettingCenterImage;
@property (nonatomic, strong) UIColor *Left_VC_BtnTitleColor;
@property (nonatomic, strong) UIImage *Left_VC_KFBtnImage;
@property (nonatomic, strong) UIImage *Left_VC_GetMoneyBtnImage;
@property (nonatomic, strong) UIImage *Left_VC_ChargeBtnImage;
@property (nonatomic, strong) UIColor *Left_VC_CellBackgroundColor;
@property (nonatomic, strong) UIColor *Left_VC_BtnBackgroundColor;
@property (nonatomic, strong) UIImage *Left_VC_TopImage;
@property (nonatomic, strong) UIColor *LeftControllerLineColor;
@property (nonatomic, strong) UIColor *OpenPrizeWuXing;
@property (nonatomic, strong) UIColor *leftBackViewImageColor;
@property (nonatomic, strong) UIColor *LeftCtrlCellTextColor;


#pragma mark -  AI智能选号
@property (nonatomic, strong) UIImage *IM_AI_ShengXiaoBackImage;
@property (nonatomic, strong) UIImage *IM_AI_ShuImage;
@property (nonatomic, strong) UIImage *IM_AI_SheImage;
@property (nonatomic, strong) UIImage *IM_AI_LongImage;
@property (nonatomic, strong) UIImage *IM_AI_HuImage;
@property (nonatomic, strong) UIImage *IM_AI_NiuImage;
@property (nonatomic, strong) UIImage *IM_AI_ZhuImage;
@property (nonatomic, strong) UIImage *IM_AI_MaImage;
@property (nonatomic, strong) UIImage *IM_AI_HouImage;
@property (nonatomic, strong) UIImage *IM_AI_YangImage;
@property (nonatomic, strong) UIImage *IM_AI_JiImage;
@property (nonatomic, strong) UIImage *IM_AI_GouImage;
@property (nonatomic, strong) UIImage *IM_AI_TuImage;
@property (nonatomic, strong) UIImage *IM_AI_ShakeImgView;
@property (nonatomic, strong) UIImage *IM_AI_BirthdayImage;
@property (nonatomic, strong) UIImage *IM_AI_ShengXiaoNormalImage;
@property (nonatomic, strong) UIImage *IM_AI_ShakeNormalImage;
@property (nonatomic, strong) UIImage *IM_AI_LoverNormalImage;
@property (nonatomic, strong) UIImage *IM_AI_FamilyNormalImage;
@property (nonatomic, strong) UIImage *IM_AI_BirthdayNormalImage;
@property (nonatomic, strong) UIImage *IM_AI_ShengXiaoSeletImage;
@property (nonatomic, strong) UIImage *IM_AI_ShakeSeletImage;
@property (nonatomic, strong) UIImage *IM_AI_LoverSeletImage;
@property (nonatomic, strong) UIImage *IM_AI_FamilySeletImage;
@property (nonatomic, strong) UIImage *IM_AI_BirthdaySeletImage;
@property (nonatomic, strong) UIImage *IM_AI_BGroundcolorImage;
@property (nonatomic, strong) UIColor *IM_AI_AutoSelectLblNormalColor;
@property (nonatomic, strong) UIColor *IM_AI_AutoSelectLblSelectColor;


// 挑码助手
@property (nonatomic, strong) UIColor *CO_TM_HeadView;
@property (nonatomic, strong) UIColor *CO_TM_HeadContentView;
@property (nonatomic, strong) UIColor *CO_TM_BackView;
@property (nonatomic, strong) UIColor *CO_TM_Btn3TitleText;
@property (nonatomic, strong) UIColor *CO_TM_Btn3Back;
@property (nonatomic, strong) UIColor *CO_TM_Btn3BackSelected;
@property (nonatomic, strong) UIColor *CO_TM_Btn3borderColor;
@property (nonatomic, strong) UIColor *CO_TM_smallBtnText;
@property (nonatomic, strong) UIColor *CO_TM_smallBtnTextSelected;
@property (nonatomic, strong) UIColor *CO_TM_smallBtnborderColor;
@property (nonatomic, strong) UIColor *CO_TM_smallBtnBackColor;
@property (nonatomic, strong) UIColor *CO_TM_smallBtnBackColorSelected;


@property (nonatomic, strong) UIColor *CO_Circle_TitleText;
@property (nonatomic, strong) UIColor *CO_BuyLot_Left_ViewBack;
@property (nonatomic, strong) UIColor *CO_BuyLot_Left_LeftCellBack;
@property (nonatomic, strong) UIColor *CO_BuyLot_Left_LeftCellTitleText;
@property (nonatomic, strong) UIColor *CO_BuyLot_Left_LeftCellBack_Selected;
@property (nonatomic, strong) UIColor *CO_BuyLot_Left_LeftCellTitleText_Selected;
@property (nonatomic, strong) UIColor *CO_BuyLot_Left_CellBack;
@property (nonatomic, strong) UIColor *CO_BuyLot_Left_CellTitleText;

@property (nonatomic, copy) NSString *OnlineBtnImage;
@property (nonatomic, copy) NSString *KeFuTopImageName;
@property (nonatomic, copy) NSString *ChatVcDeleteImage;
@property (nonatomic, strong) UIColor *ChangLongLblBorderColor;

@property (nonatomic, copy) NSString *KJRLSelectCalendar2;
@property (nonatomic, copy) NSString *KJRLSelectCalendar4;
@property (nonatomic, copy) NSString *AIShakeImageName;
@property (nonatomic, strong) UIColor *confirmBtnTextColor;
@property (nonatomic, strong) UIColor *ShareCopyBtnTitleColor;
@property (nonatomic, strong) UIColor *PersonCountTextColor;
@property (nonatomic, copy) NSString *NextStepArrowImage;
@property (nonatomic, strong) UIColor *OpenLotteryLblLayerColor;
@property (nonatomic, strong) UIColor *changLongEnableBtnBackgroundColor;
@property (nonatomic, copy) NSString *CartSimpleBottomViewDelBtnImage;
@property (nonatomic, strong) UIColor *CO_BuyDelBtn;
@property (nonatomic, strong) UIColor *CartSimpleBottomViewDelBtnBackgroundColor;
@property (nonatomic, strong) UIColor *CartSimpleBottomViewTopBackgroundColor;
@property (nonatomic, strong) UIColor *QiCiXQSixHeaderSubtitleTextColor;
@property (nonatomic, strong) UIColor *loginHistoryTextColor;
@property (nonatomic, copy) NSString *messageIconName;
@property (nonatomic, copy) NSString *quanziLaBaImage;
@property (nonatomic, strong) UIColor *xinshuiFollowBtnBackground;
@property (nonatomic, copy) NSString *LHDSBtnImage;
@property (nonatomic, copy) NSString *OpenLotteryBottomNFullImage;
@property (nonatomic,copy) NSString *OpenLotteryBottomNormalImage;
@property (nonatomic, copy) NSString *BuyLotteryQPDDZGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPBJLGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPSLWHGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPBRNNGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPWRZJHGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPXLCHGrayImageName;
@property (nonatomic, strong) UIColor *HomeViewBackgroundColor;
@property (nonatomic, copy) NSString *AoZhouLotterySwitchBtnImage;
@property (nonatomic, strong) UIColor *AoZhouLotterySwitchBtnTitleColor;
@property (nonatomic, copy) NSString *bottomDefaultImageName;
@property (nonatomic, strong) UIColor *ChangLongRightBtnTitleNormalColor;
@property (nonatomic, strong) UIColor *ChangLongRightBtnSubtitleNormalColor;
@property (nonatomic, strong) UIColor *AoZhouScrollviewBackgroundColor;
@property (nonatomic, strong) UIColor *AoZhouMiddleBtnNormalBackgroundColor;
@property (nonatomic, strong) UIColor *AoZhouMiddleBtnSelectBackgroundColor;
@property (nonatomic, strong) UIColor *AoZhouLotterySeperatorLineColor;
@property (nonatomic, strong) UIColor *AoZhouLotteryBtnTitleSelectColor;
@property (nonatomic, strong) UIColor *AoZhouLotteryBtnSelectBackgroundColor;
@property (nonatomic, strong) UIColor *AoZhouLotteryBtnSelectSubtitleColor;
@property (nonatomic, strong) UIColor *AoZhouLotteryBtnTitleNormalColor;
@property (nonatomic, strong) UIColor *AoZhouLotteryBtnNormalBackgroundColor;
@property (nonatomic, strong) UIColor *AoZhouLotteryBtnNormalSubtitleColor;
@property (nonatomic, strong) UIColor *CartSectionLineColor;

@property (nonatomic, strong) UIColor *ChangLongRightBtnBackgroundColor;
@property (nonatomic, strong) UIColor *ChangLongTitleColor;
@property (nonatomic, strong) UIColor *ChangLongKindLblTextColor;
@property (nonatomic, strong) UIColor *ChangLongResultLblColor;
@property (nonatomic, strong) UIColor *ChangLongIssueTextColor;
@property (nonatomic, strong) UIColor *ChangLongTimeLblColor;
@property (nonatomic, strong) UIColor *ChangLongTotalLblColor;




@property (nonatomic, strong) UIColor *CO_ScrMoneyNumBtnText;
@property (nonatomic, strong) UIColor *CO_ScrMoneyNumViewBack;

// 直播开奖
@property (nonatomic, strong) UIColor *CO_LiveLot_BottomBtnBack;
@property (nonatomic, strong) UIColor *CO_LiveLot_CellLabelBack;
@property (nonatomic, strong) UIColor *CO_LiveLot_CellLabelText;

@property (nonatomic, strong) UIColor *CO_ChatRoomt_SendBtnBack;


@property (nonatomic, copy) NSString *QQLoginImageName;
@property (nonatomic, copy) NSString *WechatLoginImageName;
@property (nonatomic, strong) UIColor *xxncCheckBtnBackgroundColor;
@property (nonatomic, copy) NSString *xxncImageName;
@property (nonatomic, copy) NSString *ForgetPsdWhiteBackArrow;
@property (nonatomic, copy) NSString *LoginWhiteClose;
@property (nonatomic, copy) NSString *MimaEye;
@property (nonatomic, copy) NSString *NicknameEye;
@property (nonatomic, copy) NSString *CodeEye;
@property (nonatomic, copy) NSString *InviteCodeEye;
@property (nonatomic, copy) NSString *AccountEye;
@property (nonatomic, strong) UIColor *ForgetPsdTitleTextColor;
@property (nonatomic, copy) NSString *ForgetPsdBackgroundImage;
@property (nonatomic, strong) UIColor *LoginForgetPsdTextColor;
@property (nonatomic, strong) UIColor *RegistNoticeTextColor;
@property (nonatomic, copy) NSString *RegistBackgroundImage;
@property (nonatomic, copy) NSString *LoginBackgroundImage;
@property (nonatomic, strong) UIColor *LoginBtnBackgroundcolor;
@property (nonatomic, strong) UIColor *LoginBoardColor;
@property (nonatomic, strong) UIColor *LoginSureBtnTextColor;
@property (nonatomic, strong) UIColor *LoginLinebBackgroundColor;
@property (nonatomic, strong) UIColor *LoginTextColor;
@property (nonatomic, strong) UIColor *PK10_color1;
@property (nonatomic, strong) UIColor *PK10_color2;
@property (nonatomic, strong) UIColor *PK10_color3;
@property (nonatomic, strong) UIColor *PK10_color4;
@property (nonatomic, strong) UIColor *PK10_color5;
@property (nonatomic, strong) UIColor *PK10_color6;
@property (nonatomic, strong) UIColor *PK10_color7;
@property (nonatomic, strong) UIColor *PK10_color8;
@property (nonatomic, strong) UIColor *PK10_color9;
@property (nonatomic, strong) UIColor *PK10_color10;
@property (nonatomic, strong) UIColor *QiCiDetailLineBackgroundColor;
@property (nonatomic, strong) UIColor *QiCiDetailTitleColor;
@property (nonatomic, strong) UIColor *QiCiDetailCellBackgroundColor;
@property (nonatomic, strong) UIColor *CO_OpenLotHeaderInSectionView;

@property (nonatomic, strong) UIColor *QiCiDetailInfoColor;
@property (nonatomic, strong) UIColor *chongqinheadBackgroundColor;
@property (nonatomic, strong) UIColor *QicCiDetailSixheadTitleColor;
@property (nonatomic, strong) UIColor *SixOpenHeaderSubtitleTextColor;
//棋牌
@property (nonatomic, copy) NSString *BuyLotteryQPdzGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPerBaGangGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPqznnGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPzjhGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPsgGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPyzlhGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPesydGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPtbnnGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPjszjhGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPqzpjGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPsssGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryQPxywzGrayImageName;
//足彩
@property (nonatomic, copy) NSString *BuyLotteryZCjczqGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryZCjclqGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryZCzqsscGrayImageName;
@property (nonatomic, copy) NSString *BuyLotteryZCrxjcGrayImageName;
@property (nonatomic, copy) NSString *SettingPushImageName;
@property (nonatomic, copy) NSString *SettingShakeImageName;
@property (nonatomic, copy) NSString *SettingVoiceImageName;
@property (nonatomic, copy) NSString *SettingSwitchSkinImageName;
@property (nonatomic, copy) NSString *SettingServiceImageName;
@property (nonatomic, copy) NSString *SettingAboutUsImageName;

@property (nonatomic, copy) NSString *SixGreenBallName;
@property (nonatomic, copy) NSString *SixBlueBallName;
@property (nonatomic, copy) NSString *SixRedBallName;
@property (nonatomic, copy) NSString *SscBlueBallName;
@property (nonatomic, copy) NSString *SscBallName;
@property (nonatomic, strong) UIImage *PostCircleImage;
@property (nonatomic, copy) NSString *PostCircleImageName;
@property (nonatomic, strong) UIColor *CircleUserCenterMiddleBtnBackgroundColor;
@property (nonatomic, strong) UIImage *CircleUderCenterTopImage;
@property (nonatomic, strong) UIColor *ApplyExpertPlaceholdColor;

@property (nonatomic, strong) UIColor *CO_Account_Info_BtnBack;
@property (nonatomic, strong) UIColor *ApplyExpertConfirmBtnTextColor;
@property (nonatomic, strong) UIColor *applyExpertBackgroundColor;
@property (nonatomic, strong) UIColor *ExpertInfoTextColorA;
@property (nonatomic, strong) UIColor *ExpertInfoTextColorB;
@property (nonatomic, copy) NSString *WFSMImage;
@property (nonatomic, strong) UIColor *PrizeMessageTopbackViewTextColor;

@property (nonatomic, strong) UIColor *GraphSetViewBckgroundColor;
@property (nonatomic, copy) NSString *XSTJSearchImage;
@property (nonatomic, strong) UIImage *XSTJMyArticleImage;

@property (nonatomic, strong) UIImage *TouZhuImage;

@property (nonatomic, copy) NSString *AppFistguideUse1;
@property (nonatomic, copy) NSString *AppFistguideUse2;
@property (nonatomic, copy) NSString *AppFistguideUse3;

// 登录注册
@property (nonatomic, strong) UIImage *registerVcPhotoImage;
@property (nonatomic, strong) UIImage *registerVcCodeImage;
@property (nonatomic, strong) UIImage *registerVcPSDImage;
@property (nonatomic, strong) UIImage *registerVcPSDAgainImage;
@property (nonatomic, strong) UIImage *registerVcInviteImage;
@property (nonatomic, strong) UIImage *LoginVcPhoneImage;
@property (nonatomic, strong) UIImage *LoginVcHiddenImage;
@property (nonatomic, strong) UIImage *LoginVcHiddenSelectImage;
@property (nonatomic, strong) UIColor *registerVcRegisterBtnBckgroundColor;
@property (nonatomic, strong) UIColor *registerVcRegisterBtnBTextColor;
@property (nonatomic, strong) UIImage *loginVcQQimage;
@property (nonatomic, strong) UIImage *loginVcWechatimage;
@property (nonatomic, strong) UIColor *loginLineBackgroundColor;
@property (nonatomic, strong) UIImage *loginVcBgImage;
@property (nonatomic, strong) UIImage *logoIconImage;


@property (nonatomic, strong) UIImage *shareVcQQImage;
@property (nonatomic, strong) UIImage *shareVcWeChatImage;
@property (nonatomic, strong) UIImage *shareVcPYQImage;
@property (nonatomic, strong) UIColor *shareVcCopyBtnBackgroundColor;
@property (nonatomic, strong) UIColor *shareToLblTextColor;
@property (nonatomic, strong) UIImage *shareLineImage;

// 跟单
@property (nonatomic, strong) UIColor *CO_GD_SelectedTextNormal;
@property (nonatomic, strong) UIColor *CO_GD_SelectedTextSelected;

@property (nonatomic, strong) UIColor *CO_GD_TopBackgroundColor;
@property (nonatomic, strong) UIImage *IM_GD_DashenTableImgView;
@property (nonatomic, strong) UIColor *CO_GD_TopBackHeadTitle;
@property (nonatomic, strong) UIColor *CO_GD_Title_BtnBackSelected;
@property (nonatomic, strong) UIColor *CO_GD_AllPeople_BtnText;


@property (nonatomic, strong) UIColor *expertContentLblTextcolor;
@property (nonatomic, strong) UIImage *expertInfoTopImgView;
@property (nonatomic, strong) UIColor *accountInfoTopViewBackgroundColor;
@property (nonatomic, strong) UIColor *accountInfoNicknameTextColor;
@property (nonatomic, strong) UIColor *CO_MoneyTextColor;


@property (nonatomic, strong) UIImage *MyWalletTopImage;
@property (nonatomic, strong) UIImage *MyWalletBankCartImage;
@property (nonatomic, strong) UIImage *IM_CircleDetailHeadImage;
@property (nonatomic, strong) UIColor *circleListDetailViewBackgroundColor;
@property (nonatomic, strong) UIColor *expertWinlblTextcolor;
@property (nonatomic, strong) UIColor *OpenLotteryTimeLblTextColor;
@property (nonatomic, strong) UIColor *confirmBtnBackgroundColor;
@property (nonatomic, strong) UIImage *safeCenterTopImage;
@property (nonatomic, strong) UIColor *CO_Me_TopLabelTitle;
@property (nonatomic, strong) UIImage *shareInviteImage;
@property (nonatomic, strong) UIImage *shareBackImage;
@property (nonatomic, strong) UIImage *shareMainImage;
@property (nonatomic, strong) UIImage *calendarLeftImage;
@property (nonatomic, strong) UIImage *calendarRightImage;
@property (nonatomic, strong) UIColor *calendarBackgroundColor;
@property (nonatomic, strong) UIColor *KJRLSelectBackgroundColor;
@property (nonatomic, strong) UIImage *IM_CalendarTopImage;

#pragma mark 六合图库
@property (nonatomic, strong) UIColor *CO_LHTK_SubmitBtnBack; 
@property (nonatomic, strong) UIColor *LHTKTextfieldBackgroundColor;
@property (nonatomic, strong) UIColor *LHTKRemarkTextFeildBorderColor;
@property (nonatomic, strong) UIImage *XSTJdetailZanImage;
@property (nonatomic, strong) UIImage *attentionViewCloseImage;
@property (nonatomic, copy) NSString *backBtnImageName;
@property (nonatomic, strong) UIImage *HobbyCellImage;



// 购彩
@property (nonatomic, strong) UIColor *CO_buyLotBgColor;
@property (nonatomic, strong) UIColor *KeyTitleColor;



@property (nonatomic, strong) UIColor *TopUpViewTopViewBackgroundcolor;
@property (nonatomic, strong) UIColor *chargeMoneyLblSelectColor;
@property (nonatomic, strong) UIColor *chargeMoneyLblSelectBackgroundcolor;
@property (nonatomic, strong) UIColor *chargeMoneyLblNormalColor;
@property (nonatomic, strong) UIColor *LoginNamePsdPlaceHoldColor;
@property (nonatomic, strong) UIColor *LoginNamePsdFieldTextColor;
@property (nonatomic, strong) UIColor *tabbarItemTitleColor;
@property (nonatomic, strong) UIColor *openLotteryCalendarBackgroundcolor;
@property (nonatomic, strong) UIColor *openLotteryCalendarTitleColor;
@property (nonatomic, strong) UIColor *openLotteryCalendarWeekTextColor;


@property (nonatomic, strong) UIColor *CO_OpenLetBtnText_Normal;
@property (nonatomic, strong) UIColor *CO_OpenLetBtnText_Selected;
@property (nonatomic, strong) UIColor *CO_OpenLot_BtnBack_Normal;
@property (nonatomic, strong) UIColor *CO_OpenLot_BtnBack_Selected;

@property (nonatomic, strong) UIColor *pushDanSubbarBackgroundcolor;
@property (nonatomic, strong) UIColor *CO_LongDragon_PushSetting_BtnBack;

@property (nonatomic, strong) UIColor *CO_Circle_Cell1_TextLabel_BackgroundC;
@property (nonatomic, strong) UIColor *CO_Circle_Cell1_DetailTextLabel_BackgroundC;
@property (nonatomic, strong) UIColor *CO_Circle_Cell2_TextLabel_BackgroundC;
@property (nonatomic, strong) UIColor *CO_Circle_Cell2_DetailTextLabel_BackgroundC;
@property (nonatomic, strong) UIColor *CO_Circle_Cell3_TextLabel_BackgroundC;
@property (nonatomic, strong) UIColor *CO_Circle_Cell3_DetailTextLabel_BackgroundC;
@property (nonatomic, strong) UIColor *CO_Circle_Cell4_TextLabel_BackgroundC;
@property (nonatomic, strong) UIColor *CO_Circle_Cell4_DetailTextLabel_BackgroundC;
@property (nonatomic, strong) UIColor *sixHeTuKuRemarkbarBackgroundcolor;


@property (nonatomic, strong) UIColor *openCalendarTodayColor;
@property (nonatomic, strong) UIColor *openCalendarTodayViewBackground;
@property (nonatomic, strong) UIColor *loginSeperatorLineColor;
@property (nonatomic, strong) UIColor *getCodeBtnvBackgroundcolor;
@property (nonatomic, strong) UIColor *getCodeBtnvTitlecolor;

@property (nonatomic, strong) UIColor *LoginNamePsdTextColor;

@property (nonatomic, strong) UIColor *myCircleUserMiddleViewBackground;
@property (nonatomic, strong) UIColor *tixianShuoMingColor;
@property (nonatomic, strong) UIColor *bettingBtnColor;
@property (nonatomic, strong) UIColor *missCaculateBarNormalBackground;
@property (nonatomic, strong) UIColor *missCaculateBarselectColor;
@property (nonatomic, strong) UIColor *missCaculateBarNormalColor;
@property (nonatomic, strong) UIColor *pushDanBarTitleSelectColot;
@property (nonatomic, strong) UIColor *pushDanSubBarNormalTitleColor;
@property (nonatomic, strong) UIColor *pushDanSubBarSelectTextColor;


@property (nonatomic, strong) UIColor *RootVC_ViewBackgroundC;

@property (nonatomic, strong) UIColor *CircleVC_HeadView_BackgroundC;
@property (nonatomic, strong) UIColor *CO_Circle_Cell_BackgroundC;
@property (nonatomic, strong) UIColor *CO_Circle_Cell_TextLabel_BackgroundC;
@property (nonatomic, strong) UIColor *CO_Circle_Cell_DetailTextLabel_BackgroundC;
@property (nonatomic, strong) UIColor *Circle_Post_titleSelectColor;
@property (nonatomic, strong) UIColor *Circle_Post_titleNormolColor;
@property (nonatomic, strong) UIColor *xinshuiBottomViewTitleColor;

@property (nonatomic, strong) UIColor *xinshuiDetailAttentionBtnBackGroundColor;


@property (nonatomic, strong) UIColor *xinshuiDetailAttentionBtnNormalGroundColor;

@property (nonatomic, strong) UIColor *CO_KillNumber_LabelText;
@property (nonatomic, strong) UIColor *CO_KillNumber_LabelBack;
@property (nonatomic, strong) UIColor *gongShiShaHaoFormuTitleNormalColor;
@property (nonatomic, strong) UIColor *gongShiShaHaoFormuTitleSelectColor;
@property (nonatomic, strong) UIColor *gongshiShaHaoFormuBtnBackgroundColor;
@property (nonatomic, strong) UIColor *xinshuiRemarkTitleColor;


@property (nonatomic, strong) UIColor *OpenLotteryVC_TitleLabs_TextC;
@property (nonatomic, strong) UIColor *OpenLotteryVC_ColorLabs_TextC;
@property (nonatomic, strong) UIColor *OpenLotteryVC_ColorLabs1_TextC;
@property (nonatomic, strong) UIColor *OpenLotteryVC_SubTitle_TextC;
@property (nonatomic, strong) UIColor *OpenLotteryVC_SubTitle_BorderC;
@property (nonatomic, strong) UIColor *gonggaoSelectColor;




@property (nonatomic, strong) UIColor *OpenLotteryVC_Cell_BackgroundC;
@property (nonatomic, strong) UIColor *OpenLotteryVC_View_BackgroundC;
@property (nonatomic, strong) UIColor *OpenLotteryVC_SeperatorLineBackgroundColor;
@property (nonatomic, strong) UIColor *SixRecommendVC_View_BackgroundC;

@property (nonatomic, strong) UIColor *HobbyVC_MessLab_BackgroundC;
@property (nonatomic, strong) UIColor *HobbyVC_MessLab_TextC;
@property (nonatomic, strong) UIColor *HobbyVC_View_BackgroundC;
@property (nonatomic, strong) UIColor *HobbyVC_OKButton_BackgroundC;
@property (nonatomic, strong) UIColor *HobbyVC_OKButton_TitleBackgroundC;
@property (nonatomic, strong) UIColor *HobbyVC_SelButton_TitleBackgroundC;
@property (nonatomic, strong) UIColor *HobbyVC_UnSelButton_TitleBackgroundC;
@property (nonatomic, strong) UIColor *HobbyVC_SelButton_BackgroundC;
@property (nonatomic, strong) UIColor *HobbyVC_UnSelButton_BackgroundC;
@property (nonatomic, strong) UIColor *Circle_View_BackgroundC;
@property (nonatomic, strong) UIColor *Circle_HeadView_BackgroundC;
@property (nonatomic, strong) UIColor *Circle_HeadView_Title_UnSelC;
@property (nonatomic, strong) UIColor *Circle_HeadView_Title_SelC;
@property (nonatomic, strong) UIColor *Circle_HeadView_NoticeView_BackgroundC;
@property (nonatomic, strong) UIColor *Circle_HeadView_GuangBo_BackgroundC;
@property (nonatomic, strong) UIColor *Circle_Cell_BackgroundC;
@property (nonatomic, strong) UIColor *Circle_Cell_ContentlabC;
@property (nonatomic, strong) UIColor *Circle_Cell_Commit_BackgroundC;
@property (nonatomic, strong) UIColor *Circle_Cell_Commit_TitleC;
@property (nonatomic, strong) UIColor *Circle_Cell_AttentionBtn_TitleC;
@property (nonatomic, strong) UIColor *Circle_Line_BackgroundC;
@property (nonatomic, strong) UIColor *Circle_FooterViewLine_BackgroundC;
@property (nonatomic, strong) UIColor *OpenLottery_S_Cell_BackgroundC;
@property (nonatomic, strong) UIColor *OpenLottery_S_Cell_TitleC;
@property (nonatomic, strong) UIColor *Login_NamePasswordView_BackgroundC;
@property (nonatomic, strong) UIColor *Login_ForgetSigUpBtn_BackgroundC;
@property (nonatomic, strong) UIColor *Login_ForgetSigUpBtn_TitleC;
@property (nonatomic, strong) UIColor *Login_LogoinBtn_BackgroundC;
@property (nonatomic, strong) UIColor *Login_LogoinBtn_TitleC;
@property (nonatomic, strong) UIColor *Buy_LotteryMainBackgroundColor;
@property (nonatomic, strong) UIColor *Buy_LotteryItemNormalBackgroundColor;
@property (nonatomic, strong) UIColor *Buy_LotteryItemSelectBackgroundColor;
@property (nonatomic, strong) UIColor *RootWhiteC;


@property (nonatomic, strong) UIColor *Circle_remark_nameColor;
@property (nonatomic, strong) UIColor *Circle_Title_nameColor;
@property (nonatomic, strong) UIColor *CartBarBackgroundColor;
@property (nonatomic, strong) UIColor *CartBarTitleNormalColor;
@property (nonatomic, strong) UIColor *CartBarTitleSelectColor;
@property (nonatomic, strong) UIColor *pushDanBarTitleNormalColor;;
@property (nonatomic, strong) UIColor *CartHomeSelectSeperatorLine;
@property (nonatomic, strong) UIColor *MessageTitleColor;


//六合图库
@property (nonatomic, strong) UIColor *LiuheTuKuLeftTableViewBackgroundColor;
@property (nonatomic, strong) UIColor *LiuheTuKuOrangeColor;
@property (nonatomic, strong) UIColor *LiuheTuKuLeftTableViewSeperatorLineColor;
@property (nonatomic, strong) UIColor *LiugheTuKuTopBtnGrayColor;
@property (nonatomic, strong) UIColor *LiuheTuKuProgressValueColor;
@property (nonatomic, strong) UIColor *LiuheTuKuTouPiaoBtnBackgroundColor;
@property (nonatomic, strong) UIColor *LiuheTuKuRemarkBarBackgroundColor;
@property (nonatomic, strong) UIColor *LiuheTuKuRemarkSendBackgroundColor;
//@property (nonatomic, strong) UIColor *LiuheTuKuTextColor666;
@property (nonatomic, strong) UIColor *LiuheTuKuTextRedColor;
@property (nonatomic, strong) UIColor *grayColor333;
@property (nonatomic, strong) UIColor *grayColor666;
@property (nonatomic, strong) UIColor *grayColor999;

#pragma mark 六合大神
@property (nonatomic, strong) UIColor *LiuheDashendBackgroundColor;

//心水推荐
@property (nonatomic, strong) UIColor *xinShuiReconmentGoldColor;
@property (nonatomic, strong) UIColor *xinShuiReconmentRedColor;
@property (nonatomic, strong) UIColor *TouPiaoContentViewTopViewBackground;
@property (nonatomic, strong) UIColor *XinshuiRecommentScrollBarBackgroundColor;
@property (nonatomic, strong) UIColor *PublishBtnBackgroundColor;
@property (nonatomic, strong) UIColor *xinshuiBottomVeiwSepeLineColor;

// 长龙
@property (nonatomic, strong) UIColor *CO_buyBottomViewBtn;


#pragma mark - 支付相关
@property (nonatomic, strong) UIColor *CO_Pay_SubmitBtnBack;

#pragma mark - 购彩

@property (nonatomic, strong) UIColor *Buy_HeadView_BackgroundC;
@property (nonatomic, strong) UIColor *Buy_HeadView_Footer_BackgroundC;
@property (nonatomic, strong) UIColor *Buy_HeadView_Title_C;
@property (nonatomic, strong) UIColor *Buy_HeadView_historyV_Cell1_C;
@property (nonatomic, strong) UIColor *Buy_HeadView_historyV_Cell2_C;

@property (nonatomic, strong) UIColor *Buy_LeftView_BackgroundC;
@property (nonatomic, strong) UIColor *Buy_LeftView_Btn_TitleSelC;
@property (nonatomic, strong) UIColor *Buy_LeftView_Btn_TitleUnSelC;
@property (nonatomic, strong) UIColor *Buy_LeftView_Btn_PointSelC;
@property (nonatomic, strong) UIColor *Buy_LeftView_Btn_PointUnSelC;
@property (nonatomic, strong) UIColor *Buy_RightBtn_Title_UnSelC;
@property (nonatomic, strong) UIColor *Buy_RightBtn_Title_SelC;
@property (nonatomic, strong) UIColor *Buy_CollectionHeadV_TitleC;
@property (nonatomic, strong) UIColor *Buy_CollectionHeadV_ViewC;
@property (nonatomic, strong) UIColor *CO_Bottom_LabelText;

@property (nonatomic, strong) UIColor *Buy_CollectionCellButton_BackgroundSel;
@property (nonatomic, strong) UIColor *Buy_CollectionCellButton_BackgroundUnSel;
@property (nonatomic, strong) UIColor *Buy_CollectionCellButton_TitleCSel;
@property (nonatomic, strong) UIColor *Buy_CollectionCellButton_TitleCUnSel;
@property (nonatomic, strong) UIColor *Buy_CollectionCellButton_SubTitleCSel;
@property (nonatomic, strong) UIColor *Buy_CollectionCellButton_SubTitleCUnSel;
@property (nonatomic, strong) UIColor *Buy_CollectionViewLine_C;


@property (nonatomic, strong) UIColor *CO_BuyLot_HeadView_LabelText;
@property (nonatomic, strong) UIColor *CO_BuyLot_HeadView_Label_border;
@property (nonatomic, strong) UIColor *CO_BuyLot_Right_bcViewBack;
@property (nonatomic, strong) UIColor *CO_BuyLot_Right_bcView_border;


@property (nonatomic, strong) UIColor *CartHomeHeaderSeperatorColor;
@property (nonatomic, strong) UIColor *genDanHallTitleNormalColr;
@property (nonatomic, strong) UIColor *genDanHallTitleSelectColr;
@property (nonatomic, strong) UIColor *genDanHallTitleBackgroundColor;




#pragma mark 番摊 牛牛 双色球 七乐彩 大乐透
@property (nonatomic, strong) UIColor *NN_LinelColor;

@property (nonatomic, copy) NSString * NN_Xian_normalImg;
@property (nonatomic, copy) NSString * NN_Xian_selImg;
@property (nonatomic, copy) NSString * NN_zhuang_normalImg;
@property (nonatomic, copy) NSString * NN_zhuang_selImg;
@property (nonatomic, strong) UIColor *NN_xian_normalColor;
@property (nonatomic, strong) UIColor *NN_xian_selColor;
@property (nonatomic, strong) UIColor *NN_zhuang_normalColor;
@property (nonatomic, strong) UIColor *NN_zhuang_selColor;

@property (nonatomic, strong) UIImage * NN_XianBgImg;
@property (nonatomic, strong) UIImage * NN_XianBgImg_sel;

@property (nonatomic, strong) UIColor *Buy_NNXianTxColor_normal;
@property (nonatomic, strong) UIColor *Buy_NNXianTxColor_sel;
@property (nonatomic, strong) UIColor *Fantan_headerLineColor;

@property (nonatomic, strong) UIColor *Fantan_historyHeaderBgColor;
@property (nonatomic, strong) UIColor *Fantan_historyHeaderLabColor;
@property (nonatomic, strong) UIColor *Fantan_historycellColor1;
@property (nonatomic, strong) UIColor *Fantan_historycellColor2;
@property (nonatomic, strong) UIColor *Fantan_historycellColor3;

@property (nonatomic, strong) UIColor *Fantan_historycellOddColor;
@property (nonatomic, strong) UIColor *Fantan_historycellEvenColor;

@property (nonatomic, strong) UIColor *CO_Fantan_HeadView_Label;


@property (nonatomic, strong) NSString *RedballImg_normal;
@property (nonatomic, strong) NSString *RedballImg_sel;
@property (nonatomic, strong) NSString *BlueballImg_normal;
@property (nonatomic, strong) NSString *BlueballImg_sel;
@property (nonatomic, strong) UIColor *blackOrWhiteColor;
@property (nonatomic, strong) UIColor *Fantan_textFieldColor;
@property (nonatomic, strong) UIColor *CO_Fantan_textFieldTextColor;
@property (nonatomic, strong) UIColor *CO_BuyLotBottomView_TopView3_BtnText;
@property (nonatomic, strong) UIColor *CO_BuyLotBottomView_BotView2_BtnBack;

@property (nonatomic, strong) UIColor *Fantan_tfPlaceholdColor;
@property (nonatomic, strong) UIColor *CO_Buy_textFieldText;

@property (nonatomic, strong) UIColor *Fantan_iconColor;

@property (nonatomic, strong) UIImage * Fantan_SpeakerImg;
@property (nonatomic, strong) UIImage * Fantan_FloatImgUp;
@property (nonatomic, strong) UIImage * Fantan_FloatImgDown;
@property (nonatomic, strong) UIImage * Fantan_JianImg;
@property (nonatomic, strong) UIImage * Fantan_AddImg;

@property (nonatomic, strong) UIImage * Fantan_DelImg;
@property (nonatomic, strong) UIImage * Fantan_ShakeImg;
@property (nonatomic, strong) UIImage * Fantan_AddToBasketImg;
@property (nonatomic, strong) UIImage * Fantan_basketImg;

@property (nonatomic, strong) UIColor *Buy_fantanBgColor;
@property (nonatomic, strong) UIColor *Fantan_CountDownBgColor;
@property (nonatomic, strong) UIColor *Fantan_CountDownBoderColor;
@property (nonatomic, strong) UIColor *Fantan_MoneyColor;
@property (nonatomic, strong) UIColor *Buy_fantanCellBgColor;//cell背景颜色
@property (nonatomic, strong) UIColor *FantanColor1;
@property (nonatomic, strong) UIColor *FantanColor2;
@property (nonatomic, strong) UIColor *FantanColor3;
@property (nonatomic, strong) UIColor *FantanColor4;
@property (nonatomic, strong) UIColor *Fantan_labelColor;

@property (nonatomic, strong) UIColor *Buy_fantanTimeColor;//倒计时颜色
@property (nonatomic, strong) UIColor *Buy_fantan;

#pragma mark UIImage
@property (nonatomic, strong) UIImage * Buy_LeftView_Btn_BackgroundUnSel;
@property (nonatomic, strong) UIImage * Buy_LeftView_Btn_BackgroundSel;



@property (nonatomic, copy) NSString *circleHomeGDDTImageName;
@property (nonatomic, copy) NSString *circleHomeXWZXImageName;
@property (nonatomic, copy) NSString *circleHomeDJZXImageName;
@property (nonatomic, copy) NSString *circleHomeZCZXImageName;
@property (nonatomic, copy) NSString *circleHomeSDQImageName;
@property (nonatomic, copy) NSString *circleHomeCell1Bgcolor;
@property (nonatomic, copy) NSString *circleHomeCell2Bgcolor;
@property (nonatomic, copy) NSString *circleHomeCell3Bgcolor;
@property (nonatomic, copy) NSString *circleHomeCell4Bgcolor;
@property (nonatomic, copy) NSString *circleHomeCell5Bgcolor;
@property (nonatomic, strong) UIImage *circleHomeBgImage;

@property (nonatomic, strong) UIColor *CO_LongDragonTopView;
@property (nonatomic, strong) UIColor *CO_LongDragonTopViewBtn;
@property (nonatomic, strong) UIColor *CO_LongDragonCell;

@property (nonatomic, strong) UIColor *OpenLotteryVC_ColorLabs_TextB;




+ (id)shareManager;

- (void)whiteTheme;
- (void)darkTheme;

- (void)LitterFish_whiteTheme;
- (void)LitterFish_darkTheme;

- (void)eightTheme;
- (void)hkTheme;


@end

NS_ASSUME_NONNULL_END
