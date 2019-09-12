//
//  BettingRecordListCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "BettingRecordListCtrl.h"
#import "BettingListCtrl.h"
@interface BettingRecordListCtrl ()

@property (nonatomic, strong)CJScroViewBar *typeBar;

@end

@implementation BettingRecordListCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navView.hidden = YES;
    [self buildScrollBar];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updataorder) name:@"REFRESHORDER" object:nil];
}

-(void)buildScrollBar {
    
    
    if ([self.Bettingtype isEqualToString:@"NORMAL"]) {
        
        NSArray *titles = @[@"全部",@"未开奖",@"未中奖",@"已中奖"];
        
        for (int i = 0; i< titles.count ;i++) {
            
            [self.dataSource addObject:[NSNull null]];
        }
        
        self.typeBar = [[CJScroViewBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        self.typeBar.lineColor = [[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor];
        self.typeBar.backgroundColor = [[CPTThemeConfig shareManager] pushDanSubbarBackgroundcolor];
        [self.view addSubview:self.typeBar];
        
        self.scrollView.frame = CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 30);
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * titles.count, self.scrollView.bounds.size.height);
        self.scrollView.scrollEnabled = YES;
        [self.view addSubview:self.scrollView];
        
        [self.typeBar layoutIfNeeded];
        
        [self.typeBar setData:titles NormalColor:[[CPTThemeConfig shareManager] pushDanSubBarNormalTitleColor] SelectColor:[[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor] Font:[UIFont systemFontOfSize:14]];
        
        @weakify(self)
        [self.typeBar getViewIndex:^(NSString *title, NSInteger index) {
            
            self.typeBar.selectedBtn.backgroundColor = CLEAR;
            if ([[self.dataSource objectAtIndex:index] isEqual:[NSNull null]]) {
                
                BettingListCtrl *list = [[BettingListCtrl alloc]init];
                list.status = index == 0 ? nil : index == 1 ? @"WAIT" : index == 2 ? @"NO_WIN" : @"WIN";
                list.Bettingtype = self.Bettingtype;
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
        
        [self.typeBar setViewIndex:0];
    }
    else{
        BettingListCtrl *list = [[BettingListCtrl alloc]init];
        list.status = nil;
        list.Bettingtype = self.Bettingtype;
        list.view.frame = self.view.bounds;
        [self addChildViewController:list];
        [self.view addSubview:list.view];
    }
}

#pragma mark - 滚动标题代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    [self.typeBar setViewIndex:index];
}

-(void)updataorder {
    
    [self.typeBar setViewIndex:0];
    
    BettingListCtrl *list = self.dataSource.firstObject;
    
    [list refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
