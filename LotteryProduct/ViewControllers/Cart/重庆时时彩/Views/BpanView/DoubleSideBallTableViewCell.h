//
//  DoubleSideBallTableViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/15.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DoubleSideBallTableViewCellDelegate <NSObject>

- (void)selectBigSmallBalls:(NSMutableArray *)selectBallsArray;

@end


@interface DoubleSideBallTableViewCell : UITableViewCell

@property (nonatomic, strong)NSMutableArray *selectBigSmallLabelArray;


//赔率
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *peiLvLabels;

//选中的"大,小,单,双"等 label
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *ballLabels;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *numberBackViews;

@property (nonatomic, strong) NSArray *itemModels;


@property (nonatomic,weak) id<DoubleSideBallTableViewCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
