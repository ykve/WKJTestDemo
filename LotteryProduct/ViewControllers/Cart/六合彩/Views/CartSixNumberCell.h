//
//  CartSixNumberCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartSixNumberCell : UICollectionViewCell
@property (nonatomic, strong)UIButton *numberBtn;
@property (nonatomic, strong)UILabel *Oddslab;
/**
 1:球型
 2：块型
 */
@property (nonatomic, assign)NSInteger type;
/**
 号码
 */
@property (nonatomic, copy) NSString *title;
/**
 赔率
 */
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy)void (^selectBlock)(UIButton *sender);
@end
