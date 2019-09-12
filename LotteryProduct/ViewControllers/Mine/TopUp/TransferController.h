//
//  TransferController.h
//  LotteryProduct
//
//  Created by pt c on 2019/7/19.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPTPayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TransferController : UIViewController

/// 充值渠道ID
@property (nonatomic, strong) CPTPayModel *payModel;
@property (nonatomic, copy) NSString *rechargeMoney;


@end

NS_ASSUME_NONNULL_END
