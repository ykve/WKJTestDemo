//
//  CPTChangLongVCViewController.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/5/16.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTChangLongController.h"
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
#import "NavigationVCViewController.h"
#import "CPTBuyPickMoneyView.h"
#import "NSTimer+CQBlockSupport.h"

#define bottomViewHeight 80
@interface CPTChangLongController ()<UITableViewDelegate,UITableViewDataSource, ChangLongTableViewCellDelegate, CartSimpleBottomViewDelegate, UITextFieldDelegate>
{
    NSMutableArray* _idArray;
    __block NSMutableArray* _historyArray;
    __block IGKbetModel *_model;
    MSWeakTimer *weakTimer;
    CPTBuyPickMoneyView *_pickMoneyView;
}

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *autoRefreshTimeLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger startCountDownNum;
@property (nonatomic, assign) NSInteger restCountDownNum;


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

@property (nonatomic, strong) NSMutableArray *pushSettingsArray;

@property (nonatomic, strong) NSMutableArray *pushSelectLotArray;
@property (nonatomic, strong) NSMutableArray *pushSelectLongNumArray;

@property (nonatomic, strong) NSArray<NSIndexPath *> *indexPathsForSelectedItems;
@property (nonatomic, strong) NSMutableArray<NSIndexPath *> *selectedItemAtIndexPathArray;

@end

@implementation CPTChangLongController


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_historyArray removeAllObjects];
    [_pickMoneyView brokeBlock];
    _historyArray = nil;
    [self endCountDown:NO];
    
}
- (void)loadView{
    [super loadView];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData:) name:@"RefreshOpenLotteryUI" object:nil];
    
}



- (void)refreshBottomViewUI {
    
}
- (void)configUI {
    //    self->_model = data;
    [self.myTableView reloadData];
    //    [self reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationVCViewController *nav = (NavigationVCViewController *)self.navigationController;
    [nav removepang];
    
    [self initPushSetting];
    

//    [self rigBtn:@"推送设置" Withimage:nil With:^(UIButton *sender) {
//        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
//        __weak __typeof(self)weakSelf = self;
//        alert.didSelectItemAtIndexPathBlock = ^(NSArray *indexPathsForSelectedItems){
//            __strong __typeof(weakSelf)strongSelf = weakSelf;
//            // 选中
//            strongSelf.indexPathsForSelectedItems = indexPathsForSelectedItems;
//        };
//
//        alert.didConfirmBlock = ^{
//            // 确认
//            __strong __typeof(weakSelf)strongSelf = weakSelf;
//            [strongSelf onPushSettingsConfirm];
//        };
//
//        [alert buildLongDragonView:self.pushSettingsArray selectedItemAtIndexPathArray:self.selectedItemAtIndexPathArray];
//        [alert show];
//
//    }];
    
    
    self.randomLine = 100;
    self.isRandom = NO;
    self.isLoding = NO;
    self.titlestring = @"长龙";
    
    [self getChangLongData];
    
    
    [self setupUI];
    [self loadFootView];
    [self initTableView];
    
    [self showFootView];
    
    _startCountDownNum = 20;
    [self startCountDown];
}

- (void)initPushSetting {
    
    //    NSArray *longArray = @[
    //                           @{@"title": @"时时彩", @"titleValue": @"TOPIC_SSC_DRAGONLONG_DATA", @"isSelected": @(NO)},
    //                           @{@"title": @"PC蛋蛋", @"titleValue": @"TOPIC_PCEGG_DRAGONLONG_DATA", @"isSelected": @(NO)},
    //                           @{@"title": @"六合彩", @"titleValue": @"TOPIC_LHC_DRAGONLONG_DATA", @"isSelected": @(NO)},
    //                           @{@"title": @"澳洲ACT", @"titleValue": @"TOPIC_AUSPKS_DRAGONLONG_DATA", @"isSelected": @(NO)},
    //                           @{@"title": @"PK10", @"titleValue": @"TOPIC_PKTEN_DRAGONLONG_DATA", @"isSelected": @(NO)}];
    //    NSArray *numArray = @[
    //                          @{@"title": @"6", @"titleValue": @"6", @"isSelected": @(NO)},
    //                          @{@"title": @"7", @"titleValue": @"7", @"isSelected": @(NO)},
    //                          @{@"title": @"8", @"titleValue": @"8", @"isSelected": @(NO)},
    //                          @{@"title": @"9", @"titleValue": @"9", @"isSelected": @(NO)},
    //                          @{@"title": @"10", @"titleValue": @"10", @"isSelected": @(NO)},
    //                          @{@"title": @"11", @"titleValue": @"11", @"isSelected": @(NO)},
    //                          @{@"title": @"12", @"titleValue": @"12", @"isSelected": @(NO)},
    //                          @{@"title": @"12以上", @"titleValue": @"1000", @"isSelected": @(NO)}];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *pushSelectLotArray = [defaults objectForKey:@"pushSelectLotArray"];
    NSArray *pushSelectLongNumArray = [defaults objectForKey:@"pushSelectLongNumArray"];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"时时彩" forKey:@"title"];
    [dict setValue:@"TOPIC_SSC_DRAGONLONG_DATA" forKey:@"titleValue"];
    [dict setValue:@(NO) forKey:@"isSelected"];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict2 setObject:@"PC蛋蛋" forKey:@"title"];
    [dict2 setValue:@"TOPIC_PCEGG_DRAGONLONG_DATA" forKey:@"titleValue"];
    [dict2 setValue:@(NO) forKey:@"isSelected"];
    
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
    [dict3 setObject:@"六合彩" forKey:@"title"];
    [dict3 setValue:@"TOPIC_LHC_DRAGONLONG_DATA" forKey:@"titleValue"];
    [dict3 setValue:@(NO) forKey:@"isSelected"];
    
    NSMutableDictionary *dict4 = [NSMutableDictionary dictionary];
    [dict4 setObject:@"澳洲ACT" forKey:@"title"];
    [dict4 setValue:@"TOPIC_AUSPKS_DRAGONLONG_DATA" forKey:@"titleValue"];
    [dict4 setValue:@(NO) forKey:@"isSelected"];
    
    NSMutableDictionary *dict5 = [NSMutableDictionary dictionary];
    [dict5 setObject:@"PK10" forKey:@"title"];
    [dict5 setValue:@"TOPIC_PKTEN_DRAGONLONG_DATA" forKey:@"titleValue"];
    [dict5 setValue:@(NO) forKey:@"isSelected"];
    NSArray *lotArray = @[dict,dict2,dict3,dict4,dict5];
    
    
    NSMutableDictionary *numDict = [NSMutableDictionary dictionary];
    [numDict setObject:@"6" forKey:@"title"];
    [numDict setValue:@"6" forKey:@"titleValue"];
    [numDict setValue:@(NO) forKey:@"isSelected"];
    
    NSMutableDictionary *numDict2 = [NSMutableDictionary dictionary];
    [numDict2 setObject:@"7" forKey:@"title"];
    [numDict2 setValue:@"7" forKey:@"titleValue"];
    [numDict2 setValue:@(NO) forKey:@"isSelected"];
    
    NSMutableDictionary *numDict3 = [NSMutableDictionary dictionary];
    [numDict3 setObject:@"8" forKey:@"title"];
    [numDict3 setValue:@"8" forKey:@"titleValue"];
    [numDict3 setValue:@(NO) forKey:@"isSelected"];
    
    NSMutableDictionary *numDict4 = [NSMutableDictionary dictionary];
    [numDict4 setObject:@"9" forKey:@"title"];
    [numDict4 setValue:@"9" forKey:@"titleValue"];
    [numDict4 setValue:@(NO) forKey:@"isSelected"];
    
    NSMutableDictionary *numDict5 = [NSMutableDictionary dictionary];
    [numDict5 setObject:@"10" forKey:@"title"];
    [numDict5 setValue:@"10" forKey:@"titleValue"];
    [numDict5 setValue:@(NO) forKey:@"isSelected"];
    
    NSMutableDictionary *numDict6 = [NSMutableDictionary dictionary];
    [numDict6 setObject:@"11" forKey:@"title"];
    [numDict6 setValue:@"11" forKey:@"titleValue"];
    [numDict6 setValue:@(NO) forKey:@"isSelected"];
    
    NSMutableDictionary *numDict7 = [NSMutableDictionary dictionary];
    [numDict7 setObject:@"12" forKey:@"title"];
    [numDict7 setValue:@"12" forKey:@"titleValue"];
    [numDict7 setValue:@(NO) forKey:@"isSelected"];
    
    NSMutableDictionary *numDict8 = [NSMutableDictionary dictionary];
    [numDict8 setObject:@"12以上" forKey:@"title"];
    [numDict8 setValue:@"1200" forKey:@"titleValue"];
    [numDict8 setValue:@(NO) forKey:@"isSelected"];
    NSArray *numArray = @[numDict,numDict2,numDict3,numDict4,numDict5,numDict6,numDict7,numDict8];
    
    [self.pushSettingsArray addObject:lotArray];
    [self.pushSettingsArray addObject:numArray];
    
    
    for (NSMutableDictionary *localDict in pushSelectLotArray) {
        for (NSInteger index = 0; index < lotArray.count; index++) {
            NSMutableDictionary *dict = lotArray[index];
            if ([localDict[@"titleValue"] isEqualToString: dict[@"titleValue"]]) {
                [dict setObject:@(YES) forKey:@"isSelected"];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                [self.selectedItemAtIndexPathArray addObject:indexPath];
            }
        }
    }
    
    if (pushSelectLotArray.count > 0) {
        for (NSMutableDictionary *localDict in pushSelectLongNumArray) {
            for (NSInteger index = 0; index < numArray.count; index++) {
                NSMutableDictionary *dict = numArray[index];
                if ([localDict[@"titleValue"] isEqualToString: dict[@"titleValue"]]) {
                    [dict setObject:@(YES) forKey:@"isSelected"];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:1];
                    [self.selectedItemAtIndexPathArray addObject:indexPath];
                }
            }
        }
    }
}

#pragma mark -  确认
- (void)onPushSettingsConfirm {
    self.pushSelectLotArray = [NSMutableArray array];
    self.pushSelectLongNumArray = [NSMutableArray array];
    
    for (NSInteger index = 0; index < self.indexPathsForSelectedItems.count; index++) {
        NSIndexPath *indexPath = self.indexPathsForSelectedItems[index];
        NSDictionary *dict = self.pushSettingsArray[indexPath.section][indexPath.row];
        if (indexPath.section == 0) {
            [self.pushSelectLotArray addObject:dict];
        } else {
            [self.pushSelectLongNumArray addObject:dict];
        }
    }
    
    if ((self.pushSelectLotArray.count > 0 && self.pushSelectLongNumArray.count > 0) || (self.pushSelectLotArray.count == 0 && self.pushSelectLongNumArray.count == 0)) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.pushSelectLotArray forKey:@"pushSelectLotArray"];
        [defaults setObject:self.pushSelectLongNumArray forKey:@"pushSelectLongNumArray"];
        [defaults synchronize];
    }
    
    
    self.selectedItemAtIndexPathArray = [NSMutableArray array];
    [self.selectedItemAtIndexPathArray addObjectsFromArray:self.indexPathsForSelectedItems];
    
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSArray *arr1 = [defaults objectForKey:@"pushSelectLotArray"];
    //    NSArray *arr2 = [defaults objectForKey:@"pushSelectLongNumArray"];
    MBLog(@"1");
}


- (void)initTableView {
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CPT_StatusBarAndNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-CPT_StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
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
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChangLongTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ChangLongTableViewCellID"];
    [self.view addSubview:self.myTableView];
    @weakify(self)
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.right.left.equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self getChangLongData];
    }];
    
    self.view.backgroundColor = self.myTableView.backgroundColor = [[CPTThemeConfig shareManager] OpenLotteryVC_View_BackgroundC];
    
    
//    UIImageView *bgImgView = [[UIImageView alloc] init];
//    [self.view addSubview:bgImgView];
//    [self.view sendSubviewToBack:bgImgView];
//    [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//

}

- (void)setupUI {
    UIView *topView = [[UIView alloc] init];  
    topView.backgroundColor = [[CPTThemeConfig shareManager] CO_LongDragonTopView];
    [self.view addSubview:topView];
    _topView = topView;
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(Height_NavBar);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"自动刷新:";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor colorWithHex:@"#999999"];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.left.mas_equalTo(topView.mas_left).offset(17);
    }];
    
    UILabel *autoRefreshTimeLabel = [[UILabel alloc] init];
    autoRefreshTimeLabel.text = @"20s";
    autoRefreshTimeLabel.font = [UIFont systemFontOfSize:15];
    autoRefreshTimeLabel.textColor = [UIColor colorWithHex:@"#FFC145"];
    autoRefreshTimeLabel.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:autoRefreshTimeLabel];
    _autoRefreshTimeLabel = autoRefreshTimeLabel;
    
    [autoRefreshTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.left.mas_equalTo(titleLabel.mas_right).offset(8);
    }];
    
    UIButton *refreshBtn = [[UIButton alloc] init];
    [refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(onRefreshBtn) forControlEvents:UIControlEventTouchUpInside];
    refreshBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    refreshBtn.backgroundColor = [[CPTThemeConfig shareManager] CO_LongDragonTopViewBtn];
    refreshBtn.layer.cornerRadius = 5;
    [topView addSubview:refreshBtn];
    
    [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.right.mas_equalTo(topView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    UIView *linebotView = [[UIView alloc] init];
    linebotView.backgroundColor = [UIColor colorWithHex:@"#D6D6D6" Withalpha:0.5];
    [topView addSubview:linebotView];
    
    [linebotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(topView);
        make.height.mas_equalTo(0.3);
    }];

}

#pragma mark -  刷新
- (void)onRefreshBtn {
    [self getChangLongData];
    [self startCountDown];
}

#pragma mark -  长龙咨询列表数据
- (void)getChangLongData {
    @weakify(self)
    [WebTools  postWithURL:@"/sg/getSgLongDragons.json" params:nil success:^(BaseData *data) {
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        @strongify(self)
        [self.myTableView.mj_header endRefreshing];
        [self.ChangLongModels removeAllObjects];
        [self.cptBuyBallModels removeAllObjects];
        NSArray *array = [ChangLongModel mj_objectArrayWithKeyValuesArray:data.data];
        [self.ChangLongModels addObjectsFromArray:array];
        
        [self.myTableView reloadData];
        [self refreshUI];
    } failure:^(NSError *error) {
        @strongify(self)
        self.isLoding = NO;
        [self.myTableView.mj_header endRefreshing];
        
    } showHUD:YES];
}

- (void)showMoneyUI{
    @weakify(self)
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.4 animations:^{
        @strongify(self)
        [self->_pickMoneyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(44);
        }];
        [self.view layoutIfNeeded];
    }];
}
- (void)hiddenMoneyUI{
    @weakify(self)
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.4 animations:^{
        @strongify(self)
        [self->_pickMoneyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [self showMoneyUI];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self hiddenMoneyUI];
    return YES;
}

#pragma mark - tableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ChangLongModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChangLongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChangLongTableViewCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [[CPTThemeConfig shareManager] CO_LongDragonCell];
    ChangLongModel *model;
    model = self.ChangLongModels[indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.model = model;
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 141.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    
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
    
    self.bottomView.pricelab.textColor = [[CPTThemeConfig shareManager] CO_Bottom_LabelText];
    self.bottomView.maxpricelab.textColor = [[CPTThemeConfig shareManager] CO_Bottom_LabelText];
    
    UIColor *c = [[CPTThemeConfig shareManager] Buy_CollectionHeadV_ViewC];
    NSString * num = [NSString stringWithFormat:@"%ld",self.cptBuyBallModels.count];
    NSString * totle = [NSString stringWithFormat:@"%ld",money*self.cptBuyBallModels.count];
    NSMutableAttributedString *totlettr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 注 %@ 元",num,totle]];
    [totlettr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(0, num.length)];
    [totlettr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(num.length + 3, totle.length)];
    
    self.bottomView.pricelab.attributedText = totlettr;
    
    if(self.cptBuyBallModels.count>0 && self.ChangLongModels.count>0){
        NSMutableSet * tmpModels = [NSMutableSet setWithSet:self.cptBuyBallModels];
        NSMutableArray * tmpLongs = [NSMutableArray arrayWithArray:self.ChangLongModels];
        CGFloat max = 0.00;
        
        for(NSInteger i=0;i<tmpLongs.count;i++){
            NSMutableSet * tmpA = [NSMutableSet set];
            for(CPTBuyBallModel * buyModel in tmpModels){
                NSIndexPath *path = buyModel.modelLocation;
                if(path.section == i){
                    [tmpA addObject:buyModel];
                }
            }
            if(tmpA.count<1)continue;
            CGFloat tmpOdd = 0.00;
            for(CPTBuyBallModel * m in tmpA){
                tmpOdd = MAX(m.subTitle.floatValue, tmpOdd);
            }
            max = max + tmpOdd * [self.bottomView.textField.text integerValue];
            [tmpA removeAllObjects];
        }
        
        NSString * maxWin;
        if(max >= 100000.00){
            maxWin = [NSString stringWithFormat:@"%.2f万",max/10000.00];
        }
        else{
            maxWin = [NSString stringWithFormat:@"%.2f",max];
        }
        NSMutableAttributedString *maxWinttr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最高中 %@ 元",maxWin]];
        [maxWinttr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(4, maxWin.length)];
        [maxWinttr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(4, maxWin.length)];
        self.bottomView.maxpricelab.attributedText = maxWinttr;
    } else if (self.cptBuyBallModels.count == 0) {
        NSString * maxWin = @"0.00";
        NSMutableAttributedString *maxWinttr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最高中 %@ 元",maxWin]];
        [maxWinttr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(4, maxWin.length)];
        [maxWinttr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(4, maxWin.length)];
        self.bottomView.maxpricelab.attributedText = maxWinttr;
    }
}

- (void)loadFootView{
    
    [self.view addSubview:self.bottomView];
    @weakify(self)
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo((IS_IPHONEX ) ? @(bottomViewHeight + 40) : @(bottomViewHeight));
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
            //            if([self.cptBuyBallModels count]<=0){
            //                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择投注号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
            //                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //                }];
            //                [alert addAction:defaultAction];
            //                [self presentViewController:alert animated:YES completion:nil];
            //                return;
            //            }
            //            if([self.bottomView.textField.text length]<=0){
            //                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入每注金额" message:nil preferredStyle:UIAlertControllerStyleAlert];
            //                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //                    @strongify(self)
            //                    [self.bottomView.textField becomeFirstResponder];
            //                }];
            //                [alert addAction:defaultAction];
            //                [self presentViewController:alert animated:YES completion:nil];
            //                return;
            //            }
            //            NSMutableSet * tmpModels = [NSMutableSet setWithSet:self.cptBuyBallModels];
            //            NSMutableArray * tmpLongs = [NSMutableArray arrayWithArray:self.ChangLongModels];
            //            for(CPTBuyBallModel * model in tmpModels){
            //                NSIndexPath *path = model.modelLocation;
            //                ChangLongModel * longM = tmpLongs[path.section];
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
                
                //                CartTypeModel *type = [[CartTypeModel alloc] init];
                //                type.name = btn.model.playType;
                //                type.categoryId = [btn.model.categoryId integerValue];
                //                type.ID = [btn.model.ID integerValue];
                NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                //    |—— playId    Integer    （必须）玩法id
                //    |—— settingId    Integer    （必须）玩法配置id
                //    |—— betNumber    String    （必须）投注号码
                //    |—— betAmount    double    （必须）投注金额
                //    |—— betCount    Integer    （必须）总注数  1
                [pdic setObject:@(longM.playTagId) forKey:@"playId"];
                [pdic setObject:@(model.settingId) forKey:@"settingId"];
                [pdic setObject:@([self.bottomView.textField.text integerValue]) forKey:@"betAmount"];
                [pdic setObject:@(1) forKey:@"betCount"];
                NSString * betNumber = [NSString stringWithFormat:@"%@@%@",longM.playTag,model.title];
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

- (void)showFootView {
    @weakify(self)
    if(!_pickMoneyView){
        _pickMoneyView = [[CPTBuyPickMoneyView alloc] init];
        
        [self.view addSubview:_pickMoneyView];
        
        [_pickMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.right.equalTo(self.view);
            make.height.offset(0);
            make.bottom.equalTo(self.bottomView.mas_top);
        }];
        [self.view bringSubviewToFront:_pickMoneyView];
        [_pickMoneyView configUIWith:^(NSInteger money) {
            @strongify(self)
            self.bottomView.textField.text = [NSString stringWithFormat:@"%ld",(long)money];
            [self refreshBottomViewUI];
        }];
    }
}

#pragma mark -  倒计时
- (void)startCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _restCountDownNum = _startCountDownNum;
    
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer cq_scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf handleCountDowning];
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    self.timer.fireDate = [NSDate distantPast];
}

- (void)endCountDown:(BOOL)isAuto {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (isAuto) {
        _restCountDownNum = _startCountDownNum;
        [self endAction];
    }
    
}


- (void)handleCountDowning {
    [self countDownTimeing];
    
    if (_restCountDownNum == 0) { // 倒计时完成
        [self endCountDown:YES];
        return;
    }
    _restCountDownNum --;
}


- (void)endAction {
    self.autoRefreshTimeLabel.text = [NSString stringWithFormat:@"%zds", self.restCountDownNum];
    [self getChangLongData];
    [self startCountDown];
}

- (void)countDownTimeing {
    self.autoRefreshTimeLabel.text = [NSString stringWithFormat:@"%zds", self.restCountDownNum];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self endCountDown:NO];
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
        _bottomView.textField.delegate = self;
        
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
- (NSMutableArray *)pushSettingsArray {
    if (!_pushSettingsArray) {
        _pushSettingsArray = [[NSMutableArray alloc] init];
    }
    return _pushSettingsArray;
}

- (NSMutableArray *)pushSelectLotArray {
    if (!_pushSelectLotArray) {
        _pushSelectLotArray = [[NSMutableArray alloc] init];
    }
    return _pushSelectLotArray;
}

- (NSMutableArray *)pushSelectLongNumArray {
    if (!_pushSelectLongNumArray) {
        _pushSelectLongNumArray = [[NSMutableArray alloc] init];
    }
    return _pushSelectLongNumArray;
}

- (NSMutableArray *)selectedItemAtIndexPathArray {
    if (!_selectedItemAtIndexPathArray) {
        _selectedItemAtIndexPathArray = [NSMutableArray array];
    }
    return _selectedItemAtIndexPathArray;
}


@end

