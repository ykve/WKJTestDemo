//
//  BallTool.h
//  LotteryProduct
//
//  Created by pt c on 2019/4/9.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fantan_OddModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BallTool : NSObject

+ (UIColor *)getColorWithNum:(NSInteger)num;
+ (NSMutableArray *)sortingFantanWithArray:(NSMutableArray *)array;
+ (NSString *)resetTheExplainTxWithString:(NSString *)str;
+ (BOOL)isFantanSeriesLottery:(NSInteger)lotteryId;
+ (float)heightWithFont:(float)font limitWidth:(float)width string:(NSString *)str;
+ (NSInteger)numberOfEmptyLine:(NSString *)str;
+ (BOOL)isLongwaveById:(NSInteger)gameId;//判断是否是低频
+(CGFloat)getChatMessageHeightWithString:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
