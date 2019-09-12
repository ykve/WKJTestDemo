//
//  MineMessageCell.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/3/3.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+LXVerticalStyle.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (weak, nonatomic) IBOutlet UILabel *contentlab;

@property (weak, nonatomic) IBOutlet UILabel *timelab;

@property (weak, nonatomic) IBOutlet UILabel *statuslab;

@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UIView *topBackView;

@end

NS_ASSUME_NONNULL_END
