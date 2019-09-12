//
//  PK10TwoFaceLuzhuCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10TwoFaceLuzhuCtrl.h"
#import "PK10TwoFaceLuzhulistCtrl.h"
@interface PK10TwoFaceLuzhuCtrl ()

@property (nonatomic, strong) CJScroViewBar *twofaceBar;

@property (nonatomic, copy) NSString *date;

@end

@implementation PK10TwoFaceLuzhuCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"两面路珠";
    
    self.date = [Tools getlocaletime];
    
    [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] WFSMImage] With:^(UIButton *sender) {
        
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        [alert buildPK10TwofaceluzhuInfoView];
        [alert show];
    }];
    
    @weakify(self)
    [self buildTimeViewWithType:self.lottery_type With:^(UIButton *sender) {
        @strongify(self)
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];

        [alert builddateView:^(NSString *date) {
            @strongify(self)
            self.date = date;
            
            [sender setTitle:date forState:UIControlStateNormal];
            
            NSInteger index = self.scrollView.contentOffset.x / SCREEN_WIDTH;
            
            PK10TwoFaceLuzhulistCtrl *list = [self.dataSource objectAtIndex:index];
            
            [list initDataWithtime:date];
            
        }];
        [alert show];
    }  With:^{
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
    
    NSArray *titles = @[@"大小路珠",@"单双路珠",@"龙虎路珠"];
    
    for (int i = 0; i< titles.count ;i++) {
        
        [self.dataSource addObject:[NSNull null]];
    }
    
    self.twofaceBar = [[CJScroViewBar alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT+34, SCREEN_WIDTH, 44)];
    self.twofaceBar.lineColor = LINECOLOR;
    self.twofaceBar.backgroundColor = MAINCOLOR;
    [self.view addSubview:self.twofaceBar];
    
    self.scrollView.frame = CGRectMake(0, NAV_HEIGHT + 34 + 44, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 34 - 44);
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * titles.count, self.scrollView.bounds.size.height);
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    [self.twofaceBar layoutIfNeeded];
    
    [self.twofaceBar setData:titles NormalColor:WHITE SelectColor:BASECOLOR Font:[UIFont systemFontOfSize:16]];
    @weakify(self)
    [self.twofaceBar getViewIndex:^(NSString *title, NSInteger index) {
        @strongify(self)
        if ([[self.dataSource objectAtIndex:index] isEqual:[NSNull null]]) {
            
            PK10TwoFaceLuzhulistCtrl *list = [[PK10TwoFaceLuzhulistCtrl alloc]init];
            list.lottery_type = self.lottery_type;
            list.type = index;
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
    
    [self.twofaceBar setViewIndex:0];
}

#pragma mark - 滚动标题代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    [self.twofaceBar setViewIndex:index];
}

-(void)refresh {
    
    if ([[self.dataSource objectAtIndex:0] isEqual:[NSNull null]] == NO) {
        
        PK10TwoFaceLuzhulistCtrl *list = [self.dataSource objectAtIndex:0];
        
        [list initDataWithtime:self.date];
    }
    if ([[self.dataSource objectAtIndex:1] isEqual:[NSNull null]] == NO) {
        
        PK10TwoFaceLuzhulistCtrl *list = [self.dataSource objectAtIndex:1];
        
        [list initDataWithtime:self.date];
    }
    if ([[self.dataSource objectAtIndex:2] isEqual:[NSNull null]] == NO) {
        
        PK10TwoFaceLuzhulistCtrl *list = [self.dataSource objectAtIndex:2];
        
        [list initDataWithtime:self.date];
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
