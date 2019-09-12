//
//  SixModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/26.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixModel.h"

@implementation SixModel

-(void)setType:(NSString *)type {
    
    _type = type;
    
    if ([Tools isPureInt:type]) {
        
        self.number = type;
        
        self.wuxin = [Tools numbertowuxin:type];
        
        self.bose = [[SixModel numbertocolor:type] valueForKey:@"color"];
        
        self.bosestring = [[SixModel numbertocolor:type] valueForKey:@"colorstring"];
        
        self.last = [NSString stringWithFormat:@"%@尾",[type substringFromIndex:1]];
    }
    else{
        self.time = type;
    }
}

-(void)setValue:(NSString *)value {
    
    _value = value;
    
    if ([value isEqualToString:@"牛"] || [value isEqualToString:@"马"] || [value isEqualToString:@"羊"] || [value isEqualToString:@"狗"] || [value isEqualToString:@"鸡"] || [value isEqualToString:@"猪"]) {
        
        self.jiaye = @"家";
    }
    else {
        self.jiaye = @"野";
    }
}

/**
 六合彩数字选背景图
 */
+(NSDictionary *)numbertocolor:(NSString *)string {
    
    if ([string isEqualToString:@"01"] || [string isEqualToString:@"02"] || [string isEqualToString:@"07"] || [string isEqualToString:@"08"] || [string isEqualToString:@"12"] || [string isEqualToString:@"13"] || [string isEqualToString:@"18"] || [string isEqualToString:@"19"] || [string isEqualToString:@"23"] || [string isEqualToString:@"24"] || [string isEqualToString:@"29"] || [string isEqualToString:@"30"] || [string isEqualToString:@"34"] || [string isEqualToString:@"35"] || [string isEqualToString:@"40"] || [string isEqualToString:@"45"] || [string isEqualToString:@"46"]) {
        
        return @{@"color":[UIColor colorWithHex:@"f15347"],@"colorstring":@"红波"};
    }
    else if ([string isEqualToString:@"03"] || [string isEqualToString:@"04"] || [string isEqualToString:@"09"] || [string isEqualToString:@"10"] || [string isEqualToString:@"14"] || [string isEqualToString:@"15"] || [string isEqualToString:@"20"] || [string isEqualToString:@"25"] || [string isEqualToString:@"26"] || [string isEqualToString:@"31"] || [string isEqualToString:@"36"] || [string isEqualToString:@"37"] || [string isEqualToString:@"41"] || [string isEqualToString:@"42"] || [string isEqualToString:@"47"] || [string isEqualToString:@"48"]) {
        
        return @{@"color":[UIColor colorWithHex:@"0587c5"],@"colorstring":@"蓝波"};
    }
    else {
        
        return @{@"color":[UIColor colorWithHex:@"46be64"],@"colorstring":@"绿波"};
    }
    
}

@end
