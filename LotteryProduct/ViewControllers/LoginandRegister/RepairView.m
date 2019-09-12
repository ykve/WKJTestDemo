//
//  RepairView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/4/26.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RepairView.h"

@interface RepairView ()

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *noteLbl;

@end

@implementation RepairView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
    self.noteLbl.textColor = [UIColor colorWithHex:@"333333"];
    self.timeLbl.textColor = [UIColor colorWithHex:@"333333"];
}

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    // 时间字符串
    NSString *startTime = [NSString stringWithFormat:@"%@", dict[@"startTime"]];
    NSString *endTime = [NSString stringWithFormat:@"%@", dict[@"endTime"]];

    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";

    // NSString * -> NSDate *
    NSDate *startDate = [fmt dateFromString:startTime];
    NSDate *endDate = [fmt dateFromString:endTime];

    [fmt setDateFormat:@"M月dd日 HH:mm"];
    startTime = [fmt stringFromDate:startDate];
    endTime = [fmt stringFromDate:endDate];
    
    self.timeLbl.text = [NSString stringWithFormat:@"%@ - %@",  startTime, endTime];
    self.noteLbl.text = [NSString stringWithFormat:@"%@", dict[@"content"] ? dict[@"content"] : @"给您带来不便敬请谅解"];
}

@end
