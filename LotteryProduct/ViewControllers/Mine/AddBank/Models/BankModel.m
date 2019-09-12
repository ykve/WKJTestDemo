//
//  BankModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/9.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "BankModel.h"

@implementation BankModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

-(void)setCardNumber:(NSString *)cardNumber {
    
    _cardNumber = cardNumber;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"plist"];
    
    NSArray *arr = [[NSArray alloc]initWithContentsOfFile:plistPath];
    
    for(NSDictionary *dic in arr)
    {
        NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", dic[@"regex"]];
        
        BOOL flag = [regextest evaluateWithObject:cardNumber];
        
        if(flag)
        {
            self.banktype = [self getBankTypeName:dic[@"bankType"]];

            break;
        }
    }
}

-(NSString *)getBankTypeName:(NSString *)bankType
{
    NSString *typeName = [[NSString alloc]init];
    if([bankType isEqualToString:@"CC"])
    {
        typeName = @"信用卡";
    }
    else if([bankType isEqualToString:@"PC"])
    {
        typeName = @"预付费卡";
    }
    else if([bankType isEqualToString:@"SCC"])
    {
        typeName = @"准贷记卡";
    }
    else if([bankType isEqualToString:@"DC"])
    {
        typeName = @"储蓄卡";
    }
    
    return typeName;
}

@end
