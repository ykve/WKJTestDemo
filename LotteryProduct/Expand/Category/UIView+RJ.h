//
//  UIView+RJ.h
//  chefHelper
//
//  Created by Jiang on 2017/10/10.
//  Copyright © 2017年 MB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RJ)

/// 圆角
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/// 边框宽度
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;

/// 边框颜色
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

@end
