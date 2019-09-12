//
//  PCResultModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/2.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCResultModel : NSObject

@property (nonatomic , copy) NSString              * number;
@property (nonatomic , copy) NSString              * bigOrSmall;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * leopard;
@property (nonatomic , copy) NSString              * singleOrDouble;
@property (nonatomic , copy) NSString              * limitValue;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , assign) NSInteger              sum;

@property (nonatomic , assign) NSInteger              before10;
@property (nonatomic , assign) NSInteger              before30;
@property (nonatomic , assign) NSInteger              before50;
@property (nonatomic , assign) NSInteger              before100;
@property (nonatomic , copy) NSString               * waiting;
@end
