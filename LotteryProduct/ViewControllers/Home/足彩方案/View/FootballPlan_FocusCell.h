//
//  FootballPlan_FocusCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/4/24.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FootballRemarkListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FootballPlan_FocusCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *retView;
- (void)setDataWithModel:(FootballRemarkListModel *)model;

@end

NS_ASSUME_NONNULL_END
