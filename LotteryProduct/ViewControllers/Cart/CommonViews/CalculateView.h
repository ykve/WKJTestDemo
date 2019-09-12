//
//  CalculateView.h
//  BuyLotteryBanner
//
//  Created by 研发中心 on 2018/12/28.
//  Copyright © 2018 研发中心. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalculateView : UIView

@property (nonatomic, assign)CGFloat baseMoney;
@property (nonatomic, assign)CGFloat multiNum;


@property (nonatomic, strong)NSArray *moneyArray;

@property (nonatomic, strong)NSArray *multiArray;


@property (nonatomic, strong)UIView *fatherView;

@property (nonatomic, assign)CGFloat totalMoney;




@end

NS_ASSUME_NONNULL_END
