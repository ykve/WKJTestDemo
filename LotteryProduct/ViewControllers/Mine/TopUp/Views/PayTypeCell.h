//
//  PayTypeCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/11.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayTypeCell : UICollectionViewCell

@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UIImageView *iconImageView;
@property (strong, nonatomic)  UILabel *maxMoneyLabel;
@property (strong, nonatomic)  UIView *bgView;

@property (strong, nonatomic)  UIImageView *maskImageView;
@property (strong, nonatomic)  UILabel *maskTitleLabel;
@property (strong, nonatomic)  UILabel *maskMaxMinMoneyLabel;

@end
