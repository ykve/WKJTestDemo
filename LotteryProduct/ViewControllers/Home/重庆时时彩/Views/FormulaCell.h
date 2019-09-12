//
//  FormulaCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/6.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormulaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *versionslab;
@property (weak, nonatomic) IBOutlet UILabel *timelab;
@property (weak, nonatomic) IBOutlet UILabel *numberlab;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numlabs;
@property (weak, nonatomic) IBOutlet UILabel *sixnumber;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *versionlab_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timelab_width;
/**
 是否是六合彩，六合彩需从新布局 0正常布局 1：正码布局 2：特码布局
 */
@property (assign, nonatomic) NSInteger issixtype;
@property (weak, nonatomic) IBOutlet UILabel *nosixvaluelab;

@end
