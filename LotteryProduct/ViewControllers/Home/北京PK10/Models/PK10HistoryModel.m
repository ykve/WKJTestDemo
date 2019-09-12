//
//  PK10HistoryModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/3.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10HistoryModel.h"

@implementation PK10HistoryModel

-(void)setNum:(NSArray<NSNumber *> *)num {
    
    _num = num;
    
    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
    NSMutableArray *arr2 = [[NSMutableArray alloc]init];
    NSMutableArray *arr3 = [[NSMutableArray alloc]init];
    for (NSNumber *number in num) {
        
        NSInteger n = number.integerValue;
        
        Numbers *numbers = [[Numbers alloc]init];
        
        numbers.num = n;
        
        numbers.isselect = NO;
        
        [arr3 addObject:numbers];
        
        if(n > 5) {
            
            [arr1 addObject:@"大"];
        }
        else {
            [arr1 addObject:@"小"];
        }
        if(n%2 == 0) {
            
            [arr2 addObject:@"双"];
        }
        else {
            [arr2 addObject:@"单"];
        }
    }
    
    self.bigorsmallArray = arr1;
    self.sigleordoubleArray = arr2;
    self.numberArray = arr3;
    
    NSInteger first = num.firstObject.integerValue;
    NSInteger second = num[1].integerValue;
    self.total = INTTOSTRING(first+second);
    self.bigorsmall = (first + second) < 12 ? @"小" : @"大";
    self.signleordouble = (first + second)%2 == 0 ? @"双" : @"单";
    
    NSString *str1 = num[0].integerValue > num[9].integerValue ? @"龙" : @"虎";
    NSString *str2 = num[1].integerValue > num[8].integerValue ? @"龙" : @"虎";
    NSString *str3 = num[2].integerValue > num[7].integerValue ? @"龙" : @"虎";
    NSString *str4 = num[3].integerValue > num[6].integerValue ? @"龙" : @"虎";
    NSString *str5 = num[4].integerValue > num[5].integerValue ? @"龙" : @"虎";
    
    self.longhuArray = @[str1,str2,str3,str4,str5];
}

@end

@implementation Numbers


@end
