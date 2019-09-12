//
//  CCHSuspendWindow.h
//  SuspendViewDemo
//
//  Created by cchhjj on 16/12/13.
//  Copyright © 2016年 CanHe Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCHContentViewController.h"

/**
 注意： 使用时要用全局变量持有 CCHSuspendWindow的对象，不然会被释放而无法显示。
 */

@interface CCHSuspendWindow : UIWindow

/**
 CCHSuspendWindow 构造方法，请使用该方法创建

 @param contentView 自定义的内容视图
 @return CCHSuspendWindow对象
 */
- (instancetype)initWithContentView:(UIView *)contentView;

/**
 自定义的内容视图
 */
@property (weak, nonatomic) UIView *contentView;

/**
 显示
 */
- (void)show;

/**
 隐藏
 */
- (void)hide;



@end
