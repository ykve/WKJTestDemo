//
//  DrawBeijingCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawBeijingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titlelab;
/**
 期数
 */
@property (weak, nonatomic) IBOutlet UILabel *Issuelab;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

/**
 下一期数
 */
@property (weak, nonatomic) IBOutlet UILabel *endIssuelab;

@property (weak, nonatomic) IBOutlet UILabel *endtimelab;

@property (strong, nonatomic) WB_Stopwatch * stopWatchLabel;


@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rights;

@end
