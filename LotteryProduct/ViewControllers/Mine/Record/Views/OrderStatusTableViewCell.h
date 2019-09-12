//
//  OrderStatusTableViewCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/7/22.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderStatusTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *lineView;

+ (instancetype)cellWithTableView:(UITableView *)tableView
                       reusableId:(NSString *)ID;

// strong注释
@property (nonatomic, strong) id model;

@end

NS_ASSUME_NONNULL_END
