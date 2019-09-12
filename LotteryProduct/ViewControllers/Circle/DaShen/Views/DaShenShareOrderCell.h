//
//  DaShenShareOrderCell.h
//  LotteryProduct
//
//  Created by Jiang on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushOrderModel.h"
#import "Gendan_PostmarkView.h"
@protocol DaShenShareOrderCellDelegate<NSObject>

- (void)dashenForrowOrderAction:(PushOrderModel *)model;

@end

@interface DaShenShareOrderCell : UITableViewCell

@property (weak, nonatomic) id<DaShenShareOrderCellDelegate> delegate;

@property (nonatomic, assign) NSInteger lottery_id;
@property (nonatomic, assign) NSInteger postMarkState;//0 未跟单
@property (nonatomic,assign) NSInteger rateType; //1 盈利率 2 胜率 3 连中
@property (strong, nonatomic) PushOrderModel *model;
/**
 盈利率、胜率、连中
 */
//@property (strong, nonatomic) UILabel *typelab;
/**
 头像
 */
@property (strong, nonatomic) UIImageView *headimgv;


+(CGFloat)getHeight:(PushOrderModel *)model;

+ (instancetype)cellWithTableView:(UITableView *)tableView reusableId:(NSString *)ID;

@end

