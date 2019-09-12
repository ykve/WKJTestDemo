//
//  FormulaCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/6.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "FormulaCtrl.h"
#import "FormulaListCtrl.h"
#import "FormulaBottomView.h"
@interface FormulaCtrl ()

@property (nonatomic, strong)CJScroViewBar *formulaBar;

@property (nonatomic, strong)FormulaBottomView *bottomView;

@property (nonatomic, copy) NSString *date;
@end

@implementation FormulaCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"公式杀号";
    self.view.backgroundColor = [UIColor whiteColor];
    self.date = [Tools getlocaletime];
    [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] WFSMImage] With:^(UIButton *sender) {
        
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        
        [alert buildformulaInfoView];
        
        [alert show];
    }];
    @weakify(self)
    if (self.lottery_type == 4) {
        
        [self buildTimeViewWithType:self.lottery_type With:nil With:^{
            @strongify(self)
            [self refresh];
        }];
    }
    else{
        [self buildTimeViewWithType:self.lottery_type With:^(UIButton *sender) {
            @strongify(self)
            ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
            
            alert.lastDate = self.date;
            
            [alert builddateView:^(NSString *date) {
                @strongify(self)
                self.date = date;
                
                NSInteger index = self.scrollView.contentOffset.x / SCREEN_WIDTH;
                
                [sender setTitle:date forState:UIControlStateNormal];
                
                FormulaListCtrl *list = [self.dataSource objectAtIndex:index];
                list.lottery_type = self.lottery_type;
                [list initDataWithtime:date];
            }];
            
            [alert show];
        } With:^{
            @strongify(self)
            [self refresh];
        }];
    }
 
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
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_xglhc" object:nil];
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
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xglhc" object:nil];
            break;
    }
    
}


-(void)buildScrollBar {
    
    NSArray *titles = nil;
    if (self.lottery_type == 1 || self.lottery_type == 2 || self.lottery_type == 3) {
        
        titles = @[@"第一球",@"第二球",@"第三球",@"第四球",@"第五球"];
    }
    else if (self.lottery_type == 6 || self.lottery_type == 7 || self.lottery_type == 11) {
        titles = @[@"冠军",@"亚军",@"第三名",@"第四名",@"第五名",@"第六名",@"第七名",@"第八名",@"第九名",@"第十名"];
    }
    else if (self.lottery_type == 4) {
        titles = @[@"正码",@"特码"];
    }
    for (int i = 0; i< titles.count ;i++) {
        
        [self.dataSource addObject:[NSNull null]];
    }
    
    self.formulaBar = [[CJScroViewBar alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT+34, SCREEN_WIDTH, 44)];
    self.formulaBar.lineColor = [[CPTThemeConfig shareManager]pushDanSubBarSelectTextColor];
    self.formulaBar.backgroundColor = [[CPTThemeConfig shareManager] pushDanSubbarBackgroundcolor];
    [self.view addSubview:self.formulaBar];
    
    self.scrollView.frame = CGRectMake(0, NAV_HEIGHT + 34 + 44, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 34 - 44 - 120);
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * titles.count, self.scrollView.bounds.size.height);
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];

    [self.formulaBar layoutIfNeeded];
    
    [self.formulaBar setData:titles NormalColor:[[CPTThemeConfig shareManager] gongShiShaHaoFormuTitleNormalColor] SelectColor:[[CPTThemeConfig shareManager]pushDanSubBarSelectTextColor] Font:[UIFont systemFontOfSize:16]];
    @weakify(self)
    [self.formulaBar getViewIndex:^(NSString *title, NSInteger index) {
        @strongify(self)
        if ([[self.dataSource objectAtIndex:index] isEqual:[NSNull null]]) {
            
            FormulaListCtrl *list = [[FormulaListCtrl alloc]init];
            list.lottery_type = self.lottery_type;
            list.number = index + 1;
            list.StatisticsBlock = ^(NSDictionary *statis) {
                @strongify(self)
                [self updataBottomData:statis];
            };
            list.view.frame = CGRectMake(SCREEN_WIDTH *index, 0, SCREEN_WIDTH, self.scrollView.bounds.size.height);
            [self addChildViewController:list];
            [self.scrollView addSubview:list.view];
            [self.dataSource replaceObjectAtIndex:index withObject:list];
        }
        else {
            
            FormulaListCtrl *list = [self.dataSource objectAtIndex:index];
            
            [self updataBottomData:list.StatisticsDic];
            
        }
        [UIView animateWithDuration:0.3 animations:^{
            @strongify(self)
            self.scrollView.contentOffset = CGPointMake(index * SCREEN_WIDTH, 0);
        }];
    }];
    
    [self.formulaBar setViewIndex:0];
    
}

-(void)updataBottomData:(NSDictionary *)statis {
    
    if ([statis valueForKey:@"count"]) {
        
        NSArray *array = [statis valueForKey:@"count"];
        
        NSArray *arr1,*arr2,*arr3;
        
        for (int i = 0; i< array.count; i++) {
            
            NSDictionary *dic = array[i];
            
            switch (i) {
                case 0:
                    arr1 = @[dic[@"sin"],dic[@"sec"],dic[@"cos"],dic[@"cot"],dic[@"tan"]];
                    break;
                case 1:
                    arr2 = @[dic[@"sin"],dic[@"sec"],dic[@"cos"],dic[@"cot"],dic[@"tan"]];
                    break;
                case 2:
                    arr3 = @[dic[@"sin"],dic[@"sec"],dic[@"cos"],dic[@"cot"],dic[@"tan"]];
                    break;
                default:
                    break;
            }
        }
        
        for (int i = 0; i< 5;i++) {
            
            UILabel *lab1 = self.bottomView.accuracylabs[i];
            UILabel *lab2 = self.bottomView.currentlabs[i];
            UILabel *lab3 = self.bottomView.maxlabs[i];
            
            NSNumber *number1 = arr1[i];
            NSNumber *number2 = arr2[i];
            NSNumber *number3 = arr3[i];
            lab1.text = [NSString stringWithFormat:@"%@%@",number1.stringValue,@"%"];
            lab2.text = number2.stringValue;
            lab3.text = number3.stringValue;
        }
    }
    else {
    
        for (int i = 0; i< 5;i++) {
            
            UILabel *lab1 = self.bottomView.accuracylabs[i];
            UILabel *lab2 = self.bottomView.currentlabs[i];
            UILabel *lab3 = self.bottomView.maxlabs[i];
            
            NSNumber *number1 = statis[@"win"][i];
            NSNumber *number2 = statis[@"current"][i];
            NSNumber *number3 = statis[@"max"][i];
            lab1.text = [NSString stringWithFormat:@"%@%@",number1.stringValue,@"%"];
            lab2.text = number2.stringValue;
            lab3.text = number3.stringValue;
        }
    }
}

#pragma mark - 滚动标题代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    [self.formulaBar setViewIndex:index];
}

-(void)Statistics:(UIButton *)sender {
    
    @weakify(self)
    if (self.bottomView.frame.origin.y<SCREEN_HEIGHT) {
        
        [UIView animateWithDuration:0.15 animations:^{
            @strongify(self)
            self.bottomView.frame = CGRectMake(0, SCREEN_HEIGHT + SAFE_HEIGHT, SCREEN_WIDTH, 120);
        }];
    }
    else {
        [UIView animateWithDuration:0.15 animations:^{
            
            
        }];
    }
}

-(FormulaBottomView *)bottomView {
    
    if (!_bottomView) {
        
        _bottomView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([FormulaBottomView class]) owner:self options:nil]firstObject];
        
        [self.view addSubview:_bottomView];
        [self.view sendSubviewToBack:_bottomView];
        
        _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - 120, SCREEN_WIDTH, 120);
    }
    return _bottomView;
}

-(void)refresh {
    
    int i = 0;
    for (id data in self.dataSource) {
        
        if ([data isKindOfClass:[UIViewController class]]) {
            
            FormulaListCtrl *list = [self.dataSource objectAtIndex:i];
            list.lottery_type = self.lottery_type;
            [list initDataWithtime:self.date];
        }
        i++;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
