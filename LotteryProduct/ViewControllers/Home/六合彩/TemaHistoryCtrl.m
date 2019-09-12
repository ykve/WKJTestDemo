//
//  TemaHistoryCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/12.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "TemaHistoryCtrl.h"
#import "WDLineChartView.h"
#import "SixModel.h"
@interface TemaHistoryCtrl ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topconst;
@property (weak, nonatomic) IBOutlet UILabel *hottitlelab;
@property (weak, nonatomic) IBOutlet UILabel *cooltitlelab;
@property (weak, nonatomic) IBOutlet UIView *hotbgView;
@property (weak, nonatomic) IBOutlet UIView *coolbgView;
@property (weak, nonatomic) IBOutlet UILabel *toptitlelab;
@property (nonatomic, strong) WDLineChartView * hotlineView;
@property (nonatomic, strong) WDLineChartView * coollineView;

@property (nonatomic, strong) NSMutableArray *hotxValues , *hotyValues, *coolxValues, *coolyValues;

@end

@implementation TemaHistoryCtrl

-(NSMutableArray *)hotxValues {
    
    if (!_hotxValues) {
        
        _hotxValues = [[NSMutableArray alloc]init];
    }
    return _hotxValues;
}

-(NSMutableArray *)hotyValues {
    
    if (!_hotyValues) {
        
        _hotyValues = [[NSMutableArray alloc]init];
    }
    return _hotyValues;
}

-(NSMutableArray *)coolxValues {
    
    if (!_coolxValues) {
        
        _coolxValues = [[NSMutableArray alloc]init];
    }
    return _coolxValues;
}

-(NSMutableArray *)coolyValues {
    
    if (!_coolyValues) {
        
        _coolyValues = [[NSMutableArray alloc]init];
    }
    return _coolyValues;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.topconst.constant = NAV_HEIGHT + 15;
    
    self.titlestring = self.type == 622 ? @"正码历史冷热图" : @"特码历史冷热图";
    self.hottitlelab.text = self.type == 622 ? @"正码历史热图" : @"特码历史热图";
    self.cooltitlelab.text = self.type == 622 ? @"正码历史冷图" : @"特码历史冷图";
    [self setwhiteC];
    self.hotlineView = [WDLineChartView lineChartViewWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,148)];
    
    [self.hotbgView addSubview:self.hotlineView];
    
    self.coollineView = [WDLineChartView lineChartViewWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,148)];
    
    [self.coolbgView addSubview:self.coollineView];
    
    self.hotlineView.showPillar = NO;
    self.coollineView.showPillar = NO;
    self.hotlineView.pointType = 1;
    self.coollineView.pointType = 1;
    self.hotlineView.lineColor = [UIColor orangeColor];
    self.hotlineView.xbgColor = BUTTONCOLOR;
    self.coollineView.xbgColor = BUTTONCOLOR;
    self.hotlineView.xColor = WHITE;
    self.coollineView.xColor = WHITE;
    self.hotlineView.typestr = @"号码";
    self.coollineView.typestr = @"号码";
    
    self.versionnumber = @"100";
    
    //投注按钮
    [self buildBettingBtn];
    
}

-(void)setVersionnumber:(NSString *)versionnumber {
    
    [super setVersionnumber:versionnumber];
    
    self.toptitlelab.text = [NSString stringWithFormat:@"当前统计的期数：%@",versionnumber];
    
    [self initData];
    
}

-(void)initData {
    
    [self.hotyValues removeAllObjects];
    [self.hotxValues removeAllObjects];
    [self.coolyValues removeAllObjects];
    [self.coolxValues removeAllObjects];
    
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/getInfoB.json" params:@{@"type":[NSString stringWithFormat:@"%ld",self.type],@"issue":self.versionnumber} success:^(BaseData *data) {
        @strongify(self)
        NSArray *hot = [SixModel mj_objectArrayWithKeyValuesArray:[data.data firstObject]];
        
        NSSortDescriptor *numberSD = [NSSortDescriptor sortDescriptorWithKey:@"num" ascending:NO];
        
        hot = [hot sortedArrayUsingDescriptors:@[numberSD]];
        
        for (SixModel *dic in hot) {
            
            [self.hotxValues addObject:dic.type];
            
            [self.hotyValues addObject:@(dic.num)];
        }
        
        self.hotlineView.xValues = self.hotxValues;
        
        self.hotlineView.yValues = self.hotyValues;
        
        NSArray *cool = [SixModel mj_objectArrayWithKeyValuesArray:[data.data lastObject]];
        
        cool = [cool sortedArrayUsingDescriptors:@[numberSD]];
        
        for (SixModel *dic in cool) {
            
            [self.coolxValues addObject:dic.type];
            
            [self.coolyValues addObject:@(dic.num)];
        }
        
        self.coollineView.xValues = self.coolxValues;
        
        self.coollineView.yValues = self.coolyValues;
        
        [self.hotlineView drawChartView];
        
        [self.coollineView drawChartView];
        
    } failure:^(NSError *error) {
        
        
    } showHUD:NO];
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
