//
//  RecordModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/30.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordModel : NSObject

@property (nonatomic , copy) NSNumber              * ID;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , assign) CGFloat              amount;
/// 充值状态 1成功2失败3等待支付   |   提现状态 1.待处理2.处理中3.拒绝4.成功
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * remark;

// ***** 账变记录使用 ****
/// 变动金额
@property (nonatomic , assign) CGFloat              money;
/// 钱包余额
@property (nonatomic , assign) double              balance;
/// 类型
@property (nonatomic , copy) NSString              * type;







@property (nonatomic , copy) NSString              * title;



@end
