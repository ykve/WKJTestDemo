//
//  CartHomeModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/30.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartHomeModel.h"

@implementation CartHomeModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id",
             @"isWork":@"isWork"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"lotterys" : @"CrartHomeSubModel",
             };
}

@end
