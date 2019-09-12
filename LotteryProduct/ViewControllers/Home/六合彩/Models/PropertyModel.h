//
//  PropertyModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/12.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyModel : NSObject

@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, copy) NSString *title;

/**
 家禽野兽内容
 */
@property (nonatomic, copy) NSMutableString *contentstring;
@end
