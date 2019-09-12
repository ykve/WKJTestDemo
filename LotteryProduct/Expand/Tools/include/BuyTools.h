//
//  BuyTools.h
//  LotteryProduct
//
//  Created by vsskyblue on 2019/1/5.
//  Copyright © 2019年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CartTypeModel.h"
#import "CartChongqinModel.h"
#import "CartChongqinMissModel.h"
#import "CartBeijingModel.h"
#import "CartBeijinMissModel.h"
#import "CartOddsModel.h"
#import "CartPCModel.h"
#import "CartSixModel.h"
#import "CartOddsModel.h"
#import "IQTextView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BuyTools : NSObject



+(instancetype)tools;

#pragma mark - 获取时时彩数据源
-(NSArray *)getchongqinDataSourceWith:(CartTypeModel *)selectModel With:(CartChongqinMissModel *)missmodel With:(IQTextView *)textView;

#pragma mark - 获取下注注数
-(void)getchongqintotallotteryCountWith:(CartTypeModel *)selectModel With:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times With:(IQTextView *)textView success:(void (^)(NSString *cout, NSString *price))success;

#pragma mark - 文本输入号码购买
-(void)publishchongqintextViewData:(BOOL)cart With:(CartTypeModel *)selectModel With:(IQTextView *)textView With:(NSInteger)pricetype With:(NSInteger)times With:(CartChongqinMissModel *)missmodel With:(NSMutableArray *)cartArray success:(void (^)(NSArray *data))success;

#pragma mark - 一星定位胆号码购买
-(void)publishchongqindingweidanData:(BOOL)cart  With:(CartTypeModel *)selectModel With:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times With:(CartChongqinMissModel *)missmodel With:(NSMutableArray *)cartArray Withcount:(NSInteger)count  success:(void (^)(NSArray *data))success;

#pragma mark - 直选复式购买号码/大小单双码购买
-(void)publishchongqinnumberData:(BOOL)cart With:(CartTypeModel *)selectModel With:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times With:(CartChongqinMissModel *)missmodel With:(NSMutableArray *)cartArray Withcount:(NSInteger)count success:(void (^)(NSArray *data))success;

#pragma mark - 组选号码购买
-(void)publishchongqinGroupData:(BOOL)cart With:(CartTypeModel *)selectModel With:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times With:(CartChongqinMissModel *)missmodel With:(NSMutableArray *)cartArray Withcount:(NSInteger)count success:(void (^)(NSArray *data))success;

#pragma mark - 文本输入号码购买注数
-(NSInteger)getchongqintextDataCountWith:(IQTextView *)textView With:(CartTypeModel *)selectModel;



#pragma mark - 获取北京PK10数据
-(void)getpk10DataSource:(NSMutableArray *)dataSource With:(CartTypeModel *)selectModel With:(CartBeijinMissModel *)missmodel With:(CartOddsModel *)oddmodel With:(IQTextView *)textView With:(BOOL)showfoot;
#pragma mark - 获取下注注数
-(void)getpk10totallotteryCountWith:(CartTypeModel *)selectModel With:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times success:(void (^)(NSString *cout, NSString *price))success;
#pragma mark - 单式输入号码的注数
-(void)getpk10textlotterycountWith:(CartTypeModel *)selectModel With:(IQTextView *)textView With:(NSInteger)pricetype With:(NSInteger)times success:(void (^)(NSString *cout, NSString *price))success;

#pragma mark - 最高可中
-(void)getpk10maxpriceWith:(CartTypeModel *)selectModel With:(CartBeijinMissModel *)missmodel With:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times success:(void (^)(NSString *price))success;

#pragma mark - NO:号码投注/YES:号码加购物车
-(void)publishpk10lotteryData:(BOOL)cart With:(CartTypeModel *)selectModel With:(CartBeijinMissModel *)missmodel With:(NSMutableArray *)dataSource Withcar:(NSMutableArray *)cartArray With:(IQTextView *)textView With:(NSInteger)pricetype With:(NSInteger)times Withcount:(NSInteger)count success:(void (^)(NSString*data))success;



#pragma mark - 获取pc蛋蛋彩票下注注数
-(void)getpclotteryCountWith:(CartTypeModel *)selectModel With:(NSInteger)pricetype With:(NSInteger)times Withface:(NSArray *)faceDataArray Withcolor:(NSArray *)colorDataArray Withsame:(NSArray *)sameDataArray Withnumber:(NSArray *)numberDataArray success:(void (^)(NSString *cout, NSString *price))success;;

#pragma mark - cart = no:立即购买/cart = yes:加入购彩篮，
-(void)publishpclotteryData:(BOOL)cart With:(CartTypeModel *)selectModel With:(CartChongqinMissModel *)missmodel With:(NSInteger)pricetype With:(NSInteger)times Withface:(NSArray *)faceDataArray Withcolor:(NSArray *)colorDataArray Withsame:(NSArray *)sameDataArray Withnumber:(NSArray *)numberDataArray Withcar:(NSMutableArray *)cartArray Withcount:(NSInteger)count success:(void (^)(NSString*data,NSArray*dataArray))success;



#pragma mark - 获取六合彩下注注数及金额
-(void)getsixlotteryCountWith:(CartTypeModel *)selectModel WithballArr:(NSMutableArray *)ballDataArray WithblockArr:(NSMutableArray *)blockDataArray Withblock2Arr:(NSMutableArray *)block2DataArray WithdatasourceArr:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times With:(UITableView *)tableView success:(void (^)(NSString*countstr,NSString*pricestr,NSString*maxprice))success;

#pragma mark - 六合彩购买 cart = no:立即购买/cart = yes:加入购彩篮，
-(void)publishsixlotteryData:(BOOL)cart With:(CartTypeModel *)selectModel WithballArr:(NSMutableArray *)ballDataArray WithblockArr:(NSMutableArray *)blockDataArray Withblock2Arr:(NSMutableArray *)block2DataArray WithdatasourceArr:(NSMutableArray *)dataSource Withodds:(NSArray *)oddsArray WithcartArr:(NSMutableArray *)cartArray With:(NSInteger)pricetype With:(NSInteger)times With:(NSInteger)zhengma_type With:(NSInteger)color_type Withcount:(NSInteger)count success:(void (^)(NSArray*dataArray))success;

@end

NS_ASSUME_NONNULL_END
