//
//  LastnumberCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/12.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

typedef enum {
    
    Weishudaxiao = 631,/// 尾数大小统计图
    
    Lianmazoushi = 632,/// 连码走势图
    
    Lianxiaozoushi = 633,/// 连肖走势图
    
    Jiaqinyeshou = 634,/// 家禽野兽统计图
    
}TypeInfo;

@interface LastnumberCtrl : RootCtrl

@property (nonatomic, assign) TypeInfo type;

@end
