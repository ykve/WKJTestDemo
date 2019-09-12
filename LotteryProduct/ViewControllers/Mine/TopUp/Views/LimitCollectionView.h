//
//  LimitCollectionView.h
//  LotteryProduct
//
//  Created by pt c on 2019/7/19.
//  Copyright © 2019 vsskyblue. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TopUpModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^HeadClickBlock)(CGFloat money);

@interface LimitCollectionView : UIView

@property (nonatomic, copy) HeadClickBlock headClickBlock;

+ (LimitCollectionView *)headViewWithModel:(id)model;

@property (nonatomic, strong) id model;

@end

NS_ASSUME_NONNULL_END
