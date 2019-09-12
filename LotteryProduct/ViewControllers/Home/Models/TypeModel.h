//
//  TypeModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/31.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) BOOL selected;

@end
