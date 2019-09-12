//
//  CartBPanBeijingPKHeaderView.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/26.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CartBPanBeijingPKHeaderViewDelegate <NSObject>

- (void)ChargeController;

- (void)lookHistoryData:(UIButton *)sender;


@end

@interface CartBPanBeijingPKHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nextversionslab;
@property (weak, nonatomic) IBOutlet UILabel *currentversionslab;
@property (weak, nonatomic) IBOutlet UILabel *endtimelab;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlabs;
@property (weak, nonatomic) IBOutlet UILabel *waitinglab;


@property (copy, nonatomic) void(^lookallBlock)(void);

@property (nonatomic,weak) id<CartBPanBeijingPKHeaderViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
