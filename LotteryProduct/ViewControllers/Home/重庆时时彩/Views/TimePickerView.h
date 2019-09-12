//
//  TimePickerView.h
//  WorksProduct
//
//  Created by vsskyblue on 2018/3/12.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+YN.h"
#import "UIPickerView+YLT.h"
#import "PickerCell.h"

@interface TimePickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;


@property (strong, nonatomic) NSMutableArray *arrayYears;
@property (strong, nonatomic) NSMutableArray *arrayMonths;
@property (strong, nonatomic) NSMutableArray *arrayDays;
@property (strong, nonatomic) NSMutableArray *arrayHour;
@property (strong, nonatomic) NSMutableArray *arrayMin;

@property (copy, nonatomic) NSString *strYear;      //  年
@property (copy, nonatomic) NSString *strMonth;     //  月
@property (copy, nonatomic) NSString *strDay;       //  日
@property (copy, nonatomic) NSString *strHour;
@property (copy, nonatomic) NSString *strMin;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

/**
 显示小时分钟
 */
@property (assign, nonatomic) BOOL showhourandmin;

@property (copy, nonatomic) void (^TimeBlock)(NSString *time);

+(TimePickerView *)share;
-(void)showhourandmin:(BOOL)showhourandmin lastDate:(NSDate*)lastDate;
@end
