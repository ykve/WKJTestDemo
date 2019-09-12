//
//  OpenButton.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/5/28.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CPTOpenButtonType)//彩种
{
    CPTOpenButtonType_RedBall,
    CPTOpenButtonType_BludBall,
    CPTOpenButtonType_LHCBall
};
@interface OpenButton : UIButton
@property(nonatomic,assign)CPTOpenButtonType type;
- (void)dismissOpenGif;
- (void)showOpenGif;
@end

NS_ASSUME_NONNULL_END
