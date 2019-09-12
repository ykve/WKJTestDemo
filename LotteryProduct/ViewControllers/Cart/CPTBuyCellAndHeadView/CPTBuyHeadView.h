//
//  CalculateView.h
//  BuyLotteryBanner
//
//  Created by 研发中心 on 2018/12/28.
//  Copyright © 2018 研发中心. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NiuWinLabel.h"
#import "CPTCountDownLabel.h"
#import "MSWeakTimer.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CPTBuyHeadViewDelegate <NSObject>
- (void)clickDownBtn:(NSInteger)clickTimes;
- (void)addmoneyClick;
- (void)showStopView;
- (void)tapRightView;
- (void)dismissStopView;
- (void)reFmoneyClick;

@end
@interface CPTBuyHeadView : UIView

@property (assign,nonatomic) CPTBuyTicketType type;
@property (nonatomic, assign) NSInteger lotteryId;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, assign) NSInteger endTime;//封盘时间
@property (weak, nonatomic) IBOutlet CPTCountDownLabel *endTimeLabel;//截止/封盘时间
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *nextDateL;
@property (weak, nonatomic) IBOutlet UIView *hourView;
@property (weak, nonatomic) IBOutlet UILabel *hourL;



@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *currentDateL;

@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIImageView *downIV;
@property (weak, nonatomic) IBOutlet UILabel *moneyL;

@property (weak, nonatomic) id<CPTBuyHeadViewDelegate>delegate;
@property (assign, nonatomic) NSInteger clickTimes;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tanfanLabelTopSpace;
@property (weak, nonatomic) IBOutlet UILabel *fantanLabel;
@property (weak, nonatomic) IBOutlet UIView *niuWinBgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *speakerBtn;
@property (copy, nonatomic) NSString *issue;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *lineFLabel;
@property (assign, nonatomic) long long finishLongLongTime ;
@property (strong, nonatomic)  MSWeakTimer *timer;;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

- (void)destroyTimer;


- (void)checkMoney;
- (void)removeNSNotification;
- (void)changeBallState:(BOOL)isPaile5;//p3 p5直选 开奖结果球的状态改变
- (void)configUIByData;
-(void)historyData;
@end

NS_ASSUME_NONNULL_END
