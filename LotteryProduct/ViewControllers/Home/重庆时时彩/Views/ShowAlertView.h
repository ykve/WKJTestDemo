//
//  ShowAlertView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/1.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimePickerView.h"
#import "VVLongCollectionView.h"

typedef void (^DidSelectItemAtIndexPathBlock)(NSArray *indexPathsForSelectedItems);
typedef void (^DidShowAlertViewConfirmBlock)(void);


@interface ShowAlertView : UIView

@property (strong, nonatomic) TimePickerView *PickerView;
@property (strong, nonatomic) UITextField *versionfield;
@property (strong, nonatomic) UIControl *overlayView;
@property (copy,   nonatomic) void (^showalertBlock)(NSString *version);
@property (copy,   nonatomic) void (^selectindexBlock)(NSInteger index);
@property (copy,   nonatomic) void (^selectbuttonBlock)(UIButton *button);
@property (copy,   nonatomic) void (^dismissBlock)(NSInteger index ,NSInteger sort);
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) NSInteger sort;
@property (copy, nonatomic) NSString *lastDate;

///
@property (nonatomic, strong) VVLongCollectionView *longCollectionView;


/**
 重庆时时彩走势图设置
 */
-(void)buildsetView:(NSInteger)index Withsort:(NSInteger)sort With:(void(^)(NSInteger index, NSInteger sort))setBlock;
/**
 重庆时时彩走势图个位走势设置
 */
-(void)buildsetlineView;
/**
 重庆时时彩日期选择说明
 */
-(void)builddateView:(void (^)(NSString *date))success ;
/**
 重庆时时彩历史开奖帮助说明
 */
-(void)buildexplainView ;
/**
 遗漏统计
 */
-(void)buildmissstatistcsView;
/**
 大小遗漏
 */
-(void)buildmissbigorsmallView;
/**
 单双遗漏
 */
-(void)buildmisssingleanddoubleView;
/**
 遗漏选择时间
 */
-(void)buildmissdateView:(void (^)(UIButton *button))success;
/**
 今日统计设置
 */
-(void)buildtodaysetWithtype:(NSInteger)type WithView:(void (^)(NSDictionary *))success;
/**
 重庆今日统计帮助说明
 */
-(void)buildtodayInfoView;
/**
 PC今日统计帮助说明
 */
-(void)buildPCtodayInfoView;
/**
 公式杀号说明
 */
-(void)buildformulaInfoView;
/**
 查询助手说明
 */
-(void)buildsixhelpInfoView;
/**
 资讯统计期数填写
 */
-(void)buildsixversionsView;
/**
 挑码助手帮助说明
 */
-(void)buildpickhelperInfoView;
/**
 AI智能选号说明
 */
-(void)buildAIInfoView;
/**
 北京PK10号码遗漏说明
 */
-(void)buildPK10missInfoView;
/**
 北京PK10今日号码帮助说明
 */
-(void)buildPK10todaynumberInfoView;
/**
 北京PK10冷热分析帮助说明
 */
-(void)buildPK10HotandCoolInfoView;
/**
  北京PK10冷热统计的期数
 */
-(void)buildPK10HotandCoolDateViewWith:(NSInteger)index;
/**
 北京PK10两面遗漏说明
 */
-(void)buildPK10TwofacemissInfoView;
/**
 北京PK10两面遗漏的期数
 */
-(void)buildPK10TwofacemissDateViewWith:(NSInteger)index;
/**
  两面路珠说明
 */
-(void)buildPK10TwofaceluzhuInfoView;
/**
 北京PK10冠亚和路珠
 */
-(void)buildPK10guanjunheluzhuInfoView;
/**
 北京PK10qianhouluzhu
 */
-(void)buildPK10qianhouluzhuInfoView;
/**
  购彩重庆时时彩玩法说明-
 */
-(void)buildCartchongqinInfoView:(NSInteger)type;
/**
 购买六合彩玩法说明
 */
-(void)buildCartsixInfoView:(NSInteger)type;
/**
 购买PC蛋蛋玩法说明
 */
-(void)buildCartPCInfoView:(NSInteger)type;
/**
 购买北京PK10玩法说明
 */
-(void)buildCartBeijinInfoView:(NSInteger)type;
/**
 提现说明
 */
-(void)buildGetOutPriceWithtext:(NSString *)string;
// 长龙推送设置
- (void)buildLongDragonView:(NSArray *)array selectedItemAtIndexPathArray:(NSArray *)selectedItemAtIndexPathArray;



-(void)showWith:(UIView *)view;

-(void)show;

-(void)dismiss;

-(void)buildCPTBuyInfoViewWithInfo:(NSString *)str1 eg:(NSString *)str2;
-(void)buildCPTBuyInfoViewWithStr1:(NSString *)str1 andStr2:(NSString *)str2 andStr3:(NSString *)str3;


@property (nonatomic, copy) DidSelectItemAtIndexPathBlock didSelectItemAtIndexPathBlock;
@property (nonatomic, copy) DidShowAlertViewConfirmBlock didConfirmBlock;


@end
