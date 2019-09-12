//
//  PCInfoModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/2.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LastSg;

@interface PCInfoNewModel : NSObject

@property (nonatomic , copy) NSString * number;
@property (nonatomic , copy) NSString * issue;
@property (nonatomic , copy) NSString * niuWinner;

@end

//新增彩种model
@interface LotteryInfoModel:NSObject
@property (nonatomic , copy) NSString              * nextIssue;
@property (nonatomic , copy) NSString              * number;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , copy) NSString              * niuWinner;
@property (nonatomic, copy) NSString                * openCount;
@property (nonatomic, copy) NSString                * noOpenCount;
@property (nonatomic, copy) NSString                * time;
@property (nonatomic , assign) NSInteger             nextTime;
@end


@interface PCInfoModel : NSObject

@property (nonatomic , strong) LastSg              * lastSg;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , assign) NSInteger              surplus;
@property (nonatomic , assign) NSInteger               time;
@property (nonatomic , assign) NSString            * nextIssue;
@end

@interface LastSg :NSObject
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * number;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , copy) NSString              * time;


@property (nonatomic , copy) NSString              * bigOrSmall;
@property (nonatomic , copy) NSString              * singleOrDouble;
@property (nonatomic , assign) NSInteger              sum;
@end


@interface SixInfoModel:NSObject
@property (nonatomic , copy) NSString              * numberstr;

@property (nonatomic , copy) NSString              * nextIssue;
@property (nonatomic , copy) NSString               * number;
@property (nonatomic , assign) NSInteger              nextOpenTime;
@property (nonatomic , copy) NSString              * shengxiao;
@property (nonatomic , copy) NSString              * shengxiao2;

@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , assign) NSInteger              nextTime;
@property (nonatomic , copy) NSString              * time;
@end

@interface ChongqinInfoModel:NSObject

@property (nonatomic , strong) NSArray             * numbers;
@property (nonatomic , copy) NSString              * number;
@property (nonatomic , copy) NSString              * numberstr;

@property (nonatomic , assign) NSInteger              nextTime;
@property (nonatomic , copy) NSString              * nextIssue;
@property (nonatomic , assign) NSInteger              noOpenCount;
@property (nonatomic , copy) NSString              * todayTime;
@property (nonatomic , assign) NSInteger              openCount;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , copy) NSString              * niuWinner;

@property (nonatomic , assign) NSInteger              he;

@end

@interface PK10InfoModel:NSObject

@property (nonatomic , copy) NSString              * number;
@property (nonatomic , assign) NSInteger               nextTime;
@property (nonatomic , assign) NSInteger              nextIssue;
@property (nonatomic , assign) NSInteger              noOpenCount;
@property (nonatomic , copy) NSString              * todayTime;
@property (nonatomic , assign) NSInteger              openCount;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , copy) NSString              * niuWinner;


@end

@interface ZuCaiInfoModel:NSObject

@property (nonatomic , copy) NSString              * number;
@property (nonatomic , assign) NSInteger               nextTime;
@property (nonatomic , assign) NSInteger              nextIssue;
@property (nonatomic , assign) NSInteger              noOpenCount;
@property (nonatomic , copy) NSString              * todayTime;
@property (nonatomic , assign) NSInteger              openCount;
@property (nonatomic , copy) NSString              * issue;

@end

