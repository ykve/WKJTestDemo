//
//  LiuHeTuKuTopView.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/17.
//  Copyright © 2019 vsskyblue. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol LiuHeTuKuTopViewDelegate <NSObject>

- (void)selectPerios:(UIButton *)sender;

@end

@interface LiuHeTuKuTopView : UIView


@property (strong, nonatomic) UIButton *preBtn;
@property (strong, nonatomic) UIButton *nextBtn;
@property (strong, nonatomic) UILabel *titleLbl;

@property (strong, nonatomic) UIView *backView;

@property (nonatomic,weak) id<LiuHeTuKuTopViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
