//
//  PK10VersionTrendCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10VersionTrendCtrl.h"
#import "WDLineChartView.h"
#import "AppDelegate.h"
@interface PK10VersionTrendCtrl ()

@property (nonatomic, strong) CJScroViewBar *placeBar;
@property (nonatomic, strong) CJScroViewBar *numberBar;
@property (nonatomic, strong) WDLineChartView * lineView;
@property (nonatomic, strong) UIButton *curenttypeBtn;
@property (nonatomic, strong) NSMutableArray *xvalues;
@property (nonatomic, strong) NSMutableArray *placeArray;
@property (nonatomic, strong) NSMutableArray *numberArray;
@property (nonatomic, strong) NSMutableArray *sumArray;
@end

@implementation PK10VersionTrendCtrl

-(NSMutableArray *)xvalues {
    
    if (!_xvalues) {
        
        _xvalues = [[NSMutableArray alloc]init];
    }
    return _xvalues;
}

-(NSMutableArray *)placeArray {
    
    if (!_placeArray) {
        
        _placeArray = [[NSMutableArray alloc]init];
        
        for (int i = 0; i<10; i++) {
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            
            [_placeArray addObject:array];
        }
    }
    return _placeArray;
}

-(NSMutableArray *)numberArray {
    
    if (!_numberArray) {
        
        _numberArray = [[NSMutableArray alloc]init];
        
        for (int i = 0; i<10; i++) {
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            
            [_numberArray addObject:array];
        }
    }
    return _numberArray;
}

-(NSMutableArray *)sumArray {
    
    if (!_sumArray) {
        
        _sumArray = [[NSMutableArray alloc]init];
    }
    return _sumArray;
}

-(CJScroViewBar *)placeBar {
    
    if (!_placeBar) {
        
        _placeBar = [[CJScroViewBar alloc]initWithFrame:CGRectMake(0, 44+25, SCREEN_WIDTH, 25)];
        _placeBar.lineColor = [[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor];
        _placeBar.backgroundColor = [[CPTThemeConfig shareManager] pushDanSubbarBackgroundcolor];
        [self.view addSubview:_placeBar];
        [_placeBar layoutIfNeeded];
        
        [_placeBar setData:@[@"冠军",@"亚军",@"第三名",@"第四名",@"第五名",@"第六名",@"第七名",@"第八名",@"第九名",@"第十名"] NormalColor:[[CPTThemeConfig shareManager] pushDanSubBarNormalTitleColor] SelectColor:[[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor] Font:[UIFont systemFontOfSize:16]];
        @weakify(self)
        [_placeBar getViewIndex:^(NSString *title, NSInteger index) {
            @strongify(self)
            NSMutableArray *values = [self.placeArray objectAtIndex:index];
            self.lineView.xValues = self.xvalues;
            self.lineView.yValues = values;
            [self.lineView drawChartView];
        }];
    }
    return _placeBar;
}

-(CJScroViewBar *)numberBar {
    
    if (!_numberBar) {
        
        _numberBar = [[CJScroViewBar alloc]initWithFrame:CGRectMake(0, 44+25, SCREEN_WIDTH, 25)];
        _numberBar.lineColor = [[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor];
        _numberBar.backgroundColor = [[CPTThemeConfig shareManager] pushDanSubbarBackgroundcolor];
        [self.view addSubview:_numberBar];
        
        [_numberBar setData:@[@"号码一",@"号码二",@"号码三",@"号码四",@"号码五",@"号码六",@"号码七",@"号码八",@"号码九",@"号码十"] NormalColor:[[CPTThemeConfig shareManager] pushDanSubBarNormalTitleColor] SelectColor:[[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor] Font:[UIFont systemFontOfSize:16]];

        @weakify(self)
        [_numberBar getViewIndex:^(NSString *title, NSInteger index) {
            @strongify(self)
            NSMutableArray *values = [self.numberArray objectAtIndex:index];
            self.lineView.xValues = self.xvalues;
            self.lineView.yValues = values;
            [self.lineView drawChartView];
        }];
    }
    return _numberBar;
}

-(WDLineChartView *)lineView {
    
    if (!_lineView) {
        
        _lineView = [WDLineChartView lineChartViewWithFrame:CGRectMake(0, 44 + 50, SCREEN_WIDTH, SCREEN_HEIGHT - 44-50)];
        
        [self.view addSubview:_lineView];
  
        _lineView.showPillar = NO;
        _lineView.pointType = 1;
        _lineView.lineColor = LINECOLOR;
        _lineView.pointColor = LINECOLOR;
        _lineView.xbgColor = WHITE;
        _lineView.xColor = YAHEI;
        _lineView.everyW = 40;
        _lineView.typestr = @"";
    }
    return _lineView;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"横版走势";
    self.view.backgroundColor = [[CPTThemeConfig shareManager] pushDanSubbarBackgroundcolor];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //允许转成横屏
    appDelegate.allowRotation = YES;
    //调用横屏代码
    [UIDevice switchNewOrientation:UIInterfaceOrientationLandscapeRight];
    
    self.navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    @weakify(self)
    [self.navView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(44));
    }];
    [self settypeBtn];
    
    [self initData];
    
    //投注按钮
    [self buildBettingBtn];
}

-(void)settypeBtn {
    
    NSArray *titles = @[@"位置走势",@"号码走势",@"冠亚和走势"];
    UIButton *lastBtn = nil;
    for (int i = 0; i< titles.count ; i++) {
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:titles[i] andTitleColor:MAINCOLOR andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(typeClick:) andType:UIButtonTypeCustom];
        [btn setTitleColor:LINECOLOR forState:UIControlStateSelected];
        btn.backgroundColor = WHITE;
        btn.tag = 100+i;
        [self.view addSubview:btn];
        @weakify(self)
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.navView.mas_bottom);
            make.height.equalTo(@25);
            if (lastBtn) {
                
                make.left.equalTo(lastBtn.mas_right);
                
                make.width.equalTo(lastBtn.mas_width);
                
                if (i == titles.count-1) {
                    
                    make.right.equalTo(self.view);
                }
            }
            else {
                make.left.equalTo(self.view);
            }
        }];
        
        lastBtn = btn;
        
        if (i == 0) {
            btn.selected = YES;
            
            self.curenttypeBtn = btn;
        }
    }
}

-(void)initData {
    
    NSString *url = nil;
    if (self.lottery_type == 6) {
        
        url = @"/bjpksSg/getSgTrend.json";
    }
    else if (self.lottery_type == 7) {
        url = @"/xyftSg/getSgTrend.json";
    } else if (self.lottery_type == 11) {
        url = @"/azPrixSg/getSgTrend.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:nil success:^(BaseData *data) {
        
        @strongify(self)
        NSArray *array = data.data;
        
        NSArray *n = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10"];
        for (NSDictionary *dic in array) {
            
            [self.xvalues addObject:[dic[@"issue"] substringFromIndex:[dic[@"issue"] length]-3]];
            
            NSString *number = dic[@"number"];
            
            NSArray *numberarray = [number componentsSeparatedByString:@","];
            
            NSInteger sum  = 0;
        
            for (NSInteger i = 0; i< numberarray.count ; i++) {
                
                NSString *num = [numberarray objectAtIndex:i];
                
                NSMutableArray *arr = self.placeArray[i];
                
                NSMutableArray *arr2 = self.numberArray[i];
                
                [arr addObject:num];
                
                NSInteger index = [numberarray indexOfObject:n[i]] + 1;
                
                [arr2 addObject:INTTOSTRING(index)];
                
                if (i<2) {
                    
                    sum += num.integerValue;
                }
            }
            
            [self.sumArray addObject:INTTOSTRING(sum)];
        }
        
        [self.placeBar setViewIndex:0];
        
    } failure:^(NSError *error) {
        
    }];
}




-(void)typeClick:(UIButton *)sender {
    
    self.curenttypeBtn.selected = NO;
    
    sender.selected = YES;
    
    self.curenttypeBtn = sender;
    
    if (self.curenttypeBtn.tag == 100) {
        
        self.placeBar.hidden = NO;
        self.numberBar.hidden = YES;
        [self.placeBar setViewIndex:0];
    }
    else if (self.curenttypeBtn.tag == 101) {
        
        self.placeBar.hidden = YES;
        self.numberBar.hidden = NO;
        [self.numberBar setViewIndex:0];
    }
    else {
        
        self.placeBar.hidden = YES;
        self.numberBar.hidden = YES;
        
        self.lineView.xValues = self.xvalues;
        self.lineView.yValues = self.sumArray;
        [self.lineView drawChartView];
    }
}

//使用这里的代码也是oK的。 这里利用 NSInvocation 调用 对象的消息
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //禁用侧滑手势方法
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
    //切换到竖屏
    [UIDevice switchNewOrientation:UIInterfaceOrientationPortrait];
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
