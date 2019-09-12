//
//  AoZhouACTButton.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPTBuyBallModel;

NS_ASSUME_NONNULL_BEGIN

@interface AoZhouACTButton : UIButton

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic,weak) UILabel *subTitleLbl;

@property (nonatomic, strong) CPTBuyBallModel *model;


@property (nonatomic,assign) BOOL isselected;


@end

NS_ASSUME_NONNULL_END
