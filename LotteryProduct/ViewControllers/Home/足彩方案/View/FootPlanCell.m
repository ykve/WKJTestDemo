//
//  FootPlanCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/24.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "FootPlanCell.h"
#import "CountDown.h"
@implementation FootPlanCell
{
    CountDown *_countDownForLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _matchView.layer.borderWidth = 0.5;
    _matchView.layer.borderColor = [UIColor colorWithHex:@"90BE69"].CGColor;
    _countDownForLabel = [[CountDown alloc] init];
}
- (void)setDataWithModel:(FootballRemarkListModel *)model{
    if(_countDownForLabel){
        [_countDownForLabel destoryTimer];
    }
    _matchLabel.text = model.troop;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.heads] placeholderImage:[UIImage imageNamed:@"mrtx"]];
    
    _nameLabel.text = model.referrer;
    self.contentLabel.text = model.title;
    NSArray *retArr = [model.number componentsSeparatedByString:@","];
    for (UIView *vv in self.self.retView.subviews) {
        [vv removeFromSuperview];
    }
    if(retArr.count>1){
        for(int i = 0;i<retArr.count;i++){
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(24*i, 0, 20, 20)];
            lab.layer.cornerRadius = 3;
            lab.layer.masksToBounds = YES;

            lab.textColor = [UIColor whiteColor];
            lab.font = [UIFont boldSystemFontOfSize:13];
            lab.textAlignment = NSTextAlignmentCenter;
            NSString *num = retArr[i];
            if(num.integerValue == 0){
                lab.text = @"红";
            }else if(num.integerValue == 1){
                lab.text = @"黑";
            }else if(num.integerValue == 2){
                lab.text = @"1/2";
            }
            
            if([lab.text isEqualToString: @"红"]){
                lab.backgroundColor = [UIColor redColor];
            }else if ([lab.text isEqualToString:@"黑"]){
                lab.backgroundColor = [UIColor blackColor];
            }else if ([lab.text isEqualToString: @"1/2"]){
                lab.backgroundColor = [UIColor colorWithHex:@"f78826"];
            }
            [self.retView addSubview:lab];
        }
    }
    _percentLabel.text = [NSString stringWithFormat:@"%@%@",model.probability,@"%"];
    _seeNumLabel.text = model.realViews;
    _plNumLabel.text = model.commentCount;
    NSDate *date = [self stringConversionNSDate:model.endTime];
    NSDate *date1 = [self stringConversionNSDate:model.startTime];
    NSTimeInterval nowInt = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval startTimeInterval = [date1 timeIntervalSince1970];
    NSTimeInterval finishTimeInt = [date timeIntervalSince1970] + 90*60;

    NSDate *createDate = [self stringConversionNSDate:model.createTime];
    NSTimeInterval creatTimeInterval = [createDate timeIntervalSince1970];
    if(nowInt > creatTimeInterval){
        NSTimeInterval sss = nowInt - creatTimeInterval;
        int days = (int)(sss/(3600*24));
        int hours = (int)((sss-days*24*3600)/3600);
        int minute = (int)(sss-days*24*3600-hours*3600)/60;
        if(days){
            _timeLabel.text = [NSString stringWithFormat:@"%d天前发布",days];
//            if(hours){
//                if(minute){
//                    _timeLabel.text = [NSString stringWithFormat:@"%d天%d小时%d分钟前发布",days,hours,minute];
//                }else{
//                    _timeLabel.text = [NSString stringWithFormat:@"%d天%d小时前发布",days,hours];
//                }
//
//            }else{
//                _timeLabel.text = [NSString stringWithFormat:@"%d天前发布",days];
//            }
        }else{
            if(hours){
                _timeLabel.text = [NSString stringWithFormat:@"%d小时前发布",hours];
//                if(minute){
//                    _timeLabel.text = [NSString stringWithFormat:@"%d小时%d分钟前发布",hours,minute];
//                }else{
//                    _timeLabel.text = [NSString stringWithFormat:@"%d小时前发布",hours];
//                }
            }else{
                if(minute){
                    _timeLabel.text = [NSString stringWithFormat:@"%d分钟前发布",minute];
                }else{
                    _timeLabel.text = @"1分钟前发布";
                }
            }
        }
        
    }else{
        _timeLabel.text = @"***前发布";
    }
    if(nowInt < startTimeInterval){//未开赛
        @weakify(self)
        [_countDownForLabel countDownWithStratTimeStamp:nowInt finishTimeStamp:startTimeInterval completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
            @strongify(self)
            NSString *hourStr;
            NSString *minuteStr;
            NSString *secondStr;
            if (hour<10) {
                hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
            }else{
                hourStr = [NSString stringWithFormat:@"%ld",(long)hour];
            }
            if (minute<10) {
                minuteStr = [NSString stringWithFormat:@"0%ld",(long)minute];
            }else{
                minuteStr = [NSString stringWithFormat:@"%ld",(long)minute];
            }
            if (second<10) {
                secondStr = [NSString stringWithFormat:@"0%ld",(long)second];
            }else{
                secondStr = [NSString stringWithFormat:@"%ld",(long)second];
            }
            self.stLabel.text = [NSString stringWithFormat:@"距开赛 %@:%@:%@",hourStr,minuteStr,secondStr];
        }];
        self.titleView.backgroundColor = [UIColor colorWithHex:@"FAEBEE"];
        self.stLabel.textColor = [UIColor colorWithHex:@"C01833"];
    }else if (startTimeInterval > nowInt&& nowInt <finishTimeInt){
        self.titleView.backgroundColor = [UIColor colorWithHex:@"EACD91"];
        self.stLabel.text = @"开赛中";
        self.stLabel.textColor = [UIColor colorWithHex:@"C01833"];
    }else if (nowInt >finishTimeInt){
        self.titleView.backgroundColor = [UIColor colorWithHex:@"CCCCCC"];
        self.stLabel.textColor = WHITE;
        self.stLabel.text = @"已结束";
    }
    
}
- (NSDate *)stringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}
- (void)dealloc{
    [_countDownForLabel destoryTimer];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
