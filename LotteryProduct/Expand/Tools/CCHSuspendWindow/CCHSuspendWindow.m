//
//  CCHSuspendWindow.m
//  SuspendViewDemo
//
//  Created by cchhjj on 16/12/13.
//  Copyright © 2016年 CanHe Chen. All rights reserved.
//

#import "CCHSuspendWindow.h"

@implementation CCHSuspendWindow {
    __weak CCHContentViewController *contentViewController;
}

- (instancetype)initWithContentView:(UIView *)contentView {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        [self setupForContentView:contentView];

    }
    return self;
}


- (void)setupForContentView:(UIView *)contentView {
    
    self.backgroundColor = [UIColor clearColor];
    self.windowLevel = UIWindowLevelStatusBar + 10;
    
    CCHContentViewController *vc = [CCHContentViewController new];
    self.contentView = contentView;
    vc.contentView = contentView;
    contentViewController = vc;
    self.rootViewController = vc;
    
    
}


- (void)show {
    
    self.hidden = NO;
    [UIView animateWithDuration:0.1 animations:^{
        self.rootViewController.view.alpha = 1;
    }];
    
    
}

- (void)hide {
    
    [UIView animateWithDuration:0.1 animations:^{
        self.rootViewController.view.alpha = 0.3;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = nil;
    
    CGRect rect = _contentView.frame;
    
    if (CGRectContainsPoint(rect, point)) {
        return [super hitTest:point withEvent:event];
    }
    
    return view;
}


@end
