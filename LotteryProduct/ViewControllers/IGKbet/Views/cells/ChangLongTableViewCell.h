//
//  ChangLongTableViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/7.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangLongModel.h"
#import "CountDown.h"
#import "CPTSixModel.h"


NS_ASSUME_NONNULL_BEGIN

@protocol ChangLongTableViewCellDelegate <NSObject>

- (void)addLotteryModel:(CPTBuyBallModel *)buyModel;
- (void)removeLotteryModel:(CPTBuyBallModel *)buyModel;


@end

@interface ChangLongTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (nonatomic, strong) ChangLongModel *model;
@property (strong, nonatomic) CountDown *countDownForLabel;
@property (nonatomic, strong) CPTBuyBallModel *leftModel;
@property (nonatomic, strong) CPTBuyBallModel *rightModel;
@property (nonatomic, strong) NSIndexPath *indexPath;


@property (nonatomic,weak) id<ChangLongTableViewCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
