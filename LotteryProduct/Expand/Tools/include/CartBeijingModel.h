//
//  CartBeijingModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/10.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartOddsModel.h"

@interface CartBeijingModel : NSObject

@property (nonatomic, strong) NSArray *numbers;

@property (nonatomic, strong) NSMutableArray *selectnumbers;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger segmenttype;

@property (nonatomic, strong) NSDictionary *missdata;

@property (nonatomic, strong) NSMutableArray <OddsList *> *odds;

@end

