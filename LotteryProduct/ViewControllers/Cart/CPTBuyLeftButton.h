//
//  CPTBuyLeftButton.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface CPTBuyLeftButton : UIButton
@property(nonatomic, strong) CPTSixPlayTypeModel * model;
@property (nonatomic, strong) NSMutableArray<CPTSixPlayTypeModel*>* rightModels;
@property (nonatomic, strong) NSMutableArray<CPTBuyBallModel*>* selectModels;

@property (nonatomic, strong) UIView *pointView;
@property (nonatomic , assign) NSInteger ID;

- (void)configUI;
- (void)showSelPoint;
- (void)showUnSelPoint;
- (BOOL)checkPointState;
- (void)clearSelectModels;
- (void)hiddenPoint;

@end

NS_ASSUME_NONNULL_END
