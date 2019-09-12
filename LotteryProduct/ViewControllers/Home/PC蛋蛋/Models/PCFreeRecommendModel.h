//
//  PCFreeRecommendModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PCInfoModel.h"
@class LastRecommend;
@class List;
@interface PCFreeRecommendModel : NSObject

@property (nonatomic , strong) LastSg              * lastSg;
@property (nonatomic , strong) LastRecommend              * lastRecommend;
@property (nonatomic , strong) NSArray<List *>              * list;
@property (nonatomic , assign) NSInteger              total;
@end

@class PceggLotterySg;
@class PceggRecommend;
@interface List :NSObject
@property (nonatomic , strong) PceggLotterySg              * pceggLotterySg;
@property (nonatomic , strong) PceggRecommend              * pceggRecommend;

@end

@interface PceggRecommend :NSObject
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * regionOneNumber;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , copy) NSString              * regionTwoSingle;
@property (nonatomic , copy) NSString              * regionOneSingle;
@property (nonatomic , copy) NSString              * regionTwoSize;
@property (nonatomic , copy) NSString              * regionThreeSingle;
@property (nonatomic , copy) NSString              * regionThreeNumber;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * regionOneSize;
@property (nonatomic , copy) NSString              * regionThreeSize;
@property (nonatomic , copy) NSString              * regionTwoNumber;

@end

@interface PceggLotterySg :NSObject
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * number;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , copy) NSString              * time;

@end

@interface LastRecommend :NSObject
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * regionOneNumber;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , copy) NSString              * regionTwoSingle;
@property (nonatomic , copy) NSString              * regionOneSingle;
@property (nonatomic , copy) NSString              * regionTwoSize;
@property (nonatomic , copy) NSString              * regionThreeSingle;
@property (nonatomic , copy) NSString              * regionThreeNumber;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * regionOneSize;
@property (nonatomic , copy) NSString              * regionThreeSize;
@property (nonatomic , copy) NSString              * regionTwoNumber;

@end

