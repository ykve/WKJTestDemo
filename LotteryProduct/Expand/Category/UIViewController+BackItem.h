//
//  UIViewController+BackItem.h
//  WJZH
//
//  Created by Jiang on 2018/7/2.
//  Copyright © 2018年 Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BackItem) <UIGestureRecognizerDelegate>

/// 设置白色返回按钮
- (void)rj_setUpWhiteBackNavBarItem;

/// 设置黑色返回按钮
- (void)rj_setUpBlackBackNavBarItem;
@end
