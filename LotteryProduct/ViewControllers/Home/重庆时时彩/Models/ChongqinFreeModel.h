//
//  ChongqinFreeModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/8.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChongqinFreeListModel;
@class ChongqinFreeListInfoModel;
@interface ChongqinFreeModel : NSObject

@property (nonatomic , assign) NSInteger              ge;
@property (nonatomic , assign) NSInteger              wan;
@property (nonatomic , assign) NSInteger              shi;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , assign) NSInteger              sum;
@property (nonatomic , copy) NSString              * date;
@property (nonatomic , copy) NSString              * dragonTiger;
@property (nonatomic , assign) NSInteger              bai;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , assign) NSInteger              qian;

@property (nonatomic , strong) NSMutableArray<ChongqinFreeListModel *>      * list;

@property (nonatomic , strong) ChongqinFreeListModel *infomodel;

@end



@interface ChongqinFreeListModel : NSObject

@property (nonatomic , strong) ChongqinFreeListInfoModel *model;

@property (nonatomic , strong) NSArray *array;

@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , copy) NSString              * openNumber;

@end

@interface ChongqinFreeListInfoModel : NSObject

@property (nonatomic , copy) NSString              * ballTwoNumber;
@property (nonatomic , copy) NSString              * ballThreeSingle;
@property (nonatomic , copy) NSString              * ballFourNumber;
@property (nonatomic , copy) NSString              * ballFourSize;
@property (nonatomic , copy) NSString              * ballOneSize;
@property (nonatomic , copy) NSString              * ballFiveSize;
@property (nonatomic , copy) NSString              * ballFiveSingle;
@property (nonatomic , copy) NSString              * ballOneSingle;
@property (nonatomic , copy) NSString              * ballThreeNumber;
@property (nonatomic , copy) NSString              * dragonTiger;

@property (nonatomic , copy) NSString              * ballThreeSize;
@property (nonatomic , copy) NSString              * ballFourSingle;
@property (nonatomic , copy) NSString              * ballTwoSize;
@property (nonatomic , copy) NSString              * ballTwoSingle;
@property (nonatomic , copy) NSString              * ballOneNumber;
@property (nonatomic , copy) NSString              * ballFiveNumber;
@end


