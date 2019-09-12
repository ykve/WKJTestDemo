//
//  CPTBuyCollectionLonghuHeadView.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/3/8.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPTBuyCollectionLonghuHeadView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *longBtn;
@property (weak, nonatomic) IBOutlet UIButton *huBtn;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@property (copy, nonatomic) void(^lookallBlock)(void);
@end

NS_ASSUME_NONNULL_END
