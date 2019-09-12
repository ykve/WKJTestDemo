//
//  LeftViewController.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/13.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

NS_ASSUME_NONNULL_BEGIN

@interface LeftViewController : UIView
@property (nonatomic , strong)RootCtrl *vc;
-(void)show:(RootCtrl *)viewcontroller;
-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
