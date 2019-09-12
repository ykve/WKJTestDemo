//
//  CircleDetailViewController.h
//  LotteryProduct
//
//  Created by Jiang on 2018/7/2.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainTouchTableView;

// title晒单圈
@interface CircleDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *topView;

@property (nonatomic, assign) BOOL canScroll;

@property (weak, nonatomic) IBOutlet MainTouchTableView *tableView;

@end
