//
//  ChongqinCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChongqinCell : UICollectionViewCell
/**
 期数
 */
@property (weak, nonatomic) IBOutlet UILabel *Issuelab;

/**
 今日售
 */
@property (weak, nonatomic) IBOutlet UILabel *sellIssuelab;
/**
 剩余期数
 */
@property (weak, nonatomic) IBOutlet UILabel *releaseIssuelab;
/**
 截止时间
 */
@property (weak, nonatomic) IBOutlet UILabel *endtimelab;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (copy, nonatomic) void(^actionClickBlock)(NSInteger index);

@end
