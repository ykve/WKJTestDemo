//
//  CalendarView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/8.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CalendarView.h"

@interface CalendarView ()




/**用于切换日历界面时中转月份用的*/
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSMutableDictionary *fillColors;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;


@property (strong, nonatomic) UIImageView *topImageView;
@property (strong, nonatomic) UILabel *datelab;
@property (strong, nonatomic) UIButton *lastBtn;
@property (strong, nonatomic) UIButton *nextBtn;
@property (strong, nonatomic) FSCalendar *calendar;

@property (strong, nonatomic) UILabel *statuslab;

@property (strong, nonatomic) UIView *todayView;
@property (strong, nonatomic) UILabel *openLotteryDateLbl;



@end

@implementation CalendarView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"imageName"];
    topImageView.userInteractionEnabled = YES;
    [self addSubview:topImageView];
    _topImageView = topImageView;
    
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@(377));
    }];
    
    
    UILabel *datelab = [[UILabel alloc] init];
    datelab.text = @"-";
    datelab.font = [UIFont boldSystemFontOfSize:16];
    datelab.textColor = [UIColor whiteColor];
    datelab.textAlignment = NSTextAlignmentCenter;
    [topImageView addSubview:datelab];
    _datelab = datelab;
    
    [datelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topImageView.mas_top).offset(46);
        make.centerX.mas_equalTo(topImageView.mas_centerX);
    }];
    
    UIButton *lastBtn = [[UIButton alloc] init];
    [lastBtn addTarget:self action:@selector(beforeClick:) forControlEvents:UIControlEventTouchUpInside];
    [lastBtn setImage:[UIImage imageNamed:@"kj_left"] forState:UIControlStateNormal];
    lastBtn.tag = 100;
    [topImageView addSubview:lastBtn];
    
    [lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(datelab.mas_centerY);
        make.left.mas_equalTo(topImageView.mas_left).offset(26);
        make.size.mas_equalTo(CGSizeMake(10, 17));
    }];
    
    UIButton *nextBtn = [[UIButton alloc] init];
    [nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setImage:[UIImage imageNamed:@"kj_right"] forState:UIControlStateNormal];
    nextBtn.tag = 101;
    [topImageView addSubview:nextBtn];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(datelab.mas_centerY);
        make.right.equalTo(topImageView.mas_right).offset(-26);
        make.size.mas_equalTo(CGSizeMake(10, 17));
    }];
    
    
    UILabel *statuslab = [[UILabel alloc] init];
    statuslab.text = @"-";
    statuslab.font = [UIFont systemFontOfSize:14];
    statuslab.textColor = [UIColor colorWithHex:@"#333333"];
    statuslab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:statuslab];
    _statuslab = statuslab;
    
    [statuslab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    
    FSCalendar *calendar = [[FSCalendar alloc] init];
    calendar.backgroundColor = [UIColor greenColor];
    [topImageView addSubview:calendar];
    _calendar = calendar;
    
    [calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_top).offset(78);
        make.left.right.equalTo(topImageView);
        make.bottom.equalTo(topImageView.mas_bottom).offset(-40);
    }];

    
    UILabel *openLotteryDateLbl = [[UILabel alloc] init];
    openLotteryDateLbl.text = @"开奖日";
    openLotteryDateLbl.font = [UIFont systemFontOfSize:13];
    openLotteryDateLbl.textColor = [UIColor colorWithHex:@"#666666"];
    openLotteryDateLbl.textAlignment = NSTextAlignmentRight;
    [topImageView addSubview:openLotteryDateLbl];
    _openLotteryDateLbl = openLotteryDateLbl;
    
    [openLotteryDateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topImageView.mas_bottom).offset(-20);
        make.right.equalTo(topImageView.mas_right).offset(-35);
    }];
    
    
    UIView *todayView = [[UIView alloc] init];
    todayView.layer.cornerRadius = 16/2;
    todayView.layer.masksToBounds = YES;
    [topImageView addSubview:todayView];
    _todayView = todayView;
    
    [todayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(openLotteryDateLbl.mas_centerY);
        make.right.mas_equalTo(openLotteryDateLbl.mas_left).offset(-15);
        make.size.mas_equalTo(16);
    }];

    
    [self setUI];
}




-(void)setUI {
    
    [self.nextBtn setImage:[[CPTThemeConfig shareManager] calendarRightImage] forState:UIControlStateNormal];
    [self.lastBtn setImage:[[CPTThemeConfig shareManager] calendarLeftImage] forState:UIControlStateNormal];
    self.topImageView.image = [[CPTThemeConfig shareManager] IM_CalendarTopImage];
    
    self.date = [NSDate date];
    
    self.calendar.delegate = self;
    self.calendar.dataSource = self;
    self.calendar.backgroundColor = [[CPTThemeConfig shareManager] calendarBackgroundColor];
    self.calendar.headerHeight = 0;
    // 星期View Text
    self.calendar.appearance.weekdayTextColor = [[CPTThemeConfig shareManager] openLotteryCalendarWeekTextColor];
    self.calendar.appearance.subtitleFont = FONT(9);
    self.calendar.weekdayHeight = 45;
    // 星期View
    self.calendar.calendarWeekdayView.backgroundColor = [[CPTThemeConfig shareManager] openLotteryCalendarTitleColor];
    // 当前日
    self.calendar.appearance.todayColor = [[CPTThemeConfig shareManager] openCalendarTodayColor];
    self.calendar.appearance.borderRadius = 1.0;  // 设置当前选择是圆形,0.0是正方形
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    self.calendar.locale = locale;  // 设置周次是中文显示
    self.calendar.allowsSelection = NO;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]]; 
    self.todayView.backgroundColor = [[CPTThemeConfig shareManager] openCalendarTodayViewBackground];
    
    self.openLotteryDateLbl.textColor = [UIColor colorWithHex:@"666666"];

    self.datelab.text = strDate;
    [self initData:YES];
}

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar{
    
    return [NSDate datebeforeYear:1980];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    
//    return [NSDate date];
    return [[NSDate date] dateAfterDay:36500];

}

- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleDefaultColorForDate:(NSDate *)date{
    
    return [UIColor redColor];
}

- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillSelectionColorForDate:(NSDate *)date{
    
    return BASECOLOR;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date{
    
    return YES;
}

-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date {
    
    NSString *key = [self.dateFormatter stringFromDate:date];
    
    if ([self.fillColors.allKeys containsObject:key]) {
        
        return self.fillColors[key];
    }
    return nil;
}


-(void)calendarCurrentPageDidChange:(FSCalendar *)calendar{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    NSString *strDate = [dateFormatter stringFromDate:calendar.currentPage];
    
    self.datelab.text = strDate;
    
}


- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date{
    
    NSLog(@"selectdate:%@",date);
    
}


- (void)beforeClick:(UIButton *)sender {
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self.date options:0];
    self.date = newDate;
    [self.calendar setCurrentPage:newDate animated:YES];
    
    [self initData:NO];
}
- (void)nextClick:(UIButton *)sender {

    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self.date options:0];
    self.date = newDate;

    [self.calendar setCurrentPage:newDate animated:YES];
    
    [self initData:NO];
}

-(void)initData:(BOOL)today {
    
    NSLog(@"%ld--%02lu",self.date.getYear,self.date.getMonth);
    
    NSString *time = [NSString stringWithFormat:@"%ld-%02lu",self.date.getYear,(unsigned long)self.date.getMonth];
    [WebTools postWithURL:@"/lhcSg/startlottoDate.json" params:@{@"date":time} success:^(BaseData *data) {
        
        NSArray *array = data.data[@"lhcDate"];
        
        [self.fillColors removeAllObjects];
        
        for (NSString *datestring in array) {
            
            [self.fillColors setValue:[[CPTThemeConfig shareManager] openCalendarTodayViewBackground] forKey:datestring];
        }
        
        [self.calendar reloadData];
        
        if (today) {
            
            if ([array containsObject:[self.dateFormatter stringFromDate:[NSDate date]]]) {
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
                self.statuslab.text = [NSString stringWithFormat:@"%@ (农历%@）%@",[dateFormatter stringFromDate:[NSDate date]],[self getchinesetime],@"开奖日"];
                self.statuslab.textColor = [UIColor colorWithHex:@"666666"];
            }
            else {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
                self.statuslab.text = [NSString stringWithFormat:@"%@ (农历%@）%@",[dateFormatter stringFromDate:[NSDate date]],[self getchinesetime],@"非开奖日"];
                self.statuslab.textColor = [UIColor colorWithHex:@"666666"];

            }
        }

    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(NSMutableDictionary *)fillColors {
    
    if (!_fillColors) {
        
        _fillColors = [[NSMutableDictionary alloc]init];
    }
    return _fillColors;
}

-(NSDateFormatter *)dateFormatter {
    
    if (!_dateFormatter) {
        
        _dateFormatter = [[NSDateFormatter alloc]init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

-(NSString *)getchinesetime {
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛巳",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸卯",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:[NSDate date]];
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year - 1];
    
    return [NSString stringWithFormat:@"%@年%02ld月%02ld日",y_str,(long)localeComp.month,(long)localeComp.day];
}

@end
