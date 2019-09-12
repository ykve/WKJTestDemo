//
//  AoZhouActBuyLotteryVeiw.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AoZhouActBuyLotteryVeiwDelegate <NSObject>

- (void)lotteryClickAction;

@end

@interface AoZhouActBuyLotteryVeiw : UIView

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (nonatomic,weak) id<AoZhouActBuyLotteryVeiwDelegate> delegate;


- (void)deleteSelectBtns;
-(void)getRandomBtn;

@end

NS_ASSUME_NONNULL_END
