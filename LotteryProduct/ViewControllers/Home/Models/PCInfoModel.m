//
//  PCInfoModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/2.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PCInfoModel.h"

@implementation PCInfoNewModel

@end

@implementation PCInfoModel

@end

@implementation LotteryInfoModel

@end

@implementation LastSg

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

@end

@implementation SixInfoModel



@end

@implementation ChongqinInfoModel

-(void)setNumber:(NSString *)number {
    _number = number;
    if([number containsString:@","]){
        self.numbers = [number componentsSeparatedByString:@","];
    }else{
        NSMutableArray *nums = [[NSMutableArray alloc]init];
        for (int i = 0; i<number.length;i++) {
            [nums addObject:[number substringWithRange:NSMakeRange(i, 1)]];
        }
        self.numbers = nums;
    }
}
@end

@implementation PK10InfoModel


@end

@implementation ZuCaiInfoModel

@end
