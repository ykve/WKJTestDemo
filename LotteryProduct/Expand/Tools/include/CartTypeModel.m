//
//  CartTypeModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartTypeModel.h"

@implementation CartTypeModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

-(NSMutableArray *)type1Array {
    
    if (!_type1Array) {
        
        _type1Array = [[NSMutableArray alloc]init];
    }
    return _type1Array;
}

-(NSMutableArray *)type2Array {
    
    if (!_type2Array) {
        
        _type2Array = [[NSMutableArray alloc]init];
    }
    return _type2Array;
}
@end
