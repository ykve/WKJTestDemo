//
//  ZJDetailCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/7/2.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "ZJDetailCell.h"
#import "ColorTool.h"
#import "BallTool.h"
#import "Gendan_PostmarkView.h"
#import "CountDown.h"


@interface ZJDetailCell()

@property (weak, nonatomic) IBOutlet UIView *bettingDesView;
@property (weak, nonatomic) IBOutlet UIView *betTopLineView;

@end


@implementation ZJDetailCell
{
    ExpertModel *_currentModel;
    CountDown *_countDownForLabel;
}
- (void)setIsGendan:(BOOL)isGendan{
    _isGendan = isGendan;
    if(isGendan){
        self.genDanView.hidden = NO;
        self.gdZJNameLab.hidden = NO;
        self.gdZJValueLab.hidden = NO;
        self.ljzjNameLabel.text = @"盈利率:";
    }else{
        self.ljzjNameLabel.text = @"累计中奖:";
        self.genDanView.hidden = YES;
        self.gdZJNameLab.hidden = YES;
        self.gdZJValueLab.hidden = YES;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _countDownForLabel = [[CountDown alloc] init];
    [_btn1 setBackgroundImage:[ColorTool imageWithColor:[UIColor colorWithHex:@"DDDDDD"]] forState:UIControlStateNormal];
    [_btn1 setBackgroundImage:[ColorTool imageWithColor:[UIColor colorWithHex:@"AC1E2D"]] forState:UIControlStateSelected];
    [_btn2 setBackgroundImage:[ColorTool imageWithColor:[UIColor colorWithHex:@"DDDDDD"]] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[ColorTool imageWithColor:[UIColor colorWithHex:@"AC1E2D"]] forState:UIControlStateSelected];
}
- (void)setDataWithModel:(ExpertModel *)model{
    _currentModel = model;
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:model.heads] placeholderImage:[UIImage imageNamed:@"mrtx"]];
    _namelabel.text = model.nickname;
    _focusBtn.selected = model.isFocus?YES:NO;
    _moneyLabel.text = [NSString stringWithFormat:@"%@元",model.totalMoney];
    _contentLabel.text = model.personalContent;
    CGFloat h = [BallTool heightWithFont:13 limitWidth:SCREEN_WIDTH-20 string:model.personalContent];
    _contentHeight.constant = h>21?h:21;
    _rateLabel1.text = [NSString stringWithFormat:@"%@%@",model.showWinRate,@"%"];
    _rateLabel2.text = [NSString stringWithFormat:@"%@",model.showMaxLz];
    _rateLabel3.text = [NSString stringWithFormat:@"%@%@",model.showProfitRate,@"%"];
    NSArray *retArr = [model.allRecord componentsSeparatedByString:@","];
    _slNameLabel.text = [NSString stringWithFormat:@"胜率(%@)",model.jizji];
    for (UIView *vv in _stackView.subviews) {
        [vv removeFromSuperview];
    }
    
    NSInteger count = retArr.count > 10 ? 10 : retArr.count;
    for (int i = 0; i<count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22, 20)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(22/2-9, 1, 18, 18)];
        label.textAlignment = NSTextAlignmentCenter;
        NSString *numStr = i < retArr.count ? retArr[i] : @"2";
        label.layer.cornerRadius = 9;
        label.layer.masksToBounds = YES;
        label.textColor = WHITE;
        label.font = [UIFont systemFontOfSize:12];
        if(numStr.integerValue == 0){
            label.text = @"赢";
            label.backgroundColor = [UIColor colorWithHex:@"BB2A2A"];
        }else if(numStr.integerValue == 1){
            label.text = @"亏";
            label.backgroundColor = [UIColor colorWithHex:@"5AA924"];
        }else if(numStr.integerValue == 2){
            label.text = @"和";
            label.backgroundColor = [UIColor colorWithHex:@"5E75B6"];
        } else {
            label.text = @"无";
            label.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
        }
        
        [view addSubview:label];
        [_stackView addArrangedSubview:view];
    }
    if(model.ing == YES){
        _btn1.selected = YES;
        _btn2.selected = NO;
    }else{
        _btn1.selected = NO;
        _btn2.selected = YES;
    }

}
- (void)startCountDownWithTime:(NSInteger )time{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    long long finishLongLong = time;
    //    long long finishLongLong = [[NSDate date] timeIntervalSince1970] + self.endTime +5;
    //    if(finishLongLong == 0||now>finishLongLong){
    //        return;
    //    }
    @weakify(self)
    [_countDownForLabel countDownWithStratTimeStamp:now finishTimeStamp:finishLongLong completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
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
        self.timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr];
        NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
        if(totoalSecond ==0){
            MBLog(@"totoalSecond %ld====",(long)totoalSecond);
            self.timeLabel.text = @"";
        }
    }];
}

#pragma mark - 关注/取消关注大神
- (IBAction)focusClick:(UIButton *)sender {
    NSInteger type = sender.selected?2:1;
    
    NSMutableDictionary *dictPar = [[NSMutableDictionary alloc]init];
    [dictPar setValue:@(type) forKey:@"type"];
    [dictPar setValue:@(self.model.godId) forKey:@"godId"];
    
    [WebTools postWithURL:@"/circle/god/focusOrCancle.json" params:dictPar success:^(BaseData *data) {
        if(data.status.integerValue == 1){
            sender.selected = !sender.selected;
            if(sender.selected){
                self->_currentModel.isFocus = 1;
            }else{
                self->_currentModel.isFocus = 0;
            }
            if(self.didUpdateModel){
                self.didUpdateModel(self->_currentModel);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


- (IBAction)btnClick:(UIButton *)sender {
    if(!sender.selected){
        sender.selected = YES;
        if(sender == _btn1){
            _btn2.selected = NO;
            _currentModel.ing = YES;
        }else{
            _btn1.selected = NO;
            _currentModel.ing = NO;
        }
        if(self.didUpdateModel){
            self.didUpdateModel(self->_currentModel);
        }
        if(self.didClickBtn){
            self.didClickBtn(sender.tag);
        }
    }
}

- (void)setModel:(TuidanDetailModel *)model {
    _model = model;

    UIImage *img = IMAGE(@"gendanlishi");
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    _fourItemsBgImgView.image = img;
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:model.head]];
    _namelabel.text = model.nickName;
    _focusBtn.selected = model.isFollow?YES:NO;
    _moneyLabel.text = [NSString stringWithFormat:@"%@%@",model.calcProfitRate,@"%"];

    _contentLabel.text = model.personalContent;

    _zjAnalyseLabel.text = model.godAnalyze;
    _gdZJValueLab.text = [NSString stringWithFormat:@"%@元",model.totalMoney];
    NSArray *retArr = [model.lotteryRecord componentsSeparatedByString:@","];
    for (UIView *vv in _stackView.subviews) {
        [vv removeFromSuperview];
    }
    
    NSInteger count = retArr.count > 10 ? 10 : retArr.count;
    for (int i = 0; i < count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22, 20)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(22/2-9, 1, 18, 18)];
        label.textAlignment = NSTextAlignmentCenter;
        NSString *numStr = i < retArr.count ? retArr[i] : @"2";
        label.layer.cornerRadius = 9;
        label.layer.masksToBounds = YES;
        label.textColor = WHITE;
        label.font = [UIFont systemFontOfSize:12];
        if(numStr.integerValue == 0){
            label.text = @"赢";
            label.backgroundColor = [UIColor colorWithHex:@"BB2A2A"];
        }else if(numStr.integerValue == 1){
            label.text = @"亏";
            label.backgroundColor = [UIColor colorWithHex:@"5AA924"];
        }else if(numStr.integerValue == 2){
            label.text = @"和";
            label.backgroundColor = [UIColor colorWithHex:@"5E75B6"];
        } else {
            label.text = @"无";
            label.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
        }
        [view addSubview:label];
        [_stackView addArrangedSubview:view];
    }
    _lotteryNameLabel.text = model.lotteryName;
    _issueLabel.text = [NSString stringWithFormat:@"(第%@期)",model.issue];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    if((model.endTime/1000)<now){
        [self startCountDownWithTime:now+100];
    }else{
        _timeLabel.text = @"";
    }
    
    if(model.picture&&model.picture.length>0){
        [_pictureImgView sd_setImageWithURL:[NSURL URLWithString:model.picture]];
    }else{
        _picHeight.constant = 0;
    }
    _followNumLabel.text = [NSString stringWithFormat:@"%@人已跟单",model.gdCount];
    
    _boxLab1.text = [NSString stringWithFormat:@"%.2f元",model.betAmount];
    _boxLab2.text = [NSString stringWithFormat:@"%.2f元",model.numberAmount];
    _boxLab3.text = [NSString stringWithFormat:@"%@%@",model.bonusScale,@"%"];
    _boxLab4.text = [NSString stringWithFormat:@"%@",model.ensureOdds];
    
    if(model.isShow == 1){//展示
        _bettingDesView.hidden = NO;

        _contentLab1.text = [NSString stringWithFormat:@"%@",model.lotteryName];
        _contentLab2.text = [NSString stringWithFormat:@"%@",model.issue];
        _contentLab3.text = [NSString stringWithFormat:@"%@",model.betNumber];
        _contentLab4.text = [NSString stringWithFormat:@"%@",model.betOdds];
        _contentLab5.text = [NSString stringWithFormat:@"%.2f元",model.betAmount];
        _contentLab6.text = [NSString stringWithFormat:@"%@元",model.maxMoney];
        
        
        NSString *stateStr;
        if([model.btStatus isEqualToString:@"WAIT"]){
            stateStr = @"等待开奖";
        }else {
            Gendan_PostmarkView *pmView = [[[NSBundle mainBundle] loadNibNamed:@"Gendan_PostmarkView" owner:nil options:nil]lastObject];
            if ([model.btStatus isEqualToString:@"WIN"]){
                stateStr = @"中奖";
                pmView.code = 2;
                pmView.label.text = [NSString stringWithFormat:@"%.2f",model.winAmount];
            }else if ([model.btStatus isEqualToString:@"NO_WIN"]){
                stateStr = @"未中奖";
                pmView.code = 0;
            }else if ([model.btStatus isEqualToString:@"HE"]){
                stateStr = @"打和";
                pmView.code = 1;
            }
            pmView.frame = CGRectMake(0, 0, 60, 60);
            [self.winStateView addSubview:pmView];
        }
        _contentLab7.text = stateStr;

    }else{
        //不展示
        _bettingDesView.hidden = YES;

        NSString *text;
        if(model.secretStatus == 1){
            text = @"投注详情保密中，跟单后公开";
        }else if(model.secretStatus == 2){
            text = @"投注详情保密中，开奖后公开";
        }
        UIButton *betViewBtn = [[UIButton alloc] init];
        [betViewBtn setTitle:text forState:UIControlStateNormal];
        [betViewBtn setTitleColor:[UIColor colorWithHex:@"#3D301C"] forState:UIControlStateNormal];
        betViewBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [betViewBtn setBackgroundImage:[UIImage imageNamed:@"touzhubaomi"] forState:UIControlStateNormal];
        [betViewBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 15, 0.0, 0.0)];
        [self.genDanView addSubview:betViewBtn];

        [betViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.betTopLineView.mas_bottom).offset(20);
            make.centerX.mas_equalTo(self.genDanView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(243, 40));
        }];

        
    }
    

}
@end
