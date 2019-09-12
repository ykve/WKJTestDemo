//
//  NSNumber+Select.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/15.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "NSNumber+Select.h"
#import <objc/runtime.h>
static const char *strIsSelectedKey = "strIsSelectedKey";

@implementation NSNumber (Select)

-(void)setIsSelected:(BOOL)isSelected
{
    objc_setAssociatedObject(self, strIsSelectedKey, @(isSelected), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isSelected
{
    NSNumber *number = objc_getAssociatedObject(self, strIsSelectedKey);;
    return  [number boolValue];
}


@end
