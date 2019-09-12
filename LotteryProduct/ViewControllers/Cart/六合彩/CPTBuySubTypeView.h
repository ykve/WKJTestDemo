//
//  CPTBuySubTypeView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CPTBuyLeftButton;
@protocol CPTBuySubTypeViewDelegate <NSObject>
- (void)clickBuySubTypeView:(CPTBuyLeftButton *)btn;
@end

@interface CPTBuySubTypeView : UIView


@property (nonatomic, weak) id<CPTBuySubTypeViewDelegate>  delegate;
@property (nonatomic, copy) NSMutableArray<CPTBuyLeftButton *> *btnArray;


- (void)configUIByData:(NSArray<CPTSixPlayTypeModel *> *)playTypeArray;
@end
