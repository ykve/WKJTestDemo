//
//  CPTBuyHomeCtrlViewController.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/22.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CPTBuyHomeType)//彩种
{
    CPTBuyHomeType_QiPai=0,
    CPTBuyHomeType_ZhenRenShiXun=1,
    CPTBuyHomeType_ZuCai=2,
    CPTBuyHomeType_DianJing=3
};
@interface CPTBuyHomeCtrl : UIViewController
@property(nonatomic,assign) CPTBuyHomeType type;
@end

NS_ASSUME_NONNULL_END
