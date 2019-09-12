//
//  CPTBuyPickMoneyView.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/25.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPTBuyPickMoneyView : UIView
@property(nonatomic, copy) void (^clickBlock)(NSInteger money);

- (void)configUIWith:(void (^)(NSInteger money))click;
- (void)brokeBlock;
@end

NS_ASSUME_NONNULL_END
