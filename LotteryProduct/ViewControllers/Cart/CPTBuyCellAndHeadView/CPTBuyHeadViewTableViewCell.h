//
//  CPTBuyHeadViewTableViewCell
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/30.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCInfoModel.h"

@interface CPTBuyHeadViewTableViewCell : UITableViewCell

@property (assign,nonatomic) CPTBuyTicketType type;
@property (strong, nonatomic) SixInfoModel * model;
@property (nonatomic, assign) NSInteger categoryId;
@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (copy, nonatomic) NSMutableArray<UIButton *> *titleBtnArray;
@property (copy, nonatomic) NSMutableArray<UILabel *> *subTitleArray;
@property (weak, nonatomic) IBOutlet UILabel *fantanLabel;
@property (weak, nonatomic) IBOutlet UIView *niuWinBgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;

- (void)sixModel:(SixInfoModel *)model;
- (void)pk10Model:(PK10InfoModel *)pk10Model;
- (void)sscModel:(ChongqinInfoModel *)model;
- (void)configUI;
- (void)pcddModel:(PCInfoNewModel *)model;
- (void)pailie35Model:(ChongqinInfoModel *)model;//排列3、5
- (void)lotteryInfoModel:(LotteryInfoModel *)model;

@end
