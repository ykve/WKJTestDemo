//
//  MainTouchTableView.m
//  ClawGame
//
//  Created by Jiang on 2017/12/21.
//  Copyright © 2017年 softgarden. All rights reserved.
//

#import "MainTouchTableView.h"

@implementation MainTouchTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
//    if ([otherGestureRecognizer.view isKindOfClass:[UICollectionView class]]) {
//        return NO;
//    }
    
    return YES;
}

@end
