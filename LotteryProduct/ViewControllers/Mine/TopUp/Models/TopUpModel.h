//
//  TopUpModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/12.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopUpModel : NSObject



@property (nonatomic, copy) NSString *price;
@property (nonatomic, assign)BOOL status;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *mId;
@property (nonatomic, copy) NSString *isDel;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *rechargeAccountId;

@end
