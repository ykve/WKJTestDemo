//
//  BuyHeadViewCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/3/8.
//  Copyright © 2019年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyHeadViewCell : UITableViewCell
@property (assign,nonatomic) CPTBuyTicketType type;
@property (nonatomic, assign) NSInteger lotteryId;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nextDateLabel;//下期开奖

@property (weak, nonatomic) IBOutlet UIView *leftView;//左侧view

@property (weak, nonatomic) IBOutlet UIView *hrView;
@property (weak, nonatomic) IBOutlet UIView *minuteView;
@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (weak, nonatomic) IBOutlet UILabel *hrLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *openDateLabel;

@end

NS_ASSUME_NONNULL_END
