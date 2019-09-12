//
//  PK10HotCoolModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PK10HotCoolModel : NSObject

@property (nonatomic, copy) NSString *number;
@property (nonatomic, strong)NSMutableArray *hotArray;
@property (nonatomic, strong)NSMutableArray *warmthArray;
@property (nonatomic, strong)NSMutableArray *coolArray;
@end
