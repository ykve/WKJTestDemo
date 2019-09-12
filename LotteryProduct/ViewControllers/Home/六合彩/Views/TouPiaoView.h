//
//  TouPiaoView.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/20.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouPiaoModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TouPiaoViewDelegate <NSObject>

- (void)toupiao;

@end

@interface TouPiaoView : UIView

@property (nonatomic, strong)NSArray *modelsArray;


@property (nonatomic,weak) id<TouPiaoViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
