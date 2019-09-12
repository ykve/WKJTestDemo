//
//  PCHistoryModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/1.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCHistoryModel : NSObject

@property (nonatomic , copy) NSString              * number;
@property (nonatomic , copy) NSString              * bigOrSmall;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , copy) NSString              * singleOrDouble;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , assign) NSInteger              sum;
@property (nonatomic , assign) NSInteger              he;
@end
