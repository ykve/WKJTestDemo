//
//  RedOrBlueBallCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/3/18.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface RedOrBlueBallCell : UICollectionViewCell
@property (nonatomic,assign) BOOL isRed;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ballWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ballHeight;

@property (weak, nonatomic) IBOutlet OpenButton *ballBtn;
@property (nonatomic,assign)BOOL isNN;//是否是牛牛
@property (nonatomic,assign) BOOL isHistory;
-(void)setNum:(NSString *)num isRed:(BOOL)isRed opening:(BOOL)isOpening;
@end

NS_ASSUME_NONNULL_END
