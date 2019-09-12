//
//  CartOddsModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartOddsModel.h"

@implementation CartOddsModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}
+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"oddsList":@"OddsList"};
}
@end

@implementation Setting
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id",@"matchtype":@"matchtype"};
}
@end
@implementation OddsList
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}
@end
