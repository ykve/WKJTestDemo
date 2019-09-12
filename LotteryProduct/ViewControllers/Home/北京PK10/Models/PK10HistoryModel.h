//
//  PK10HistoryModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/3.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Numbers;

@interface PK10HistoryModel : NSObject

@property (nonatomic , copy) NSString              * time;
@property (nonatomic , strong) NSArray<NSNumber *>              * num;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , copy) NSString              * date;
@property (nonatomic , copy) NSString              * number;
@property (nonatomic , strong) NSArray<NSString *>    *bigorsmallArray;
@property (nonatomic , strong) NSArray<NSString *>    *sigleordoubleArray;


@property (nonatomic , copy) NSString *total;
@property (nonatomic , copy) NSString *bigorsmall;
@property (nonatomic , copy) NSString *signleordouble;
@property (nonatomic , strong) NSArray<NSString *>    *longhuArray;
@property (nonatomic , strong) NSArray<Numbers *> *numberArray;
@end

@interface Numbers:NSObject

@property (nonatomic, assign)NSInteger num;

@property (nonatomic, assign)BOOL isselect;

@end


