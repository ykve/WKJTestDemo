//
//  PCNumberTrendCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/13.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PCNumberTrendCtrl.h"
#import "PCNumberResultCtrl.h"
#import "PCHotCoolCtrl.h"
#import "PCGraphCtrl.h"
@interface PCNumberTrendCtrl ()

@property (nonatomic, strong) CJScroViewBar *PCBar;

@property (nonatomic,assign) NSInteger index , sort;

@property (nonatomic, strong) UIButton *setBtn;

@end

@implementation PCNumberTrendCtrl

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"号码走势";
    @weakify(self)
    [self buildTimeViewWithType:5 With:nil With:^{
        @strongify(self)
        [self refresh];
    }];
    
    [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] WFSMImage] With:^(UIButton *sender) {
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        [alert buildexplainView];
        [alert show];
    }];
    
    
    
    self.setBtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE([[CPTThemeConfig shareManager] IC_Nav_Setting_Gear])  andTarget:self andAction:@selector(setClick) andType:UIButtonTypeCustom];
    [self.navView addSubview:self.setBtn];
    
    [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.rightBtn.mas_left).offset(-8);
        make.size.mas_equalTo(CGSizeMake(43, 43));
        make.centerY.equalTo(self.rightBtn);
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_pcegg" object:nil];
    
}

-(void)removenotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_pcegg" object:nil];
}

-(void)buildScrollBar {
    
    NSArray *titles = @[@"开奖结果",@"冷热",@"第一区",@"第二区",@"第三区"];
    
    for (int i = 0; i< titles.count ;i++) {
        
        [self.dataSource addObject:[NSNull null]];
    }
    
    self.PCBar = [[CJScroViewBar alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT+34, SCREEN_WIDTH, 44)];
    self.PCBar.lineColor = LINECOLOR;
    self.PCBar.backgroundColor = MAINCOLOR;
    [self.view addSubview:self.PCBar];
    
    self.scrollView.frame = CGRectMake(0, NAV_HEIGHT + 34 + 44, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 34 - 44);
    self.scrollView.delegate = self;
//    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * titles.count, self.scrollView.bounds.size.height);
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    [self.PCBar layoutIfNeeded];
    
    [self.PCBar setData:titles NormalColor:WHITE SelectColor:BASECOLOR Font:[UIFont systemFontOfSize:16]];
   
    @weakify(self)
    [self.PCBar getViewIndex:^(NSString *title, NSInteger index) {
        @strongify(self)

        self.setBtn.hidden = index == 1 ? YES : NO;
        
        if ([[self.dataSource objectAtIndex:index] isEqual:[NSNull null]]) {
            
            if (index == 0) {
                
                PCNumberResultCtrl *list = [[PCNumberResultCtrl alloc]init];
                list.view.frame = CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, self.scrollView.bounds.size.height);
                [self addChildViewController:list];
                [self.scrollView addSubview:list.view];
                [self.dataSource replaceObjectAtIndex:index withObject:list];
            }
            else if (index == 1) {
                
                PCHotCoolCtrl *list = [[PCHotCoolCtrl alloc]init];
                list.view.frame = CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, self.scrollView.bounds.size.height);
                [self addChildViewController:list];
                [self.scrollView addSubview:list.view];
                [self.dataSource replaceObjectAtIndex:index withObject:list];
            }
            else {
                
                PCGraphCtrl *list = [[PCGraphCtrl alloc]init];
                list.type = index -1;
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
    
    [self.PCBar setViewIndex:0];
}

#pragma mark - 滚动标题代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    [self.PCBar setViewIndex:index];
}

-(void)setClick {
    
    ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
    @weakify(self)
    [alert buildsetView:self.index Withsort:self.sort With:^(NSInteger index, NSInteger sort) {
        @strongify(self)

        self.index = index;
        self.sort = sort;
        
        NSInteger page = self.scrollView.contentOffset.x / SCREEN_WIDTH;
        
        if (page == 0) {
            
            PCNumberResultCtrl *list = [self.dataSource objectAtIndex:page];
            
            [list initDataWithissue:self.index Withsort:self.sort];
        }
        else {
            PCGraphCtrl *list = [self.dataSource objectAtIndex:page];
            
            [list initDataWithissue:self.index Withsort:self.sort];
        }
        
    }];
    [alert show];
}

-(void)refresh {
    
    if ([[self.dataSource objectAtIndex:0]isEqual:[NSNull null]]==NO) {
        
        PCNumberResultCtrl *list = [self.dataSource objectAtIndex:0];
        
        [list initDataWithissue:self.index Withsort:self.sort];
    }
    if ([[self.dataSource objectAtIndex:1]isEqual:[NSNull null]]==NO) {
        
        PCHotCoolCtrl *list = [self.dataSource objectAtIndex:1];
        
        [list initData];
    }
    if ([[self.dataSource objectAtIndex:2]isEqual:[NSNull null]]==NO) {
        
        PCGraphCtrl *list = [self.dataSource objectAtIndex:2];
        
        [list initDataWithissue:self.index Withsort:self.sort];
    }
    if ([[self.dataSource objectAtIndex:3]isEqual:[NSNull null]]==NO) {
        
        PCGraphCtrl *list = [self.dataSource objectAtIndex:3];
        
        [list initDataWithissue:self.index Withsort:self.sort];
    }
    if ([[self.dataSource objectAtIndex:4]isEqual:[NSNull null]]==NO) {
        
        PCGraphCtrl *list = [self.dataSource objectAtIndex:4];
        
        [list initDataWithissue:self.index Withsort:self.sort];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
