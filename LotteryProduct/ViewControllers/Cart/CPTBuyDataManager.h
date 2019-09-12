//
//  CPTBuyDataManager.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CPTSixModel;
@class CPTBuyBallModel;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,CPTBuyCategoryId)//彩种
{
    CPTBuyCategoryId_SSC                        =   11,/**<时时彩*/
    CPTBuyCategoryId_LHC                        =   12,/**<6合彩*/
    CPTBuyCategoryId_PK10                       =   13,/**<pk0*/
    CPTBuyCategoryId_XYFT                       =   14,/**<幸运飞艇*/
    CPTBuyCategoryId_PCDD                       =   15,/**<PC蛋蛋*/
    CPTBuyCategoryId_FFC                        =   16,/**<分分彩*/
    CPTBuyCategoryId_TC                         =   17,/**<体彩*/
    CPTBuyCategoryId_FC                         =   18,/**<福彩*/
    CPTBuyCategoryId_NN                         =   19,/**<牛牛*/
    CPTBuyCategoryId_FT                         =   20,/**<番摊*/
    CPTBuyCategoryId_AZACT                      =   21,/**<澳洲ACT*/
    CPTBuyCategoryId_HLXL                       =   22,/**<欢乐系列*/
};
typedef NS_ENUM(NSInteger,CPTBuyTicketType)//彩种
{
    CPTBuyTicketType_LiuHeCai                   =   1201,//六合彩
    CPTBuyTicketType_OneLiuHeCai                =   1202,//1分六合彩
    CPTBuyTicketType_FiveLiuHeCai               =   1203,//5分六合彩
    CPTBuyTicketType_ShiShiLiuHeCai             =   1204,//时时六合彩
    
    CPTBuyTicketType_PK10                       =   1301,//北京pc10
    CPTBuyTicketType_TenPK10                    =   1302,//十分pc10
    CPTBuyTicketType_FivePK10                   =   1303,//5分pc10
    CPTBuyTicketType_JiShuPK10                  =   1304,//急速pc10
    
    CPTBuyTicketType_SSC                        =   1101,//重庆时时彩
    CPTBuyTicketType_XJSSC                      =   1102,//新疆时时彩
    CPTBuyTicketType_TJSSC                      =   1103,//天津时时彩
    CPTBuyTicketType_TenSSC                     =   1104,//10分时时彩
    CPTBuyTicketType_FiveSSC                    =   1105,//5分时时彩
    CPTBuyTicketType_JiShuSSC                   =   1106,//急速时时彩
    
    CPTBuyTicketType_XYFT                       =   1401,//幸运飞艇
    CPTBuyTicketType_PCDD                       =   1501,//pc蛋蛋
    CPTBuyTicketType_FFC                        =   1601,//比特币分分彩
    
    CPTBuyTicketType_DaLetou                    =   1701,//大乐透
    CPTBuyTicketType_PaiLie35                   =   1702,//排列35
    CPTBuyTicketType_HaiNanQiXingCai            =   1703,//海南七星彩
    
    CPTBuyTicketType_Shuangseqiu                =   1801,//双色球
    CPTBuyTicketType_3D                         =   1802,//福彩3D
    CPTBuyTicketType_QiLecai                    =   1803,//七乐彩
    
    CPTBuyTicketType_NiuNiu_KuaiLe              =   1901,//快乐牛牛
    CPTBuyTicketType_NiuNiu_AoZhou              =   1902,//澳洲牛牛
    CPTBuyTicketType_NiuNiu_JiShu               =   1903,//极速牛牛
    
    CPTBuyTicketType_FantanPK10                 =   2001,//pk10番摊
    CPTBuyTicketType_FantanXYFT                 =   2002,//幸运飞艇番摊
    CPTBuyTicketType_FantanSSC                  =   2003,//时时彩番摊
    
    CPTBuyTicketType_AoZhouACT                  =   2201,//澳洲ACT
    CPTBuyTicketType_AoZhouShiShiCai            =   2202,//澳洲时时彩
    CPTBuyTicketType_AoZhouF1                   =   2203,//澳洲F1

};


@interface CPTBuyDataManager : NSObject
@property(strong,nonatomic)CPTSixModel *sixData;
@property(assign,nonatomic)CPTBuyTicketType  type;


+ (id)shareManager;
- (void)configType:(CPTBuyTicketType)type;
- (NSMutableArray *)configDataByTicketType:(CPTBuyTicketType)type;
//番摊 牛牛 赔率
- (NSDictionary *)configOtherDataByTicketType:(CPTBuyTicketType)type;

- (NSString *)changeTypeToString:(CPTBuyTicketType)type;
- (NSString *)changeTypeToTypeString:(CPTBuyTicketType)type;//将CPTBuyTicketType 改为 string 
- (CPTBuyTicketType )changeTypeStringToStrong:(NSString *)typeString;

//购彩蓝 相关计算
- (NSMutableDictionary *)checkTmpCartArrayByType:(NSString *)type superPlayKey:(NSString *)superPlayKey eachMoney:(NSInteger)money;
- (void)addBallModelToTmpCartArray:(CPTBuyBallModel *)model;
- (void)addBallModelToCartArray:(NSMutableDictionary *)model;
- (void)removeBallModelFromTmpCartArray:(CPTBuyBallModel *)model;
- (void)removeModelFromCartArray:(CPTBuyBallModel *)model;
- (void)clearTmpCartArray;
- (void)clearCartArray;
- (NSMutableArray<CPTBuyBallModel *> *)dataTmpCartArray;
- (NSMutableArray<CPTBuyBallModel *> *)dataCartArray;

//获取玩法赔率相关信息
- (void)downloadOdds;
- (void)unzipOddsFile;
- (void)removeModelFromCartArrayByDic:(NSDictionary *)dic;

- (void)loadData;//提前加载数据

- (NSArray<NSNumber *> *)allLotteryIds;

- (BOOL)checkIsOkToBuy;
- (BOOL)isOurL:(CPTBuyTicketType)type;
@end

NS_ASSUME_NONNULL_END
