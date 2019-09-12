//
//  PK10HistoryCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10HistoryCtrl.h"
#import "PK10historylistCtrl.h"
#import "PK10FirstandSecondCtrl.h"
#import "PK10NumberDistrubtionCtrl.h"
@interface PK10HistoryCtrl ()

@property (nonatomic, strong) CJScroViewBar *beijinBar;

@property (nonatomic, copy) NSString *date;
@end

@implementation PK10HistoryCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"历史开奖";
    
    self.date = [Tools getlocaletime];
    
    @weakify(self)
    [self buildTimeViewWithType:self.lottery_type With:^(UIButton *sender) {
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        alert.lastDate = self.date;
        [alert builddateView:^(NSString *date) {
            @strongify(self)

            self.date = date;
            
            [sender setTitle:date forState:UIControlStateNormal];
            
            [self refresh];
            
        }];
        [alert show];
    }With:^{
        @strongify(self)
        [self refresh];
    }];
    
    [self buildScrollBar];
    
    //投注按钮
    [self buildBettingBtn];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self addnotification];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self removenotification];
}
-(void)addnotification {
    
    if (self.lottery_type == 6) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_bjpks" object:nil];
    }
    else{
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_xyft" object:nil];
    }
    
}

-(void)removenotification {
    
    if (self.lottery_type == 6) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_bjpks" object:nil];
    }
    else{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xyft" object:nil];
    }
}


-(void)buildScrollBar {
    
    NSArray *titles = @[@"开奖号码",@"冠亚和龙虎",@"号码分布"];
    
    for (int i = 0; i< titles.count ;i++) {
        
        [self.dataSource addObject:[NSNull null]];
    }
    
    self.beijinBar = [[CJScroViewBar alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT+34, SCREEN_WIDTH, 44)];
    self.beijinBar.lineColor = LINECOLOR;
    self.beijinBar.backgroundColor = MAINCOLOR;
    [self.view addSubview:self.beijinBar];
    
    self.scrollView.frame = CGRectMake(0, NAV_HEIGHT + 34 + 44, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 34 - 44);
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * titles.count, self.scrollView.bounds.size.height);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    [self.beijinBar layoutIfNeeded];
    
    [self.beijinBar setData:titles NormalColor:WHITE SelectColor:BASECOLOR Font:[UIFont systemFontOfSize:16]];
    
    @weakify(self)
    [self.beijinBar getViewIndex:^(NSString *title, NSInteger index) {
        @strongify(self)
        if ([[self.dataSource objectAtIndex:index] isEqual:[NSNull null]]) {
            if (index == 0) {
                PK10historylistCtrl *list = [[PK10historylistCtrl alloc]init];
                list.lottery_type = self.lottery_type;
                list.view.frame = CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, self.scrollView.bounds.size.height);
                [self addChildViewController:list];
                [self.scrollView addSubview:list.view];
                [self.dataSource replaceObjectAtIndex:index withObject:list];
            }
            else if (index == 1) {
                PK10FirstandSecondCtrl *list = [[PK10FirstandSecondCtrl alloc]init];
                list.lottery_type = self.lottery_type;
                list.view.frame = CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, self.scrollView.bounds.size.height);
                [self addChildViewController:list];
                [self.scrollView addSubview:list.view];
                [self.dataSource replaceObjectAtIndex:index withObject:list];
            }
            else {
                PK10NumberDistrubtionCtrl *list = [[PK10NumberDistrubtionCtrl alloc]initWithNibName:@"PK10NumberDistrubtionCtrl" bundle:[NSBundle mainBundle]];
                list.lottery_type = self.lottery_type;
                list.view.frame = CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, self.scrollView.bounds.size.height);
                [self addChildViewController:list];
                [self.scrollView addSubview:list.view];
                [self.dataSource replaceObjectAtIndex:index withObject:list];
            }
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            @strongify(self)
            self.scrollView.contentOffset = CGPointMake(index * SCREEN_WIDTH, 0);
        }];
    }];
    
    [self.beijinBar setViewIndex:0];
}

#pragma mark - 滚动标题代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    [self.beijinBar setViewIndex:index];
}

-(void)refresh {
    
    if ([[self.dataSource objectAtIndex:0]isEqual:[NSNull null]]==NO) {
        
        PK10historylistCtrl *list = [self.dataSource objectAtIndex:0];
        list.lottery_type = self.lottery_type;
        [list initDataWithtime:self.date];
    }
    if ([[self.dataSource objectAtIndex:1]isEqual:[NSNull null]]==NO) {
        
        PK10FirstandSecondCtrl *list = [self.dataSource objectAtIndex:1];
        list.lottery_type = self.lottery_type;
        [list initDataWithtime:self.date];
    }
    if ([[self.dataSource objectAtIndex:2]isEqual:[NSNull null]]==NO) {
        
        PK10NumberDistrubtionCtrl *list = [self.dataSource objectAtIndex:2];
        list.lottery_type = self.lottery_type;
        [list initDataWithtime:self.date];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
