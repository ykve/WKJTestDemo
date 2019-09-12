//
//  MyCircleViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "MyCircleViewController.h"

@interface MyCircleViewController ()
/// 我的关注
@property (weak, nonatomic) IBOutlet UILabel *myFollowLabel;
/// 我的粉丝
@property (weak, nonatomic) IBOutlet UILabel *myFansLabel;

@property (strong, nonatomic) NSArray<UILabel *> *labels;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation MyCircleViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    self.labels = @[self.myFollowLabel, self.myFansLabel];

    [self configLabelTap];
    [self setUpLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)configLabelTap {
    
    for (int i = 0; i < self.labels.count; i++) {
        UILabel *label = self.labels[i];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapAction:)]];
    }
}

- (void)setUpLabel {
    for (int i = 0; i < self.labels.count; i++) {
        UILabel *label = self.labels[i];
        label.textColor = i == self.currentIndex ? [UIColor whiteColor] : [UIColor colorWithHex:@"404040"];
        label.backgroundColor = i == self.currentIndex ? [UIColor colorWithHex:@"BFBFBF"] : [UIColor colorWithHex:@"EEEEEE"];
    }
}

- (void)setUpScrollView {
    [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * self.currentIndex, 0) animated:NO];
}

- (void)labelTapAction:(UITapGestureRecognizer *)tap {
    self.currentIndex = tap.view.tag;
    
    [self setUpLabel];
    [self setUpScrollView];
}

@end
