//
//  CCHViewController.m
//  SuspendViewDemo
//
//  Created by cchhjj on 16/12/13.
//  Copyright © 2016年 CanHe Chen. All rights reserved.
//

#import "CCHContentViewController.h"

@interface CCHContentViewController ()

@end

@implementation CCHContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    if (_contentView) {

        [self.view addSubview:_contentView];
        
        [self constraintPointForView:_contentView];
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    CGPoint prePoint = [touch previousLocationInView:self.view];
    
    CGFloat x = point.x - prePoint.x;
    
    CGFloat y = point.y - prePoint.y;
    
    CGRect rect = _contentView.frame;
    rect.origin.x += x;
    rect.origin.y += y;
    
    _contentView.frame = rect;
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self constraintPointForView:_contentView];
    
}

- (void)constraintPointForView:(UIView *)view {
    
    CGRect rect = view.frame;
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGFloat margin = 3;
    
    if (minX < margin) {
        rect.origin.x = margin;
    }
    
    if (maxX > w - margin) {
        
        CGFloat fx = w - margin - rect.size.width;
        
        rect.origin.x = fx;
    }
    
    if (minY < margin) {
        rect.origin.y = margin;
    }
    
    if (maxY > h - margin) {
        
        CGFloat fy = h - margin - rect.size.height;
        
        rect.origin.y = fy;
    }
    
    if (CGRectEqualToRect(rect, view.frame)) {
        return;
    }
    
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        view.frame = rect;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

@end
