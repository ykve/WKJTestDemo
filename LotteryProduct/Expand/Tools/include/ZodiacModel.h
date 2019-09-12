//
//  ZodiacModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartOddsModel.h"
@interface ZodiacModel : NSObject

@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, strong)NSArray *zodiacArray;

-(NSArray *)getnumber:(CartOddsModel *)oddmodel;

@end
