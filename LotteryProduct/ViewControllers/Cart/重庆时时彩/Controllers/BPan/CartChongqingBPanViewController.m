//
//  CartChongqingBPanViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/13.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CartChongqingBPanViewController.h"
#import "LeftSelectScroll.h"
#import "IGKbetListCtrl.h"
#import "CartTypeView.h"
#import "SQMenuShowView.h"
#import "BettingRecordViewController.h"
#import "GraphCtrl.h"
#import "FormulaCtrl.h"
#import "FreeRecommendCtrl.h"
#import "CartCQBpanHeaderVeiw.h"
#import "PGGModel.h"
#import "FormulaCtrl.h"
#import "FormulaListCtrl.h"
#import "HalfRedBoViewController.h"
#import "HalfBlueBoViewController.h"
#import "DoubleSideViewController.h"
#import "LiuHeCaiHalfBoViewController.h"
#import "BpanLeftTableViewCell.h"
#import "QianZhongHouViewController.h"
#import "UIImage+color.h"
#import "PCHistoryModel.h"
#import "CartChongqinHeadCell.h"
#import "CartCQOneToFiveViewController.h"
#import "CartTypeModel.h"
#import "CalculateView.h"
#import "CQDouNiuViewController.h"
#import "CartTypeModel.h"
#import "CartCQModel.h"
#import "LoginAlertViewController.h"
#import "KeFuViewController.h"
#import "TopUpViewController.h"
#import "BuyLotBottomView.h"

static NSString *BpanLeftTableViewCellID = @"BpanLeftTableViewCellID";


#define View_WIDTH  0.8 * [UIScreen mainScreen].bounds.size.width

@interface CartChongqingBPanViewController ()<WB_StopWatchDelegate,UITableViewDelegate,UITableViewDataSource,CartCQBpanHeaderVeiwDelegate, DoubleSideViewControllerDelegate>

//CalculateView
@property (nonatomic, strong)NSArray *moneyArray;
//倍数
@property (nonatomic, strong)NSArray *multiArray;

@property (nonatomic, strong) CartCQBpanHeaderVeiw *headView;

@property (nonatomic, strong) WB_Stopwatch *stopwatch;

@property (nonatomic, strong) CartTypeView *typeView;

@property (nonatomic, strong) UIButton *typeBtn;
@property (nonatomic, strong) CartTypeModel *selectModel;
@property (nonatomic, strong) BuyLotBottomView *footView;
@property (nonatomic, strong) UILabel *pricelab;

@property (nonatomic, strong)UIScrollView *leftScrollView;


/**
 玩法设置模式
 */
@property (nonatomic, assign) NSInteger pricetype;
/**
 玩法设置倍数
 */
@property (nonatomic, assign) NSInteger times;
@property (nonatomic, strong) CartChongqinMissModel *missmodel;
/**
 展示表尾，并section =1的列表收回
 */
@property (nonatomic, assign) BOOL showfoot;
@property (nonatomic, strong) BuyLotBottomView *bottomView;

@property (nonatomic, strong) IQTextView *textView;

@property (nonatomic, strong) SQMenuShowView *showView;


@property (nonatomic, strong) NSArray *categoryArray;

//左边分类 tableview
@property(strong,nonatomic)UITableView *leftTableView;
@property (nonatomic, strong) NSMutableArray *detailArray;

@property (nonatomic, assign)int lastPosition;

//记录选中 index
@property (nonatomic, assign)NSInteger selectedIndexPath;
@property (nonatomic, assign)NSInteger lastSelectedIndexPath;
@property (nonatomic, weak)UIButton *lastLeftBtn;
@property (nonatomic, weak)UIButton *currentLeftBtn;

@property (nonatomic, strong)NSMutableArray *LeftBtnsArray;


@property (nonatomic, strong)UILabel *totalcountlab;

@property (nonatomic, strong)UILabel *totalpricelab;

@property (nonatomic, strong)UIButton *publishBtn;

/**
 展示section = 0的列表
 */
@property (nonatomic, assign) BOOL showhead;
//两面 总和传过来的选中的balls
@property (nonatomic, strong)NSMutableArray *doubleSideToatalDragonSelectArray;
//两面 总和传过来的选中的balls
@property (nonatomic, strong)NSMutableArray *doubleSideOtherSelectArray;

//1-5球
@property (nonatomic, strong)NSMutableArray *oneToFiveSelectArray;
//前中后
@property (nonatomic, strong)NSMutableArray *qianZhongHouSelectArray;
//斗牛
@property (nonatomic, strong)NSMutableArray *douNiuSelectArray;

@property (nonatomic, strong)CartChongqinModel *selectBallsModel;



@end

@implementation CartChongqingBPanViewController

#pragma mark 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
        
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(doubleSideSelectTotalDragonBalls:) name:@"doubleSideSelectTotalDragnBall" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(doubleSideSelectOtherBalls:) name:@"doubleSideSelectOtherBall" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(qianZhongHouSelectOtherBall:) name:@"qianZhongHouSelectOtherBall" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ontToFiveSelectOtherBalls:) name:@"ontToFiveSelectOtherBalls" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(douNiuNotification:) name:@"douNiuSelectTotalDragnBall" object:nil];

    //获取购彩一级分类
    [self getTypeRootData];

}


#pragma mark 通知处理
//两面 长龙
- (void)doubleSideSelectTotalDragonBalls : (NSNotification *)noti{

    NSArray *arr = noti.object;
    
    [self.doubleSideToatalDragonSelectArray removeAllObjects];
    
    [self.doubleSideToatalDragonSelectArray addObjectsFromArray:arr];
    
    
    for (UILabel *lbl in self.doubleSideOtherSelectArray) {
        
//        if ([model.selectnumbers containsObject:string]) {
//
//            [model.selectnumbers removeObject:string];
//        }
//        else {
//            [model.selectnumbers addObject:string];
//        }
        [self.selectBallsModel.selectnumbers addObject:lbl.text];
    }
    
    UIButton *btn = self.LeftBtnsArray[0];

    if (self.doubleSideToatalDragonSelectArray.count == 0 && self.doubleSideOtherSelectArray.count == 0) {
        
        UIImage *yeallowImage = [UIImage imageWithColor:BASECOLOR size:CGSizeMake(8, 8)];
        
        [btn setImage:yeallowImage forState:UIControlStateNormal];
        [btn setImage:yeallowImage forState:UIControlStateSelected];
        
    }else{
        
        UIImage *greenImage = [UIImage imageWithColor:[UIColor greenColor] size:CGSizeMake(8, 8)];
        
        [btn setImage:greenImage forState:UIControlStateNormal];
        [btn setImage:greenImage forState:UIControlStateSelected];
        
    }
}

- (void)doubleSideSelectOtherBalls : (NSNotification *)noti{
    NSArray *arr = noti.object;
    
    [self.doubleSideOtherSelectArray removeAllObjects];
    
    [self.doubleSideOtherSelectArray addObjectsFromArray:arr];
    
    UIButton *btn = self.LeftBtnsArray[0];

    if (self.doubleSideToatalDragonSelectArray.count == 0 && self.doubleSideOtherSelectArray.count == 0) {
       
        UIImage *yeallowImage = [UIImage imageWithColor:BASECOLOR size:CGSizeMake(8, 8)];
        
        [btn setImage:yeallowImage forState:UIControlStateNormal];
        [btn setImage:yeallowImage forState:UIControlStateSelected];
        
    }else{
        
        UIImage *greenImage = [UIImage imageWithColor:[UIColor greenColor] size:CGSizeMake(8, 8)];
        
        [btn setImage:greenImage forState:UIControlStateNormal];
        [btn setImage:greenImage forState:UIControlStateSelected];
        
    }
    
}

//1-5球
- (void)ontToFiveSelectOtherBalls : (NSNotification *)noti{

    NSArray *arr = noti.object;
    
    [self.oneToFiveSelectArray removeAllObjects];
    
    [self.oneToFiveSelectArray addObjectsFromArray:arr];
    
    [self dealWithNotiFication:noti index:1 selectBallArray:self.oneToFiveSelectArray];
}
//前中后
- (void)qianZhongHouSelectOtherBall : (NSNotification *)noti{
    NSArray *arr = noti.object;
    
    [self.qianZhongHouSelectArray removeAllObjects];
    
    [self.qianZhongHouSelectArray addObjectsFromArray:arr];
    
    [self dealWithNotiFication:noti index:2 selectBallArray:self.qianZhongHouSelectArray];
    
}
//斗牛
- (void)douNiuNotification:(NSNotification *)noti{
    
    NSArray *arr = noti.object;

    [self.douNiuSelectArray removeAllObjects];

    [self.douNiuSelectArray addObjectsFromArray:arr];

    [self dealWithNotiFication:noti index:3 selectBallArray:self.douNiuSelectArray];
}

- (void)dealWithNotiFication:(NSNotification *)noti index:(NSInteger)index selectBallArray:(NSMutableArray *)selectBallArray{
    
    UIButton *btn = self.LeftBtnsArray[index];
    
    if (selectBallArray.count > 0) {
        
        UIImage *greenImage = [UIImage imageWithColor:[UIColor greenColor] size:CGSizeMake(8, 8)];
        
        [btn setImage:greenImage forState:UIControlStateNormal];
        [btn setImage:greenImage forState:UIControlStateSelected];
        
    }else{//1
        
        UIImage *yeallowImage = [UIImage imageWithColor:BASECOLOR size:CGSizeMake(8, 8)];
        
        [btn setImage:yeallowImage forState:UIControlStateNormal];
        [btn setImage:yeallowImage forState:UIControlStateSelected];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self refresh];
    
    self.pricelab.text = [NSString stringWithFormat:@"￥%.2f",[Person person].balance];
    
    [self addnotification];
}


- (void)buildLeftScrollView{
    
    self.leftScrollView.pagingEnabled = YES;
    self.leftScrollView.showsVerticalScrollIndicator = NO;
    
    UIView *leftSepelatorLine = [[UIView alloc] initWithFrame:CGRectMake(self.leftScrollView.width - 1, 0, 1, self.leftScrollView.height)];
    leftSepelatorLine.backgroundColor = [UIColor colorWithHex:@"2C3036"];

    [self.leftScrollView addSubview:leftSepelatorLine];
    
    
    CGFloat h = 40;
    
    for (int i = 0 ; i < self.categoryArray.count; i++) {
        
        CartTypeModel *model = self.categoryArray[i];
        
        CGFloat y = i * (h + 2);

        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, y, self.leftScrollView.width - 5, h)];
        
        [self roundSide:2 button:btn];
        
        
        if (i == 0) {
            btn.selected = YES;
            self.lastLeftBtn = btn;
        }
        
        btn.tag = i;
        [self.LeftBtnsArray addObject:btn];
        
        [btn setTitle:model.name forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"2C3036"] size:btn.size] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"9C2D33"] size:btn.size] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIImage *yeallowImage = [UIImage imageWithColor:BASECOLOR size:CGSizeMake(8, 8)];
//        UIImage *greenImage = [UIImage imageWithColor:[UIColor greenColor] size:CGSizeMake(8, 8)];
        
        [btn setImage:yeallowImage forState:UIControlStateSelected];
        btn.imageView.layer.masksToBounds = YES;
        btn.imageView.layer.cornerRadius = 4;
        
        [btn setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 22, 25)];

        if (btn.currentTitle.length >= 6) {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 22, 30)];
        }
        
        
        [self.leftScrollView addSubview:btn];
    }
    
    self.leftScrollView.contentSize = CGSizeMake(0, self.categoryArray.count * (h + 1));

}



#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 如果是 左侧的 tableView 直接return
    if (scrollView == self.leftTableView) return;
    
    self.lastLeftBtn.selected = NO;
    
    if (scrollView.contentOffset.y/self.scrollView.height > self.selectedIndexPath) {
        return;
    }
    
    self.selectedIndexPath = scrollView.contentOffset.y/self.scrollView.height;
    
    
    UIButton *btn = self.LeftBtnsArray[self.selectedIndexPath];
    btn.selected = YES;
    
    self.lastSelectedIndexPath = btn.tag;
    self.lastLeftBtn = btn;
}

- (void)roundSide:(NSInteger)side button:(UIButton *)btn
{
    UIBezierPath *maskPath;
    
    if (side == 1)//左上,左下
        maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds
                                         byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                               cornerRadii:CGSizeMake(26.f, 26.f)];
    else if (side == 2)//右上,右下
        maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds
                                         byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                               cornerRadii:CGSizeMake(26.f, 26.f)];
    else if (side == 3)//
        maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds
                                         byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                               cornerRadii:CGSizeMake(26.f, 26.f)];
    else
        maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds
                                         byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                               cornerRadii:CGSizeMake(26.f, 26.f)];
    

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = btn.bounds;
    maskLayer.path = maskPath.CGPath;
    
    btn.layer.mask = maskLayer;
    
    [btn.layer setMasksToBounds:YES];
}

-(void)refresh {
    
    [self inithistoryData];
    
    [self getnextissue];
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

#pragma mark - 获取历史开奖
-(void)inithistoryData {
    
    NSString *url = nil;
    
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/lishiSg.json";
    }else if (self.lottery_type == 2) {
        
        url = @"/xjsscSg/lishiSg.json";
    }else if (self.lottery_type == 3) {
        
        url = @"/txffcSg/lishiSg.json";
    }
    
    [WebTools postWithURL:url params:@{@"pageNum":@1,@"pageSize":@5} success:^(BaseData *data) {
        
        self.dataArray = [PCHistoryModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
        
        PCHistoryModel *firstmodel = [self.dataArray firstObject];
        
        self.headView.currentversionslab.text = [NSString stringWithFormat:@"%@",firstmodel.issue];
        
        self.headView.waitinglab.hidden = YES;
        
        for (UILabel *lab in self.headView.numberlabs) {
            
            if (lab.tag<105) {
                
                NSString *num = [firstmodel.number substringWithRange:NSMakeRange(lab.tag-100, 1)];
                
                lab.text = num;
                
                lab.hidden = NO;
            }
        }
        
    } failure:^(NSError *error) {
        
        [self endRefresh:self.tableView WithdataArr:nil];
    }showHUD:NO];
}

#pragma mark - 获取下期开奖期数和时间
-(void)getnextissue {
    
    [Tools getNextOpenTime:self.lottery_type Withresult:^(NSDictionary *dic) {
        
        self.headView.nextversionslab.text = STRING(dic[@"issue"]);
        self.stopwatch.startTimeInterval = [dic[@"start"]integerValue];
        [self.stopwatch setCountDownTime:[dic[@"time"]integerValue]];//多少秒 （1分钟 == 60秒）
        if ([dic[@"time"]integerValue]>=0) {
            [self.stopwatch start];
        }
        
    }];
}

//时间到了
-(void)timerLabel:(WB_Stopwatch*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
//    [self inithistoryData];
    
    [self getnextissue];
    
    NSInteger time = self.lottery_type == 3 ? 10 : 100;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        [self inithistoryData];
        
        [self getnextissue];
        
    });
    
}

//开始倒计时
-(void)timerLabel:(WB_Stopwatch*)timerlabel
       countingTo:(NSTimeInterval)time
        timertype:(WB_StopwatchLabelType)timerType {
    //    NSLog(@"time:%f",time);
    
}

#pragma mark 分类按钮点击
- (void)clickLeftBtn:(UIButton *)btn{

    self.lastLeftBtn.selected = NO;
    btn.selected = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.height * btn.tag)];
    }];
    
    self.lastSelectedIndexPath = btn.tag;
    self.lastLeftBtn = btn;

    [self.tableView reloadData];
}

- (void)buildScrollView{
    
    self.scrollView.frame = CGRectMake(SCREEN_WIDTH - View_WIDTH, CGRectGetMaxY(self.headView.frame), View_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.headView.frame) - self.footView.height);
//    self.scrollView.scrollEnabled = NO;
    self.scrollView.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
    [self.view addSubview:self.scrollView];

    self.scrollView.pagingEnabled = YES;
    
    //创建子控制器
    for (int i = 0; i < self.categoryArray.count; i++) {
        
        if (i == 0) {
           
            DoubleSideViewController *doubleSideVc = [[DoubleSideViewController alloc] init];
            
            CartTypeModel *model = self.categoryArray.firstObject;
            doubleSideVc.typeModel = model;
            
            doubleSideVc.view.frame = CGRectMake(0, self.scrollView.height * i, View_WIDTH, self.scrollView.height);
            doubleSideVc.tableView.frame = CGRectMake(0, 0, doubleSideVc.view.width, doubleSideVc.view.height);
            
            doubleSideVc.delegate = self;
            
          
            [self addChildViewController:doubleSideVc];
            [self.scrollView addSubview:doubleSideVc.view];
            
        }else if (i == 1){
     
            CartCQOneToFiveViewController *oneToFiveVc = [[CartCQOneToFiveViewController alloc] init];
            oneToFiveVc.view.frame = CGRectMake(0, self.scrollView.height * i, View_WIDTH, self.scrollView.height);

            oneToFiveVc.tableView.frame = CGRectMake(0, 0, oneToFiveVc.view.width, oneToFiveVc.view.height);

            oneToFiveVc.lottery_type = 2;
            [self addChildViewController:oneToFiveVc];

            [self.scrollView addSubview:oneToFiveVc.view];
            
         
        }else if(i == 2){
            QianZhongHouViewController *qianHouZhongVc = [[QianZhongHouViewController alloc] init];
            
            qianHouZhongVc.lottery_type = 1;
            
            qianHouZhongVc.view.frame = CGRectMake(0, self.scrollView.height * i, View_WIDTH, self.scrollView.height);
            qianHouZhongVc.tableView.frame = CGRectMake(0, 0, qianHouZhongVc.view.width, qianHouZhongVc.view.height);
            [self.scrollView addSubview:qianHouZhongVc.view];
            
            [self addChildViewController:qianHouZhongVc];
        }else if (i == 3){
            
            CQDouNiuViewController *douNiuVc = [[CQDouNiuViewController alloc] init];

            douNiuVc.lottery_type = 1;

            douNiuVc.view.frame = CGRectMake(0, self.scrollView.height * i, View_WIDTH, self.scrollView.height);
            douNiuVc.tableView.frame = CGRectMake(0, 0, douNiuVc.view.width, douNiuVc.view.height);

            [self.scrollView addSubview:douNiuVc.view];

            [self addChildViewController:douNiuVc];
//            LiuHeCaiHalfBoViewController *halfBoVc = [[LiuHeCaiHalfBoViewController alloc] init];
//
//            halfBoVc.lottery_type = 1;
//
//            halfBoVc.view.frame = CGRectMake(0, self.scrollView.height * i, View_WIDTH, self.scrollView.height);
//            halfBoVc.tableView.frame = CGRectMake(0, 44, halfBoVc.view.width, halfBoVc.view.height - 44 - 64);
//            [self.scrollView addSubview:halfBoVc.view];
//
//            [self addChildViewController:halfBoVc];
        }
        
       
    }

    self.scrollView.contentSize = CGSizeMake(View_WIDTH, self.scrollView.height  * self.categoryArray.count);
    self.scrollView.scrollEnabled = NO;
    self.scrollView.delegate = self;
    
}

#pragma mark 数据
#pragma mark - 获取购彩一级分类
-(void)getTypeRootData {
    
    [WebTools postWithURL:@"/lottery/queryFirstPlayByCateId.json" params:@{@"categoryId":@(self.categoryId)} success:^(BaseData *data) {
        
        self.categoryArray = [CartTypeModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self buildLeftScrollView];
        
        [self buildScrollView];
        
        [self getfirstCategoryData];
        
//        [self getquerymiss];
        [self buildDataSource];
        
        [self.leftTableView reloadData];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(void)gettotalprice {
    
    CGFloat price = 0.0;
    NSInteger count = 0;
    for (NSMutableDictionary *dic in self.dataSource) {
        
        count += [dic[@"count"]integerValue];
        CGFloat amount = [dic[@"times"]integerValue] * [Tools lotteryprice:[dic[@"pricetype"]integerValue]] * [dic[@"count"]integerValue];
        price += amount;
    }
    
    self.totalcountlab.text = [NSString stringWithFormat:@"共%ld注，",count];
    self.totalpricelab.text = [NSString stringWithFormat:@"投注总额：%.2f元",price];
}

-(void)getfirstCategoryData {
    
    CartTypeModel *model = self.categoryArray.firstObject;
    
    model.selected = YES;
    
    [WebTools postWithURL:@"/lottery/queryChildrenByParentId.json" params:@{@"categoryId":@(self.categoryId),@"parentId":@(model.ID)} success:^(BaseData *data) {
        
        int i = 0 ;
        for (NSArray *array in data.data) {
            
            NSArray *arrlist = [CartTypeModel mj_objectArrayWithKeyValuesArray:array];
            
            if (i == 0) {
                
                [model.type1Array addObjectsFromArray:arrlist];
                
                CartTypeModel *classmodel = model.type1Array.firstObject;
                
                classmodel.selected = YES;
                
                 [self.typeBtn setTitle:classmodel.name forState:UIControlStateNormal];
                
                [self.typeBtn setImagePosition:WPGraphicBtnTypeRight spacing:2];
            }
            else{
                
                for (CartTypeModel *classmodel in arrlist) {
                    
                    classmodel.isgroup = YES;
                    
                    [model.type2Array addObject:classmodel];
                }
                
            }
            i++;
        }
        
        self.selectModel = model.type1Array.firstObject;
        
        [self getquerymiss];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}


#pragma mark UITableViewDelegate
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;

}

#pragma mark DoubleSideViewControllerDelegate

- (void)selectOtherSectionBalls:(NSMutableArray *)balls{
    
//    for (UILabel *lbl in self.doubleSideSelectArray) {
//        [self.doubleSideSelectArray removeObject:lbl];
//    }
//    [self.doubleSideSelectArray addObjectsFromArray:balls];
//    [self changeButtonColor:self.doubleSideSelectArray];
}
- (void)selectFirstSectionBalls:(NSMutableArray *)balls{
    
//    for (UILabel *lbl in self.doubleSideSelectArray) {
//        [self.doubleSideSelectArray removeObject:lbl];
//    }
//    [self.doubleSideSelectArray addObjectsFromArray:balls];
//
//    [self changeButtonColor:self.doubleSideSelectArray];
}

- (void)changeButtonColor : (NSMutableArray *)balls{
    UIButton *btn = self.LeftBtnsArray[0];
    
    if (balls.count > 0) {
        UIImage *greenImage = [UIImage imageWithColor:[UIColor greenColor] size:CGSizeMake(8, 8)];
        
        [btn setImage:greenImage forState:UIControlStateNormal];
        [btn setImage:greenImage forState:UIControlStateSelected];
        
    }else{
        
        UIImage *yeallowImage = [UIImage imageWithColor:BASECOLOR size:CGSizeMake(8, 8)];
        
        [btn setImage:yeallowImage forState:UIControlStateNormal];
        [btn setImage:yeallowImage forState:UIControlStateSelected];
    }
}

#pragma mark datasource
//行数返回
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 100) {//左边类型 tableview
        return self.categoryArray.count;
    }else{
        return 10;
    }
    
}


//cell显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (tableView.tag == 100) {
        
        BpanLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BpanLeftTableViewCellID forIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            cell.titleBtn.selected = YES;
            //  self.lastSelectedIndexPath = indexPath;
        }
        
        cell.backgroundColor = [UIColor clearColor];
        CartTypeModel *model = self.categoryArray[indexPath.row];
        [cell.titleBtn setTitle:model.name forState:UIControlStateNormal];
        cell.titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        cell.titleBtn.tag = indexPath.row;
        return cell;
    }else{
        
        CartChongqinHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:RJHeaderIdentifier];
        
//        PCHistoryModel *model = [self.dataArray objectAtIndex:indexPath.row];
//
//        cell.versionslab.text = [NSString stringWithFormat:@"%@期开奖结果",model.issue];
        
//        for (UILabel *lab in cell.numberlabs) {
        
//            NSString *num = [model.number substringWithRange:NSMakeRange(lab.tag-100, 1)];
//
//            lab.text = num;
//        }
        return cell;
    }

}

#pragma mark setupUI
- (void)setupUI{
    
    self.view.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CartChongqinHeadCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJHeaderIdentifier];
    
    self.tableView.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
    
    [self.view addSubview:self.headView];
    
    [self.view addSubview:[self footview]];

    [self setupNav];
    
    [self setupTableViews];
    
//    [self setupCaculateView];
    
}

- (void)setupCaculateView{
    NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:@"CalculateView" owner:nil options:nil];
    CalculateView *calculateView = viewArray.firstObject;
    
    self.footView.frame = CGRectMake(0, SCREEN_HEIGHT  - 94 , SCREEN_WIDTH, SAFE_HEIGHT + 94);

//    calculateView.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
    calculateView.frame = CGRectMake(0, SCREEN_HEIGHT  - 94 , SCREEN_WIDTH, SAFE_HEIGHT + 94);

    
    calculateView.fatherView = self.view;
    calculateView.moneyArray = self.moneyArray;
    calculateView.multiArray = self.multiArray;
    
    [self.view addSubview:calculateView];
}

- (void)setupTableViews{

    [self.view addSubview:self.leftScrollView];
}

- (void)setupNav{
    [self rigBtn:@"" Withimage:@"BpanZhushou" With:^(UIButton *sender) {
        
        [self.typeView dismiss];

        [self.showView showView];
    }];
    
    
    [self.rightBtn setTitleColor:BASECOLOR forState:UIControlStateNormal];
}

#pragma mark 查看历史数据
- (void)lookHistoryData:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    self.showhead = sender.selected;
    
    if (sender.selected) {
        
        [self.view addSubview:self.tableView];
        
//        [UIView animateWithDuration:1.0 animations:^{
            self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.headView.frame));

//        }];
        
        [self.tableView reloadData];

    }else{
        
        [self.tableView removeFromSuperview];
        
    }
    

    
}



-(void)buildDataSource {
    
    [self.dataSource removeAllObjects];
    
    self.showfoot = NO;
    
    self.bottomView.numlab.text = @"0";
    self.bottomView.pricelab.text = @"0.00";
    
    if (self.selectModel.ID == 28 || self.selectModel.ID == 42 || self.selectModel.ID == 60 || self.selectModel.ID == 51 || self.selectModel.ID == 67 || self.selectModel.ID == 74 || self.selectModel.ID == 92 || self.selectModel.ID == 84 || self.selectModel.ID == 89 || self.selectModel.ID == 86) {
        
        self.showfoot = YES;
    }
    
    NSArray *array = [[BuyTools tools] getchongqinDataSourceWith:self.selectModel With:self.missmodel With:self.textView];
    
    [self.dataSource addObjectsFromArray:array];
    
    [self.tableView reloadData];
    
}

#pragma mark - 最高可中
-(void)getmaxprice {
    
    if (self.selectModel.ID == 97) {
        
        CGFloat price = [Tools lotteryprice:self.pricetype] * self.times * [self.missmodel.play[@"odds"]floatValue] * 5;
        self.bottomView.maxpricelab.text = [NSString stringWithFormat:@"最高可中%.2f元",price];
    }
    else if (self.selectModel.ID > 97) {
        
        if (self.selectModel.ID == 103) {
            
            CGFloat price = [Tools lotteryprice:self.pricetype] * self.times * [self.missmodel.play[@"odds"]floatValue];
            self.bottomView.maxpricelab.text = [NSString stringWithFormat:@"最高可中%.2f元",price];
        }
        else {
            CGFloat price = [Tools lotteryprice:self.pricetype] * self.times * [self.missmodel.play[@"odds"]floatValue] * 2;
            self.bottomView.maxpricelab.text = [NSString stringWithFormat:@"最高可中%.2f元",price];
        }
    }
    else {
        CGFloat price = [Tools lotteryprice:self.pricetype] * self.times * [self.missmodel.play[@"odds"]floatValue];
        self.bottomView.maxpricelab.text = [NSString stringWithFormat:@"最高可中%.2f元",price];
    }
}

#pragma mark - 获取直选遗漏
-(void)getquerymiss {
    
    [WebTools postWithURL:@"/lottery/querySelection.json" params:@{@"lotteryId":@(self.lotteryId),@"playId":@(self.selectModel.ID)} success:^(BaseData *data) {
        
        self.missmodel = [CartChongqinMissModel mj_objectWithKeyValues:data.data];

        [self buildDataSource];
        
        [self getmaxprice];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 获取组选遗漏
-(void)getgroupmiss {
    
    [WebTools postWithURL:@"/lottery/queryGroupSelection.json" params:@{@"lotteryId":@(self.lotteryId),@"playId":@(self.selectModel.ID)} success:^(BaseData *data) {
        
        self.missmodel = [CartChongqinMissModel mj_objectWithKeyValues:data.data];
        
        [self buildDataSource];
        
        [self getmaxprice];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark CartCQBpanHeaderVeiwDelegate
- (void)ChargeController{
    
    if ([Person person].payLevelId.length == 0) {
        [MBProgressHUD showError:@"无用户层级, 暂无法充值"];
        return;
    }
    TopUpViewController *topUpVC = [[TopUpViewController alloc] init];
    [self.navigationController pushViewController:topUpVC animated:YES];

}

-(CartCQBpanHeaderVeiw *)headView {
    
    if (!_headView) {
        WS(weakSelf);
        _headView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CartCQBpanHeaderVeiw class]) owner:self options:nil]firstObject];
        
        _headView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 172);
        
        self.stopwatch = [[WB_Stopwatch alloc]initWithLabel:_headView.endtimelab andTimerType:WBTypeTimer];
        _headView.delegate = self;
        self.stopwatch.delegate = self;
        [self.stopwatch setTimeFormat:@"HH:mm:ss"];
        
        _headView.lookallBlock = ^{
            
            IGKbetListCtrl *list = [[IGKbetListCtrl alloc]init];
            list.lottery_type = weakSelf.lottery_type;
            list.titlestring = weakSelf.lottery_type == 1 ? @"重庆时时彩" : weakSelf.lottery_type == 2 ? @"新疆时时彩" : @"比特币分分彩";
            WEAKPUSH(list);
        };
    }
    return _headView;
}

-(CartTypeView *)typeView {
    
    if (!_typeView) {
        WS(weakSelf);
        _typeView = [[CartTypeView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT+40, SCREEN_WIDTH, 0)];
        _typeView.backgroundColor = WHITE;
        _typeView.dismissBlock = ^{
            
            weakSelf.typeBtn.selected = NO;
            [weakSelf.typeBtn setImagePosition:WPGraphicBtnTypeRight spacing:2];
        };
        _typeView.showTypeBlock = ^(CartTypeModel *model) {
            
            [weakSelf.typeBtn setTitle:model.name forState:UIControlStateNormal];
            
            weakSelf.selectModel = model;
            
            if (model.isgroup) {
                
                [weakSelf getgroupmiss];
            }
            else {
                [weakSelf getquerymiss];
            }
            
            [weakSelf getmaxprice];
        };
    }
    return _typeView;
}

- (SQMenuShowView *)showView{
    
    if (_showView) {
        return _showView;
    }
    
    _showView = [[SQMenuShowView alloc]initWithFrame:(CGRect){CGRectGetWidth(self.view.frame)-100-10,NAV_HEIGHT+5,100,0}
                                               items:@[@"遗漏",@"投注记录",@"在线客服",@"曲线图",@"公式杀号",@"免费推荐"]
                                           showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-25,10}];
    _showView.sq_backGroundColor = MAINCOLOR;
    _showView.itemTextColor = WHITE;
    __weak typeof(self) weakSelf = self;
    [_showView selectBlock:^(SQMenuShowView *view, NSInteger index) {
        
        NSLog(@"点击第%ld个item",index+1);
        if (index == 1) {
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                 @weakify(self)
                [self presentViewController:login animated:YES completion:nil];
                login.loginBlock = ^(BOOL result) {
                    @strongify(self)
                    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
                    
                    BettingRecordViewController *bettingRecordVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"BettingRecordViewController"];
                    
                    [self.navigationController pushViewController:bettingRecordVC animated:YES];
                };
                return ;
            }
            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
            
            BettingRecordViewController *bettingRecordVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"BettingRecordViewController"];
            
            [self.navigationController pushViewController:bettingRecordVC animated:YES];
        }
        else if (index == 2) {
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                 @weakify(self)
                [self presentViewController:login animated:YES completion:nil];
                login.loginBlock = ^(BOOL result) {
                    @strongify(self)
                    // 在线客服
//                    if ([[ChatHelp shareHelper]login]){
//
//                        // 进入会话页面
//                        HDChatViewController *chatVC = [[HDChatViewController alloc] initWithConversationChatter:HX_IM]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
//                        [self.navigationController pushViewController:chatVC animated:YES];
//                    }
                    KeFuViewController *kefuVc = [[KeFuViewController alloc] init];
                    
                    PUSH(kefuVc);
                };
                return ;
            }
            // 在线客服
//            if ([[ChatHelp shareHelper]login]){
//
//                // 进入会话页面
//                HDChatViewController *chatVC = [[HDChatViewController alloc] initWithConversationChatter:HX_IM]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
//                [self.navigationController pushViewController:chatVC animated:YES];
//            }
            KeFuViewController *kefuVc = [[KeFuViewController alloc] init];
            
            PUSH(kefuVc);
        }
        else if (index == 3) {
            
            GraphCtrl *graph = [[GraphCtrl alloc]init];
            graph.lottery_type = self.lottery_type;
            PUSH(graph);
        }
        else if (index == 4) {
            
            FormulaCtrl *forumla = [[FormulaCtrl alloc]init];
            forumla.lottery_type = self.lottery_type;
            PUSH(forumla);
        }
        else if (index == 5) {
            
            FreeRecommendCtrl *free = [[FreeRecommendCtrl alloc]init];
            free.lottery_type = self.lottery_type;
            PUSH(free);
            

        }
        
    }];
    _showView.showmissBlock = ^(BOOL showmiss) {
        
        [weakSelf.tableView reloadData];
    };
    [self.view addSubview:_showView];
    return _showView;
}

-(BuyLotBottomView *)footview {
    if (_footView) {
        _footView = [[BuyLotBottomView alloc] init];
        [self.view addSubview:_footView];
        _footView.frame = CGRectMake(0, SCREEN_HEIGHT  - 94 , SCREEN_WIDTH, SAFE_HEIGHT + 94);
     }
    return _footView;

}

- (NSMutableArray *)detailArray {
    if (_detailArray == nil) {
        _detailArray = [NSMutableArray array];

    }
    return _detailArray;
}

- (UIScrollView *)leftScrollView{
    if (!_leftScrollView) {
        _leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame), SCREEN_WIDTH*0.2, SCREEN_HEIGHT - CGRectGetMaxY(self.headView.frame) - self.footView.height)];
    }
    return _leftScrollView;
}


- (UITableView *)leftTableView {
    if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame), SCREEN_WIDTH*0.2, SCREEN_HEIGHT - CGRectGetMaxY(self.headView.frame) - self.footView.height)];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _leftTableView.tag = 100;
        _leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _leftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _leftTableView.showsVerticalScrollIndicator = NO;

        [_leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BpanLeftTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:BpanLeftTableViewCellID];

    }
    return _leftTableView;
}

- (NSMutableArray *)LeftBtnsArray{
    if (!_LeftBtnsArray) {
        _LeftBtnsArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _LeftBtnsArray;
}

- (NSMutableArray *)doubleSideToatalDragonSelectArray{
    if (!_doubleSideToatalDragonSelectArray) {
        _doubleSideToatalDragonSelectArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _doubleSideToatalDragonSelectArray;
}

- (NSMutableArray *)doubleSideOtherSelectArray{
    if (!_doubleSideOtherSelectArray) {
        _doubleSideOtherSelectArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _doubleSideOtherSelectArray;
}

- (NSMutableArray *)oneToFiveSelectArray{
    if (!_oneToFiveSelectArray) {
        _oneToFiveSelectArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _oneToFiveSelectArray;
}

- (NSMutableArray *)qianZhongHouSelectArray{
    if (!_qianZhongHouSelectArray) {
        _qianZhongHouSelectArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _qianZhongHouSelectArray;
}

- (NSMutableArray *)douNiuSelectArray{
    if (!_douNiuSelectArray) {
        _douNiuSelectArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _douNiuSelectArray;
}

- (NSArray *)moneyArray{
    if (!_moneyArray) {
        _moneyArray = @[@"1角",@"5角",@"1元",@"5元",@"10元",@"100元",@"1000元",@"2000元",@"5000元",@"10000元"];
    }
    
    return _moneyArray;
}

- (NSArray *)multiArray{
    if (!_multiArray) {
        _multiArray = @[@"5倍",@"10倍",@"20倍",@"50倍",@"100倍",@"200倍",@"500倍",@"1000倍"];
    }
    
    return _multiArray;
}
@end
