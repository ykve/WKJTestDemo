//
//  CartHomeHeaderView.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/12.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartHomeModel.h"
#import "CrartHomeSubModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CartHomeHeaderViewDelegate <NSObject>

- (void)skipToAPan:(UIButton *)sender;
- (void)skipToBPan:(CrartHomeSubModel *)subModel;

@end

@interface CartHomeHeaderView : UICollectionReusableView

@property (nonatomic, strong) CartHomeModel *model;

@property (weak, nonatomic) IBOutlet UIView *seperatorLine;

@property (nonatomic,weak) id<CartHomeHeaderViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
