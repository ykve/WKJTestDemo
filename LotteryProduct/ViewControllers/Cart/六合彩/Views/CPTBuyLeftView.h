//
//  CPTBuyLeftView.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CPTBuyLeftButton;
NS_ASSUME_NONNULL_BEGIN

@protocol CPTBuyLeftButtonDelegate <NSObject>
- (void)clickLeftButtonView:(CPTBuyLeftButton *)btn;
@end

@interface CPTBuyLeftView : UIView

@property (nonatomic, weak) id<CPTBuyLeftButtonDelegate>  delegate;
@property (nonatomic, copy) NSMutableArray<CPTBuyLeftButton *> *btnArray;

- (void)configUIByData:(NSArray<CPTSixPlayTypeModel *> *)titleArray;
- (CPTBuyLeftButton *)selectButtonByIndex:(NSString *)playType;
- (void)clearAll;
@end

NS_ASSUME_NONNULL_END
