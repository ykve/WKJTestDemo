//
//  PCFreeRecommendModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PCFreeRecommendModel.h"

@implementation PCFreeRecommendModel

+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"list":@"List"};
}

@end

@implementation LastRecommend

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

@end

@implementation PceggLotterySg

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}
@end

@implementation PceggRecommend

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

@end
@implementation List

@end

