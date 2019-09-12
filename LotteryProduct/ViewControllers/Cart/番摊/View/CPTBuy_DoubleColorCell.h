//
//  CPTBuy_DoubleColorCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/3/12.
//  Copyright © 2019年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPTBuy_DoubleColorCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *redCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *blueCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;

@property (nonatomic,assign) NSInteger lotteryId;
- (void)clearAllWithRandom:(BOOL)isRandom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redCollectionWitdhScale;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueCollectionWidthScale;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *blueView;//蓝球区


@property (nonatomic,copy) void(^didChangeSelection)( NSArray* _Nonnull ,NSArray *_Nonnull);
@end

NS_ASSUME_NONNULL_END
