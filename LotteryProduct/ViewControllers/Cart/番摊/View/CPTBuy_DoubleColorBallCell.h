//
//  CPTBuy_DoubleColorBallCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/3/12.
//  Copyright © 2019年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CPTBuy_DoubleColorBallCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *ballBtn;
@property(nonatomic,assign) BOOL isRed;
@property(nonatomic,copy) void (^didClick)(UIButton *);

-(void)setNumWith:(NSInteger)num isRed:(BOOL)isRed andSelect:(BOOL)isSelected;
@end

NS_ASSUME_NONNULL_END
