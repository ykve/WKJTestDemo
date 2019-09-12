//
//  CPTSixModel.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/2.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTSixModel.h"

@implementation CPTSixModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"playTypes" : @"CPTSixPlayTypeModel",
             };
}
@end

@implementation CPTSixPlayTypeModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"ID":@",",
             @"subTypes" : @"CPTSixsubPlayTypeModel",
             };
}
@end

@implementation CPTSixsubPlayTypeModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"balls" : @"CPTBuyBallModel",
             };
}
@end

@implementation CPTBuyBallModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"longS":@"long"};
}
@end
