//
//  CartChongqinModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/10.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartChongqinModel : NSObject

@property (nonatomic, strong) NSArray *numbers;

@property (nonatomic, strong) NSMutableArray *selectnumbers;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger segmenttype;

@property (nonatomic, strong) NSDictionary *missdata;
/**
 YES:组选
 NO:直选
 */
@property (nonatomic, assign) BOOL isgroup;
/**
 1：1重号
 2：2重号
 3：3重号
 4：4重号
 5：5重号
 */
@property (nonatomic, assign) NSInteger same;
@end
