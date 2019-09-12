//
//  LiuHeTuKuRemarkTableViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/18.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiuHeTKRemarkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiuHeTuKuRemarkTableViewCell : UITableViewCell



@property (assign, nonatomic)  BOOL isFirst;

+ (instancetype)cellWithTableView:(UITableView *)tableView
                       reusableId:(NSString *)ID;

@property (nonatomic, strong) LiuHeTKRemarkModel *model;

@end

NS_ASSUME_NONNULL_END
