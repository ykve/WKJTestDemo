//
//  LYYTextView.h
//  baisibudejie
//
//  Created by Xiaoyue on 16/6/6.
//  Copyright © 2016年 李运洋. All rights reserved.



// 带有占位符

#import <UIKit/UIKit.h>

@interface LYYTextView : UITextView

/** 占位符*/
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 默认为灰色*/
@property (nonatomic, strong) UIColor *placeholderColor;

@end
