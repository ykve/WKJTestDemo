//
//  CPTOpenLotteryCtrl.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/26.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTOpenLotteryCtrl.h"
#import "PCInfoModel.h"
#import "IGKbetModel.h"
#import "CPTBuyHeadViewTableViewCell.h"
#import "IGKbetListCtrl.h"
#import "CPTOpenLotteryCell.h"
#import "AppDelegate.h"
#import "ChangLongTableViewCell.h"
#import "ChangLongModel.h"
#import "CPTSixModel.h"
#import "CartSimpleBottomView.h"
#import "MSWeakTimer.h"
#import "LoginAlertViewController.h"
#define bottomViewHeight 80

@interface CPTOpenLotteryCtrl ()<UITableViewDelegate,UITableViewDataSource, ChangLongTableViewCellDelegate, CartSimpleBottomViewDelegate>
{
    NSMutableArray* _idArray;
    __block NSMutableArray* _historyArray;
    __block IGKbetModel *_model;
    MSWeakTimer *weakTimer;

}
@property (strong, nonatomic) UITableView *myTableView;
@property (nonatomic, assign) NSInteger curenttime;
@property (nonatomic, strong) NSMutableArray *ChangLongModels;
@property (nonatomic, assign)int randomLine;
@property (nonatomic, assign)int randomModel;
@property (nonatomic, assign)BOOL isRandom;
//选中的购彩模型
@property (nonatomic, strong) NSMutableSet *cptBuyBallModels;
@property (nonatomic, strong) CartSimpleBottomView *bottomView;
//记录是否正在请求
@property (nonatomic, assign)BOOL isLoding;
@property (nonatomic, assign)int updateTimeSecond;




@end

@implementation CPTOpenLotteryCtrl
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_historyArray removeAllObjects];
    _historyArray = nil;
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.isShowNav) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.title = @"长龙";
    }else{
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    [self performSelector:@selector(configUI) withObject:nil afterDelay:0.1];
    

}


- (void)configUI{
    //    self->_model = data;
    [self.myTableView reloadData];
    //    [self reloadData];
}

- (void)loadView {
    [super loadView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAllData:) name:@"RefreshOpenLotteryUI" object:nil];
    
    self.myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.tableFooterView = [UIView new];
    self.myTableView.estimatedRowHeight =67;
    self.myTableView.estimatedSectionHeaderHeight = 30;
    self.myTableView.estimatedSectionFooterHeight = 0;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    for(NSNumber *idNumber in self.idArray){
        NSString * idString = [[CPTBuyDataManager shareManager] changeTypeToTypeString:idNumber.integerValue];
        [self.myTableView registerClass:[CPTOpenLotteryCell class] forCellReuseIdentifier:idString];
    }
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChangLongTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ChangLongTableViewCellID"];
    
    
    //    [self.myTableView registerClass:[CPTOpenLotteryCell class] forCellReuseIdentifier:@"CPTBuyTicketType_TJSSC"];
    //    [self.myTableView registerClass:[CPTOpenLotteryCell class] forCellReuseIdentifier:@"CPTBuyTicketType_XJSSC"];
    //    [self.myTableView registerClass:[CPTOpenLotteryCell class] forCellReuseIdentifier:@"CPTBuyTicketType_TenSSC"];
    //    [self.myTableView registerClass:[CPTOpenLotteryCell class] forCellReuseIdentifier:@"CPTBuyTicketType_FiveSSC"];
    //    [self.myTableView registerClass:[CPTOpenLotteryCell class] forCellReuseIdentifier:@"CPTBuyTicketType_JiShuSSC"];
    //    [self.myTableView registerClass:[CPTOpenLotteryCell class] forCellReuseIdentifier:@"CPTBuyTicketType_HuanLe_Shishicai"];
    //    [self.myTableView registerClass:[CPTOpenLotteryCell class] forCellReuseIdentifier:@"CPTBuyTicketType_FFC"];
    //
    //    [self.myTableView registerClass:[CPTOpenLotteryCell class] forCellReuseIdentifier:@"CPTBuyTicketType_LiuHeCai"];
    //    [self.myTableView registerClass:[CPTOpenLotteryCell class] forCellReuseIdentifier:@"CPTBuyTicketType_PK10"];
    //    [self.myTableView registerClass:[CPTOpenLotteryCell class] forCellReuseIdentifier:@"CPTBuyTicketType_XYFT"];
    //    [self.myTableView registerClass:[CPTOpenLotteryCell class] forCellReuseIdentifier:@"CPTBuyTicketType_FFC"];
    //    [self.myTableView registerClass:[CPTOpenLotteryCell class] forCellReuseIdentifier:@"CPTBuyTicketType_PCDD"];
    
    
    [self.view addSubview:self.myTableView];
    @weakify(self)
    

    if (self.changlong) {
        [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.right.top.left.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-bottomViewHeight);
        }];
    }else{
        [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.right.top.bottom.left.equalTo(self.view);
            //        make.top.offset(NAV_HEIGHT);
        }];
    }
    
//    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.right.top.bottom.left.equalTo(self.view);
//        //        make.top.offset(NAV_HEIGHT);
//    }];

    
    self.view.backgroundColor = self.myTableView.backgroundColor = [[CPTThemeConfig shareManager] OpenLotteryVC_View_BackgroundC]; 

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CPTOpenLotteryManager shareManager] openSocket];

    self.randomLine = 100;
    self.isRandom = NO;
    self.isLoding = NO;
    self.updateTimeSecond = 0;

    if(!_historyArray)_historyArray = [NSMutableArray array];
    //    [self initData];
    //    [self performSelector:@selector(initData) withObject:nil afterDelay:0.1];
    @weakify(self)
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        if (self.changlong) {
            [self initDataChangLong];
        }else{
            [self initData];
        }
    }];
    //    _idArray = [NSMutableArray arrayWithObjects:@(CPTBuyTicketType_SSC),@(CPTBuyTicketType_LiuHeCai),@(CPTBuyTicketType_PK10),@(CPTBuyTicketType_FFC),@(CPTBuyTicketType_XJSSC),@(CPTBuyTicketType_XYFT ),@(CPTBuyTicketType_PCDD), nil];
    for(NSNumber *idNumber in self.idArray){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI:) name:[NSString stringWithFormat:@"%ld",(long)idNumber.integerValue] object:nil];
    }
    
    if (self.changlong) {
        weakTimer = [MSWeakTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(updateRefreshTime) userInfo:nil repeats:YES dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
        self.title = @"长龙";
        [self initDataChangLong];
        [self loadFootView];

    }
    
}

- (void)reloadData{
    //    if(!_model){
    //        @weakify(self)
    //        [[CPTOpenLotteryManager shareManager] checkModel:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
    //            @strongify(self)
    //            self->_model = data;
    //            [self.myTableView reloadData];
    //        }];
    //    }
}

- (void)initDataChangLong{
    
    [WebTools  postWithURL:@"/sg/getSgLongDragons.json" params:nil success:^(BaseData *data) {

        self.updateTimeSecond = 1;
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }

        [self.myTableView.mj_header endRefreshing];
        [self.ChangLongModels removeAllObjects];
        NSArray *array = [ChangLongModel mj_objectArrayWithKeyValuesArray:data.data];
        [self.ChangLongModels addObjectsFromArray:array];
        
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        self.isLoding = NO;
        self.updateTimeSecond = 1;
        [self.myTableView.mj_header endRefreshing];

    } showHUD:NO];
}

-(void)initData {
    @weakify(self)
    [[CPTOpenLotteryManager shareManager] checkModelByIds:self.idArray callBack:^(IGKbetModel * _Nonnull data,BOOL isSuccess) {
        @strongify(self)
        if(isSuccess){
            self->_model = data;
            self.curenttime = [[CPTOpenLotteryManager shareManager] curenttime];
        }
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
    }];
}

- (void)updateRefreshTime{
    self.updateTimeSecond = 0;
}
-(void)refreshUI:(NSNotification *)notification {
    
    if (self.changlong) {
        if (self.updateTimeSecond == 0) {
            [self initDataChangLong];
        }
        return;
    }
    NSString *key = notification.name;
    //    MBLog(@"NSNotification:%@",key);
    NSInteger index=[self.idArray indexOfObject:@(key.integerValue)];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    _model = (IGKbetModel *)notification.object;
    self.curenttime = [[CPTOpenLotteryManager shareManager] curenttime];
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        [UIView setAnimationsEnabled:NO]; // 或者[UIView setAnimationsEnabled:NO];
        [self.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [UIView setAnimationsEnabled:YES]; // 或者[UIView setAnimationsEnabled:YES];
   
    });
}

-(void)refreshAllData:(NSNotification *)notification {
    _model = (IGKbetModel *)notification.object;
    self.curenttime = [[CPTOpenLotteryManager shareManager] curenttime];
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        [self.myTableView reloadData];
    });
}

#pragma mark - tableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.changlong) {
        return self.ChangLongModels.count;
    }
    return _idArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.changlong) {
        ChangLongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChangLongTableViewCellID" forIndexPath:indexPath];
        ChangLongModel *model;
        
        if (self.isRandom) {
            
            if (indexPath.row == self.randomLine) {
                   model = self.ChangLongModels[self.randomLine];
//                CPTBuyBallModel *buyModel;
                if (self.randomModel == 0) {
                    model.leftSelect = YES;
                    model.rightSelect = NO;
                }else{
                    model.leftSelect = NO;
                    model.rightSelect = YES;
                }
                
//                [self.cptBuyBallModels addObject:buyModel];
            }else{
                model = self.ChangLongModels[indexPath.row];
            }
        }else{
            model = self.ChangLongModels[indexPath.row];
        }
        cell.indexPath = indexPath;
        
        cell.backgroundColor = CLEAR;
        cell.delegate = self;
        cell.model = model;
        if (self.isRandom) {
            if (indexPath.row == self.randomLine) {
                CPTBuyBallModel *buyModel;
                if (self.randomModel == 0) {
                    buyModel = cell.leftModel;
                }else{
                    buyModel = cell.rightModel;
                }
                buyModel.modelLocation = [NSIndexPath indexPathForRow:self.randomModel inSection:self.randomLine];
                
                [self.cptBuyBallModels addObject:buyModel];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    CPTBuyTicketType tmpType = [_idArray[indexPath.row] integerValue];
    NSString * idString = [[CPTBuyDataManager shareManager] changeTypeToTypeString:tmpType];
    
    CPTOpenLotteryCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
    cell.type = tmpType;
    [cell configUI];
    cell.nameLabel.text = [[CPTBuyDataManager shareManager] changeTypeToString:tmpType];
    cell.backgroundColor = CLEAR;
    if(!_model){return cell;}
    switch (tmpType) {
        case CPTBuyTicketType_LiuHeCai:
        {
            SixInfoModel *firstmodel = _model.lhc;
            [cell sixModel:firstmodel];
        }
            break;
        case CPTBuyTicketType_OneLiuHeCai:
        {
            SixInfoModel *firstmodel = _model.onelhc;
            [cell sixModel:firstmodel];
        }
            break;
        case CPTBuyTicketType_FiveLiuHeCai:
        {
            SixInfoModel *firstmodel = _model.fivelhc;
            [cell sixModel:firstmodel];
        }
            break;
        case CPTBuyTicketType_ShiShiLiuHeCai:
        {
            SixInfoModel *firstmodel = _model.sslhc;
            [cell sixModel:firstmodel];
        }
            break;
        case CPTBuyTicketType_PK10:{
            PK10InfoModel *firstmodel = _model.bjpks;
            [cell pk10Model:firstmodel];
        }break;
        case CPTBuyTicketType_TenPK10:{
            PK10InfoModel *firstmodel = _model.tenpks;
            [cell pk10Model:firstmodel];
        }break;
        case CPTBuyTicketType_FivePK10:{
            PK10InfoModel *firstmodel = _model.fivepks;
            [cell pk10Model:firstmodel];
        }break;
        case CPTBuyTicketType_JiShuPK10:{
            PK10InfoModel *firstmodel = _model.jspks;
            [cell pk10Model:firstmodel];
        }break;
            
        case CPTBuyTicketType_XYFT:{
            PK10InfoModel *firstmodel = _model.xyft;
            [cell pk10Model:firstmodel];
        }break;
            
        case CPTBuyTicketType_SSC:
        {
            ChongqinInfoModel *firstmodel = _model.cqssc;
            [cell sscModel:firstmodel];
        } break;
        case CPTBuyTicketType_TJSSC:
        {
            ChongqinInfoModel *firstmodel = _model.tjssc;
            [cell sscModel:firstmodel];
        } break;
        case CPTBuyTicketType_TenSSC:
        {
            ChongqinInfoModel *firstmodel = _model.tenssc;
            [cell sscModel:firstmodel];
        } break;
        case CPTBuyTicketType_FiveSSC:
        {
            ChongqinInfoModel *firstmodel = _model.fivessc;
            [cell sscModel:firstmodel];
        } break;
        case CPTBuyTicketType_JiShuSSC:{
            ChongqinInfoModel *firstmodel = _model.jsssc;
            [cell sscModel:firstmodel];
        }break;
            
        case CPTBuyTicketType_XJSSC:
        {
            ChongqinInfoModel *firstmodel = _model.xjssc;
            [cell sscModel:firstmodel];
        } break;
        case CPTBuyTicketType_FFC:
        {
            ChongqinInfoModel *firstmodel = _model.txffc;
            [cell sscModel:firstmodel];
        } break;
        case CPTBuyTicketType_PCDD:
        {
            LotteryInfoModel *firstmodel = _model.pcegg;
            [cell pcddModel:firstmodel];
            
        } break;
        case CPTBuyTicketType_FantanPK10:
        {
            PK10InfoModel *firstmodel = [[PK10InfoModel alloc] init];
            firstmodel.nextTime = _model.fantanPK10.nextTime;
            firstmodel.issue = _model.fantanPK10.issue;
            firstmodel.nextIssue = [_model.fantanPK10.nextIssue integerValue];
            firstmodel.nextTime = _model.fantanPK10.nextTime;
            firstmodel.number = _model.fantanPK10.number;
            [cell pk10Model:firstmodel];
            
        } break;
        case CPTBuyTicketType_FantanXYFT:
        {
            PK10InfoModel *firstmodel = [[PK10InfoModel alloc] init];
            firstmodel.nextTime = _model.fantanXYFT.nextTime;
            firstmodel.issue = _model.fantanXYFT.issue;
            firstmodel.nextIssue = [_model.fantanXYFT.nextIssue integerValue];
            firstmodel.nextTime = _model.fantanXYFT.nextTime;
            firstmodel.number = _model.fantanXYFT.number;
            [cell pk10Model:firstmodel];
        } break;
        case CPTBuyTicketType_FantanSSC:
        {
            ChongqinInfoModel *firstmodel = [[ChongqinInfoModel alloc] init];
            firstmodel.nextTime = _model.fantanSSC.nextTime;
            firstmodel.issue = _model.fantanSSC.issue;
            firstmodel.nextIssue = _model.fantanSSC.nextIssue;
            firstmodel.numbers = [_model.fantanSSC.number componentsSeparatedByString:@","];
            [cell sscModel:firstmodel];
        } break;
        case CPTBuyTicketType_NiuNiu_KuaiLe:
        {
            ChongqinInfoModel *firstmodel = _model.fivessc;
            firstmodel.niuWinner = _model.nnKuaile.niuWinner;
            [cell sscModel:firstmodel];
        } break;
        case CPTBuyTicketType_NiuNiu_JiShu:
        {
            PK10InfoModel *firstmodel = _model.jspks;
            firstmodel.niuWinner = _model.nnJisu.niuWinner;
            
            [cell pk10Model:firstmodel];
        } break;
        case CPTBuyTicketType_HaiNanQiXingCai:{
            LotteryInfoModel *firstmodel = _model.haiNanQiXingCai;
            [cell lotteryInfoModel:firstmodel];
        }break;
        case CPTBuyTicketType_PaiLie35:{
            LotteryInfoModel *firstmodel = _model.paiLie35;
            [cell lotteryInfoModel:firstmodel];
        }break;
        case CPTBuyTicketType_Shuangseqiu:{
            LotteryInfoModel *firstmodel = _model.shuangseqiu;
            [cell lotteryInfoModel:firstmodel];
        }break;
        case CPTBuyTicketType_DaLetou:{
            LotteryInfoModel *firstmodel = _model.daLetou;
            [cell lotteryInfoModel:firstmodel];
        }break;
        case CPTBuyTicketType_QiLecai:{
            LotteryInfoModel *firstmodel = _model.qiLecai;
            [cell lotteryInfoModel:firstmodel];
        }break;
        case CPTBuyTicketType_3D:{
            LotteryInfoModel *firstmodel = _model.threeD;
            [cell lotteryInfoModel:firstmodel];
        }break;
        case CPTBuyTicketType_AoZhouACT:{
            LotteryInfoModel *firstmodel = _model.aoZhouACT;
            [cell lotteryInfoModel:firstmodel];
        }break;
        case CPTBuyTicketType_AoZhouF1:{
            PK10InfoModel *firstmodel = [[PK10InfoModel alloc] init];
            firstmodel.nextTime = _model.aozhouF1.nextTime;
            firstmodel.issue = _model.aozhouF1.issue;
            firstmodel.nextIssue = [_model.aozhouF1.nextIssue integerValue];
            firstmodel.nextTime = _model.aozhouF1.nextTime;
            firstmodel.number = _model.aozhouF1.number;
            [cell pk10Model:firstmodel];
        }break;
        case CPTBuyTicketType_AoZhouShiShiCai:{
            ChongqinInfoModel *firstmodel = [[ChongqinInfoModel alloc] init];
            firstmodel.nextTime = _model.aozhouSSC.nextTime;
            firstmodel.issue = _model.aozhouSSC.issue;
            firstmodel.nextIssue = _model.aozhouSSC.nextIssue;
            firstmodel.nextTime = _model.aozhouSSC.nextTime;
            firstmodel.numbers = [_model.aozhouSSC.number componentsSeparatedByString:@","];
            firstmodel.number = _model.aozhouSSC.number;
            [cell sscModel:firstmodel];
        }break;
        case CPTBuyTicketType_NiuNiu_AoZhou:{
            PK10InfoModel *firstmodel = [[PK10InfoModel alloc] init];
            firstmodel.nextTime = _model.aozhouF1.nextTime;
            firstmodel.issue = _model.aozhouF1.issue;
            firstmodel.nextIssue = [_model.aozhouF1.nextIssue integerValue];
            firstmodel.nextTime = _model.aozhouF1.nextTime;
            firstmodel.number = _model.aozhouF1.number;
            firstmodel.niuWinner = _model.nnAozhou.niuWinner;
            [cell pk10Model:firstmodel];
        }break;
            
        default:
            break;
    }
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_idArray.count<1){
        return 141.;
    }
    CPTBuyTicketType tmpType = [_idArray[indexPath.row] integerValue];
    if(tmpType == CPTBuyTicketType_PCDD){
        return 116.;
    }else if (tmpType == CPTBuyTicketType_HaiNanQiXingCai || tmpType == CPTBuyTicketType_3D|| tmpType == CPTBuyTicketType_Shuangseqiu|| tmpType == CPTBuyTicketType_DaLetou|| tmpType == CPTBuyTicketType_QiLecai ){
        return 116.;
    }
    else{
        return 141.;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (self.changlong) {
        
//        [self getRandomNum];
        return;
    }
    [self push:indexPath.row];
}

-(void)push:(NSInteger)lottery_type {
    IGKbetListCtrl *list = [[IGKbetListCtrl alloc]init];
    CPTBuyTicketType type = [_idArray[lottery_type] integerValue];
    list.type = type;
    list.titlestring = [[CPTBuyDataManager shareManager] changeTypeToString:type];
    PUSH(list);
}

- (void)refreshUI{
    NSInteger money = [self.bottomView.textField.text integerValue];
    
    if (money <= 0) {
        money = 0;
        self.bottomView.textField.text = @"";
    }
    //    if (money >= 10000) {
    //        money = 10000;
    //        self.textField.text = @"10000";
    //    }
//    NSMutableDictionary * dic ;
    UIColor *c = [[CPTThemeConfig shareManager] Buy_CollectionHeadV_ViewC];
    //    self.pricelab.text = [NSString stringWithFormat:@"%ld",[dic[CPTCART_TOTLEMONEY] integerValue]];
    //    self.numlab.text = [NSString stringWithFormat:@"%ld",[dic[CPTCART_TOTLEAvailable] integerValue]];
    NSString * num = [NSString stringWithFormat:@"%ld",self.cptBuyBallModels.count];
    NSString * totle = [NSString stringWithFormat:@"%ld",money*self.cptBuyBallModels.count];
    NSMutableAttributedString *totlettr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 注 %@ 元",num,totle]];
    [totlettr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(0, num.length)];
    [totlettr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(num.length + 3, totle.length)];
    
    self.bottomView.pricelab.attributedText = totlettr;
    
//    CGFloat max = [dic[CPTCART_MAXWIN] floatValue];
//    NSString * maxWin;
//    if(max>=100000.00){
//        maxWin = [NSString stringWithFormat:@"%.2f万",max/10000.00];
//    }
//    else{
//        maxWin = [NSString stringWithFormat:@"%.2f",[dic[CPTCART_MAXWIN] floatValue]];
//    }
//    NSMutableAttributedString *maxWinttr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最高中 %@ 元",maxWin]];
//    [maxWinttr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(4, maxWin.length)];
//    [maxWinttr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(4, maxWin.length)];
//    self.bottomView.maxpricelab.attributedText = maxWinttr;
}

- (void)loadFootView{
    
//    self.bottomView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CartSimpleBottomView class]) owner:self options:nil]firstObject];
    [self.view addSubview:self.bottomView];
    @weakify(self)
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo((IS_IPHONEX && self.isShowNav) ? @(bottomViewHeight + 40) : @(bottomViewHeight));
    }];
    
    self.bottomView.bottomClickBlock = ^(NSInteger type,UIButton *sender) {
        @strongify(self)
        if (type == 1) { //清空
            [self.cptBuyBallModels removeAllObjects];
            for (ChangLongModel *model in self.ChangLongModels) {
                model.leftSelect = NO;
                model.rightSelect = NO;
            }
            self.isRandom = NO;
            [self.myTableView reloadData];
            [self refreshUI];
        }
        else if (type == 10) {//+-
            [self refreshUI];
        }
        else if (type == 11) {//
            [self refreshUI];
        }
        else if (type == 4) { //加入购彩
            if([self.cptBuyBallModels count]<=0){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择投注号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            if([self.bottomView.textField.text length]<=0){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入每注金额" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    @strongify(self)
                    [self.bottomView.textField becomeFirstResponder];
                }];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            NSMutableSet * tmpModels = [NSMutableSet setWithSet:self.cptBuyBallModels];
            NSMutableArray * tmpLongs = [NSMutableArray arrayWithArray:self.ChangLongModels];
            for(CPTBuyBallModel * model in tmpModels){
                NSIndexPath *path = model.modelLocation;
                ChangLongModel * longM = tmpLongs[path.section];
            }

//            NSMutableArray * d = [NSMutableArray array];
//            NSMutableDictionary * betDic = [[CPTBuyDataManager shareManager] checkTmpCartArrayByType:_bottomView.superType superPlayKey:_bottomView.superPlayKey eachMoney:[_bottomView.textField.text integerValue]];
//            CartTypeModel * type;
//            for(CPTBuyBallModel *model in self.cptBuyBallModels){
//                    type = [[CartTypeModel alloc] init];
//                    type.name = btn.model.playType;
//                    type.categoryId = [btn.model.categoryId integerValue];
//                    type.ID = [btn.model.ID integerValue];
//                    NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
//                    //    |—— playId    Integer    （必须）玩法id
//                    //    |—— settingId    Integer    （必须）玩法配置id
//                    //    |—— betNumber    String    （必须）投注号码
//                    //    |—— betAmount    double    （必须）投注金额
//                    //    |—— betCount    Integer    （必须）总注数  1
//                    [pdic setObject:@(type.ID) forKey:@"playId"];
//                    [pdic setObject:@(model.settingId) forKey:@"settingId"];
//                    [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"betAmount"];
//                    [pdic setObject:@(1) forKey:@"betCount"];
//                    if(model.longS){
//                        NSString * betNumber = [NSString stringWithFormat:@"%@@%@%@",model.superKey,model.longS,model.title];
//                        [pdic setObject:betNumber forKey:@"betNumber"];
//                        [d addObject:pdic];
//                    }else{
//                        NSString * betNumber = [NSString stringWithFormat:@"%@@%@",model.superKey,model.title];
//                        [pdic setObject:betNumber forKey:@"betNumber"];
//                        [d addObject:pdic];
//                    }
//                    
//                    continue;
//            }

        }
        else if (type == 5) {//立即投注
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self presentViewController:login animated:YES completion:nil];
                login.loginBlock = ^(BOOL result) {

                };
                return;
            }
            if([self.cptBuyBallModels count]<=0){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择投注号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            if([self.bottomView.textField.text length]<=0){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入每注金额" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    @strongify(self)
                    [self.bottomView.textField becomeFirstResponder];
                }];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            NSMutableSet * tmpModels = [NSMutableSet setWithSet:self.cptBuyBallModels];
            NSMutableArray * tmpLongs = [NSMutableArray arrayWithArray:self.ChangLongModels];
            for(CPTBuyBallModel * model in tmpModels){
                NSIndexPath *path = model.modelLocation;
                ChangLongModel * longM = tmpLongs[path.section];
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                NSString*bStr = longM.nextIssue;
                [dic setValue:bStr forKey:@"issue"];
                [dic setValue:[NSNumber numberWithInteger:longM.typeId.integerValue] forKey:@"lotteryId"];
                [dic setValue:[Person person].uid forKey:@"userId"];
                
                CartTypeModel *type = [[CartTypeModel alloc] init];
//                type.name = btn.model.playType;
//                type.categoryId = [btn.model.categoryId integerValue];
//                type.ID = [btn.model.ID integerValue];
                NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                //    |—— playId    Integer    （必须）玩法id
                //    |—— settingId    Integer    （必须）玩法配置id
                //    |—— betNumber    String    （必须）投注号码
                //    |—— betAmount    double    （必须）投注金额
                //    |—— betCount    Integer    （必须）总注数  1
                [pdic setObject:@(type.ID) forKey:@"playId"];
                [pdic setObject:@(model.settingId) forKey:@"settingId"];
                [pdic setObject:@([self.bottomView.textField.text integerValue]) forKey:@"betAmount"];
                [pdic setObject:@(1) forKey:@"betCount"];
                NSString * betNumber = [NSString stringWithFormat:@"%@@%@",longM.playType,model.title];
                [pdic setObject:betNumber forKey:@"betNumber"];
                [dic setValue:@[pdic] forKey:@"orderBetList"];
                MBLog(@"下单：%@",dic);
                [WebTools postWithURL:@"/order/orderBet.json" params:dic success:^(BaseData *data) {
                    @strongify(self)
                    sender.enabled = YES;
                    [MBProgressHUD showSuccess:data.info];
                    [self.cptBuyBallModels removeAllObjects];
                    for (ChangLongModel *model in self.ChangLongModels) {
                        model.leftSelect = NO;
                        model.rightSelect = NO;
                    }
                    [self.myTableView reloadData];
                    [self refreshUI];
                } failure:^(NSError *error) {
                    sender.enabled = YES;
                } showHUD:YES];
            }
        }
//        else { //购物篮
//            if ([Person person].uid == nil) {
//                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
//                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//                [self presentViewController:login animated:YES completion:nil];
//                login.loginBlock = ^(BOOL result) {
//
//                };
//                return;
//            }
//            CartListCtrl *list = [[CartListCtrl alloc]init];
//            list.dataSource = [[CPTBuyDataManager shareManager] dataCartArray] ;
//            list.lotteryId = self.lotteryId;
//            list.type = self.type;
//            list.lottery_type = self.type;
//            @weakify(self)
//            list.updataArray = ^(NSArray *array) {
//                @strongify(self)
//                [self.hub setCount:array.count];
//                [self.hub bump];
//            };
//            PUSH(list);
//        }
    };
    
//    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        //        make.top.equalTo(self.view.mas_bottom);
//        make.top.equalTo(self.view.mas_bottom).offset( -SAFE_HEIGHT - 94);
//        make.left.right.equalTo(self.view);
//        make.height.equalTo(@(SAFE_HEIGHT + 94));
//    }];
}
- (void)getRandomNum{
    
    self.isRandom = YES;
    self.randomLine = arc4random() % self.ChangLongModels.count;
    self.randomModel = arc4random() % 2;
    
    [self.cptBuyBallModels removeAllObjects];

    for (ChangLongModel *model in self.ChangLongModels) {
        model.leftSelect = NO;
        model.rightSelect = NO;
    }
    
    [self.myTableView reloadData];
    
}

#pragma mark ChangLongTableViewCellDelegate
- (void)addLotteryModel:(CPTBuyBallModel *)buyModel{
    self.isRandom = NO;
    if (!buyModel) {
        return;
    }
    [self.cptBuyBallModels addObject:buyModel];
    [self refreshUI];
}

- (void)removeLotteryModel:(CPTBuyBallModel *)buyModel{
    self.isRandom = NO;
    if (!buyModel) {
        return;
    }
    [self.cptBuyBallModels removeObject:buyModel];
    [self refreshUI];
}

- (CartSimpleBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CartSimpleBottomView class]) owner:self options:nil]firstObject];
        _bottomView.userInteractionEnabled = YES;
        _bottomView.fatherView = self.view;

    }
    return _bottomView;
}
- (NSMutableArray *)ChangLongModels{
    if (!_ChangLongModels) {
        _ChangLongModels = [NSMutableArray arrayWithCapacity:5];
    }
    return _ChangLongModels;
}

- (NSMutableSet *)cptBuyBallModels{
    if (!_cptBuyBallModels) {
        _cptBuyBallModels = [NSMutableSet set];
    }
    return _cptBuyBallModels;
}
@end
