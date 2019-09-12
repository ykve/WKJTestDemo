//
//  CartSixModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/10.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartSixModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong)NSArray *array;
@property (nonatomic, assign)BOOL select;
@property (nonatomic, copy) NSString *odds;
/**
   单个球当做对象
 */
@property (nonatomic, copy) NSString *number;

@end
