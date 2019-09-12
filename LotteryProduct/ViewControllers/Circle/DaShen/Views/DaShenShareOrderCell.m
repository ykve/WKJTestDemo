//
//  DaShenShareOrderCell.m
//  LotteryProduct
//
//  Created by Jiang on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "DaShenShareOrderCell.h"
#import "CountDown.h"
#import "UIView+WZB.h"

@interface DaShenShareOrderCell ()

/// 
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *viewTable;


/**
 姓名
 */
@property (strong, nonatomic) UILabel *namelab;

/**
 盈利率、胜率、连中的值
 */
@property (strong, nonatomic) UILabel *typevaluelab;
/**
 彩种
 */
@property (strong, nonatomic) UILabel *lottery_namelab;
/**
 玩法
 */
@property (weak, nonatomic) IBOutlet UILabel *lottery_playlab;
/**
 期号
 */
@property (strong, nonatomic) UILabel *lottery_versionlab;
/**
 赔率
 */
@property (strong, nonatomic) UILabel *lottery_oddslab;
/**
 投注金额
 */
@property (strong, nonatomic) UILabel *lottery_pricelab;
/**
 分红:
 */
@property (strong, nonatomic) UILabel *addpricelab;
/**
 保障赔率:
 */
@property (strong, nonatomic) UILabel *safelab;
/**
 投注总金额:
 */
@property (strong, nonatomic) UILabel *totalpricelab;
/**
 开奖后公开
 */
@property (strong, nonatomic) UILabel *secretlab;
/**
 2000
 */
@property (strong, nonatomic) UILabel *peoplenumlab;
@property (strong, nonatomic)  UIStackView *tenRetStackView;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIView *postMarkBgView;
@property (strong, nonatomic) UILabel *endLabel;
@property (strong, nonatomic)  UIView *rateView;


@end

@implementation DaShenShareOrderCell
{
    CountDown *_countDownForLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView reusableId:(NSString *)ID {
    DaShenShareOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[DaShenShareOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _countDownForLabel = [[CountDown alloc] init];
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor colorWithHex:@"#F2F9FF"];
    backView.layer.borderColor = [UIColor colorWithHex:@"#B8DEFF"].CGColor;
    backView.layer.borderWidth = 1.0;
    backView.layer.cornerRadius = 12;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    _backView = backView;
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
    }];
    
    
    UIView *k1View = [[UIView alloc] init];
    k1View.backgroundColor = [UIColor colorWithHex:@"#B8DEFF"];
    [self addSubview:k1View];
    [k1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top);
        make.left.equalTo(backView.mas_left);
        make.size.mas_equalTo(12);
    }];
    UIView *k2View = [[UIView alloc] init];
    k2View.backgroundColor = [UIColor colorWithHex:@"#B8DEFF"];
    [self addSubview:k2View];
    
    [k2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top);
        make.right.equalTo(backView.mas_right);
        make.size.mas_equalTo(CGSizeMake(12, 10));
    }];
    
    // 单边圆角或者单边框
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kSCREEN_WIDTH -10*2, 210-15) byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10,10)];
//    //圆角大小
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = CGRectMake(0, 0, kSCREEN_WIDTH -10*2, 210-15);
//    maskLayer.path = maskPath.CGPath;
//    self.backView.layer.mask = maskLayer;
    
    // ***** top *****
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor colorWithHex:@"#B8DEFF"];
    [backView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(backView);
        make.height.mas_equalTo(39);
    }];
    
    UIImageView *headimgv = [[UIImageView alloc] init];
    headimgv.image = [UIImage imageNamed:@"imageName"];
    headimgv.layer.cornerRadius = 27/2;
    headimgv.layer.masksToBounds = YES;
    [topView addSubview:headimgv];
    _headimgv = headimgv;

    [headimgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.left.equalTo(topView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(27, 27));
    }];


    UILabel *namelab = [[UILabel alloc] init];
    namelab.text = @"-";
    namelab.font = [UIFont systemFontOfSize:13];
    namelab.textColor = [UIColor colorWithHex:@"#367EC9"];
    namelab.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:namelab];
    _namelab = namelab;

    [namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.left.equalTo(headimgv.mas_right).offset(5);
    }];

    UILabel *secretlab = [[UILabel alloc] init];
    secretlab.text = @"-";
    secretlab.layer.cornerRadius = 16/2;
    secretlab.layer.masksToBounds = YES;
    secretlab.font = [UIFont systemFontOfSize:11];
    secretlab.textColor = [UIColor colorWithHex:@"#5DADFF"];
    secretlab.textAlignment = NSTextAlignmentLeft;
    secretlab.backgroundColor = [UIColor whiteColor];
    [topView addSubview:secretlab];
    _secretlab = secretlab;

    [secretlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.left.equalTo(namelab.mas_right).offset(10);
        make.height.mas_equalTo(16);
    }];

    UIView *typeBackView = [[UIView alloc] init];
    typeBackView.backgroundColor = [UIColor colorWithHex:@"#FF870F"];
    typeBackView.layer.cornerRadius = 18/2;
    typeBackView.layer.masksToBounds = YES;
    [topView addSubview:typeBackView];
    _rateView = typeBackView;
    
    [typeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.right.equalTo(topView.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(110, 18));
    }];

    UILabel *typevaluelab = [[UILabel alloc] init];
    typevaluelab.text = @"-";
    typevaluelab.font = [UIFont systemFontOfSize:11];
    typevaluelab.textColor = [UIColor whiteColor];
    typevaluelab.textAlignment = NSTextAlignmentLeft;
    [typeBackView addSubview:typevaluelab];
    _typevaluelab = typevaluelab;

    [typevaluelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(typeBackView.mas_centerY);
        make.left.equalTo(typeBackView.mas_left).offset(8);
    }];

    
    // ***** z *****
    UIView *zzView = [[UIView alloc] init];
    zzView.backgroundColor = [UIColor colorWithHex:@"#F2F9FF"];
    [backView addSubview:zzView];
    [zzView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.right.equalTo(backView);
        make.height.mas_equalTo(30);
    }];

    UIView *zbottomlineView = [[UIView alloc] init];
    zbottomlineView.backgroundColor = [UIColor colorWithHex:@"#B8DEFF"];
    [backView addSubview:zbottomlineView];
    [zbottomlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zzView.mas_bottom);
        make.left.right.equalTo(backView);
        make.height.mas_equalTo(0.5);
    }];

    UILabel *lottery_namelab = [[UILabel alloc] init];
    lottery_namelab.text = @"-";
    lottery_namelab.font = [UIFont boldSystemFontOfSize:14];
    lottery_namelab.textColor = [UIColor colorWithHex:@"#333333"];
    lottery_namelab.textAlignment = NSTextAlignmentLeft;
    [zzView addSubview:lottery_namelab];
    _lottery_namelab = lottery_namelab;

    [lottery_namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(zzView.mas_centerY);
        make.left.equalTo(zzView.mas_left).offset(10);
    }];

    UILabel *lottery_versionlab = [[UILabel alloc] init];
    lottery_versionlab.text = @"-";
    lottery_versionlab.font = [UIFont systemFontOfSize:13];
    lottery_versionlab.textColor = [UIColor colorWithHex:@"#333333"];
    lottery_versionlab.textAlignment = NSTextAlignmentLeft;
    [zzView addSubview:lottery_versionlab];
    _lottery_versionlab = lottery_versionlab;

    [lottery_versionlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(zzView.mas_centerY);
        make.left.equalTo(lottery_namelab.mas_right).offset(5);
    }];

    UIView *tenBackView = [[UIView alloc] init];
    tenBackView.backgroundColor = [UIColor clearColor];
    [zzView addSubview:tenBackView];
    
    [tenBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(zzView.mas_centerY);
        make.left.equalTo(lottery_versionlab.mas_right).offset(10);
        make.right.equalTo(zzView.mas_right).offset(-5);
        make.height.mas_equalTo(18);
    }];

    
    UIStackView *tenRetStackView = [[UIStackView alloc] init];
        tenRetStackView.backgroundColor = [UIColor redColor];
    //子控件的布局方向
    tenRetStackView.axis = UILayoutConstraintAxisHorizontal;
    tenRetStackView.distribution = UIStackViewDistributionFillEqually;
//    tenRetStackView.spacing = 5;
    tenRetStackView.alignment = UIStackViewAlignmentFill;
    tenRetStackView.contentMode = UIViewContentModeScaleToFill;
    //    _playerStackView.frame = CGRectMake(0, 100, ScreenWidth, 200);
    [tenBackView addSubview:tenRetStackView];
    _tenRetStackView = tenRetStackView;
//    [tenBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.right.equalTo(tenBackView);
//    }];

    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"-";
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor colorWithHex:@"#666666"];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:contentLabel];
    _contentLabel = contentLabel;

    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zzView.mas_bottom).offset(10);
        make.left.equalTo(backView.mas_left).offset(10);
        make.right.equalTo(backView.mas_right).offset(-10);
    }];
    
    
    
    UIView *verticalLineView = [[UIView alloc] init];
    verticalLineView.backgroundColor = [UIColor colorWithHex:@"#B8DEFF"];
    [backView addSubview:verticalLineView];
    
    [verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX);
        make.bottom.equalTo(backView.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(1.0, 10));
    }];

    UILabel *bo1Label = [[UILabel alloc] init];
    bo1Label.text = @"-";
    bo1Label.font = [UIFont systemFontOfSize:13];
    bo1Label.textColor = [UIColor colorWithHex:@"#6F7F8E"];
    bo1Label.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:bo1Label];
    _peoplenumlab = bo1Label;
    
    [bo1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX).multipliedBy(0.7);
        make.centerY.equalTo(verticalLineView.mas_centerY);
    }];
    
    UILabel *bo2TitleLabel = [[UILabel alloc] init];
    bo2TitleLabel.text = @"跟单截止";
    bo2TitleLabel.font = [UIFont systemFontOfSize:13];
    bo2TitleLabel.textColor = [UIColor colorWithHex:@"#6F7F8E"];
    bo2TitleLabel.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:bo2TitleLabel];
    
    [bo2TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX).multipliedBy(1.5).offset(-56/2);
        make.centerY.equalTo(verticalLineView.mas_centerY);
        make.width.mas_equalTo(56);
    }];
    
    UILabel *bo2Label = [[UILabel alloc] init];
    bo2Label.text = @"-";
    bo2Label.font = [UIFont systemFontOfSize:13];
    bo2Label.textColor = [UIColor colorWithHex:@"#FF870F"];
    bo2Label.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:bo2Label];
    _endLabel = bo2Label;
    
    [bo2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bo2TitleLabel.mas_right);
        make.centerY.equalTo(verticalLineView.mas_centerY);
    }];
    
    UIView *viewTable = [[UIView alloc] initWithFrame:(CGRect){1, 120, kSCREEN_WIDTH -10*2 - 2, 60}];
    //    UIView *v1 = [[UIView alloc] init];
    [backView addSubview:viewTable];
    _viewTable = viewTable;
    //    [viewTable wzb_drawListWithRect:viewTable.bounds line:4 columns:2 datas:@[@"选号金额", @"单注金额", @"分红比例", @"保障赔率", @"999元", @"2元", @"5%", @"3.5"]];
    
    [viewTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(verticalLineView.mas_top).offset(-10);
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.height.mas_equalTo(60);
    }];
    
    UIView *winView = [[UIView alloc] init];
    winView.backgroundColor = [UIColor clearColor];
    [backView addSubview:winView];
    _postMarkBgView = winView;
    [winView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView.mas_centerY);
        make.right.equalTo(backView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
        
        NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
        if(totoalSecond ==0){
            MBLog(@"totoalSecond %ld====",(long)totoalSecond);
            self.endLabel.text = @"-";
        } else {
            self.endLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr];
        }
    }];
}

-(void)setModel:(PushOrderModel *)model {
    _model = model;
    
    [self.headimgv sd_setImageWithURL:IMAGEPATH(model.heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
    self.namelab.text = model.nickname;
    NSString *fuhao = @"";
    if(self.rateType){
        _rateView.hidden = NO;
    }else{
        _rateView.hidden = YES;
    }
    if(self.rateType == 1||self.rateType == 2){
        fuhao = @"%";
        
    }
    switch (self.rateType) {
        case 1:
        {
            self.typevaluelab.text = [NSString stringWithFormat:@"盈利率:%@%@", model.showRate,@"%"];
        }break;
        case 2:
        {
            self.typevaluelab.text = [NSString stringWithFormat:@"胜率:%@%@", model.showRate,@"%"];
        }break;
        case 3:
        {
            self.typevaluelab.text = [NSString stringWithFormat:@"%@连中", model.showRate];
        }break;
            
        default:
            break;
    }
    

    self.secretlab.text = model.secretStatus == 1 ? @"  跟单后公开  " : @"  开奖后公开  ";
//    self.lottery_playlab.text = model.playName;  // 不知道有没有用
    self.lottery_oddslab.text = model.odds;
    self.lottery_namelab.text = model.lotteryName;
    self.lottery_versionlab.text = [NSString stringWithFormat:@"第%@期",model.issue];
    
    // 表格
//    self.totalpricelab.text = [NSString stringWithFormat:@"%.2f",model.betAmount.floatValue];
//    self.lottery_pricelab.text = [NSString stringWithFormat:@"%.2f",model.betAmount.floatValue];
//    self.addpricelab.text = [NSString stringWithFormat:@"%.2f%@",model.bonusScale,@"%"];
//    self.safelab.text = [NSString stringWithFormat:@"%.2f",model.ensureOdds];
    
    NSString *totalpricelab = [NSString stringWithFormat:@"%.2f",model.betAmount.floatValue];
    NSString *lottery_pricelab = [NSString stringWithFormat:@"%.2f",model.betAmount.floatValue];
    NSString *addpricelab = [NSString stringWithFormat:@"%.2f%@",model.bonusScale,@"%"];
    NSString *safelab = [NSString stringWithFormat:@"%.2f",model.ensureOdds];
    
    //    while (self.viewTable.subviews.count) {
    //        [self.viewTable.subviews.lastObject removeFromSuperview];
    //    }
    [self.viewTable.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.viewTable wzb_drawListWithRect:self.viewTable.bounds line:4 columns:2 datas:@[@"选号金额", @"单注金额", @"分红比例", @"保障赔率", totalpricelab, lottery_pricelab, addpricelab, safelab] colorInfo:@{@"0" : [UIColor colorWithHex:@"333333"], @"1" : [UIColor colorWithHex:@"333333"],@"2" : [UIColor colorWithHex:@"333333"],@"3" : [UIColor colorWithHex:@"333333"],@"4" : [UIColor colorWithHex:@"367EC9"],@"5" : [UIColor colorWithHex:@"367EC9"],@"6" : [UIColor colorWithHex:@"367EC9"],@"7" : [UIColor colorWithHex:@"367EC9"]}];
    
    
    self.peoplenumlab.text = [NSString stringWithFormat:@"%@人已跟单",INTTOSTRING(model.gdCount)];
    self.contentLabel.text = model.godAnalyze;
    for (UIView *vv in _tenRetStackView.subviews) {
        [vv removeFromSuperview];
    }

    NSArray *retArr = [model.lotteryRecord componentsSeparatedByString:@","];
    CGFloat width = _tenRetStackView.frame.size.width;
    
    NSInteger count = retArr.count > 10 ? 10 : retArr.count;
    
    for (int i = 0; i < count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width/10, 30)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
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
        [_tenRetStackView addArrangedSubview:view];
    }
    for (UIView *view in self.postMarkBgView.subviews) {
        [view removeFromSuperview];
    }
    if([model.btState isEqualToString:@"WIN"]||[model.btState isEqualToString:@"NO_WIN"]||[model.btState isEqualToString:@"HE"]){
        Gendan_PostmarkView *pmView = [[[NSBundle mainBundle] loadNibNamed:@"Gendan_PostmarkView" owner:nil options:nil]lastObject];
        if([model.btState isEqualToString:@"WIN"]){
            pmView.code = 2;
            pmView.label.text = [NSString stringWithFormat:@"%@",model.winAmount];
        }else if ([model.btState isEqualToString:@"NO_WIN"]){
            pmView.code = 0;
        }else if ([model.btState isEqualToString:@"HE"]){
            pmView.code = 1;
        }
        
        pmView.frame = CGRectMake(0, 0, 60, 60);
        [self.postMarkBgView addSubview:pmView];
    }else{
        if(model.isRecord){
            Gendan_PostmarkView *pmView = [[[NSBundle mainBundle] loadNibNamed:@"Gendan_PostmarkView" owner:nil options:nil]lastObject];
            pmView.frame = CGRectMake(0, 0, 60, 60);
            pmView.isGendan = model.isRecord;
            [self.postMarkBgView addSubview:pmView];
        }
    }
    
    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    if(model.endTime>now*1000){
        [self startCountDownWithTime:model.endTime/1000];
    } else {
        self.endLabel.text = @"-";
    }
}

+(CGFloat)getHeight:(PushOrderModel *)model {
    
    CGFloat h = [Tools createLableHighWithString:model.godAnalyze andfontsize:14 andwithwidth:SCREEN_WIDTH - 70];
    
    return 220 + h;
}

- (IBAction)forrowAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(dashenForrowOrderAction:)]) {
        [self.delegate dashenForrowOrderAction:self.model];
    }
}
@end
