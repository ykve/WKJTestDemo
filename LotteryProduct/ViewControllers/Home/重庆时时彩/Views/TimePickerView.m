//
//  TimePickerView.m
//  WorksProduct
//
//  Created by vsskyblue on 2018/3/12.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "TimePickerView.h"

@implementation TimePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableArray *)arrayYears
{
    if (!_arrayYears) {
        _arrayYears = [NSMutableArray array];
        for (NSInteger i = 1980; i <= (self.strYear? ([self.strYear integerValue] != [NSDate date].getYear? [NSDate date].getYear : [self.strYear integerValue]): [NSDate date].getYear); i++) {
            NSString *strYear = [NSString stringWithFormat:@"%04li", (long)i];
            [_arrayYears addObject:strYear];
        }
      }
  
    return _arrayYears;
}

- (NSMutableArray *)arrayMonths
{
    if (!_arrayMonths) {
        _arrayMonths = [NSMutableArray array];
        for (int i = 1; i <=  (self.strMonth? [self.strMonth integerValue] != [NSDate date].getMonth?  [NSDate date].getMonth:[self.strMonth integerValue]: [NSDate date].getMonth) ; i++) {
            NSString *str = [NSString stringWithFormat:@"%02i", i];
            [_arrayMonths addObject:str];
        }
    }

    return _arrayMonths;
}

- (NSMutableArray *)arrayDays
{
    if (!_arrayDays) {
        _arrayDays = [NSMutableArray array];
        for (int i = 1; i <= (self.strDay? [self.strDay integerValue] != [NSDate date].getDay? [NSDate date].getDay: [self.strDay integerValue]: [NSDate date].getDay);i++){
            NSString *str = [NSString stringWithFormat:@"%02i", i];
            [_arrayDays addObject:str];
        }
    }

    
    return _arrayDays;
}

- (void)configDate{
    [_arrayYears removeAllObjects];
    for (NSInteger i = 1980; i <= (self.strYear? ([self.strYear integerValue] != [NSDate date].getYear? [NSDate date].getYear : [self.strYear integerValue]): [NSDate date].getYear); i++) {
        NSString *strYear = [NSString stringWithFormat:@"%04li", (long)i];
        [_arrayYears addObject:strYear];
    }

    [_arrayMonths removeAllObjects];
    
    
    
    for (int i = 1; i <=  (self.strYear?( [self.strYear integerValue] != [NSDate date].getYear?  12:[NSDate date].getMonth): [NSDate date].getMonth) ; i++) {
        NSString *str = [NSString stringWithFormat:@"%02i", i];
        [_arrayMonths addObject:str];
    }
    
    [_arrayDays removeAllObjects];
    NSString *strDate = [NSString stringWithFormat:@"%@%@", self.strYear, self.strMonth];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMM";
    NSDate * dd = [dateFormatter dateFromString:strDate];
    NSInteger days = 0;
    if(self.strYear){
        if([self.strYear integerValue] != [NSDate date].getYear){
            days = [self totaldaysInMonth:dd];
        }
        else if([self.strYear integerValue] == [NSDate date].getYear){
            if([self.strMonth integerValue] != [NSDate date].getMonth){
                days = [self totaldaysInMonth:dd];
            }else{
                days = [NSDate date].getDay;
            }
        }
        else{
            days = [NSDate date].getDay;
        }
    }else{
        days = [NSDate date].getDay;
    }
    
    
    for (int i = 1; i <= days;i++){
        NSString *str = [NSString stringWithFormat:@"%02i", i];
        [_arrayDays addObject:str];
    }

}

- (NSMutableArray *)arrayHour {
    
    if (!_arrayHour) {
        
        _arrayHour = [NSMutableArray array];
        
        for (int i = 0 ; i< 24 ; i++) {
            
            NSString *str = [NSString stringWithFormat:@"%02i", i];
            [_arrayHour addObject:str];
        }
    }
    return _arrayHour;
}

- (NSMutableArray *)arrayMin {
    
    if (!_arrayMin) {
        
        _arrayMin = [NSMutableArray array];
        
        for (int i = 0; i < 60 ; i++) {
            
            NSString *str = [NSString stringWithFormat:@"%02i", i];
            
            [_arrayMin addObject:str];
        }
    }
    
    return _arrayMin;
}

-(void)awakeFromNib {
    
    [super awakeFromNib];

}
-(void)showhourandmin:(BOOL)showhourandmin lastDate:(NSDate*)lastDate{
    _showhourandmin = showhourandmin;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyyMM";
    
    NSInteger allDays = [self totaldaysInMonth:lastDate];
    for (int i = 1; i <= [NSDate date].getDay; i++) {
        NSString *strDay = [NSString stringWithFormat:@"%02i", i];
        [self.arrayDays addObject:strDay];
    }
    
    self.myPickerView.delegate = self;
    self.myPickerView.dataSource = self;
    
    //  更新年
    NSInteger currentYear = [lastDate getYear];
    NSString *strYear = [NSString stringWithFormat:@"%04li", currentYear];
    NSInteger indexYear = [self.arrayYears indexOfObject:strYear];
    if (indexYear == NSNotFound) {
        indexYear = 0;
    }
    [self.myPickerView selectRow:indexYear inComponent:0 animated:YES];
    self.strYear = self.arrayYears[indexYear];;
    
    //  更新月份
    NSInteger currentMonth = [lastDate getMonth];
    NSString *strMonth = [NSString stringWithFormat:@"%02li", currentMonth];
    NSInteger indexMonth = [self.arrayMonths indexOfObject:strMonth];
    if (indexMonth == NSNotFound) {
        indexMonth = 0;
    }
    [self.myPickerView selectRow:indexMonth inComponent:1 animated:YES];
    self.strMonth = self.arrayMonths[indexMonth];
    
    //  更新日
    NSInteger currentDay = [lastDate getDay];
    NSString *strDay = [NSString stringWithFormat:@"%02li", currentDay];
    NSInteger indexDay = [self.arrayDays indexOfObject:strDay];
    if (indexDay == NSNotFound) {
        indexDay = 0;
    }
    [self.myPickerView selectRow:indexDay inComponent:2 animated:YES];
    self.strDay = self.arrayDays[indexDay];
    
    if (showhourandmin) {
        
        NSInteger currentHour = [lastDate getHour];
        NSString *strHour = [NSString stringWithFormat:@"%02li", currentHour];
        NSInteger indexHour = [self.arrayHour indexOfObject:strHour];
        if (indexHour == NSNotFound) {
            
            indexHour = 0;
        }
        [self.myPickerView selectRow:indexHour inComponent:3 animated:YES];
        self.strHour = self.arrayHour[indexHour];
        
        NSInteger currentMin = [lastDate getMinute];
        NSString *strMin = [NSString stringWithFormat:@"%02li", currentMin];
        NSInteger indexMin = [self.arrayMin indexOfObject:strMin];
        if (indexMin == NSNotFound) {
            
            indexMin = 0;
        }
        [self.myPickerView selectRow:indexMin inComponent:4 animated:YES];
        self.strMin = self.arrayMin[indexMin];
        
        
        [self.myPickerView clearSpearatorLine];
        
    }else {
        
        [self.myPickerView clearSpearatorLine];
    }
}

-(void)setShowhourandmin:(BOOL)showhourandmin {
    
    _showhourandmin = showhourandmin;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyyMM";
    
    NSInteger allDays = [self totaldaysInMonth:[NSDate date]];
    for (int i = 1; i <=  [NSDate date].getDay; i++) {
        NSString *strDay = [NSString stringWithFormat:@"%02i", i];
        [self.arrayDays addObject:strDay];
    }
    
    self.myPickerView.delegate = self;
    self.myPickerView.dataSource = self;
    
    //  更新年
    NSInteger currentYear = [[NSDate date] getYear];
    NSString *strYear = [NSString stringWithFormat:@"%04li", currentYear];
    NSInteger indexYear = [self.arrayYears indexOfObject:strYear];
    if (indexYear == NSNotFound) {
        indexYear = 0;
    }
    [self.myPickerView selectRow:indexYear inComponent:0 animated:YES];
    self.strYear = self.arrayYears[indexYear];;
    
    //  更新月份
    NSInteger currentMonth = [[NSDate date] getMonth];
    NSString *strMonth = [NSString stringWithFormat:@"%02li", currentMonth];
    NSInteger indexMonth = [self.arrayMonths indexOfObject:strMonth];
    if (indexMonth == NSNotFound) {
        indexMonth = 0;
    }
    [self.myPickerView selectRow:indexMonth inComponent:1 animated:YES];
    self.strMonth = self.arrayMonths[indexMonth];
    
    //  更新日
    NSInteger currentDay = [[NSDate date] getDay];
    NSString *strDay = [NSString stringWithFormat:@"%02li", currentDay];
    NSInteger indexDay = [self.arrayDays indexOfObject:strDay];
    if (indexDay == NSNotFound) {
        indexDay = 0;
    }
    [self.myPickerView selectRow:indexDay inComponent:2 animated:YES];
    self.strDay = self.arrayDays[indexDay];
    
    if (showhourandmin) {
        
        NSInteger currentHour = [[NSDate date] getHour];
        NSString *strHour = [NSString stringWithFormat:@"%02li", currentHour];
        NSInteger indexHour = [self.arrayHour indexOfObject:strHour];
        if (indexHour == NSNotFound) {
            
            indexHour = 0;
        }
        [self.myPickerView selectRow:indexHour inComponent:3 animated:YES];
        self.strHour = self.arrayHour[indexHour];
        
        NSInteger currentMin = [[NSDate date] getMinute];
        NSString *strMin = [NSString stringWithFormat:@"%02li", currentMin];
        NSInteger indexMin = [self.arrayMin indexOfObject:strMin];
        if (indexMin == NSNotFound) {
            
            indexMin = 0;
        }
        [self.myPickerView selectRow:indexMin inComponent:4 animated:YES];
        self.strMin = self.arrayMin[indexMin];
        
        
        [self.myPickerView clearSpearatorLine];
        
    }else {
    
        [self.myPickerView clearSpearatorLine];
    }
}

#pragma mark - 计算出当月有多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

#pragma mark - UIPickerView DataSource and Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.showhourandmin) {
        
        return 5;
    }
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.arrayYears.count;
    } else if (component == 1) {
        return self.arrayMonths.count;
    } else if (component == 2){
        return self.arrayDays.count;
    } else if (component == 3) {
        return self.arrayHour.count;
    }else {
        return self.arrayMin.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    ((UIView *)[pickerView.subviews objectAtIndex:1]).backgroundColor = [UIColor clearColor];
    ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = [UIColor clearColor];
    if (component == 0) {
        PickerCell *cell = [PickerCell cellWithName:self.arrayYears[row]];
        return cell;
    } else if (component == 1) {
        PickerCell *cell = [PickerCell cellWithName:self.arrayMonths[row]];
        return cell;
    } else if (component == 2) {
        PickerCell *cell = [PickerCell cellWithName:self.arrayDays[row]];
        return cell;
    } else if (component == 3) {
        PickerCell *cell = [PickerCell cellWithName:self.arrayHour[row]];
        return cell;
    }else {
        PickerCell *cell = [PickerCell cellWithName:self.arrayMin[row]];
        return cell;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.strYear = self.arrayYears[row];
    } else if (component == 1) {
        self.strMonth = self.arrayMonths[row];
    } else if (component == 2){
        self.strDay = self.arrayDays[row];
    } else if (component == 3) {
        self.strHour = self.arrayHour[row];
    }else {
        self.strMin = self.arrayMin[row];
    }
    
    if (component != 2) {
        NSString *strDate = [NSString stringWithFormat:@"%@%@", self.strYear, self.strMonth];
        [self upDateCurrentAllDaysWithDate:[self.dateFormatter dateFromString:strDate]];
    }
    [self configDate];
    [pickerView reloadAllComponents];
}

#pragma mark - 更新选中的年、月份时的日期
- (void)upDateCurrentAllDaysWithDate:(NSDate *)currentDate
{
    [self.arrayDays removeAllObjects];
    
    NSInteger allDays = [self totaldaysInMonth:currentDate];
    for (int i = 1; i <= allDays; i++) {
        NSString *strDay = [NSString stringWithFormat:@"%02i", i];
        [self.arrayDays addObject:strDay];
    }
    
    [self.myPickerView reloadComponent:2];
    
    //  更新日
    NSInteger indexDay = [self.arrayDays indexOfObject:self.strDay];
    if (indexDay == NSNotFound) {
        indexDay = (self.arrayDays.count - 1) > 0 ? (self.arrayDays.count - 1) : 0;
    }
    [self.myPickerView selectRow:indexDay inComponent:2 animated:YES];
    self.strDay = self.arrayDays[indexDay];
    
}

+(TimePickerView *)share {
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([TimePickerView class]) owner:self options:nil]lastObject];
}

- (IBAction)cancelClick:(UIButton *)sender {
    
    if (self.TimeBlock) {
        
        self.TimeBlock(nil);
    }
}
- (IBAction)sureClick:(UIButton *)sender {
    
    NSString *timestr = nil;
    if (self.showhourandmin) {
        
        timestr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", self.strYear, self.strMonth, self.strDay, self.strHour,self.strMin];
    }
    else {
        
        timestr = [NSString stringWithFormat:@"%@-%@-%@", self.strYear, self.strMonth, self.strDay];
    }
    
    if(self.TimeBlock) {
        
        self.TimeBlock(timestr);
    }
}

@end
