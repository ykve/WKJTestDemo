//
//  VVLongCollectionView.h
//  LotteryProduct
//
//  Created by pt c on 2019/7/28.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DidSelectItemAtIndexPathBlock)(NSArray *indexPathsForSelectedItems);

@interface VVLongCollectionView : UIView

@property (nonatomic, copy) DidSelectItemAtIndexPathBlock didSelectItemAtIndexPathBlock;

@property (nonatomic, strong) NSArray<NSIndexPath *> *selectedItemAtIndexPathArray;

@property (nonatomic, strong) id model;

@end

NS_ASSUME_NONNULL_END
