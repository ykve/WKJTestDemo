//
//  SixLotteryCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SixLotteryCell : UICollectionViewCell
/**
 期数
 */
@property (weak, nonatomic) IBOutlet UILabel *Issuelab;
/**
 奖池
 */
@property (weak, nonatomic) IBOutlet UILabel *totalmoneylab;

@property (weak, nonatomic) IBOutlet UILabel *timelab;
@property (weak, nonatomic) IBOutlet UILabel *weeklab;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlabs;

@property (copy, nonatomic) void(^actionClickBlock)(NSInteger index);

@end
