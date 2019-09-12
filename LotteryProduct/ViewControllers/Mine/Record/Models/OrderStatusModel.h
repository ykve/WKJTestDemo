//
//  OrderStatusModel.h
//  LotteryProduct
//
//  Created by pt c on 2019/7/22.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderStatusModel : NSObject

/// 实际支付金额
@property (nonatomic, assign) CGFloat actualAmount;
/// 订单金额
@property (nonatomic, assign) CGFloat amount;

/// 时间数组  时间 startTime 开始 estimateTime 预计 endTime 完成
@property (nonatomic, strong) NSDictionary *timeList;
/// 充值： 1成功2失败3等待支付   |   提现： 状态 1.待处理 2.处理中 3.拒绝 4.成功
@property (nonatomic, assign) NSInteger status;
/// 支付方式 1：支付宝转银行卡；2：微信转银行卡；3：银行卡转银行卡 4 线上充值  5 人工
@property (nonatomic, assign) NSInteger type;
/// 订单号
@property (nonatomic, copy) NSString *orderNo;
/// 备注
@property (nonatomic, copy) NSString *remark;
/// 附言
@property (nonatomic, assign) NSInteger postScript;


// *** 提现专有 ***
/// 提现方式
@property (nonatomic, copy) NSString *payType;
/// 收款银行
@property (nonatomic, copy) NSString *bank;
/// 卡号
@property (nonatomic, copy) NSString *cardNumber;
/// 姓名
@property (nonatomic, copy) NSString *account;


@end

NS_ASSUME_NONNULL_END
