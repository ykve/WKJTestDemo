//
//  DrawSixLotteryCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawSixLotteryCell : UITableViewCell

/**
 期数
 */
@property (weak, nonatomic) IBOutlet UILabel *Issuelab;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlabs;

/**
 下一期数
 */
@property (weak, nonatomic) IBOutlet UILabel *endIssuelab;

@property (weak, nonatomic) IBOutlet UILabel *endtimelab;

@property (strong, nonatomic) WB_Stopwatch * stopWatchLabel;

@end
