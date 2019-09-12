//
//  UIView+Category.m
//  BaseProject
//
//  Created by my on 16/3/24.
//  Copyright © 2016年 base. All rights reserved.
//

#import "UIView+TapAction.h"
#import <objc/runtime.h>

static char tapKey;
static char longtagKey;

@implementation UIView (TapAction)


#pragma mark - 添加单击手势
- (void)tapHandle:(TapAction)block {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &tapKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)longtapHandle:(LongTapAction)block {
    
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longtapAction:)];
    tap.minimumPressDuration = 2;
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &longtagKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    TapAction blcok = objc_getAssociatedObject(self, &tapKey);
    if (blcok) {
        blcok();
    }
}

-(void)longtapAction:(UILongPressGestureRecognizer *)tap {
    
    LongTapAction blcok = objc_getAssociatedObject(self, &longtagKey);
    if (blcok) {
        blcok();
    }
}
@end
