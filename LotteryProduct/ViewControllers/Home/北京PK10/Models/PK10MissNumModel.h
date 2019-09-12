//
//  PK10MissNumModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NumValue;
@interface PK10MissNumModel : NSObject

@property (nonatomic , copy) NSString              * type;
@property (nonatomic , strong) NSArray<NumValue *>              * value;

@end

@interface NumValue :NSObject
@property (nonatomic , assign) NSInteger              num;
@property (nonatomic , assign) NSInteger              noOpen;
@property (nonatomic , assign) NSInteger              open;

@end
