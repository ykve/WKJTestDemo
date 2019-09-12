//
//  LiuHeCaiHalfBoViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiuHeCaiHalfBoViewController.h"
#import "HalfRedBoViewController.h"
#import "HalfBlueBoViewController.h"

#define View_WIDTH  0.8 * [UIScreen mainScreen].bounds.size.width


@interface LiuHeCaiHalfBoViewController ()


@end

@implementation LiuHeCaiHalfBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI{
    [self buildScrollBar];
    
    [self hiddenavView];
}

-(void)hiddenavView {
    
    self.navView.hidden = YES;
    self.navView.alpha = 0;
}

- (void)buildScrollBar{
    
    NSArray *titles = nil;
    if (self.lottery_type == 1 || self.lottery_type == 2 || self.lottery_type == 3) {
        
        titles = @[@"红波",@"蓝波",@"绿波"];
    }
//    else if (self.lottery_type == 6 || self.lottery_type == 7) {
//        titles = @[@"冠军",@"亚军",@"第三名",@"第四名",@"第五名",@"第六名",@"第七名",@"第八名",@"第九名",@"第十名"];
//    }
//    else if (self.lottery_type == 4) {
//        titles = @[@"正码",@"特码"];
//    }
    for (int i = 0; i < titles.count ;i++) {
        
        [self.dataSource addObject:[NSNull null]];
    }
    
    self.formulaBar = [[CJScroViewBar alloc]initWithFrame:CGRectMake(0, 0, View_WIDTH, 44)];
    self.formulaBar.lineColor = LINECOLOR;
    self.formulaBar.backgroundColor = MAINCOLOR;
    [self.view addSubview:self.formulaBar];
    
    self.scrollView.frame = CGRectMake(0, 44, View_WIDTH, self.view.height - 44);
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(View_WIDTH * titles.count, 0);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor blueColor];
    [self.formulaBar layoutIfNeeded];
    
    [self.formulaBar setData:titles NormalColor:WHITE SelectColor:BASECOLOR Font:[UIFont systemFontOfSize:16]];
    
    CGFloat scrollViewWidth = View_WIDTH;

    
    for (int i = 0; i < titles.count; i++) {
        
        if (i == 0) {
            HalfRedBoViewController *halfRedVc = [[HalfRedBoViewController alloc] init];
            halfRedVc.view.frame = CGRectMake(scrollViewWidth * i, 0, scrollViewWidth, self.scrollView.bounds.size.height);
            halfRedVc.tableView.frame = CGRectMake(0, 0, scrollViewWidth, halfRedVc.view.height - 44);
            
            halfRedVc.view.backgroundColor = [UIColor redColor];
            
            [self addChildViewController:halfRedVc];
            [self.scrollView addSubview:halfRedVc.view];
            
        }else if (i == 1 || i == 2){
            
            HalfBlueBoViewController *blueBoVc = [[HalfBlueBoViewController alloc] init];
            
            blueBoVc.view.frame = CGRectMake(scrollViewWidth * i, 0, scrollViewWidth, self.scrollView.bounds.size.height);
            blueBoVc.tableView.frame = CGRectMake(0, 0, scrollViewWidth, self.scrollView.bounds.size.height);
            
            blueBoVc.view.backgroundColor = [UIColor blueColor];
            
            [self addChildViewController:blueBoVc];
            [self.scrollView addSubview:blueBoVc.view];
            
        }
        
    }
    
    [self.formulaBar getViewIndex:^(NSString *title, NSInteger index) {
        
        if ([[self.dataSource objectAtIndex:index] isEqual:[NSNull null]]) {
            
         
        }else {
            
          
        }
        [UIView animateWithDuration:0.3 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(index * scrollViewWidth, 0);
        }];
    }];
    
    [self.formulaBar setViewIndex:0];
    
}

#pragma mark - 滚动标题代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / (SCREEN_WIDTH * 0.8);
    
    [self.formulaBar setViewIndex:index];
}


@end
