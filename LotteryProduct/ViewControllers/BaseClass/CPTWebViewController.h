//
//  CPTWebViewController.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPTWebViewController : RootCtrl
@property (nonatomic,assign) BOOL isGame;
@property (nonatomic,assign) BOOL isAG;
@property (nonatomic,assign) BOOL isKY;
@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic,assign) BOOL isFromBuy;
@property (nonatomic,assign) BOOL isAD;

@end

NS_ASSUME_NONNULL_END
