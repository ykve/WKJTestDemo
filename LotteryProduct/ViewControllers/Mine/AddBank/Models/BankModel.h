//
//  BankModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/9.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankModel : NSObject

@property (nonatomic , copy) NSString              * account;
@property (nonatomic , copy) NSString              * withdrawDepositTimes;
@property (nonatomic , copy) NSString              * realName;
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              deleted;
@property (nonatomic , copy) NSString              * bank;
@property (nonatomic , copy) NSString              * cardNumber;
@property (nonatomic , assign) NSInteger              memberId;
@property (nonatomic , copy) NSString              * icon;
@property (nonatomic , copy) NSString              * bindTime;
@property (nonatomic , copy) NSString              * banktype;
@end
