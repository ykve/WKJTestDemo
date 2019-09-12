//
//  HistoryResultCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/8.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *versionslab;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlabs;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rights;


@end
