//
//  BettingDetailCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BettingDetailCell : UITableViewCell

@property (strong, nonatomic) UILabel *titlelab;

@property (strong, nonatomic) UILabel *contentlab;

+ (instancetype)cellWithTableView:(UITableView *)tableView
                       reusableId:(NSString *)ID;

@end
