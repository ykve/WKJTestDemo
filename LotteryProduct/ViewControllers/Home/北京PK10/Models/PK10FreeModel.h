//
//  PK10FreeModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/7.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PK10FreeDataModel;

@interface PK10FreeModel : NSObject

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *issue;
@property (nonatomic, strong) NSArray<PK10FreeDataModel *> *datas;
@end

@interface PK10FreeDataModel : NSObject
@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *numbers;
@property (nonatomic, copy) NSString *singleordouble;
@property (nonatomic, copy) NSString *bigorsmall;


@end
