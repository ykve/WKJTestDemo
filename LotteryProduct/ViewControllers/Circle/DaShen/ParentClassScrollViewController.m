//
//  ParentClassScrollViewController.m
//  ClawGame
//
//  Created by Jiang on 2017/12/21.
//  Copyright © 2017年 softgarden. All rights reserved.
//

#import "ParentClassScrollViewController.h"
#import "DaShenViewController.h"
//#import "HomeScrollTool.h"

@interface ParentClassScrollViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ParentClassScrollViewController

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.scrollView.contentOffset.x == 0) {
            return YES;
        }
    }
    
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
