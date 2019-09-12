//
//  ForrowModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/26.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForrowModel : NSObject

@property (nonatomic , copy) NSString              * lotteryName;
@property (nonatomic , copy) NSString              * betNumber;
@property (nonatomic , copy) NSString              * playName;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSNumber              * betAmount;
@property (nonatomic , copy) NSString              * date;
@property (nonatomic , copy) NSNumber              * winAmount;
@property (nonatomic , copy) NSNumber              * bonusAmount;

@end
