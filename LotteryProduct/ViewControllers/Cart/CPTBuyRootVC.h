//
//  CPTBuyRootVC.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/5/21.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQMenuShowView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPTBuyRootVC : RootCtrl
@property (nonatomic, assign) NSInteger lotteryId;
@property (nonatomic, strong) SQMenuShowView *showView;
@property(assign,nonatomic)CPTBuyTicketType  type;

- (void)showChatVC;
- (void)loadVC:(UIViewController *)vc title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
