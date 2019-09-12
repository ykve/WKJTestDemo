//
//  MissCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "MissCtrl.h"
#import "MissStatisticsCtrl.h"
#import "MissBigorSmallCtrl.h"
#import "MissSingleandDoubleCtrl.h"
@interface MissCtrl ()

@property (nonatomic, strong)CJScroViewBar *missBar;

@property (nonatomic, copy) NSString *date;
@property (nonatomic,copy) NSString *index1Date;
@property (nonatomic,copy) NSString *index2Date;

@property (nonatomic, assign) NSInteger index;
@end

@implementation MissCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"遗漏统计";
    
    self.date = [Tools getlocaletime];
    self.index1Date = @"最近一个月";
    self.index2Date = @"最近一个月";
    self.index = 1;
    @weakify(self)
    [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] WFSMImage] With:^(UIButton *sender) {
        @strongify(self)
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        
        NSInteger index = self.scrollView.contentOffset.x / SCREEN_WIDTH;
        if (index == 0) {
            
            [alert buildmissstatistcsView];
        }
        else if (index == 1) {
            [alert buildmissbigorsmallView];
        }
        else {
            [alert buildmisssingleanddoubleView];
        }
        [alert show];
    }];
    
    [self buildTimeViewWithType:self.lottery_type With:^(UIButton *sender) {
        @strongify(self)
        NSInteger index = self.scrollView.contentOffset.x / SCREEN_WIDTH;
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        if (index == 0) {
            
            [alert builddateView:^(NSString *date) {
                @strongify(self)
                self.date = date;
                
                [sender setTitle:date forState:UIControlStateNormal];
                
                MissStatisticsCtrl *miss = [self.dataSource objectAtIndex:index];
                miss.lottery_type = self.lottery_type;
                [miss initData:date];
                
            }];
        }
        else {
            
            [alert buildmissdateView:^(UIButton *button) {
                @strongify(self)
                [sender setTitle:button.titleLabel.text forState:UIControlStateNormal];
                [sender setImagePosition:WPGraphicBtnTypeLeft spacing:2];
                
                self.index = button.tag == 101 ? 1 : 3;
                
                if (index == 1) {
                    
                    MissBigorSmallCtrl *miss = [self.dataSource objectAtIndex:index];
                    miss.lottery_type = self.lottery_type;
                    [miss initData:button.tag == 101 ? 1 : 3];
                    self.index1Date = button.titleLabel.text;
                }
                else{
                    self.index2Date = button.titleLabel.text;
                    MissSingleandDoubleCtrl *miss = [self.dataSource objectAtIndex:index];
                    miss.lottery_type = self.lottery_type;
                    [miss initData:button.tag == 101 ? 1 : 3];
                }
                
            }];
        }
        
        [alert show];
    } With:^{
        
        [self refresh];
    }];
    
    [self buildScrollBar];
    
    //投注按钮
    [self buildBettingBtn];
    
    [self scrollViewDidEndDecelerating:self.scrollView];
    self.scrollView.bounces = NO;
    
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
    
    switch (self.lottery_type) {
        case 1:
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_cqssc" object:nil];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_xjssc" object:nil];
            break;
        case 3:
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_txffc" object:nil];
            break;
        default:
            
            break;
    }
    
    
}

-(void)removenotification {
    
    switch (self.lottery_type) {
        case 1:
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_cqssc" object:nil];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xjssc" object:nil];
            break;
        case 3:
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_txffc" object:nil];
            break;
        default:
            
            break;
    }
    
}

-(void)buildScrollBar {
    
    NSArray *titles = @[@"遗漏统计",@"大小遗漏",@"单双遗漏"];
    
    for (int i = 0; i< titles.count ;i++) {
        
        [self.dataSource addObject:[NSNull null]];
    }
    
    self.missBar = [[CJScroViewBar alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT+34, SCREEN_WIDTH, 44)];
    self.missBar.lineColor = [[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor];
    self.missBar.backgroundColor = [[CPTThemeConfig shareManager] missCaculateBarNormalBackground];
    [self.view addSubview:self.missBar];
    
    self.scrollView.frame = CGRectMake(0, NAV_HEIGHT + 34 + 44, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 34 - 44);
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * titles.count, self.scrollView.bounds.size.height);
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    [self.missBar layoutIfNeeded];
    
    [self.missBar setData:titles NormalColor:[[CPTThemeConfig shareManager] pushDanSubBarNormalTitleColor] SelectColor:[[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor] Font:[UIFont systemFontOfSize:16]];
    @weakify(self)
    [self.missBar getViewIndex:^(NSString *title, NSInteger index) {
        @strongify(self)
        if (index == 0) {
            
            [self.dateBtn setImage:nil forState:UIControlStateNormal];
        }
        else {
            [self.dateBtn setImage:IMAGE(@"calendar_5") forState:UIControlStateNormal];
            [self.dateBtn setImagePosition:WPGraphicBtnTypeLeft spacing:2];
        }
        [self updateDateBtnTitleWithIndex:index];
        
        if ([[self.dataSource objectAtIndex:index] isEqual:[NSNull null]]) {
            @strongify(self)
            if (index == 0) {
                
                MissStatisticsCtrl *list = [[MissStatisticsCtrl alloc]init];
                list.lottery_type = self.lottery_type;
                list.view.frame = CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, self.scrollView.bounds.size.height);
                [self addChildViewController:list];
                [self.scrollView addSubview:list.view];
                [self.dataSource replaceObjectAtIndex:index withObject:list];
                
            }else if (index == 1) {
                
                MissBigorSmallCtrl *list = [[MissBigorSmallCtrl alloc]init];
                list.lottery_type = self.lottery_type;
                list.view.frame = CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, self.scrollView.bounds.size.height);
                [self addChildViewController:list];
                [self.scrollView addSubview:list.view];
                [self.dataSource replaceObjectAtIndex:index withObject:list];
                
            }else if (index == 2) {
                
                MissSingleandDoubleCtrl *list = [[MissSingleandDoubleCtrl alloc]init];
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
    
    [self.missBar setViewIndex:0];
}

#pragma mark - 滚动标题代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    [self.missBar setViewIndex:index];
    [self updateDateBtnTitleWithIndex:index];
}
- (void)updateDateBtnTitleWithIndex:(NSInteger)index{
    if(index == 0){
        [self.dateBtn setTitle:self.date forState:UIControlStateNormal];
    }else if(index == 1){
        
        [self.dateBtn setTitle:self.index1Date forState:UIControlStateNormal];
    }else if(index == 2){
        
        [self.dateBtn setTitle:self.index2Date forState:UIControlStateNormal];
    }
}

-(void)refresh {
    
    if ([[self.dataSource objectAtIndex:0] isEqual:[NSNull null]] == NO) {
        
        MissStatisticsCtrl *list = [self.dataSource objectAtIndex:0];
        list.lottery_type = self.lottery_type;
        [list initData:self.date];
    }
    if ([[self.dataSource objectAtIndex:1] isEqual:[NSNull null]] == NO) {
        
        MissBigorSmallCtrl *list = [self.dataSource objectAtIndex:1];
        list.lottery_type = self.lottery_type;
        [list initData:self.index];
    }
    if ([[self.dataSource objectAtIndex:2] isEqual:[NSNull null]] == NO) {
        
        MissSingleandDoubleCtrl *list = [self.dataSource objectAtIndex:2];
        list.lottery_type = self.lottery_type;
        [list initData:self.index];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
