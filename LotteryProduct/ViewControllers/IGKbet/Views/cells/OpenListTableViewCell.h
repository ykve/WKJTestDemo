//
//  OpenListTableViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/4/11.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCInfoModel.h"
#import "IGKbetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OpenListTableViewCell : UITableViewCell

@property (assign,nonatomic) CPTBuyTicketType type;
@property (copy, nonatomic) NSMutableArray<UIButton *> *titleBtnArray;
@property (copy, nonatomic) NSMutableArray<UILabel *> *subTitleArray;
@property (strong, nonatomic) UILabel *dateL;
@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) UILabel * nameLabel;
@property (strong, nonatomic) UILabel * currentLabel;
@property (strong, nonatomic) UILabel * nextLabel;
@property (strong, nonatomic) UILabel * timeLabel;

- (void)sixModel:(SixInfoModel *)model;
- (void)pk10Model:(PK10InfoModel *)pk10Model;
- (void)sscModel:(ChongqinInfoModel *)model;
- (void)configUI;
- (void)pcddModel:(LotteryInfoModel *)model;

//新增彩种
- (void)lotteryInfoModel:(LotteryInfoModel *)model;
@end

NS_ASSUME_NONNULL_END
