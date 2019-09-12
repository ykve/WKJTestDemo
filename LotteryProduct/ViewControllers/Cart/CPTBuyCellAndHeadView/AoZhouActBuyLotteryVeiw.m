//
//  AoZhouActBuyLotteryVeiw.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "AoZhouActBuyLotteryVeiw.h"
#import "AoZhouACTButton.h"
#import "CPTSixModel.h"

@interface AoZhouActBuyLotteryVeiw ()

@property (nonatomic, strong) NSMutableArray *oddsArray;

@property (nonatomic, assign)int randomNum;

@property (nonatomic, strong) NSMutableArray *selectButtons;



@end

@implementation AoZhouActBuyLotteryVeiw

- (void)awakeFromNib{
    [super awakeFromNib];
    
    for (AoZhouACTButton *btn in self.numberBtns) {
        btn.isselected = NO;
    }
    
    NSDictionary * plistDic = [[CPTBuyDataManager shareManager] configOtherDataByTicketType:CPTBuyTicketType_AoZhouACT];
    if([plistDic.allKeys containsObject:@"oddsList"]){
        NSArray *oddsList = [plistDic objectForKey:@"oddsList"];
        for (NSDictionary *dic in oddsList) {
            CPTBuyBallModel *model = [[CPTBuyBallModel alloc] init];
            model.subTitle = dic[@"odds"];
            model.title = dic[@"name"];
            model.settingId = [dic[@"settingId"] integerValue];
            [self.oddsArray addObject:model];
        }
        if (self.oddsArray.count < self.numberBtns.count) {
            return;
        }
        
        for (AoZhouACTButton *btn in self.numberBtns) {
            CPTBuyBallModel *model = self.oddsArray[btn.tag - 10];
            btn.model = model;
        }

    }
    
}

-(void)getRandomBtn
{
    [self deleteSelectBtns];
    
    self.randomNum = 10 + arc4random() % 14;
    CPTBuyBallModel *model;
    for (AoZhouACTButton *btn in self.numberBtns) {
        if (btn.tag == self.randomNum) {
            btn.isselected = YES;
            btn.titleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnTitleSelectColor];
            btn.backgroundColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnSelectBackgroundColor];
            btn.subTitleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnSelectSubtitleColor];
            model = self.oddsArray[btn.tag - 10];
            model.selected = YES;
            [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:model];
            [self.selectButtons addObject:btn];
        }
    }
    if ([self.delegate respondsToSelector:@selector(lotteryClickAction)]) {
        [self.delegate lotteryClickAction];
    }
}

- (void)deleteSelectBtns{
    
    CPTBuyBallModel *model;

    for (AoZhouACTButton *btn in self.selectButtons) {
        btn.isselected = NO;
        btn.titleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnTitleNormalColor];
        btn.backgroundColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnNormalBackgroundColor];
        btn.subTitleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnNormalSubtitleColor];
//        btn.layer.borderColor = btn.backgroundColor.CGColor;
        model = self.oddsArray[btn.tag - 10];
        model.selected = NO;
        [[CPTBuyDataManager shareManager] removeBallModelFromTmpCartArray:model];
    }
    [self.selectButtons removeAllObjects];
    
    if ([self.delegate respondsToSelector:@selector(lotteryClickAction)]) {
        [self.delegate lotteryClickAction];
    }

}

- (IBAction)clickBtn:(AoZhouACTButton *)sender {
    
    if (self.oddsArray.count < self.numberBtns.count) {
        return;
    }
    sender.isselected = sender.isselected ? NO : YES;

    CPTBuyBallModel *model = self.oddsArray[sender.tag - 10];

    if (sender.isselected) {
        sender.titleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnTitleSelectColor];
        sender.backgroundColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnSelectBackgroundColor];
        sender.subTitleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnSelectSubtitleColor];
//        sender.layer.borderColor = [UIColor colorWithHex:@"FFFFFF"].CGColor;
//        sender.layer.borderWidth = 1;
        model.selected = YES;
        [self.selectButtons addObject:sender];
        [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:model];

    }else{
        sender.titleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnTitleNormalColor];
        sender.backgroundColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnNormalBackgroundColor];
        sender.subTitleLbl.textColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnNormalSubtitleColor];
        model.selected = NO;
//        sender.layer.borderColor = sender.backgroundColor.CGColor;
        [self.selectButtons removeObject:sender];
        [[CPTBuyDataManager shareManager] removeBallModelFromTmpCartArray:model];
    }
    if ([self.delegate respondsToSelector:@selector(lotteryClickAction)]) {
        [self.delegate lotteryClickAction];
    }

}

- (NSMutableArray *)oddsArray{
    if (!_oddsArray) {
        _oddsArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _oddsArray;
}

- (NSMutableArray *)selectButtons{
    if (!_selectButtons) {
        _selectButtons = [NSMutableArray array];
    }
    return _selectButtons;
}


@end
