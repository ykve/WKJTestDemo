//
//  CPTBuyRightCollectionWuxingCell.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/3/11.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPTBuyRightButtonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPTBuyRightCollectionWuxingCell : UICollectionViewCell
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (weak, nonatomic) IBOutlet UILabel *ballButton;
@property (weak, nonatomic) IBOutlet UIView *bcV;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;
@property (strong, nonatomic) CPTBuyBallModel *model;
@property (assign, nonatomic) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
