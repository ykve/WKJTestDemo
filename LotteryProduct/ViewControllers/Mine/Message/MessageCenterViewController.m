//
//  MessageCenterViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "MessageCenterViewController.h"

@interface MessageCenterViewController ()

    
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation MessageCenterViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"公告",@"站内信",@"通知"]];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"公告",@"站内信"]];
    segment.layer.cornerRadius = 3;
    segment.layer.masksToBounds = YES;
    segment.frame = CGRectMake(0, 0, 110, 30);
    segment.tintColor = WHITE;
    segment.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];
    segment.selectedSegmentIndex = 0;
    
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack],NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}forState:UIControlStateSelected];

    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:WHITE}forState:UIControlStateNormal];
    
    
    [segment addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segment;
}
    
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


-(void)changeClick:(UISegmentedControl *)sender {
    
    [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * sender.selectedSegmentIndex, 0) animated:NO];
}

    
@end
