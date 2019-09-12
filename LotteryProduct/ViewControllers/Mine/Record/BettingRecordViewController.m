//
//  BettingRecordViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/21.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "BettingRecordViewController.h"
#import "BettingRecordListCtrl.h"
@interface BettingRecordViewController ()

@property (nonatomic, strong)CJScroViewBar *navBar;

@end

@implementation BettingRecordViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    @weakify(self)
    [self leftBtn:nil Withimage:@"tw_nav_return" With:^(UIButton *sender) {
        @strongify(self)

        if (self.fromepublish) {
            
            [self popIndex:2];
        }
        else{
            [self popback];
        }
    }];
    [self buildScrollBar];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updataorder) name:@"REFRESHORDER" object:nil];
}

-(void)buildScrollBar {
    
    NSArray *titles = @[@"投注",@"追号",@"撤单"];
    
    for (int i = 0; i< titles.count ;i++) {
        
        [self.dataSource addObject:[NSNull null]];
    }
    
    self.navBar = [[CJScroViewBar alloc]initWithFrame:CGRectMake(80, NAV_HEIGHT-44, SCREEN_WIDTH-160, 44)];
    self.navBar.lineColor = [[CPTThemeConfig shareManager] pushDanBarTitleSelectColot];
    self.navBar.backgroundColor = CLEAR;
    [self.navView addSubview:self.navBar];
    
    self.scrollView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT);
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * titles.count, self.scrollView.bounds.size.height);
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    [self.navBar layoutIfNeeded];
    
    [self.navBar setData:titles NormalColor:WHITE SelectColor:[[CPTThemeConfig shareManager] pushDanBarTitleSelectColot] Font:[UIFont systemFontOfSize:16]];
    
    @weakify(self)
    [self.navBar getViewIndex:^(NSString *title, NSInteger index) {
        @strongify(self)

        self.navBar.selectedBtn.backgroundColor = CLEAR;
        if ([[self.dataSource objectAtIndex:index] isEqual:[NSNull null]]) {
            
            BettingRecordListCtrl *list = [[BettingRecordListCtrl alloc]init];
            list.Bettingtype = index == 0 ? @"NORMAL" : index == 1 ? @"CHASE" : @"BACK";
            list.view.frame = CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, self.scrollView.bounds.size.height);
            [self addChildViewController:list];
            [self.scrollView addSubview:list.view];
            [self.dataSource replaceObjectAtIndex:index withObject:list];
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            @strongify(self)

            self.scrollView.contentOffset = CGPointMake(index * SCREEN_WIDTH, 0);
        }];
    }];
    
    [self.navBar setViewIndex:0];
}

#pragma mark - 滚动标题代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    [self.navBar setViewIndex:index];
}

-(void)updataorder {
    
    [self.navBar setViewIndex:0];
}
@end
