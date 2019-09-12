//
//  ParentClassScrollViewController.h
//  ClawGame
//
//  Created by Jiang on 2017/12/21.
//  Copyright © 2017年 softgarden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentClassScrollViewController : UIViewController

@property(strong, nonatomic) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL canScroll;

@property (copy, nonatomic) NSString *goTop;
@property (copy, nonatomic) NSString *leaveTop;

@end
