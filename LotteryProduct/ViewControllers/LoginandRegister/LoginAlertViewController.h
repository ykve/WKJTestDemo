//
//  LoginAlertViewController.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/4/22.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginAlertViewController : UIViewController

@property (nonatomic, copy) void (^loginBlock)(BOOL result);

@end

NS_ASSUME_NONNULL_END
