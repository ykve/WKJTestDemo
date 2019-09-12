//
//  SixBarCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/3.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixBarCtrl.h"
#import "WDLineChartView.h"
@interface SixBarCtrl ()
@property (nonatomic, strong) WDLineChartView * barView;
@property (nonatomic, strong) UILabel *versionlab;
@property (nonatomic, strong) NSMutableArray *xValues , *yValues;
@end

@implementation SixBarCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.titlestring = self.type == 1 ? @"特码两面分析图" : @"正码总分历史图";
    
    self.versionlab = [Tools createLableWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 35) andTitle:@"当前统计的期数：100" andfont:FONT(15) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
    [self.view addSubview:self.versionlab];
    
    self.barView = [WDLineChartView lineChartViewWithFrame:CGRectMake(0,NAV_HEIGHT + 35,SCREEN_WIDTH,148)];
    
    [self.view addSubview:self.barView];

    self.barView.showGrid = NO;
    self.barView.showPoint = NO;
    self.barView.lineColor = BASECOLOR;
    self.barView.showFoldLine = NO;
    self.barView.xbgColor = BUTTONCOLOR;
    self.barView.xColor = WHITE;
    self.barView.pillarColor = kColor(225, 54, 35);
    self.barView.pillarsW = 25;
    self.barView.typestr = @"类型";
    
    self.versionnumber = @"100";
    
    //投注按钮
    [self buildBettingBtn];
    
}

-(void)setVersionnumber:(NSString *)versionnumber {
    
    [super setVersionnumber:versionnumber];
    
    self.versionlab.text = [NSString stringWithFormat:@"当前统计的期数：%@",versionnumber];
    
    [self initData];
    
}

-(void)initData{

    [self.xValues removeAllObjects];
    [self.yValues removeAllObjects];
    
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/getInfoA.json" params:@{@"type":self.type == 1 ? @"605" : @"611",@"issue":self.versionnumber} success:^(BaseData *data) {
        @strongify(self)
        for (NSDictionary *dic in data.data) {
            
            [self.xValues addObject:dic[@"type"]];
            [self.yValues addObject:dic[@"num"]];
        }
        
        self.barView.xValues = self.xValues;
        
        self.barView.yValues = self.yValues;
        
        self.barView.everyW = (SCREEN_WIDTH - 40) / self.barView.xValues.count;
        
        [self.barView drawChartView];
        
    } failure:^(NSError *error) {
        
        
    }];
}

-(NSMutableArray *)xValues {
    
    if (!_xValues) {
        
        _xValues = [[NSMutableArray alloc]init];
    }
    return _xValues;
}

-(NSMutableArray *)yValues {
    
    if (!_yValues) {
        
        _yValues = [[NSMutableArray alloc]init];
    }
    return _yValues;
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
