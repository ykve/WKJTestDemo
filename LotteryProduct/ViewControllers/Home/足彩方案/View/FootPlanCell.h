//
//  FootPlanCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/4/24.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FootballRemarkListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FootPlanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *stLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *seeNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *plNumLabel;
@property (weak, nonatomic) IBOutlet UIView *retView;
@property (weak, nonatomic) IBOutlet UIView *matchView;
@property (weak, nonatomic) IBOutlet UILabel *matchLabel;

- (void)setDataWithModel:(FootballRemarkListModel *)model;

@end

NS_ASSUME_NONNULL_END
