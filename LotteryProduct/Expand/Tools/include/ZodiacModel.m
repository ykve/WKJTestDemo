//
//  ZodiacModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ZodiacModel.h"
#import "NSDate+YN.h"
@implementation ZodiacModel

-(NSArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = @[@[@"01",@"13",@"25",@"37",@"49"],@[@"12",@"24",@"36",@"48"],@[@"11",@"23",@"35",@"47"],@[@"10",@"22",@"34",@"46"],@[@"09",@"21",@"33",@"45"],@[@"08",@"20",@"32",@"44"],@[@"07",@"19",@"31",@"43"],@[@"06",@"18",@"30",@"42"],@[@"05",@"17",@"29",@"41"],@[@"04",@"16",@"28",@"40"],@[@"03",@"15",@"27",@"39"],@[@"02",@"14",@"26",@"38"]];
    }
    return _dataArray;
}

-(NSArray *)zodiacArray {
    
    if (!_zodiacArray) {
        
        _zodiacArray = @[@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪"];
    }
    return _zodiacArray;
}

-(NSArray *)getnumber:(CartOddsModel *)oddmodel {
    
    NSInteger index = [self.zodiacArray indexOfObject:[self yearofzodiac]];
    
    NSArray *a = [self.zodiacArray subarrayWithRange:NSMakeRange(0, index)];
    
    NSArray *b = [self.zodiacArray subarrayWithRange:NSMakeRange(index, self.zodiacArray.count - index)];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    
    [array addObjectsFromArray:b];
    [array addObjectsFromArray:a];
    
    NSMutableArray *newarray = [[NSMutableArray alloc]init];
    
    for (int i  =0; i< array.count; i++) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        
        NSArray *arr = [self.dataArray objectAtIndex:i];
        
        [dic setValue:array[i] forKey:@"title"];
        [dic setValue:[NSNumber numberWithBool:NO] forKey:@"select"];
        [dic setValue:arr forKey:@"array"];
        if (oddmodel) {
            
            if (oddmodel.oddsList.count == 1) { //有些把12生肖赔率作为1个，有些拆开成12个生肖
                
                [dic setValue:oddmodel.oddsList.firstObject.odds forKey:@"odds"];
            }
            else {
                for (OddsList *list in oddmodel.oddsList) {
                    
                    if ([list.name isEqualToString:array[i]]) {
                        
                        [dic setValue:list.odds forKey:@"odds"];
                    }
                }
            }
        }
        
        [newarray addObject:dic];
    }
    
    NSMutableArray *newarray2 = [[NSMutableArray alloc]init];
    
    for (NSString *str in self.zodiacArray) {
        
        for (NSDictionary *dic in newarray) {
            
            if ([str isEqualToString:dic[@"title"]]) {
                
                [newarray2 addObject:dic];
            }
        }
    }
    
    return newarray2;
}

-(NSString *) yearofzodiac {
    
    NSString *cz = [self getChineseYearWithDate:[NSDate date]];
    
    return cz;
}

- (NSString *)getChineseYearWithDate:(NSDate *)date{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛巳",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸卯",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year - 1];
    
    NSString *Cz_str = nil;
    if ([y_str hasSuffix:@"子"]) {
        Cz_str = @"鼠";
    }else if ([y_str hasSuffix:@"丑"]){
        Cz_str = @"牛";
    }else if ([y_str hasSuffix:@"寅"]){
        Cz_str = @"虎";
    }else if ([y_str hasSuffix:@"卯"]){
        Cz_str = @"兔";
    }else if ([y_str hasSuffix:@"辰"]){
        Cz_str = @"龙";
    }else if ([y_str hasSuffix:@"巳"]){
        Cz_str = @"蛇";
    }else if ([y_str hasSuffix:@"午"]){
        Cz_str = @"马";
    }else if ([y_str hasSuffix:@"未"]){
        Cz_str = @"羊";
    }else if ([y_str hasSuffix:@"申"]){
        Cz_str = @"猴";
    }else if ([y_str hasSuffix:@"酉"]){
        Cz_str = @"鸡";
    }else if ([y_str hasSuffix:@"戌"]){
        Cz_str = @"狗";
    }else if ([y_str hasSuffix:@"亥"]){
        Cz_str = @"猪";
    }
    
    return  [NSString stringWithFormat:@"%@",Cz_str];
}


@end























































