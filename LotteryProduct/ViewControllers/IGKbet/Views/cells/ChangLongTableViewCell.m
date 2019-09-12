//
//  ChangLongTableViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/7.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "ChangLongTableViewCell.h"
#import "OpenLotteryChangLongButton.h"
#import "CountDown.h"
#import "CPTSixModel.h"

@interface ChangLongTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *issueLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *kindLbl;
@property (weak, nonatomic) IBOutlet UILabel *resultLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalChanglongLbl;

@property (weak, nonatomic) IBOutlet OpenLotteryChangLongButton *rightBtn;

@property (weak, nonatomic) IBOutlet OpenLotteryChangLongButton *leftBtn;

@property (nonatomic, strong) NSMutableArray *bottomBtns;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *lastLbl;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWeith;


@end


@implementation ChangLongTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bottomLine.backgroundColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:0.2];
    self.backView.backgroundColor = CLEAR;
    self.titleLbl.textColor = [[CPTThemeConfig shareManager] ChangLongTitleColor];
    self.kindLbl.textColor = [[CPTThemeConfig shareManager] ChangLongKindLblTextColor];
    self.resultLbl.textColor = [[CPTThemeConfig shareManager] ChangLongResultLblColor];
    self.issueLbl.textColor = [[CPTThemeConfig shareManager] ChangLongIssueTextColor];
    self.timeLbl.textColor = [[CPTThemeConfig shareManager] ChangLongTimeLblColor]; 
    self.totalChanglongLbl.textColor = [[CPTThemeConfig shareManager] ChangLongTotalLblColor];
    self.kindLbl.layer.borderWidth = 1;
    self.kindLbl.layer.borderColor = [[CPTThemeConfig shareManager] ChangLongLblBorderColor].CGColor;
    self.totalChanglongLbl.layer.borderWidth = 1;
    self.totalChanglongLbl.layer.borderColor = [[CPTThemeConfig shareManager] ChangLongLblBorderColor].CGColor;

    self.resultLbl.layer.borderWidth = 1;
    self.resultLbl.layer.borderColor = [[CPTThemeConfig shareManager] ChangLongLblBorderColor].CGColor;

    self.kindLbl.layer.masksToBounds = YES;
    self.kindLbl.layer.cornerRadius = 4;
    self.resultLbl.layer.masksToBounds = YES;
    self.resultLbl.layer.cornerRadius = 4;
    self.totalChanglongLbl.layer.masksToBounds = YES;
    self.totalChanglongLbl.layer.cornerRadius = 4;
     self.timeLbl.text = @"00:00";
    self.lastLbl.hidden = YES;
    self.btnWeith.constant = self.btnHeight.constant = 50/SCAL;
 
    for (int i  = 0; i <  15; i ++) {
        
        CGFloat w = 23;
        CGFloat h = 5;
        CGFloat margin = (SCREEN_WIDTH - 15 * w)/14;
        CGFloat x = (w + margin)*i;
        CGFloat y = self.height - 6;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
        
        [btn setImage:IMAGE([[CPTThemeConfig shareManager] bottomDefaultImageName]) forState:UIControlStateNormal];
        btn.tag = i;
        [self.bottomBtns addObject:btn];
        [self.contentView addSubview:btn];
    }
    
   

}

- (void)setModel:(ChangLongModel *)model{
    _model = model;
    if(_countDownForLabel){
        [_countDownForLabel destoryTimer];
    }
    
    [self configTimer:[model.nextTime longLongValue]];
    
    self.titleLbl.text = model.type;
    self.issueLbl.text = [NSString stringWithFormat:@"%@期", model.nextIssue];
    self.kindLbl.text = [NSString stringWithFormat:@" %@ ", model.playType];
    self.resultLbl.text = [NSString stringWithFormat:@" %@ ",model.dragonType];
    self.totalChanglongLbl.text = [NSString stringWithFormat:@" %@期 ", model.dragonSum];
    
    if (model.playType.length + model.dragonType.length > 9) {
        self.lastLbl.text = [NSString stringWithFormat:@"%@期", model.dragonSum];
        self.totalChanglongLbl.hidden = YES;
        self.lastLbl.hidden = NO;
    }
    
    NSString *leftTitle = model.odds[0][@"playTypeName"];
    NSString *rightTitle = model.odds[1][@"playTypeName"];
    
    self.leftBtn.titleLbl.text = leftTitle;
    self.rightBtn.titleLbl.text = rightTitle;
    self.leftBtn.selected = self.model.leftSelect;
    self.rightBtn.selected = self.model.rightSelect;
    
    if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
        NSString *imagename = [NSString stringWithFormat:@"%@",model.type];

        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            imagename = [NSString stringWithFormat:@"tw_%@",imagename];
        }
        self.icon.image = IMAGE(imagename);
    } else{
        self.icon.image = IMAGE(model.type);
    }
    
    NSDictionary * plistDic = [[CPTBuyDataManager shareManager] configOtherDataByTicketType:[model.typeId intValue]];
    if([plistDic.allKeys containsObject:@"oddsList"]){
        NSArray *oddsList = [plistDic objectForKey:@"oddsList"];
        if([oddsList isKindOfClass:[NSString class]]){
            return;
        }
        for (NSDictionary *dic in oddsList) {
            
            NSString *leftrPlayTypeId = [NSString stringWithFormat:@"%@", model.odds[0][@"playTypeId"]];
            NSString *dicId = [NSString stringWithFormat:@"%@", dic[@"id"]];
            
            NSString *rightPlayTypeId = [NSString stringWithFormat:@"%@", model.odds[1][@"playTypeId"]];

            if ([dicId isEqualToString:leftrPlayTypeId]) {
                
                CPTBuyBallModel *ballModel = [[CPTBuyBallModel alloc] init];
                ballModel.ID = model.typeId;
                ballModel.subTitle = dic[@"odds"];
                ballModel.title = dic[@"name"];
                ballModel.settingId = [dic[@"settingId"] integerValue];
                self.leftBtn.subTitleLbl.text = [NSString stringWithFormat:@"赔%@",ballModel.subTitle];
                self.leftModel = ballModel;
            }else if([dicId isEqualToString:rightPlayTypeId]){
                CPTBuyBallModel *ballModel = [[CPTBuyBallModel alloc] init];
                ballModel.ID = model.typeId;
                ballModel.subTitle = dic[@"odds"];
                ballModel.title = dic[@"name"];
                ballModel.settingId = [dic[@"settingId"] integerValue];
                self.rightBtn.subTitleLbl.text = [NSString stringWithFormat:@"赔%@",ballModel.subTitle];
                self.rightModel = ballModel;
            }
        }
    }
    if(!self.leftModel){
        NSDictionary *dic = model.odds[0];
        CPTBuyBallModel *ballModel = [[CPTBuyBallModel alloc] init];
        ballModel.ID = model.typeId;
        ballModel.subTitle = @"2.0";
        ballModel.title = dic[@"playTypeName"];
        ballModel.settingId = [dic[@"settingId"] integerValue];
        self.leftBtn.subTitleLbl.text = [NSString stringWithFormat:@"赔%@",ballModel.subTitle];
        self.leftModel = ballModel;
    }
    if(!self.rightModel){
        NSDictionary *dic = model.odds[1];
        CPTBuyBallModel *ballModel = [[CPTBuyBallModel alloc] init];
        ballModel.ID = model.typeId;
        ballModel.subTitle = @"2.0";
        ballModel.title = dic[@"playTypeName"];
        ballModel.settingId = [dic[@"settingId"] integerValue];
        self.rightBtn.subTitleLbl.text = [NSString stringWithFormat:@"赔%@",ballModel.subTitle];
        self.rightModel = ballModel;
    }
 
    if ([model.dragonSum intValue] < 15) {
        
        for (int i = 0; i < [model.dragonSum intValue]; i ++) {
            UIButton *btn = self.bottomBtns[i];
            [btn setImage:IMAGE([[CPTThemeConfig shareManager] OpenLotteryBottomNormalImage]) forState:UIControlStateNormal];
        }
        
        for (UIButton *btn in self.bottomBtns) {
            
            if (btn.tag >= [model.dragonSum intValue]) {
                [btn setImage:IMAGE([[CPTThemeConfig shareManager] bottomDefaultImageName]) forState:UIControlStateNormal];
            }
            
        }
    }else{
        for (UIButton *btn in self.bottomBtns) {
            [btn setImage:IMAGE([[CPTThemeConfig shareManager] OpenLotteryBottomNFullImage]) forState:UIControlStateNormal];
        }
    }
}


- (IBAction)clickAction:(OpenLotteryChangLongButton *)sender {
    sender.selected = sender.selected ? NO : YES;
    if (sender.selected) {

        if (sender.tag == 10) {
            self.model.leftSelect = YES;
            self.leftModel.modelLocation = [NSIndexPath indexPathForRow:0 inSection:self.indexPath.row];
            if ([self.delegate respondsToSelector:@selector(addLotteryModel:)]) {
                [self.delegate addLotteryModel:self.leftModel];
            }
        }else{
            self.model.rightSelect = YES;
            self.rightModel.modelLocation = [NSIndexPath indexPathForRow:1 inSection:self.indexPath.row];
            if ([self.delegate respondsToSelector:@selector(addLotteryModel:)]) {
                [self.delegate addLotteryModel:self.rightModel];
            }
        }

    }else{

        if (sender.tag == 10) {
            self.model.leftSelect = NO;
            if ([self.delegate respondsToSelector:@selector(removeLotteryModel:)]) {
                [self.delegate removeLotteryModel:self.leftModel];
            }
        }else{
            self.model.rightSelect = NO;
            if ([self.delegate respondsToSelector:@selector(removeLotteryModel:)]) {
                [self.delegate removeLotteryModel:self.rightModel];
            }
        }

    }
}

- (void)configTimer:(long long)finishLongLong{
    
    @weakify(self)
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    [self.countDownForLabel countDownWithStratTimeStamp:now finishTimeStamp:finishLongLong completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        @strongify(self)
        NSString * hourS;
        NSString * minS;
        NSString * secondS;
        
        if (hour<10) {
            hourS = [NSString stringWithFormat:@"0%ld",(long)hour];
        }else{
            hourS = [NSString stringWithFormat:@"%ld",(long)hour];
        }
        if (minute<10) {
            minS = [NSString stringWithFormat:@"0%ld",(long)minute];
        }else{
            minS = [NSString stringWithFormat:@"%ld",(long)minute];
        }
        if (second<10) {
            secondS = [NSString stringWithFormat:@"0%ld",(long)second];
        }else{
            secondS = [NSString stringWithFormat:@"%ld",(long)second];
        }
        
        if([hourS integerValue]<=0){
            self.timeLbl.text = [NSString stringWithFormat:@"%@:%@",minS,secondS];
        }else{
            self.timeLbl.text = [NSString stringWithFormat:@"%@:%@:%@",hourS,minS,secondS];
        }
        NSInteger totoalSecond = minute*60+second;
        
        if (totoalSecond <= 5) {
            self.leftBtn.enabled = NO;
            self.rightBtn.enabled = NO;
            self.leftBtn.backgroundColor = [[CPTThemeConfig shareManager] changLongEnableBtnBackgroundColor];
            self.rightBtn.backgroundColor = [[CPTThemeConfig shareManager] changLongEnableBtnBackgroundColor];
        }else{

            if (totoalSecond != 0) {
                self.leftBtn.enabled = YES;
                self.rightBtn.enabled = YES;
            }
          
        }
        
        if(totoalSecond ==0){
            self.timeLbl.text = @"开奖中";
        }
        
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (NSMutableArray *)bottomBtns{
    if (!_bottomBtns) {
        _bottomBtns = [NSMutableArray arrayWithCapacity:5];
    }
    return _bottomBtns;
}

- (CountDown *)countDownForLabel{
    if (!_countDownForLabel) {
        _countDownForLabel = [[CountDown alloc] init];
    }
    return _countDownForLabel;
}
@end
