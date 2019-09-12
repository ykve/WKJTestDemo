//
//  DoubleSideTotalDragonTableViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/15.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartOddsModel.h"
#import "CartCQModel.h"

@class OddsList;

NS_ASSUME_NONNULL_BEGIN

@protocol DoubleSideTotalDragonTableViewCellDelegate <NSObject>

- (void)selectBalls:(NSMutableArray *)selectBallsArray;

@end

@interface DoubleSideTotalDragonTableViewCell : UITableViewCell

//选中的"总和大"等 label
@property (nonatomic, strong)NSMutableArray *selectTotalDragonLabelArray;


//赔率
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *peiLvLabels;
//"总和大"等 label
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *ballLabels;

//底部的 button
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;
//最底部的 view
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *numberBackViews;


//@property (copy, nonatomic) void (^selectBlock)(NSString *string);

@property (nonatomic, strong)CartOddsModel *oddModel;


@property (nonatomic, strong) NSArray *itemModels;


@property (nonatomic,weak) id<DoubleSideTotalDragonTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
