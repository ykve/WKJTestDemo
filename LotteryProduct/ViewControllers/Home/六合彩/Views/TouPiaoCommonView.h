//
//  TouPiaoCommonView.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/3/2.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol TouPiaoCommonViewDelegate <NSObject>

- (void)commonToupiao;

@end

@interface TouPiaoCommonView : UIView

@property (nonatomic, strong)NSArray *modelsArray;
@property (nonatomic, assign)BOOL isAdd;
@property (nonatomic, strong) UIView *topView;



@property (nonatomic,weak) id<TouPiaoCommonViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
