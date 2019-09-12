//
//  CartListCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartListCtrl.h"
#import "CartNormalCtrl.h"
#import "CartAppendCtrl.h"
#import "IGKbetModel.h"
#import "CountDown.h"
#import "MSWeakTimer.h"
@interface CartListCtrl ()<WB_StopWatchDelegate>

@property (nonatomic, strong)UILabel *endtimelab;

@property (nonatomic, strong)UILabel *nextversionslab;

@property (nonatomic, copy) NSString *nextversion;

@property (nonatomic, strong)WB_Stopwatch *stopwatch;

@property (nonatomic, strong)UIButton *normalBtn;

@property (nonatomic, strong)UIButton *appendBtn;

@property (nonatomic, strong)CartNormalCtrl *normalVC;

@property (nonatomic, strong)CartAppendCtrl *appendVC;
@property (strong, nonatomic)  CountDown *countDownForLabel;
@property (strong, nonatomic)  MSWeakTimer *timer;;

@end

@implementation CartListCtrl

- (void)cannelTimer{
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
    if(_countDownForLabel){
        [_countDownForLabel destoryTimer];
        _countDownForLabel= nil;
    }
}

- (void)popback{
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
    [super popback];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
    [self.stopwatch reset];
    self.stopwatch.delegate = nil;
    self.stopwatch = nil;
    
    [self removenotification];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self addnotification];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titlestring = @"购彩篮";
    @weakify(self)
    [self rigBtn:@"清空列表" Withimage:nil With:^(UIButton *sender) {
        @strongify(self)
        if([self.dataSource count]<=0){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"购彩篮为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        [AlertViewTool alertViewToolShowTitle:@"" message:@"确定清空购彩篮？" cancelTitle:@"取消" confiormTitle:@"确定" fromController:self handler:^(NSInteger index) {
            if (index == 1) {
  
                @strongify(self)
                [self.normalVC clearlist];
                [[CPTBuyDataManager shareManager] clearCartArray];
                [MBProgressHUD showSuccess:@"已清空购彩篮" finish:^{
                    @strongify(self)
                    [self popback];
                }];
            }
        }];
    }];
//    WS(weakSelf);
    
    self.rightBtn.backgroundColor = WHITE;
    [self.rightBtn setTitleColor:YAHEI forState:UIControlStateNormal];
    self.rightBtn.layer.cornerRadius = 15;
    [self.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.titlelab);
        make.right.equalTo(self.navView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 33)];
    topview.backgroundColor = kColor(255, 248, 224);
    [self.view addSubview:topview];
    
    self.endtimelab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
    [topview addSubview:self.endtimelab];
    
    self.nextversionslab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:2];
    [topview addSubview:self.nextversionslab];
    
    [self.endtimelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(topview);
        make.left.equalTo(topview.mas_centerX);
    }];
    [self.nextversionslab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(topview);
        make.right.equalTo(topview.mas_centerX);
    }];
    
//    self.stopwatch = [[WB_Stopwatch alloc]initWithLabel:self.endtimelab andTimerType:WBTypeTimer];
//    self.stopwatch.delegate = self;
//    if (self.lottery_type == 4) {
//
//        [self.stopwatch setTimeFormat:@"dd天HH时mm分ss秒"];
//    }else{
//        [self.stopwatch setTimeFormat:@"HH:mm:ss"];
//    }
    [self addSubVC];
    [self getnextissue];
}

-(void)addnotification {
    
//    switch (self.lottery_type) {
//        case 1:
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_cqssc" object:nil];
//            break;
//        case 2:
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_xjssc" object:nil];
//            break;
//        case 3:
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_txffc" object:nil];
//            break;
//        case 4:
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_xglhc" object:nil];
//            break;
//        case 5:
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_pcegg" object:nil];
//            break;
//        case 6:
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_bjpks" object:nil];
//            break;
//        default:
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_xyft" object:nil];
//
//            break;
//    }
}

-(void)removenotification {
    
//    switch (self.lottery_type) {
//        case 1:
//            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_cqssc" object:nil];
//            break;
//        case 2:
//            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xjssc" object:nil];
//            break;
//        case 3:
//            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_txffc" object:nil];
//            break;
//        case 4:
//            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xglhc" object:nil];
//            break;
//        case 5:
//            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_pcegg" object:nil];
//            break;
//        case 6:
//            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_bjpks" object:nil];
//            break;
//        default:
//            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xyft" object:nil];
//            break;
//    }
    
}

-(void)refresh {
    [self.appendVC endtimeRefresh];
    [self getnextissue];
}

-(void)addSubVC {
    
//    if (self.lotteryId == 4) {
//
//        self.normalVC = [[CartNormalCtrl alloc]init];
//        self.normalVC.dataSource = self.dataSource;
//        self.normalVC.selectModel = self.selectModel;
//        self.normalVC.updataArray = self.updataArray;
//        self.normalVC.lotteryId = self.lotteryId;
//        [self addChildViewController:self.normalVC];
//        self.normalVC.view.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT);
//        [self.view addSubview:self.normalVC.view];
//    }
//    else {
        CGFloat btnwidth = (SCREEN_WIDTH - 60)/2;
        self.normalBtn = [Tools createButtonWithFrame:CGRectMake(20, NAV_HEIGHT + 50, btnwidth, 28) andTitle:@"普通投注" andTitleColor:kColor(192, 26, 39) andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(typeClick:) andType:UIButtonTypeCustom];
        self.normalBtn.layer.cornerRadius = 5;
        self.normalBtn.layer.borderColor =kColor(192, 26, 39).CGColor;
        self.normalBtn.layer.borderWidth = 1;
        [self.view addSubview:self.normalBtn];
        
        self.appendBtn = [Tools createButtonWithFrame:CGRectMake(40 + btnwidth, NAV_HEIGHT + 50, btnwidth, 28) andTitle:@"追号投注" andTitleColor:kColor(192, 26, 39) andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(typeClick:) andType:UIButtonTypeCustom];
        self.appendBtn.layer.cornerRadius = 5;
        self.appendBtn.layer.borderColor =kColor(192, 26, 39).CGColor;
        self.appendBtn.layer.borderWidth = 1;
        [self.view addSubview:self.appendBtn];
        
        self.normalVC = [[CartNormalCtrl alloc]init];
        self.normalVC.dataSource = self.dataSource;
        self.normalVC.selectModel = self.selectModel;
        self.normalVC.updataArray = self.updataArray;
        self.normalVC.lotteryId = self.lotteryId;
        [self addChildViewController:self.normalVC];
        
        self.appendVC = [[CartAppendCtrl alloc]initWithNibName:@"CartAppendCtrl" bundle:[NSBundle mainBundle]];
        self.appendVC.dataSource = self.dataSource;
        self.appendVC.selectModel = self.selectModel;
        self.appendVC.updataArray = self.updataArray;
        self.appendVC.lotteryId = self.lotteryId;
        [self addChildViewController:self.appendVC];
        
        self.scrollView.frame = CGRectMake(0, NAV_HEIGHT + 80, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 80);
        [self.view addSubview:self.scrollView];
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 1, 0);
        self.normalVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.frame.size.height);
        [self.scrollView addSubview:self.normalVC.view];
        self.appendVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.frame.size.height);
        [self.scrollView addSubview:self.appendVC.view];
        
        [self typeClick:self.normalBtn];
//    }
    
}

#pragma mark - 获取下期开奖期数和时间
-(void)getnextissue {
    
    WS(weakSelf);
    [[CPTOpenLotteryManager shareManager] checkModelByIds:@[@(self.type)] callBack:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
        NSString * nextversion;
        NSInteger  time;
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        switch (self.type) {
            case CPTBuyTicketType_LiuHeCai:
            {
                SixInfoModel *firstmodel = data.lhc;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
            }
                break;
            case CPTBuyTicketType_OneLiuHeCai:
            {
                SixInfoModel *firstmodel = data.onelhc;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
            }
                break;
            case CPTBuyTicketType_FiveLiuHeCai:
            {
                SixInfoModel *firstmodel = data.fivelhc;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
            }
                break;
            case CPTBuyTicketType_ShiShiLiuHeCai:
            {
                SixInfoModel *firstmodel = data.sslhc;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
            }
                break;
            case CPTBuyTicketType_PK10:{
                PK10InfoModel *firstmodel = data.bjpks;
                nextversion= [NSString stringWithFormat:@"%ld",firstmodel.nextIssue];
                time = firstmodel.nextTime;
            }break;
            case CPTBuyTicketType_TenPK10:{
                PK10InfoModel *firstmodel = data.tenpks;
                nextversion = [NSString stringWithFormat:@"%ld",firstmodel.nextIssue];
                time = firstmodel.nextTime;
            }break;
            case CPTBuyTicketType_FivePK10:{
                PK10InfoModel *firstmodel = data.fivepks;
                nextversion = [NSString stringWithFormat:@"%ld",firstmodel.nextIssue];
                time = firstmodel.nextTime;
            }break;
            case CPTBuyTicketType_JiShuPK10:{
                PK10InfoModel *firstmodel = data.jspks;
                nextversion = [NSString stringWithFormat:@"%ld",firstmodel.nextIssue];
                time = firstmodel.nextTime;
            }break;
                
            case CPTBuyTicketType_XYFT:{
                PK10InfoModel *firstmodel = data.xyft;
                nextversion = [NSString stringWithFormat:@"%ld",firstmodel.nextIssue];
                time = firstmodel.nextTime;
            }break;
                
            case CPTBuyTicketType_SSC:
            {
                ChongqinInfoModel *firstmodel = data.cqssc;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
            } break;
            case CPTBuyTicketType_TJSSC:
            {
                ChongqinInfoModel *firstmodel = data.tjssc;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
            } break;
            case CPTBuyTicketType_TenSSC:
            {
                ChongqinInfoModel *firstmodel = data.tenssc;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
            } break;
            case CPTBuyTicketType_FiveSSC:
            {
                ChongqinInfoModel *firstmodel = data.fivessc;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
            } break;
            case CPTBuyTicketType_JiShuSSC:{
                ChongqinInfoModel *firstmodel = data.jsssc;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
            }break;
                
            case CPTBuyTicketType_XJSSC:
            {
                ChongqinInfoModel *firstmodel = data.xjssc;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
            } break;
            case CPTBuyTicketType_FFC:
            {
                ChongqinInfoModel *firstmodel = data.txffc;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
            } break;
            case CPTBuyTicketType_PCDD:
            {
                LotteryInfoModel *firstmodel = data.pcegg;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
                
            } break;
            case CPTBuyTicketType_FantanPK10:
            {
                PK10InfoModel *firstmodel = data.jspks;
                nextversion = [NSString stringWithFormat:@"%ld",firstmodel.nextIssue];
                time = firstmodel.nextTime;
                
            } break;
            case CPTBuyTicketType_FantanXYFT:
            {
                PK10InfoModel *firstmodel = data.xyft;
                nextversion = [NSString stringWithFormat:@"%ld",firstmodel.nextIssue];
                time = firstmodel.nextTime;
                
            } break;
            case CPTBuyTicketType_FantanSSC:
            {
                ChongqinInfoModel *firstmodel = data.jsssc;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
            } break;
            case CPTBuyTicketType_NiuNiu_KuaiLe:
            {
                ChongqinInfoModel *firstmodel = data.fivessc;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
            } break;
            case CPTBuyTicketType_NiuNiu_JiShu:
            {
                PK10InfoModel *firstmodel = data.jspks;
                nextversion = [NSString stringWithFormat:@"%ld",firstmodel.nextIssue];
                time = firstmodel.nextTime;
                
            } break;
            case CPTBuyTicketType_HaiNanQiXingCai:{
                LotteryInfoModel *firstmodel = data.haiNanQiXingCai;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
            }break;
            case CPTBuyTicketType_PaiLie35:{
                LotteryInfoModel *firstmodel = data.paiLie35;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
            }break;
            case CPTBuyTicketType_Shuangseqiu:{
                LotteryInfoModel *firstmodel = data.shuangseqiu;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
            }break;
            case CPTBuyTicketType_DaLetou:{
                LotteryInfoModel *firstmodel = data.daLetou;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
            }break;
            case CPTBuyTicketType_QiLecai:{
                LotteryInfoModel *firstmodel = data.qiLecai;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
            }break;
            case CPTBuyTicketType_3D:{
                LotteryInfoModel *firstmodel = data.threeD;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
            }break;
            case CPTBuyTicketType_AoZhouACT:{
                LotteryInfoModel *firstmodel = data.aoZhouACT;
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
            }break;
            case CPTBuyTicketType_AoZhouF1:{
                PK10InfoModel *firstmodel = [[PK10InfoModel alloc] init];
                firstmodel.nextTime = data.aozhouF1.nextTime;
                firstmodel.issue = data.aozhouF1.issue;
                firstmodel.nextIssue = [data.aozhouF1.nextIssue integerValue];
                firstmodel.nextTime = data.aozhouF1.nextTime;
                firstmodel.number = data.aozhouF1.number;
                nextversion = [NSString stringWithFormat:@"%ld",firstmodel.nextIssue];
                time = firstmodel.nextTime;
                
            }break;
            case CPTBuyTicketType_AoZhouShiShiCai:{
                ChongqinInfoModel *firstmodel = [[ChongqinInfoModel alloc] init];
                firstmodel.nextTime = data.aozhouSSC.nextTime;
                firstmodel.issue = data.aozhouSSC.issue;
                firstmodel.nextIssue = data.aozhouSSC.nextIssue;
                firstmodel.nextTime = data.aozhouSSC.nextTime;
                firstmodel.numbers = [data.aozhouSSC.number componentsSeparatedByString:@","];
                nextversion = firstmodel.nextIssue;
                time = firstmodel.nextTime;
                
            }break;
            case CPTBuyTicketType_NiuNiu_AoZhou:{
                PK10InfoModel *firstmodel = [[PK10InfoModel alloc] init];
                firstmodel.nextTime = data.aozhouF1.nextTime;
                firstmodel.issue = data.aozhouF1.issue;
                firstmodel.nextIssue = [data.aozhouF1.nextIssue integerValue];
                firstmodel.nextTime = data.aozhouF1.nextTime;
                firstmodel.number = data.aozhouF1.number;
                nextversion = [NSString stringWithFormat:@"%ld",firstmodel.nextIssue];
                time = firstmodel.nextTime;
            }break;

            default:
                nextversion = @" ";
                time = now+100;
                break;
        }
        if(!_countDownForLabel){
            _countDownForLabel = [[CountDown alloc] init];
        }
        if(_timer){
            [_timer invalidate];
            _timer = nil;
        }
        weakSelf.nextversionslab.text = [NSString stringWithFormat:@"%@期投注截止：",nextversion];
        weakSelf.normalVC.nextversion = nextversion;
        weakSelf.appendVC.nextversion = nextversion;
//        weakSelf.stopwatch.startTimeInterval = now;
//        [weakSelf.stopwatch setCountDownTime:time];//多少秒 （1分钟 == 60秒）
//        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        @weakify(self)
        [_countDownForLabel countDownWithStratTimeStamp:now finishTimeStamp:time completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
            @strongify(self)
            NSString * hourS;
            NSString * minS;
            NSString * secondS;
            
            if (hour<10) {
                hourS = [NSString stringWithFormat:@"0%ld",(long)hour];
            }else{
                hourS = [NSString stringWithFormat:@"%ld",(long)hour];
            }
            if (minute<10) {
                minS = [NSString stringWithFormat:@"0%ld",(long)minute];
            }else{
                minS = [NSString stringWithFormat:@"%ld",(long)minute];
            }
            if (second<10) {
                secondS = [NSString stringWithFormat:@"0%ld",(long)second];
            }else{
                secondS = [NSString stringWithFormat:@"%ld",(long)second];
            }
            if([hourS integerValue]<=0){
                self.endtimelab .text = [NSString stringWithFormat:@"%@:%@",minS,secondS];
            }else{
                self.endtimelab .text = [NSString stringWithFormat:@"%@:%@:%@",hourS,minS,secondS];
            }
            NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
            if(totoalSecond ==0){
                @strongify(self)

                self.nextversionslab.text = @"正在开奖...";
                if(_timer){
                    [_timer invalidate];
                    _timer = nil;
                }
                _timer = [MSWeakTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getnextissues) userInfo:nil repeats:YES dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
            }else{
                //            [weakSelf pk10Anmation];
            }
        }];
        
//        if (time>=0) {
//            [weakSelf.stopwatch start];
//        }
    }];
//    [Tools getNextOpenTime:self.lottery_type Withresult:^(NSDictionary *dic) {
//
//        weakSelf.nextversion = STRING(dic[@"issue"]);
//        weakSelf.nextversionslab.text = [NSString stringWithFormat:@"%@期投注截止：",self.nextversion];
//        weakSelf.normalVC.nextversion = self.nextversion;
//        weakSelf.appendVC.nextversion = self.nextversion;
//        weakSelf.stopwatch.startTimeInterval = [dic[@"start"]integerValue];
//        [weakSelf.stopwatch setCountDownTime:[dic[@"time"]integerValue]];//多少秒 （1分钟 == 60秒）
//        if ([dic[@"time"]integerValue]>=0) {
//            [weakSelf.stopwatch start];
//        }
//
//    }];
}

- (void)getnextissues{
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        [self.appendVC endtimeRefresh];
        [self getnextissue];
    });
}

//时间到了
-(void)timerLabel:(WB_Stopwatch*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    self.nextversionslab.text = @"正在开奖...";
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [MSWeakTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getnextissues) userInfo:nil repeats:YES dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}


//开始倒计时
-(void)timerLabel:(WB_Stopwatch*)timerlabel
       countingTo:(NSTimeInterval)time
        timertype:(WB_StopwatchLabelType)timerType {
    //    NSLog(@"time:%f",time);
    
}

-(void)typeClick:(UIButton *)sender {
    
    if (sender == self.normalBtn) {
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        self.normalBtn.backgroundColor = kColor(192, 26, 39);
        [self.normalBtn setTitleColor:WHITE forState:UIControlStateNormal];
        self.appendBtn.backgroundColor = WHITE;
        [self.appendBtn setTitleColor:kColor(192, 26, 39) forState:UIControlStateNormal];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"暂未开放" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
        
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        self.appendBtn.backgroundColor = kColor(192, 26, 39);
        [self.appendBtn setTitleColor:WHITE forState:UIControlStateNormal];
        self.normalBtn.backgroundColor = WHITE;
        [self.normalBtn setTitleColor:kColor(192, 26, 39) forState:UIControlStateNormal];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x == 0) {

        [self typeClick:self.normalBtn];
    }
    else if (scrollView.contentOffset.x == SCREEN_WIDTH) {

        [self typeClick:self.appendBtn];
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
