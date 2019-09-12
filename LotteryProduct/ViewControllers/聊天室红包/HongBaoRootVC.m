
//
//  HongBaoRootVC.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/15.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "HongBaoRootVC.h"
#import "HongBaoVC.h"

@interface HongBaoRootVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) CJScroViewBar *topView;
@end

@interface HongBaoRootVC ()



@end

@implementation HongBaoRootVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)loadView{
    [super loadView];
    _topView = [[CJScroViewBar alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 40)];
    [self.view addSubview:self.topView];
    self.topView.isHongbao = YES;
    self.topView.lineHeight = 2.0;
    self.topView.backgroundColor = CLEAR;
    self.topView.lineColor = CLEAR;
    
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT+40, SCREEN_WIDTH, SCREEN_HEIGHT-40-NAV_HEIGHT)];
    self.myScrollView.delegate = self;
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.bounces = NO;
    self.myScrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:self.myScrollView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titlestring = @"红包记录";

    NSArray * playArray = @[@"领取记录",@"发送记录"];
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        [self.topView setData:playArray NormalColor:[UIColor hexStringToColor:@"#666666"] SelectColor:[UIColor hexStringToColor:@"#FFFFFF"]  Font:[UIFont systemFontOfSize:13]];
    }else{
        [self.topView setData:playArray NormalColor:[[CPTThemeConfig shareManager] CartBarTitleNormalColor] SelectColor: [[CPTThemeConfig shareManager] CartBarTitleSelectColor] Font:[UIFont systemFontOfSize:13]];
    }
    
    self.myScrollView.contentSize = CGSizeMake(playArray.count*SCREEN_WIDTH, 0);
    for (int i=0; i<playArray.count; i++) {
        
        HongBaoVC * vc;
        vc = [[HongBaoVC alloc] init];
        vc.type = i+1;
        vc.view.frame = CGRectMake(SCREEN_WIDTH *i, 0, SCREEN_WIDTH, self.myScrollView.bounds.size.height);
        [self addChildViewController:vc];
        [self.myScrollView addSubview:vc.view];
    }
    [self.topView setViewIndex:0];
    @weakify(self)
    [self.topView getViewIndex:^(NSString *title, NSInteger index) {
        [UIView animateWithDuration:0.3 animations:^{
            @strongify(self)
            self.myScrollView.contentOffset = CGPointMake(index * SCREEN_WIDTH, 0);
        }];
    }];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self.topView setViewIndex:index];
}

@end
