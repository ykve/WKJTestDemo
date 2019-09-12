//
//  BaseData.h
//  GetSawProduct
//
//  Created by vsskyblue on 2017/11/16.
//  Copyright © 2017年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseData : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, strong) id data;

@property (nonatomic, assign) double time;

@end
