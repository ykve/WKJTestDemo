//
//  UIView+RJ.m
//  chefHelper
//
//  Created by Jiang on 2017/10/10.
//  Copyright © 2017年 MB. All rights reserved.
//

#import "UIView+RJ.h"

@implementation UIView (RJ)

- (void)setCornerRadius:(CGFloat)cornerRadius {
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)cornerRadius {
    
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
@end
