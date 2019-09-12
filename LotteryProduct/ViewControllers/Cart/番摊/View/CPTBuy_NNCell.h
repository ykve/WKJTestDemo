//
//  CPTBuy_NNCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/3/29.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPTBuy_NNCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btn1s;

@property (nonatomic,copy) void(^updateSelection)(NSArray *);
@property (weak, nonatomic) IBOutlet UIView *lineView;
- (void)clearAllWithRandom:(BOOL)isRandom;
@end

NS_ASSUME_NONNULL_END
