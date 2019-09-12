//
//  ExpertListCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpertModel.h"
@interface ExpertListCell : UITableViewCell

@property (assign, nonatomic) NSInteger nameType;

+ (instancetype)cellWithTableView:(UITableView *)tableView
                       reusableId:(NSString *)ID;
// 数据模型
@property (nonatomic, strong) id model;

@property (copy, nonatomic) void (^attentionBlock)(UIButton *sender);


- (void)setDataWithModel:(ExpertModel *)model;







@end
