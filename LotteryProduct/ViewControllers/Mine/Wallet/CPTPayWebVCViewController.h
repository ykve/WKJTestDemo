//
//  CPTPayWebVCViewController.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/5/20.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPTPayWebVCViewController : RootCtrl
@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, strong) NSURL *sfURL;

@end

NS_ASSUME_NONNULL_END
