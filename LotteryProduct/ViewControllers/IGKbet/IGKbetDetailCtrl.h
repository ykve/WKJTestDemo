//
//  IGKbetDetailCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/16.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"
#import "PCHistoryModel.h"
#import "PK10HistoryModel.h"
#import "PCInfoModel.h"
@interface IGKbetDetailCtrl : RootCtrl

@property (nonatomic, strong)SixInfoModel *sixmodel;
@property (nonatomic, strong)PCHistoryModel *pcmodel;
@property (nonatomic, strong)PK10HistoryModel *pk10model;
@property (nonatomic, strong)LotteryInfoModel *lotteryInfoModel;
@property (assign,nonatomic) CPTBuyTicketType type;

@property (nonatomic, copy) NSString *lotteryname;
@end
