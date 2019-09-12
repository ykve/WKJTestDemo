//
//  CPTBuy_AZNNCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/3/29.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPTBuy_AZNNCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btn1s;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btn2s;

@property (nonatomic,copy) void(^updateSelection)(NSArray *);
- (void)clearAllWithRandom:(BOOL)isRandom;
@end

NS_ASSUME_NONNULL_END
