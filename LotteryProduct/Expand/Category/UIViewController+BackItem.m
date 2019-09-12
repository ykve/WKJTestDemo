//
//  UIViewController+BackItem.m
//  WJZH
//
//  Created by Jiang on 2018/7/2.
//  Copyright © 2018年 Jiang. All rights reserved.
//

#import "UIViewController+BackItem.h"

@implementation UIViewController (BackItem)

/// 设置白色返回按钮
- (void)rj_setUpWhiteBackNavBarItem {
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"tw_nav_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(rj_back)];
    
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

/// 设置黑色返回按钮
- (void)rj_setUpBlackBackNavBarItem {
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"tw_nav_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rj_back)];
    
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)rj_back {
    [self.view endEditing:YES];
    
    if (self.navigationController.childViewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if (self.presentingViewController != nil) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
