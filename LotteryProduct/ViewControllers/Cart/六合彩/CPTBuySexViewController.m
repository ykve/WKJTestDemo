
//
//  CPTBuySexViewController.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuySexViewController.h"
#import "CPTBuyLeftView.h"
#import "CPTBuyLeftButtonModel.h"
#import "CartSixHeadView.h"
#import "IGKbetListCtrl.h"
#import "CPTBuyRightCollectionCell.h"
#import "CPTBuyLeftButton.h"
#import "CPTBuyCollectionHeadView.h"
#import "CPTSixModel.h"
#import "CPTBuyRightCollectionTwoNCell.h"
#import "CPTBuyRightCollectionBanBoCell.h"
#import "CPTBuyRightCollectionWeiShuCell.h"
#import "PCInfoModel.h"
#import "SQMenuShowView.h"
#import "BettingRecordViewController.h"
#import "SixRecommendCtrl.h"
#import "TemaHistoryCtrl.h"

#import "BuyLotBottomView.h"
#import "RKNotificationHub.h"
#import "CartSetView.h"
#import "TopUpViewController.h"
#import "CPTBuySubTypeView.h"
#import "CartTypeModel.h"
#import "CartListCtrl.h"
#import "CPTBuyHeadView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "CPTBuyPickMoneyView.h"
#import "PK10VersionTrendCtrl.h"
#import "FormulaCtrl.h"
#import "CPTBuyRightPaiLieCell.h"
#import "PK10FreeRecommendCtrl.h"
#import "CPTBuyCollectionLonghuHeadView.h"
#import "CPTBuyRightCollectionWuxingCell.h"
#import "CPTBuyRightCollectionOneToFiveBallCell.h"
#import "CPTBuyStopView.h"
#import "SixAIPickCtrl.h"
#import "PCFreeRecommendCtrl.h"
#import "PCTodayStatisticsCtrl.h"
#import "GraphCtrl.h"
#import "LiuHeDaShenViewController.h"
#import "LoginAlertViewController.h"
#import "CPTBuyCollectionWithLineHeadView.h"
#import "CPTBuyHeadViewStyleMore.h"
#import "AoZhouACTScrollview.h"
#import "ChatRoomCtrl.h"
#import "BallTool.h"
#import "NavigationVCViewController.h"
@interface CPTBuySexViewController ()<CPTBuyLeftButtonDelegate,CPTBuyHeadViewDelegate,CPTBuyHeadViewStyleMoreDelegate,CPTBuySubTypeViewDelegate,AoZhouActBuyLotteryVeiwDelegate>{
    CPTBuyLeftView *_leftView;
    CPTBuyHeadView *_headView;
    NSMutableArray *_playTypes;
    UICollectionView *_collectView;
    UICollectionViewFlowLayout *_layout;
    NSInteger kItem_Number;
    NSMutableArray *_rightModels;
    CPTBuyLeftButton *_currentBtn;
    CPTSixPlayTypeModel *_currentPlayModel;
    NSInteger _indexSection;
    CPTBuySubTypeView * _subTypeView;
    NSMutableArray<CPTSixPlayTypeModel *> *_subTypes;
    __block NSMutableArray<CartTypeModel *> *_cartTypeModelArray;//玩法赔率信息集合
    __block NSMutableSet<NSString *> *_hadgetedOddsArray;//标记已经请求过的玩法赔率 k按照
    CPTBuyPickMoneyView *_pickMoneyView;
    CPTBuyLeftButton * _subTypeButton;//红点标记用
    CPTBuyStopView *_stopView;//封单view
    CGFloat _moreH;
    
    AoZhouACTScrollview *_actLotteryView;
}

@property (nonatomic, strong) UILabel *pricelab;
@property (nonatomic, strong) BuyLotBottomView *bottomView;
@property (nonatomic, strong) RKNotificationHub *hub;
@property (nonatomic, strong) CartTypeModel *selectModel;
/**
 赔率数组集合
 */
@property (nonatomic, strong) __block NSArray<CartOddsModel *> *oddsArray;
@end

@implementation CPTBuySexViewController

- (void)dealloc{
    [[CPTBuyDataManager shareManager] clearTmpCartArray];
    [[CPTBuyDataManager shareManager] clearCartArray];
    if(_stopView){
        _stopView = nil;
    }
    if(_subTypeButton){
        _subTypeButton = nil;
    }
    if(_actLotteryView){
        _actLotteryView = nil;
    }
    _oddsArray = nil;
    _selectModel = nil;
    if(_pricelab){
        _pricelab = nil;
    }
    _bottomView = nil;
    _subTypeView = nil;
    _currentBtn = nil;
    _pickMoneyView = nil;
    _rightModels = nil;
    _currentBtn = nil;
    _currentPlayModel = nil;
    _headView = nil;
    _leftView = nil;
    _layout = nil;
    _collectView = nil;;
}

- (void)removeNSNotification{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CPTHIDDENMONEYUI object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:OKFORBUY object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CPTSHOWMONEYUI object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CPTSHOWINFO object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateBalance" object:nil];

    [_playTypes removeAllObjects];
    _playTypes = nil;
    [_rightModels removeAllObjects];
    _rightModels = nil;
    [_subTypes removeAllObjects];
    _subTypes = nil;
    [_cartTypeModelArray removeAllObjects];
    _cartTypeModelArray = nil;
    [_hadgetedOddsArray removeAllObjects];
    _hadgetedOddsArray = nil;
}

-(void)popback{
    [_headView destroyTimer];
    [_pickMoneyView brokeBlock];
    [self removeBlock];
    [_headView removeNSNotification];
    _headView = nil;
    [self clearModelState];
    [_hadgetedOddsArray removeAllObjects];
    [self removeNSNotification];
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)loadView{
    [super loadView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenMoneyUI) name:CPTHIDDENMONEYUI object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMoneyUI) name:CPTSHOWMONEYUI object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFootView:) name:OKFORBUY object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showInfoView:) name:CPTSHOWINFO object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBalance) name:@"updateBalance" object:nil];

//    @weakify(self)
    self.view.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
//    [self rigBtn:@"助手" Withimage:nil With:^(UIButton *sender) {
//        @strongify(self)
//        if ([Person person].uid == nil) {
//            LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
//            login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//            [self presentViewController:login animated:YES completion:nil];
//            login.loginBlock = ^(BOOL result) {
//
//            };
//            return;
//        }
//        [self.showView showView];
//    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CPTBuyDataManager shareManager] clearTmpCartArray];
    [[CPTBuyDataManager shareManager] clearCartArray];
    NavigationVCViewController *nav = (NavigationVCViewController *)self.navigationController;
    [nav removepang];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    if(IS_IPHONEX){
        [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 25;
    }

    @weakify(self)

    if( self.categoryId ==  CPTBuyCategoryId_LHC || self.categoryId == CPTBuyCategoryId_PK10 || self.type == CPTBuyTicketType_XYFT|| self.type == CPTBuyTicketType_AoZhouF1 || self.type == CPTBuyTicketType_AoZhouACT){
        _moreH = 152.+ISNEEDSHOWHH;
        _headView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CPTBuyHeadViewStyleMore class]) owner:self options:nil]firstObject];
        _headView.type = self.type;
        _headView.delegate = self;
        [self.view addSubview:_headView];
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.view);
            make.top.offset(0);//CPT_StatusBarAndNavigationBarHeight
            make.height.offset(self->_moreH);
            make.width.offset(SCREEN_WIDTH);
        }];
    }else{
        _moreH = 118.0+ISNEEDSHOWHH;
        _headView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CPTBuyHeadView class]) owner:self options:nil]firstObject];
        _headView.type = self.type;
        _headView.delegate = self;
        [self.view addSubview:_headView];
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.view);
            make.top.offset(0);//CPT_StatusBarAndNavigationBarHeight
            make.height.offset(self->_moreH);
            make.width.offset(SCREEN_WIDTH);
        }];
    }
    CGFloat itemSpace = 0;
    kItem_Number = 4;
    if(self.type == CPTBuyTicketType_AoZhouACT){
        
        _moreH = 190+ISNEEDSHOWHH;
        [_headView mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.height.offset(self->_moreH);
        }];

        _actLotteryView = [[AoZhouACTScrollview alloc] init];
        _actLotteryView.backgroundColor = self.view.backgroundColor;

        [self.view addSubview:_actLotteryView];

        [self loadFootView];

        [_actLotteryView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self->_headView.mas_bottom);
            make.width.offset(SCREEN_WIDTH);
//            make.height.offset(500);
            make.bottom.equalTo(self.bottomView.mas_top);
        }];
        [_actLotteryView configUI];
        _actLotteryView.userInteractionEnabled = YES;
        _actLotteryView.lotteryView.delegate = self;

    }else{
        [self loadFootView];
        _leftView = [[CPTBuyLeftView alloc] init];
        [self.view addSubview:_leftView];
        _leftView.delegate = self;
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self->_headView);
            make.top.equalTo(self->_headView.mas_bottom);
            make.width.offset(85.);
            make.bottom.equalTo(self.bottomView.mas_top);
        }];
        
        
        _subTypeView = [[CPTBuySubTypeView alloc] init];
        [self.view addSubview:_subTypeView];
        _subTypeView.delegate = self;
        [_subTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self->_leftView.mas_right);
            make.top.equalTo(self->_leftView);
            make.width.offset(SCREEN_WIDTH-85.);
            make.height.offset(80);
        }];
        [_subTypeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
        _subTypeView.hidden = YES;
        
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _layout.minimumInteritemSpacing = itemSpace;
        _layout.minimumLineSpacing = itemSpace;
        CGFloat itemWidth = (SCREEN_WIDTH - itemSpace * (kItem_Number - 1)) / kItem_Number;
        _layout.itemSize = CGSizeMake(itemWidth, 110);
        _layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 30 + SCREEN_WIDTH * 0.4 + 10);
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_layout];
        if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
            _collectView.backgroundColor =  WHITE;
        } else{
            _collectView.backgroundColor =  [[CPTThemeConfig shareManager] RootVC_ViewBackgroundC];//MAINCOLOR
        }
        //        _collectView.layer.masksToBounds = YES;
        //        _collectView.layer.cornerRadius = 10;
        UINib * nib = [UINib nibWithNibName:NSStringFromClass([CPTBuyRightPaiLieCell class]) bundle:[NSBundle mainBundle]];
        [_collectView registerNib:nib forCellWithReuseIdentifier:@"CPTBuyRightPaiLieCell"];
        
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([CPTBuyRightCollectionCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CPTBuyRightCollectionCell"];
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([CPTBuyRightCollectionTwoNCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CPTBuyRightCollectionTwoNCell"];
        
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([CPTBuyRightCollectionBanBoCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CPTBuyRightCollectionBanBoCell"];
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([CPTBuyRightCollectionWeiShuCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CPTBuyRightCollectionWeiShuCell"];
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([CPTBuyRightCollectionWuxingCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CPTBuyRightCollectionWuxingCell"];
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([CPTBuyRightCollectionOneToFiveBallCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CPTBuyRightCollectionOneToFiveBallCell"];
        
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([CPTBuyCollectionHeadView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CPTBuyCollectionHeadView"];
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([CPTBuyCollectionLonghuHeadView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CPTBuyCollectionLonghuHeadView"];
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([CPTBuyCollectionWithLineHeadView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CPTBuyCollectionWithLineHeadView"];
        
        
        _collectView.showsVerticalScrollIndicator = NO;
        _collectView.delegate = self;
        _collectView.dataSource = self;
        [self.view addSubview:_collectView];
        [_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self->_leftView.mas_right);
            make.top.equalTo(self->_subTypeView.mas_bottom);
            make.bottom.equalTo(self->_leftView).offset(-self->_subTypeView.height);
            make.width.offset(SCREEN_WIDTH-85);
        }];
    }
    
    _stopView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CPTBuyStopView class]) owner:self options:nil]firstObject];
    [self.view addSubview:_stopView];
    [_stopView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.view);
        make.top.equalTo(self->_leftView ? self->_leftView:self->_actLotteryView);
        make.bottom.equalTo(self->_bottomView);
    }];
    _stopView.hidden = YES;
    [self performSelector:@selector(configUI) withObject:nil afterDelay:0.1];

}

- (void)configUI{

    _indexSection = 0;
    _playTypes = [[CPTBuyDataManager shareManager] configDataByTicketType:self.type];
    NSMutableArray * tt = [self configLeftData];
    [_leftView configUIByData:tt];
    if(tt.count>0){
        _currentPlayModel = tt[0];
        _currentBtn = [_leftView selectButtonByIndex:_currentPlayModel.playType];
        if(self.type == CPTBuyTicketType_AoZhouACT){
            _headView.typeLabel.text = @"澳洲ACT";
        }else{
            _headView.typeLabel.text = _currentPlayModel.playType ;
        }
        [_currentBtn checkPointState];
        [_collectView reloadData];

    }
    _headView.endTime = self.endTime;
    _headView.lotteryId = self.lotteryId;
    [_headView configUIByData];
}
- (NSMutableArray *)configRightDataByKey:(NSString *)key{
    NSMutableArray * a = [NSMutableArray array];
    for(NSInteger i=0;i<_playTypes.count;i++){
        CPTSixPlayTypeModel * playTypeModel = _playTypes[i];
        if(playTypeModel.superType.length>0){
            if([key isEqualToString:playTypeModel.superType]){
                [a addObject:playTypeModel];
            }
        }
    }
    return a;
}

- (void )configRightHeadViewByData:(NSArray<CPTSixPlayTypeModel *>  *)key{
    [_subTypeView configUIByData:key];
    [_subTypeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(38);
    }];
    _subTypeView.hidden = NO;

}

- (NSMutableArray *)configLeftData{
    NSMutableArray * a = [NSMutableArray array];
    for(NSInteger i=0;i<_playTypes.count;i++){
        CPTSixPlayTypeModel * playTypeModel = _playTypes[i];
        if(playTypeModel.superType.length==0){
                [a addObject:playTypeModel];
        }
    }
    return a;
}

- (NSInteger)numberOfSections{
    NSInteger numberOfSections = 0;
    for(CPTSixsubPlayTypeModel * model in _currentPlayModel.subTypes){
        numberOfSections = numberOfSections + model.numberCellInSection.count;
    }
    return numberOfSections;
}

- (NSInteger)numberOfSectionsByIndex:(NSInteger )index{//通过index 查询上一个Section的 真实section个数
    NSInteger numberOfSections = 0;
    for(NSInteger i =0;i<index;i++){
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[i];
        numberOfSections = numberOfSections + model.numberCellInSection.count;
    }
    return numberOfSections;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self numberOfSections];
}

- (NSInteger )numberOfItemsInSection:(NSInteger)section{
    NSInteger totle = 0;
    for(NSInteger i =0;i<_currentPlayModel.subTypes.count;i++){
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[i];
        totle = model.numberCellInSection.count + totle;
        if(totle>=section+1){
            return i;
        }
//        if(_currentPlayModel.subTypes.count<=2){
//            if(section < totle-1){
//                return i;
//            }else if(section > totle-1){
//                return i+1;
//            }else if(section == totle-1){
//                return i;
//            }
//        }else if(_currentPlayModel.subTypes.count>=3){
//            if(section < totle-1){
//                return i;
//            }else if(section > totle-1){
//                if(_currentPlayModel.subTypes.count>=3 && i==3)
//                return i+1;
//            }else if(section == totle-1){
//                return i;
//            }
//        }

    }
    return 0;
}

- (NSInteger )indexSection:(NSInteger)section{
    NSInteger okSection = section;
    NSInteger index = [self numberOfItemsInSection:section];
//    MBLog(@"index:%ld",(long)index);
    if(index ==1){
        NSInteger lastS = 0;
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[0];
        lastS = lastS+model.numberCellInSection.count;
        okSection = section - lastS;
    }else     if(index ==2){
        NSInteger lastS = 0;
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[0];
        lastS = lastS+model.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model1 = _currentPlayModel.subTypes[1];
        lastS = lastS+model1.numberCellInSection.count;
        okSection = section - lastS;

    }else     if(index ==3){
        NSInteger lastS = 0;
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[0];
        lastS = lastS+model.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model1 = _currentPlayModel.subTypes[1];
        lastS = lastS+model1.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model2 = _currentPlayModel.subTypes[2];
        lastS = lastS+model2.numberCellInSection.count;
        okSection = section - lastS;
    }else     if(index ==4){
        NSInteger lastS = 0;
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[0];
        lastS = lastS+model.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model1 = _currentPlayModel.subTypes[1];
        lastS = lastS+model1.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model2 = _currentPlayModel.subTypes[2];
        lastS = lastS+model2.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model3 = _currentPlayModel.subTypes[3];
        lastS = lastS+model3.numberCellInSection.count;
        okSection = section - lastS;
    }else     if(index ==4){
        NSInteger lastS = 0;
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[0];
        lastS = lastS+model.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model1 = _currentPlayModel.subTypes[1];
        lastS = lastS+model1.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model2 = _currentPlayModel.subTypes[2];
        lastS = lastS+model2.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model3 = _currentPlayModel.subTypes[3];
        lastS = lastS+model3.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model4 = _currentPlayModel.subTypes[4];
        lastS = lastS+model4.numberCellInSection.count;
        okSection = section - lastS;
    }else     if(index ==5){
        NSInteger lastS = 0;
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[0];
        lastS = lastS+model.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model1 = _currentPlayModel.subTypes[1];
        lastS = lastS+model1.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model2 = _currentPlayModel.subTypes[2];
        lastS = lastS+model2.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model3 = _currentPlayModel.subTypes[3];
        lastS = lastS+model3.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model4 = _currentPlayModel.subTypes[4];
        lastS = lastS+model4.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model5 = _currentPlayModel.subTypes[5];
        lastS = lastS+model5.numberCellInSection.count;
        okSection = section - lastS;
    }else     if(index ==6){
        NSInteger lastS = 0;
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[0];
        lastS = lastS+model.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model1 = _currentPlayModel.subTypes[1];
        lastS = lastS+model1.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model2 = _currentPlayModel.subTypes[2];
        lastS = lastS+model2.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model3 = _currentPlayModel.subTypes[3];
        lastS = lastS+model3.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model4 = _currentPlayModel.subTypes[4];
        lastS = lastS+model4.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model5 = _currentPlayModel.subTypes[5];
        lastS = lastS+model5.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model6 = _currentPlayModel.subTypes[6];
        lastS = lastS+model6.numberCellInSection.count;
        okSection = section - lastS;
    }else     if(index ==7){
        NSInteger lastS = 0;
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[0];
        lastS = lastS+model.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model1 = _currentPlayModel.subTypes[1];
        lastS = lastS+model1.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model2 = _currentPlayModel.subTypes[2];
        lastS = lastS+model2.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model3 = _currentPlayModel.subTypes[3];
        lastS = lastS+model3.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model4 = _currentPlayModel.subTypes[4];
        lastS = lastS+model4.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model5 = _currentPlayModel.subTypes[5];
        lastS = lastS+model5.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model6 = _currentPlayModel.subTypes[6];
        lastS = lastS+model6.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model7 = _currentPlayModel.subTypes[7];
        lastS = lastS+model7.numberCellInSection.count;
        okSection = section - lastS;
    }else     if(index ==8){
        NSInteger lastS = 0;
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[0];
        lastS = lastS+model.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model1 = _currentPlayModel.subTypes[1];
        lastS = lastS+model1.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model2 = _currentPlayModel.subTypes[2];
        lastS = lastS+model2.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model3 = _currentPlayModel.subTypes[3];
        lastS = lastS+model3.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model4 = _currentPlayModel.subTypes[4];
        lastS = lastS+model4.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model5 = _currentPlayModel.subTypes[5];
        lastS = lastS+model5.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model6 = _currentPlayModel.subTypes[6];
        lastS = lastS+model6.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model7 = _currentPlayModel.subTypes[7];
        lastS = lastS+model7.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model8 = _currentPlayModel.subTypes[8];
        lastS = lastS+model8.numberCellInSection.count;
        okSection = section - lastS;
    }else     if(index ==9){
        NSInteger lastS = 0;
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[0];
        lastS = lastS+model.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model1 = _currentPlayModel.subTypes[1];
        lastS = lastS+model1.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model2 = _currentPlayModel.subTypes[2];
        lastS = lastS+model2.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model3 = _currentPlayModel.subTypes[3];
        lastS = lastS+model3.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model4 = _currentPlayModel.subTypes[4];
        lastS = lastS+model4.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model5 = _currentPlayModel.subTypes[5];
        lastS = lastS+model5.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model6 = _currentPlayModel.subTypes[6];
        lastS = lastS+model6.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model7 = _currentPlayModel.subTypes[7];
        lastS = lastS+model7.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model8 = _currentPlayModel.subTypes[8];
        lastS = lastS+model8.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model9 = _currentPlayModel.subTypes[9];
        lastS = lastS+model9.numberCellInSection.count;
        okSection = section - lastS;
    }else     if(index ==10){
        NSInteger lastS = 0;
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[0];
        lastS = lastS+model.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model1 = _currentPlayModel.subTypes[1];
        lastS = lastS+model1.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model2 = _currentPlayModel.subTypes[2];
        lastS = lastS+model2.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model3 = _currentPlayModel.subTypes[3];
        lastS = lastS+model3.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model4 = _currentPlayModel.subTypes[4];
        lastS = lastS+model4.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model5 = _currentPlayModel.subTypes[5];
        lastS = lastS+model5.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model6 = _currentPlayModel.subTypes[6];
        lastS = lastS+model6.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model7 = _currentPlayModel.subTypes[7];
        lastS = lastS+model7.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model8 = _currentPlayModel.subTypes[8];
        lastS = lastS+model8.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model9 = _currentPlayModel.subTypes[9];
        lastS = lastS+model9.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model10 = _currentPlayModel.subTypes[10];
        lastS = lastS+model10.numberCellInSection.count;
        okSection = section - lastS;
    }else     if(index ==11){
        NSInteger lastS = 0;
        CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[0];
        lastS = lastS+model.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model1 = _currentPlayModel.subTypes[1];
        lastS = lastS+model1.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model2 = _currentPlayModel.subTypes[2];
        lastS = lastS+model2.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model3 = _currentPlayModel.subTypes[3];
        lastS = lastS+model3.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model4 = _currentPlayModel.subTypes[4];
        lastS = lastS+model4.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model5 = _currentPlayModel.subTypes[5];
        lastS = lastS+model5.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model6 = _currentPlayModel.subTypes[6];
        lastS = lastS+model6.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model7 = _currentPlayModel.subTypes[7];
        lastS = lastS+model7.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model8 = _currentPlayModel.subTypes[8];
        lastS = lastS+model8.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model9 = _currentPlayModel.subTypes[9];
        lastS = lastS+model9.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model10 = _currentPlayModel.subTypes[10];
        lastS = lastS+model10.numberCellInSection.count;
        CPTSixsubPlayTypeModel * model11 = _currentPlayModel.subTypes[11];
        lastS = lastS+model11.numberCellInSection.count;
        okSection = section - lastS;
    }
    return okSection<0 ? 0:okSection;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger index = [self numberOfItemsInSection:section];
    NSInteger tmpSection = [self indexSection:section];
    if(tmpSection == _currentPlayModel.subTypes[index].numberCellInSection.count){
        tmpSection = tmpSection-1;
    }
    NSString *number = _currentPlayModel.subTypes[index].numberCellInSection[tmpSection];
    MBLog(@"number:%@",number);
    if([_currentPlayModel.playType isEqualToString:@"正码1-6"] && [self numberOfSections] == section + 1){
        NSInteger totle = [number integerValue] +1;
        return totle;
    }
    return [number integerValue];
}

- (NSInteger )indexByIndexPath:(NSIndexPath *)indexPath{
    NSInteger tmpS = [self numberOfItemsInSection:indexPath.section];
    NSInteger sectionInTable = 0;
    sectionInTable = indexPath.section - ([self numberOfSectionsByIndex:tmpS] );

    NSInteger numberOfSections = 0;
    CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[tmpS];
    for(NSInteger i =0;i<sectionInTable;i++){
        numberOfSections = numberOfSections + [model.numberCellInSection[i] integerValue];
    }
    return numberOfSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row + [self indexByIndexPath:indexPath];
    CPTBuyBallModel * model = _currentPlayModel.subTypes[[self numberOfItemsInSection:indexPath.section]].balls[index] ;
    _bottomView.superType = model.superKey;
    _bottomView.superPlayKey = model.superPlayKey;
    UICollectionViewCell * tmpCell;
    NSInteger uiType = [model.uiType integerValue];
    if(uiType==0){
        CPTBuyRightCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CPTBuyRightCollectionCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else if (uiType ==1){
        CPTBuyRightCollectionTwoNCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CPTBuyRightCollectionTwoNCell" forIndexPath:indexPath];
        NSInteger tmpSection = [self indexSection:indexPath. section];
        NSInteger count = [_currentPlayModel.subTypes[[self numberOfItemsInSection:indexPath.section]].numberCellInSection[tmpSection] integerValue];
        if([_currentPlayModel.playType isEqualToString:@"正码1-6"] && [self numberOfSections] == indexPath. section + 1){
            count = 3;
        }
        if(indexPath.section != 0){
            cell.tmpY.constant = 5.0;
        }else{
            cell.tmpY.constant = 0.0;
        }
        if (indexPath.row%3==0) {
            if(count == 1){
                cell.leftX.constant = 10.0;
                cell.rightX.constant = 10.0;
            }else{
                cell.leftX.constant = 10.0;
                cell.rightX.constant = 0.0;
            }
        }else if (indexPath.row%3==1){
            if(count == 2){
                cell.leftX.constant = 5.0;
                cell.rightX.constant = 10.0;
            }else{
                cell.leftX.constant = 5.0;
                cell.rightX.constant = 5.0;
            }

        }else if (indexPath.row%3==2){
            cell.leftX.constant = 0.0;
            cell.rightX.constant = 10.0;
        }
        cell.model = model;
        MBLog(@"title: %@, subtitle: %@",cell.model.title,cell.model.subTitle);

        return cell;
    }else if (uiType ==2){
        CPTBuyRightCollectionBanBoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CPTBuyRightCollectionBanBoCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else if (uiType ==4){
        CPTBuyRightPaiLieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CPTBuyRightPaiLieCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else if (uiType ==3){
        CPTBuyRightCollectionWeiShuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CPTBuyRightCollectionWeiShuCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else if (uiType ==5){
        CPTBuyRightCollectionWuxingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CPTBuyRightCollectionWuxingCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else if(uiType == 6){
        CPTBuyRightCollectionOneToFiveBallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CPTBuyRightCollectionOneToFiveBallCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    return tmpCell;
}
// AFan<<<
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        if([self isHeaderBySection:indexPath.section]){
            CPTBuyBallModel * model = _currentPlayModel.subTypes[[self numberOfItemsInSection:indexPath.section]].balls[0];
            NSInteger uiType = [model.uiType integerValue];
            NSString * play = _currentPlayModel.subTypes[[self numberOfItemsInSection:indexPath.section]].subPlayType;
            if(uiType==6 && indexPath.section != 0 && self.type != CPTBuyTicketType_3D && (self.type == CPTBuyTicketType_HaiNanQiXingCai && ![_currentPlayModel.playType isEqualToString:@"直选复式"])){
                CPTBuyCollectionWithLineHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CPTBuyCollectionWithLineHeadView" forIndexPath:indexPath];
                header.titleLabel.text = play;
                if(indexPath.section==0){
                    header.lineView.hidden = YES;
                }else{
                    header.lineView.hidden = NO;
                }
                return header;
            }else{
                if([play isEqualToString:@"1-6龙虎"]){
                CPTBuyCollectionLonghuHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CPTBuyCollectionLonghuHeadView" forIndexPath:indexPath];
                header.titleLabel.text = play;
                if(indexPath.section==0){
                    header.infoButton.hidden = NO;
                }else{
                    header.infoButton.hidden = YES;
                }
                return header;
            }else
                {
                    CPTBuyCollectionHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CPTBuyCollectionHeadView" forIndexPath:indexPath];
                    header.titleLabel.text = header.titleLabel2.text = play;
                    if((self.type == CPTBuyTicketType_HaiNanQiXingCai && [_currentPlayModel.playType isEqualToString:@"直选复式"])||(self.type == CPTBuyTicketType_PaiLie35 && ![_currentPlayModel.playType isEqualToString:@"两面"] && ![_currentPlayModel.playType isEqualToString:@"定位胆"]) || (self.type == CPTBuyTicketType_3D && ![_currentPlayModel.playType isEqualToString:@"混合"] && ![_currentPlayModel.playType isEqualToString:@"两面"]&& ![_currentPlayModel.playType isEqualToString:@"和数"]&& ![_currentPlayModel.playType isEqualToString:@"通选"]) || (self.type == CPTBuyTicketType_HaiNanQiXingCai && ![_currentPlayModel.playType isEqualToString:@"两面"] && ![_currentPlayModel.playType isEqualToString:@"定位胆"])){
                        header.titleLabel2.hidden = YES;
                        header.pointView2.hidden = YES;
                        header.pointView3.hidden = YES;
                        header.titleLabel.hidden = NO;
                        header.pointView.hidden = NO;
                        
                        header.segment.hidden = NO;
                        if(indexPath.section==0){
                            header.lineView.hidden = YES;
                        }else{
                            header.lineView.hidden = NO;
                        }
                        @weakify(self)
                        header.segmentClick= ^(NSInteger index){
                            @strongify(self)
                            NSArray<CPTBuyBallModel *> *balls = self->_currentPlayModel.subTypes[[self numberOfItemsInSection:indexPath.section]].balls;
                            switch (index) {
                                case 0:
                                {
                                    for(CPTBuyBallModel * ball in balls){
                                        ball.selected = YES;
                                        [self->_currentBtn.selectModels addObject:ball];
                                        [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:ball];
                                        self->_bottomView.superType = ball.superKey;
                                        self->_bottomView.superPlayKey = ball.superPlayKey;
                                    }
                                }
                                    break;
                                case 1:
                                {
                                    for(CPTBuyBallModel * ball in balls){
                                        if([ball.title integerValue] >4){
                                            ball.selected = YES;
                                            [self->_currentBtn.selectModels addObject:ball];
                                            [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:ball];
                                        }else{
                                            ball.selected = NO;
                                            if([self->_currentBtn.selectModels containsObject:ball]){
                                                [self->_currentBtn.selectModels removeObject:ball];
                                                [[CPTBuyDataManager shareManager] removeBallModelFromTmpCartArray:ball];
                                            }
                                        }
                                        self->_bottomView.superType = ball.superKey;
                                        self->_bottomView.superPlayKey = ball.superPlayKey;
                                    }
                                }
                                    break;
                                case 2:
                                {
                                    for(CPTBuyBallModel * ball in balls){
                                        if([ball.title integerValue] <=4){
                                            ball.selected = YES;
                                            [self->_currentBtn.selectModels addObject:ball];
                                            [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:ball];
                                        }else{
                                            ball.selected = NO;
                                            if([self->_currentBtn.selectModels containsObject:ball]){
                                                [self->_currentBtn.selectModels removeObject:ball];
                                                [[CPTBuyDataManager shareManager] removeBallModelFromTmpCartArray:ball];
                                            }
                                        }
                                        self->_bottomView.superType = ball.superKey;
                                        self->_bottomView.superPlayKey = ball.superPlayKey;
                                    }
                                }
                                    break;
                                case 3:
                                {
                                    for(CPTBuyBallModel * ball in balls){
                                        if([ball.title integerValue]%2 == 1){
                                            ball.selected = YES;
                                            [self->_currentBtn.selectModels addObject:ball];
                                            [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:ball];
                                        }else{
                                            ball.selected = NO;
                                            if([self->_currentBtn.selectModels containsObject:ball]){
                                                [self->_currentBtn.selectModels removeObject:ball];
                                                [[CPTBuyDataManager shareManager] removeBallModelFromTmpCartArray:ball];
                                            }
                                        }
                                        self->_bottomView.superType = ball.superKey;
                                        self->_bottomView.superPlayKey = ball.superPlayKey;
                                    }
                                }
                                    break;
                                case 4:
                                {
                                    for(CPTBuyBallModel * ball in balls){
                                        if([ball.title integerValue]%2 == 0){
                                            ball.selected = YES;
                                            [self->_currentBtn.selectModels addObject:ball];
                                            [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:ball];
                                        }else{
                                            ball.selected = NO;
                                            if([self->_currentBtn.selectModels containsObject:ball]){
                                                [self->_currentBtn.selectModels removeObject:ball];
                                                [[CPTBuyDataManager shareManager] removeBallModelFromTmpCartArray:ball];
                                            }
                                        }
                                        self->_bottomView.superType = ball.superKey;
                                        self->_bottomView.superPlayKey = ball.superPlayKey;
                                    }
                                }
                                    break;
                                case 5:
                                {
                                    for(CPTBuyBallModel * ball in balls){
                                        ball.selected = NO;
                                        if([self->_currentBtn.selectModels containsObject:ball]){
                                            [self->_currentBtn.selectModels removeObject:ball];
                                        }
                                        [[CPTBuyDataManager shareManager] removeBallModelFromTmpCartArray:ball];
                                        self-> _bottomView.superType = ball.superKey;
                                        self->_bottomView.superPlayKey = ball.superPlayKey;
                                    }
                                }
                                    break;
                                default:
                                    break;
                            }
                            [self->_currentBtn checkPointState];
                            [self refreshBottomViewUI];
//                            [collectionView reloadData];
                            NSMutableArray * a = [NSMutableArray array];
                            for(NSInteger i = 0;i<10;i++){
                                if(i<=4){
                                   NSIndexPath * p = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
                                    [a addObject:p];
                                }else{
                                   NSIndexPath * p =  [NSIndexPath indexPathForRow:i-5 inSection:indexPath.section+1];
                                    [a addObject:p];
                                }
                            }
                            [collectionView reloadItemsAtIndexPaths:a];
//                            [self->_collectView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.section, 2)]];

                        };
                    }else{
                        header.segment.hidden = YES;
                        header.titleLabel2.hidden = NO;
                        header.pointView2.hidden = NO;
                        header.pointView3.hidden = NO;
                        header.titleLabel.hidden = YES;
                        header.pointView.hidden = YES;
                    }
                    return header;
                }
            }
      
        }
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger tmpSection = [self indexSection:indexPath. section];

    NSInteger count = [_currentPlayModel.subTypes[[self numberOfItemsInSection:indexPath.section]].numberCellInSection[tmpSection] integerValue];

    CGFloat itemWidth = (SCREEN_WIDTH-85)/ count;
    NSInteger index = indexPath.row + [self indexByIndexPath:indexPath];
    CPTBuyBallModel * model = _currentPlayModel.subTypes[[self numberOfItemsInSection:indexPath.section]].balls[index] ;
    NSInteger uiType = [model.uiType integerValue];
    if(uiType==0){
        if(count ==1){
            count = 4;
        }
        itemWidth = (SCREEN_WIDTH-85.)/ count;
        return CGSizeMake(itemWidth, 70);
    }else if(uiType==1){
        if([_currentPlayModel.playType isEqualToString:@"正码1-6"] && [self numberOfSections] == indexPath. section + 1){
            itemWidth = (SCREEN_WIDTH-85)/ 3;
        }
        return CGSizeMake(itemWidth, 50);
    }else if(uiType==2){
        return CGSizeMake(itemWidth, 92);
    }else if(uiType==3){
        return CGSizeMake(itemWidth, 62);
    }else if(uiType==4){
        itemWidth = (SCREEN_WIDTH-85.)/ count;
        return CGSizeMake(itemWidth, 70);
    }else if(uiType==5){
        return CGSizeMake(SCREEN_WIDTH-85., 92);
    }else if(uiType ==6){
        if(count ==3){
            count = 5;
        }
        itemWidth = (SCREEN_WIDTH-85.)/ count;
        return CGSizeMake(itemWidth, 70);
    }
    return CGSizeZero;
}


- (BOOL)isHeaderBySection:(NSInteger)section{
//    if(section ==0){
//        return YES;
//    }
    NSInteger count = 0;
    for(NSInteger i =0 ;i<_currentPlayModel.subTypes.count;i++){
        if(section == count){
            return YES;
        }
        count = count +_currentPlayModel.subTypes[i].numberCellInSection.count;
    }
    return NO;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if([self isHeaderBySection:section]){
        NSString * play = _currentPlayModel.subTypes[[self numberOfItemsInSection:section]].subPlayType;
        CPTBuyBallModel * model = _currentPlayModel.subTypes[[self numberOfItemsInSection:section]].balls[0];
        NSInteger uiType = [model.uiType integerValue];
        if([play isEqualToString:@"1-6龙虎"]){
            return CGSizeMake(SCREEN_WIDTH-85., 103);
        }else{
            if(uiType == 6 && section !=0){
                return CGSizeMake(SCREEN_WIDTH-85., 60);
            }else{
                return CGSizeMake(SCREEN_WIDTH-85., 40);
            }
        }
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    if (section == self.dataArray.count / kItem_Number) {
    //        return UIEdgeInsetsMake(15, 20, 5, 15);//分别为上、左、下、右
    //    }
    //    if (section == 2) {
    //        return UIEdgeInsetsMake(10, 0, 0, 0);
    //    }
//    CPTBuyBallModel * model = _currentPlayModel.subTypes[[self numberOfItemsInSection:section]].balls[0] ;
//    NSInteger uiType = [model.uiType integerValue];
//    if(uiType == 1){
//        return UIEdgeInsetsMake(0, 5, 0, 0);
//    }
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSInteger type = indexPath.row + indexPath.section * kItem_Number;
//    CPTBuyRightButtonModel * model = _rightModels[type];
    CPTBuyRightCollectionCell *cell = (CPTBuyRightCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if(cell.model.selected){
        cell.isSelected = NO;
    }else{
        cell.isSelected = YES;
    }
    if(cell.isSelected){
        [_currentBtn.selectModels addObject:cell.model];
        [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:cell.model];
    }else{
        [_currentBtn.selectModels removeObject:cell.model];
        [[CPTBuyDataManager shareManager] removeBallModelFromTmpCartArray:cell.model];
    }
    [_currentBtn checkPointState];
    if(_subTypeButton){
        if(_currentBtn.selectModels.count>0){
            [_currentBtn showSelPoint];
        }else{
            [_currentBtn showUnSelPoint];
        }
    }
    _bottomView.superType = cell.model.superKey;
    _bottomView.superPlayKey = cell.model.superPlayKey;
    [self refreshBottomViewUI];
}

- (void)clickIndexPath:(NSIndexPath *)indexPath index:(NSInteger)index{
        NSArray<CPTBuyBallModel *> *balls = self->_currentPlayModel.subTypes[[self numberOfItemsInSection:indexPath.section]].balls;
        switch (index) {
            case 0:
            {
                for(CPTBuyBallModel * ball in balls){
                    ball.selected = YES;
                    [self->_currentBtn.selectModels addObject:ball];
                    [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:ball];
                    self->_bottomView.superType = ball.superKey;
                    self->_bottomView.superPlayKey = ball.superPlayKey;
                }
            }
                break;
            case 1:
            {
                for(CPTBuyBallModel * ball in balls){
                    if([ball.title integerValue] >4){
                        ball.selected = YES;
                    }else{
                        ball.selected = NO;
                    }
                    [self->_currentBtn.selectModels addObject:ball];
                    [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:ball];
                    self->_bottomView.superType = ball.superKey;
                    self->_bottomView.superPlayKey = ball.superPlayKey;
                }
            }
                break;
            case 2:
            {
                for(CPTBuyBallModel * ball in balls){
                    if([ball.title integerValue] <=4){
                        ball.selected = YES;
                    }else{
                        ball.selected = NO;
                    }
                    [self->_currentBtn.selectModels addObject:ball];
                    [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:ball];
                    self->_bottomView.superType = ball.superKey;
                    self->_bottomView.superPlayKey = ball.superPlayKey;
                }
            }
                break;
            case 3:
            {
                for(CPTBuyBallModel * ball in balls){
                    if([ball.title integerValue]%2 == 1){
                        ball.selected = YES;
                    }else{
                        ball.selected = NO;
                    }
                    [self->_currentBtn.selectModels addObject:ball];
                    [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:ball];
                    self->_bottomView.superType = ball.superKey;
                    self->_bottomView.superPlayKey = ball.superPlayKey;
                }
            }
                break;
            case 4:
            {
                for(CPTBuyBallModel * ball in balls){
                    if([ball.title integerValue]%2 == 0){
                        ball.selected = YES;
                    }else{
                        ball.selected = NO;
                    }
                    [self->_currentBtn.selectModels addObject:ball];
                    [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:ball];
                    self->_bottomView.superType = ball.superKey;
                    self->_bottomView.superPlayKey = ball.superPlayKey;
                }
            }
                break;
            case 5:
            {
                for(CPTBuyBallModel * ball in balls){
                    ball.selected = NO;
                    [self->_currentBtn.selectModels addObject:ball];
                    [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:ball];
                    self-> _bottomView.superType = ball.superKey;
                    self->_bottomView.superPlayKey = ball.superPlayKey;
                }
            }
                break;
            default:
                break;
        }
        [self->_currentBtn checkPointState];
        [self refreshBottomViewUI];
        [self->_collectView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.section, 2)]];

}

#pragma mark - 清空选中的ball
- (void)clearModelState{
    [_currentBtn clearSelectModels];
    for(CPTBuyLeftButton *btn in _leftView.btnArray){
        for(CPTSixsubPlayTypeModel * subPlayTypeModel in btn.model.subTypes){
            for(CPTBuyBallModel * ballModel in subPlayTypeModel.balls){
                ballModel.selected = NO;
            }
        }
    }
    for(CPTBuyLeftButton *btn in _subTypeView.btnArray){
        for(CPTSixsubPlayTypeModel * subPlayTypeModel in btn.model.subTypes){
            for(CPTBuyBallModel * ballModel in subPlayTypeModel.balls){
                ballModel.selected = NO;
            }
        }
    }
    [_leftView clearAll];
//    [_subTypeView clearAll];

    [[CPTBuyDataManager shareManager] clearTmpCartArray];
    [self refreshBottomViewUI];
}

- (void)clearSubViewModelState{
    [_currentBtn clearSelectModels];
    for(CPTBuyLeftButton *btn in _subTypeView.btnArray){
        for(CPTSixsubPlayTypeModel * subPlayTypeModel in btn.model.subTypes){
            for(CPTBuyBallModel * ballModel in subPlayTypeModel.balls){
                ballModel.selected = NO;
            }
        }
    }
//    [_leftView clearAll];
    [[CPTBuyDataManager shareManager] clearTmpCartArray];
    [self refreshBottomViewUI];
}

#pragma mark - 刷新底部UI
- (void)refreshBottomViewUI{
    [_bottomView refreshUI];
}

#pragma mark - ACT

- (void)lotteryClickAction{
    [self refreshBottomViewUI];
}

#pragma mark - CPTCartSixHeadViewDelegate

- (void)clickDownBtn:(NSInteger)clickTimes{
//    [self.view layoutIfNeeded];
    UIView * tmpV = _leftView ? self->_leftView: self->_actLotteryView;
    @weakify(self)
    if(clickTimes ==1){
        [UIView animateWithDuration:0.4 animations:^{
            @strongify(self)
            [tmpV mas_updateConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.top.equalTo(self->_headView).offset(450);
            }];
            [self.view layoutIfNeeded];
        }];
    }else    if(clickTimes ==2){
        [UIView animateWithDuration:0.4 animations:^{
            @strongify(self)
            [tmpV mas_updateConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
//                make.top.equalTo(self->_headView).offset(500);
                make.top.equalTo(self->_headView).offset(self->_moreH);//162

            }];
            [self.view layoutIfNeeded];
        }];
    }else    if(clickTimes ==3){
        [UIView animateWithDuration:0.4 animations:^{
            @strongify(self)
            [tmpV mas_updateConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.top.equalTo(self->_headView).offset(162);
            }];
            [self.view layoutIfNeeded];
        }];
    }
}
-(void)addmoneyClick {
    if ([Person person].payLevelId.length == 0) {
        [MBProgressHUD showError:@"无用户层级, 暂无法充值"];
        return;
    }
    TopUpViewController *topUpVC = [[TopUpViewController alloc] init];
    [self.navigationController pushViewController:topUpVC animated:YES];

}

- (void)showStopView{
    _stopView.hidden = NO;
}

- (void)dismissStopView{
    if(_stopView.hidden == YES){
        return;
    }
    _stopView.hidden = YES;
}

- (void)tapRightView{
    IGKbetListCtrl *list = [[IGKbetListCtrl alloc]init];
    list.type = self.type;
    list.titlestring = [[CPTBuyDataManager shareManager] changeTypeToString:self.type];
    PUSH(list);
}

- (void)reFmoneyClick{
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:login animated:YES completion:nil];
        login.loginBlock = ^(BOOL result) {
            [self reFmoneyClick];
        };
        return;
    }
    @weakify(self)
    [[Person person] checkIsNeedRMoney:^(double money) {
        @strongify(self)
        self->_headView.moneyL.text = [NSString stringWithFormat:@"%.2f",money];
    } isNeedHUD:YES];
}



#pragma mark -  CPTBuyLeftButtonDelegate
- (void)clickLeftButtonView:(CPTBuyLeftButton *)btn{
    //除开六合彩，其他都要记录
    if(self.type == CPTBuyTicketType_LiuHeCai || self.type == CPTBuyTicketType_OneLiuHeCai || self.type == CPTBuyTicketType_FiveLiuHeCai || self.type == CPTBuyTicketType_ShiShiLiuHeCai || self.type == CPTBuyTicketType_PaiLie35|| self.type == CPTBuyTicketType_3D|| self.type == CPTBuyTicketType_PCDD|| self.type == CPTBuyTicketType_HaiNanQiXingCai){
        [self clearModelState];
        if([_currentBtn checkPointState]){
            [_currentBtn showSelPoint];
        }else{
            [_currentBtn hiddenPoint];
        }
    }else{
        if([_currentBtn checkPointState]){
            [_currentBtn showSelPoint];
        }else{
            [_currentBtn hiddenPoint];
        }
    }
    _currentBtn = btn;
    _currentPlayModel = _currentBtn.model;
    if(_currentPlayModel.isShow){
        _subTypeButton = btn;
        if(_subTypes){
            [_subTypes removeAllObjects];
            _subTypes = nil;
        }
        _subTypes = [self configRightDataByKey:_currentPlayModel.playType];
        [self configRightHeadViewByData:_subTypes];
        _headView.typeLabel.text = _subTypes[0].playType ;
    }else{
        _subTypeButton = nil;
        [_subTypeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
        _subTypeView.hidden = YES;

        _headView.typeLabel.text = _currentPlayModel.playType ;
    }
    for(CartTypeModel *model in _cartTypeModelArray){
        if([model.name isEqualToString:_currentPlayModel.playType]){
            _selectModel = model;
            _currentBtn.ID = model.ID;
        }
    }
    [self collectViewReloadData];
    
    if(self.type == CPTBuyTicketType_PaiLie35){
        if([_currentPlayModel.playType isEqualToString:@"P3直选"]){
            [_headView changeBallState:NO];
        }else if([_currentPlayModel.playType isEqualToString:@"P5直选"]){
            [_headView changeBallState:YES];
        }
    }
    [_currentBtn showUnSelPoint];

//    [_currentBtn checkPointState];
//    if(self.type != CPTBuyTicketType_LiuHeCai || self.type != CPTBuyTicketType_OneLiuHeCai || self.type != CPTBuyTicketType_FiveLiuHeCai || self.type != CPTBuyTicketType_ShiShiLiuHeCai){
//        [_currentBtn showUnSelPoint];
//    }

    
    self.categoryId = _selectModel.categoryId;
    
//    if([_hadgetedOddsArray containsObject:_currentPlayModel.playType]){
//        return;
//    }
//    if ([self isLiuHeCai:self.type]) {
//        [self getsubTypeData:_selectModel];
//    }else{
//        [self getsixUIData];
//    }
}

- (void)collectViewReloadData{
    
    [CATransaction setDisableActions:YES];
    [_collectView reloadData];
    [CATransaction commit];
}

#pragma mark - CPTBuySubTypeViewDelegate
- (void)clickBuySubTypeView:(CPTBuyLeftButton *)btn{
    [self clearSubViewModelState];
    _currentPlayModel = btn.model;
    [self collectViewReloadData];
    self.categoryId = _selectModel.categoryId;
    [_subTypeButton showUnSelPoint];
    _headView.typeLabel.text = _currentPlayModel.playType ;

}

#pragma mark - 加入购彩
- (void)configCartData{
    NSMutableArray<CPTBuyBallModel *> * betList = [[CPTBuyDataManager shareManager] dataTmpCartArray];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString*bStr = _headView.issue;
    [dic setValue:bStr forKey:@"issue"];
    [dic setValue:@(self.type) forKey:@"lotteryId"];
    [dic setValue:[Person person].uid forKey:@"userId"];

    CartTypeModel * type;
    NSInteger totleA = [self.bottomView checkIsOkToBuy];
    NSInteger limitCount = [self.bottomView checkLimitCount];
    if((self.type == CPTBuyTicketType_LiuHeCai || self.type == CPTBuyTicketType_FiveLiuHeCai || self.type == CPTBuyTicketType_ShiShiLiuHeCai || self.type == CPTBuyTicketType_OneLiuHeCai) && ([_currentPlayModel.playType isEqualToString:@"正码"] || [_currentPlayModel.playType isEqualToString:@"特码"] || [_currentPlayModel.playType isEqualToString:@"正特"] || [_currentPlayModel.playType isEqualToString:@"正1特"] || [_currentPlayModel.playType isEqualToString:@"正2特"] || [_currentPlayModel.playType isEqualToString:@"正3特"] || [_currentPlayModel.playType isEqualToString:@"正4特"] || [_currentPlayModel.playType isEqualToString:@"正5特"] || [_currentPlayModel.playType isEqualToString:@"正6特"])){
        NSMutableSet *playKeyArray = [NSMutableSet set];
        for(CPTBuyBallModel * ball in betList){
            [playKeyArray addObject:ball.superKey];
        }
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        
        for(NSString * playKey in playKeyArray){
            [dataDic setObject:[NSMutableArray array] forKey:playKey];
        }
        for(NSString * playKey in playKeyArray){
            for(CPTBuyBallModel * ball in betList){
                if([playKey isEqualToString:ball.superKey]){
                    NSMutableArray *tmpA = dataDic[playKey];
                    [tmpA addObject:ball];
                }
            }
        }
        for(NSString * playKey in playKeyArray){
            NSString * betNumber =[NSString stringWithFormat:@"%@@",playKey];
            NSMutableArray<CPTBuyBallModel *> *tmpA = dataDic[playKey];
            for(NSInteger i=0;i<tmpA.count;i++){
                CPTBuyBallModel * ball = tmpA[i];
                if(tmpA.count>0){
                    
                    if(i==tmpA.count-1){
                        betNumber = [betNumber stringByAppendingFormat:@"%@",ball.title];
                    }else{
                        betNumber = [betNumber stringByAppendingFormat:@"%@,",ball.title];
                    }
                    
                }
            }
            if(tmpA.count>0){
                type = [[CartTypeModel alloc] init];
                type.name = _currentPlayModel.playType;
                type.categoryId = [_currentPlayModel.categoryId integerValue];
                type.ID = [_currentPlayModel.ID integerValue];
                NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                [pdic setObject:@(type.ID) forKey:@"playId"];
                [pdic setObject:@(tmpA[0].settingId) forKey:@"settingId"];
                [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"pricetype"];
                [pdic setObject:@(tmpA.count) forKey:@"count"];
                [pdic setObject:betNumber forKey:@"number"];
                [pdic setObject:type forKey:@"type"];
                [pdic setObject:@(1) forKey:@"times"];

                [[CPTBuyDataManager shareManager] addBallModelToCartArray:pdic];
            }
        }
    }
    else if(self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_PaiLie35 || self.type == CPTBuyTicketType_HaiNanQiXingCai){
        NSMutableDictionary * betDic = [[CPTBuyDataManager shareManager] checkTmpCartArrayByType:_bottomView.superType superPlayKey:_bottomView.superPlayKey eachMoney:[_bottomView.textField.text integerValue]];
        NSMutableSet *playKeyArray = [NSMutableSet set];
        for(CPTBuyBallModel * ball in betList){
            [playKeyArray addObject:ball.superKey];
        }
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        
        for(NSString * playKey in playKeyArray){
            [dataDic setObject:[NSMutableArray array] forKey:playKey];
        }
        for(NSString * playKey in playKeyArray){
            for(CPTBuyBallModel * ball in betList){
                if([playKey isEqualToString:ball.superKey]){
                    NSMutableArray *tmpA = dataDic[playKey];
                    [tmpA addObject:ball];
                }
            }
        }
        NSMutableArray *betNumbers = [NSMutableArray array];
        for(NSString * playKey in playKeyArray){
            NSString * betNumber =[NSString stringWithFormat:@"%@@",playKey];
            NSMutableArray *tmpA = dataDic[playKey];
            for(NSInteger i=0;i<tmpA.count;i++){
                CPTBuyBallModel * ball = tmpA[i];
                if(tmpA.count>0){
                    if(i==tmpA.count-1){
                        betNumber = [betNumber stringByAppendingFormat:@"%@",ball.title];
                    }else{
                        betNumber = [betNumber stringByAppendingFormat:@"%@,",ball.title];
                    }
                }
            }
            if(tmpA.count>0){
                [betNumbers addObject:betNumber];
            }
        }
        NSString * betNumberS = [NSString string];
        for(NSInteger i=0;i<betNumbers.count;i++){
            NSString * betNumber = betNumbers[i];
            if(i==0){
                betNumberS = [betNumberS stringByAppendingFormat:@"%@",betNumber];
            }else{
                betNumberS = [betNumberS stringByAppendingFormat:@"_%@",betNumber];
            }
        }
        type = [[CartTypeModel alloc] init];
        type.name = _currentPlayModel.playType;
        type.categoryId = [_currentPlayModel.categoryId integerValue];
        type.ID = [_currentPlayModel.ID integerValue];
        NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
        [pdic setObject:@(type.ID) forKey:@"playId"];
        [pdic setObject:@(betList[0].settingId) forKey:@"settingId"];
        
        [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"pricetype"];
        [pdic setObject:@(1) forKey:@"times"];
        [pdic setObject:betDic[CPTCART_TOTLEAvailable] forKey:@"count"];
        [pdic setObject:type forKey:@"type"];
        [pdic setObject:betNumberS forKey:@"number"];
        [[CPTBuyDataManager shareManager] addBallModelToCartArray:pdic];

    }
    else if(self.type == CPTBuyTicketType_AoZhouACT){
        for(CPTBuyBallModel *model in betList){
            type = [[CartTypeModel alloc] init];
            type.name = @"澳洲ACT";
            type.categoryId = 22;
            type.ID = 220101;
            NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
            [pdic setObject:@(type.ID) forKey:@"playId"];
            [pdic setObject:@(model.settingId) forKey:@"settingId"];
            [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"pricetype"];
            [pdic setObject:@(1) forKey:@"times"];
            [pdic setObject:@(1) forKey:@"count"];
            [pdic setObject:type forKey:@"type"];
            NSString * betNumber = [NSString stringWithFormat:@"%@@%@",@"澳洲ACT",model.title];
            [pdic setObject:betNumber forKey:@"number"];
            [[CPTBuyDataManager shareManager] addBallModelToCartArray:pdic];
        }
    }else{
        if(limitCount>1 ){
            BOOL isOK = NO;
            for(CPTBuyLeftButton *btn in _leftView.btnArray){
                for(CPTBuyBallModel *model in betList){
                    if([model.superPlayKey isEqualToString:btn.model.playType]){
                        type = [[CartTypeModel alloc] init];
                        type.name = btn.model.playType;
                        type.categoryId = [btn.model.categoryId integerValue];
                        type.ID = [btn.model.ID integerValue];
                        NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                        //    |—— playId    Integer    （必须）玩法id
                        //    |—— settingId    Integer    （必须）玩法配置id
                        //    |—— betNumber    String    （必须）投注号码
                        //    |—— betAmount    double    （必须）投注金额
                        //    |—— betCount    Integer    （必须）总注数  1
                        [pdic setObject:@(type.ID) forKey:@"playId"];
                        [pdic setObject:@(betList[0].settingId) forKey:@"settingId"];
                        [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"pricetype"];
                        [pdic setObject:@(totleA) forKey:@"count"];
                        [pdic setObject:@(1) forKey:@"times"];
                        NSString * betNumber = [NSString stringWithFormat:@"%@",betList[0].superKey];
                        NSString * betdd = @"";
                        NSString * betNumber2;
                   
                            for(NSInteger i=0;i<betList.count;i++){
                                CPTBuyBallModel *model = betList[i];
                                if(i == betList.count-1){
                                    betdd = [betdd stringByAppendingFormat:@"%@",model.title];
                                }else{
                                    betdd = [betdd stringByAppendingFormat:@"%@,",model.title];
                                }
                            }
                            betNumber2 = [NSString stringWithFormat:@"%@@%@",betNumber,betdd];
                        [pdic setObject:betNumber2 forKey:@"number"];
                        [pdic setObject:type forKey:@"type"];
                        [[CPTBuyDataManager shareManager] addBallModelToCartArray:pdic];
                        isOK = YES;
                        break;
                    }
                }
                if(isOK){
                    break;
                }
            }
            if(!isOK){
                for(CPTBuyLeftButton *btn in _subTypeView.btnArray){
                    BOOL isOK = NO;
                    for(CPTBuyBallModel *model in betList){
                        if([model.superKey isEqualToString:btn.model.playType] || [model.superPlayKey isEqualToString:btn.model.playType]){
                            type = [[CartTypeModel alloc] init];
                            type.name = btn.model.playType;
                            type.categoryId = [btn.model.categoryId integerValue];
                            type.ID = [btn.model.ID integerValue];
                            NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                            //    |—— playId    Integer    （必须）玩法id
                            //    |—— settingId    Integer    （必须）玩法配置id
                            //    |—— betNumber    String    （必须）投注号码
                            //    |—— betAmount    double    （必须）投注金额
                            //    |—— betCount    Integer    （必须）总注数  1
                            [pdic setObject:@(type.ID) forKey:@"playId"];
                            [pdic setObject:@(betList[0].settingId) forKey:@"settingId"];
                            [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"pricetype"];
                            [pdic setObject:@(totleA) forKey:@"count"];
                            [pdic setObject:@(1) forKey:@"times"];
                            NSString * betNumber = [NSString stringWithFormat:@"%@",betList[0].superKey];
                            NSString * betdd = @"";
                            for(NSInteger i=0;i<betList.count;i++){
                                CPTBuyBallModel *model = betList[i];
                                if(i == betList.count-1){
                                    betdd = [betdd stringByAppendingFormat:@"%@",model.title];
                                }else{
                                    betdd = [betdd stringByAppendingFormat:@"%@,",model.title];
                                }
                            }
                            NSString *betNumber2 = [NSString stringWithFormat:@"%@@%@",betNumber,betdd];
                            [pdic setObject:betNumber2 forKey:@"number"];
                            [pdic setObject:type forKey:@"type"];
                            [[CPTBuyDataManager shareManager] addBallModelToCartArray:pdic];
                            isOK = YES;
                            break;
                        }
                        
                    }
                    if(isOK){
                        break;
                    }
                }
            }
        }else{
            if((self.type == CPTBuyTicketType_PK10 || self.type == CPTBuyTicketType_TenPK10 || self.type == CPTBuyTicketType_FivePK10 || self.type == CPTBuyTicketType_JiShuPK10 || self.type == CPTBuyTicketType_AoZhouF1 || self.type == CPTBuyTicketType_XYFT || self.type == CPTBuyTicketType_FFC)&& ![_currentPlayModel.playType isEqualToString:@"两面"]&& ![_currentPlayModel.playType isEqualToString:@"6-10名"] && ![_currentPlayModel.playType isEqualToString:@"1-5名"]&& ![_currentPlayModel.playType isEqualToString:@"前中后"] &&![_currentPlayModel.playType isEqualToString:@"第一球"] &&![_currentPlayModel.playType isEqualToString:@"第二球"] &&![_currentPlayModel.playType isEqualToString:@"第三球"] &&![_currentPlayModel.playType isEqualToString:@"第四球"] &&![_currentPlayModel.playType isEqualToString:@"第五球"]){
                for(CPTBuyLeftButton *btn in _leftView.btnArray){
                    for(CPTBuyBallModel *model in betList){
                        if([model.superKey isEqualToString:btn.model.playType]){
                            type = [[CartTypeModel alloc] init];
                            type.name = btn.model.playType;
                            type.categoryId = [btn.model.categoryId integerValue];
                            type.ID = [btn.model.ID integerValue];
                            
                            NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                            //    |—— playId    Integer    （必须）玩法id
                            //    |—— settingId    Integer    （必须）玩法配置id
                            //    |—— betNumber    String    （必须）投注号码
                            //    |—— betAmount    double    （必须）投注金额
                            //    |—— betCount    Integer    （必须）总注数  1
                            [pdic setObject:@(type.ID) forKey:@"playId"];
                            [pdic setObject:@(model.settingId) forKey:@"settingId"];
                            [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"pricetype"];
                            [pdic setObject:@(1) forKey:@"times"];
                            [pdic setObject:@(1) forKey:@"count"];
                            [pdic setObject:type forKey:@"type"];
                            NSString * betNumber = [NSString stringWithFormat:@"%@@%@",model.superKey,model.title];
                            [pdic setObject:betNumber forKey:@"number"];
                            [[CPTBuyDataManager shareManager] addBallModelToCartArray:pdic];
                            continue;
                        }
                    }
                }
            }else{
                for(CPTBuyLeftButton *btn in _leftView.btnArray){
                    for(CPTBuyBallModel *model in betList){
                        if([model.superPlayKey isEqualToString:btn.model.playType]){
                            type = [[CartTypeModel alloc] init];
                            type.name = btn.model.playType;
                            type.categoryId = [btn.model.categoryId integerValue];
                            type.ID = [btn.model.ID integerValue];
                            
                            NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                            //    |—— playId    Integer    （必须）玩法id
                            //    |—— settingId    Integer    （必须）玩法配置id
                            //    |—— betNumber    String    （必须）投注号码
                            //    |—— betAmount    double    （必须）投注金额
                            //    |—— betCount    Integer    （必须）总注数  1
                            [pdic setObject:@(type.ID) forKey:@"playId"];
                            [pdic setObject:@(model.settingId) forKey:@"settingId"];
                            [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"pricetype"];
                            [pdic setObject:@(1) forKey:@"times"];
                            [pdic setObject:@(1) forKey:@"count"];
                            [pdic setObject:type forKey:@"type"];
                            NSString * betNumber = [NSString stringWithFormat:@"%@@%@",model.superKey,model.title];
                            [pdic setObject:betNumber forKey:@"number"];
                            [[CPTBuyDataManager shareManager] addBallModelToCartArray:pdic];
                            continue;
                        }
                    }
                }
            }

            for(CPTBuyLeftButton *btn in _subTypeView.btnArray){
                for(CPTBuyBallModel *model in betList){
                    if([model.superPlayKey isEqualToString:btn.model.playType]){
                        type = [[CartTypeModel alloc] init];
                        type.name = btn.model.playType;
                        type.categoryId = [btn.model.categoryId integerValue];
                        type.ID = [btn.model.ID integerValue];
                        
                        NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                        //    |—— playId    Integer    （必须）玩法id
                        //    |—— settingId    Integer    （必须）玩法配置id
                        //    |—— betNumber    String    （必须）投注号码
                        //    |—— betAmount    double    （必须）投注金额
                        //    |—— betCount    Integer    （必须）总注数  1
                        [pdic setObject:@(type.ID) forKey:@"playId"];
                        [pdic setObject:@(model.settingId) forKey:@"settingId"];
                        [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"pricetype"];
                        [pdic setObject:@(1) forKey:@"times"];
                        [pdic setObject:@(1) forKey:@"count"];
                        [pdic setObject:type forKey:@"type"];
                        NSString * betNumber = [NSString stringWithFormat:@"%@@%@",model.superKey,model.title];
                        [pdic setObject:betNumber forKey:@"number"];
                        [[CPTBuyDataManager shareManager] addBallModelToCartArray:pdic];
                        continue;
                    }
                }
            }
        }
    }
}

-(void)addDataToCartShop{
    
    [self configCartData];
    [self clearModelState];
    [self.hub setCount:[[CPTBuyDataManager shareManager] dataCartArray].count];
    [self.hub bump];
}
#pragma mark - 立即投注
-(void)postDataWithnumber:(UIButton *)sender{
    @weakify(self)
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
    NSInteger totleA = [self.bottomView checkIsOkToBuy];
    NSInteger limitCount = [self.bottomView checkLimitCount];

    if(totleA == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"不够一注，请选择投注号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    sender.enabled = NO;
    NSMutableArray<CPTBuyBallModel *> * betList = [[CPTBuyDataManager shareManager] dataTmpCartArray];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString*bStr = _headView.issue;
    [dic setValue:bStr forKey:@"issue"];
    [dic setValue:@(self.type) forKey:@"lotteryId"];
    [dic setValue:[Person person].uid forKey:@"userId"];
    
    NSMutableArray * d = [NSMutableArray array];
    NSMutableDictionary * betDic = [[CPTBuyDataManager shareManager] checkTmpCartArrayByType:_bottomView.superType superPlayKey:_bottomView.superPlayKey eachMoney:[_bottomView.textField.text integerValue]];
    CartTypeModel * type;
    if((self.type == CPTBuyTicketType_LiuHeCai || self.type == CPTBuyTicketType_FiveLiuHeCai || self.type == CPTBuyTicketType_ShiShiLiuHeCai || self.type == CPTBuyTicketType_OneLiuHeCai) && ([_currentPlayModel.playType isEqualToString:@"正码"] || [_currentPlayModel.playType isEqualToString:@"特码"] || [_currentPlayModel.playType isEqualToString:@"正特"] || [_currentPlayModel.playType isEqualToString:@"正1特"] || [_currentPlayModel.playType isEqualToString:@"正2特"] || [_currentPlayModel.playType isEqualToString:@"正3特"] || [_currentPlayModel.playType isEqualToString:@"正4特"] || [_currentPlayModel.playType isEqualToString:@"正5特"] || [_currentPlayModel.playType isEqualToString:@"正6特"])){
        NSMutableSet *playKeyArray = [NSMutableSet set];
        for(CPTBuyBallModel * ball in betList){
            [playKeyArray addObject:ball.superKey];
        }
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        
        for(NSString * playKey in playKeyArray){
            [dataDic setObject:[NSMutableArray array] forKey:playKey];
        }
        for(NSString * playKey in playKeyArray){
            for(CPTBuyBallModel * ball in betList){
                if([playKey isEqualToString:ball.superKey]){
                    NSMutableArray *tmpA = dataDic[playKey];
                    [tmpA addObject:ball];
                }
            }
        }
        for(NSString * playKey in playKeyArray){
            NSString * betNumber =[NSString stringWithFormat:@"%@@",playKey];
            NSMutableArray<CPTBuyBallModel *> *tmpA = dataDic[playKey];
            for(NSInteger i=0;i<tmpA.count;i++){
                CPTBuyBallModel * ball = tmpA[i];
                if(tmpA.count>0){
                
                    if(i==tmpA.count-1){
                        betNumber = [betNumber stringByAppendingFormat:@"%@",ball.title];
                    }else{
                        betNumber = [betNumber stringByAppendingFormat:@"%@,",ball.title];
                    }
    
                }
            }
            if(tmpA.count>0){
                type = [[CartTypeModel alloc] init];
                type.name = _currentPlayModel.playType;
                type.categoryId = [_currentPlayModel.categoryId integerValue];
                type.ID = [_currentPlayModel.ID integerValue];
                NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                [pdic setObject:@(type.ID) forKey:@"playId"];
                [pdic setObject:@(tmpA[0].settingId) forKey:@"settingId"];
                [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"betAmount"];
                [pdic setObject:@(tmpA.count) forKey:@"betCount"];
                [pdic setObject:betNumber forKey:@"betNumber"];
                [d addObject:pdic];
            }
        }
    }
    else if(self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_PaiLie35 || self.type == CPTBuyTicketType_HaiNanQiXingCai || (self.categoryId ==  CPTBuyCategoryId_LHC  && [_currentPlayModel.playType isEqualToString:@"特码"])){
        NSMutableSet *playKeyArray = [NSMutableSet set];
        for(CPTBuyBallModel * ball in betList){
            [playKeyArray addObject:ball.superKey];
        }
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        
        for(NSString * playKey in playKeyArray){
            [dataDic setObject:[NSMutableArray array] forKey:playKey];
        }
        for(NSString * playKey in playKeyArray){
            for(CPTBuyBallModel * ball in betList){
                if([playKey isEqualToString:ball.superKey]){
                    NSMutableArray *tmpA = dataDic[playKey];
                    [tmpA addObject:ball];
                }
            }
        }
        NSMutableArray *betNumbers = [NSMutableArray array];
        for(NSString * playKey in playKeyArray){
            NSString * betNumber =[NSString stringWithFormat:@"%@@",playKey];
            NSMutableArray *tmpA = dataDic[playKey];
            for(NSInteger i=0;i<tmpA.count;i++){
                CPTBuyBallModel * ball = tmpA[i];
                if(tmpA.count>0){
                    if(i==tmpA.count-1){
                        betNumber = [betNumber stringByAppendingFormat:@"%@",ball.title];
                    }else{
                        betNumber = [betNumber stringByAppendingFormat:@"%@,",ball.title];
                    }
                }
            }
            if(tmpA.count>0){
                [betNumbers addObject:betNumber];
            }
        }
        NSString * betNumberS = [NSString string];
        for(NSInteger i=0;i<betNumbers.count;i++){
            NSString * betNumber = betNumbers[i];
            if(i==0){
                betNumberS = [betNumberS stringByAppendingFormat:@"%@",betNumber];
            }else{
                betNumberS = [betNumberS stringByAppendingFormat:@"_%@",betNumber];
            }
        }
        type = [[CartTypeModel alloc] init];
        type.name = _currentPlayModel.playType;
        type.categoryId = [_currentPlayModel.categoryId integerValue];
        type.ID = [_currentPlayModel.ID integerValue];
        NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
        [pdic setObject:@(type.ID) forKey:@"playId"];
        [pdic setObject:@(betList[0].settingId) forKey:@"settingId"];

        [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"betAmount"];
        [pdic setObject:betDic[CPTCART_TOTLEAvailable] forKey:@"betCount"];
        [pdic setObject:betNumberS forKey:@"betNumber"];
        [d addObject:pdic];

    }
    else if(self.type == CPTBuyTicketType_AoZhouACT){
        for(CPTBuyBallModel *model in betList){
                type = [[CartTypeModel alloc] init];
                type.name = @"澳洲ACT";
                type.categoryId = 22;
                type.ID = 220101;
                NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                [pdic setObject:@(type.ID) forKey:@"playId"];
                [pdic setObject:@(model.settingId) forKey:@"settingId"];
                [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"betAmount"];
                [pdic setObject:@(1) forKey:@"betCount"];
                NSString * betNumber = [NSString stringWithFormat:@"%@@%@",@"澳洲ACT",model.title];
                [pdic setObject:betNumber forKey:@"betNumber"];
                [d addObject:pdic];
                continue;
        }
    }else{
        if(limitCount==1 && self.type != CPTBuyTicketType_AoZhouACT){
            if((self.type == CPTBuyTicketType_PK10 || self.type == CPTBuyTicketType_TenPK10 || self.type == CPTBuyTicketType_FivePK10 || self.type == CPTBuyTicketType_JiShuPK10 || self.type == CPTBuyTicketType_AoZhouF1 || self.type == CPTBuyTicketType_XYFT || self.type == CPTBuyTicketType_FFC)&& ![_currentPlayModel.playType isEqualToString:@"两面"]&& ![_currentPlayModel.playType isEqualToString:@"6-10名"]&& ![_currentPlayModel.playType isEqualToString:@"1-5名"]&& ![_currentPlayModel.playType isEqualToString:@"前中后"] &&![_currentPlayModel.playType isEqualToString:@"第一球"] &&![_currentPlayModel.playType isEqualToString:@"第二球"] &&![_currentPlayModel.playType isEqualToString:@"第三球"] &&![_currentPlayModel.playType isEqualToString:@"第四球"] &&![_currentPlayModel.playType isEqualToString:@"第五球"]){
                for(CPTBuyLeftButton *btn in _leftView.btnArray){
                    for(CPTBuyBallModel *model in betList){
                        if([model.superKey isEqualToString:btn.model.playType]){
                            type = [[CartTypeModel alloc] init];
                            type.name = btn.model.playType;
                            type.categoryId = [btn.model.categoryId integerValue];
                            type.ID = [btn.model.ID integerValue];
                            NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                            //    |—— playId    Integer    （必须）玩法id
                            //    |—— settingId    Integer    （必须）玩法配置id
                            //    |—— betNumber    String    （必须）投注号码
                            //    |—— betAmount    double    （必须）投注金额
                            //    |—— betCount    Integer    （必须）总注数  1
                            [pdic setObject:@(type.ID) forKey:@"playId"];
                            [pdic setObject:@(model.settingId) forKey:@"settingId"];
                            [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"betAmount"];
                            [pdic setObject:@(1) forKey:@"betCount"];
                            if(model.longS){
                                NSString * betNumber = [NSString stringWithFormat:@"%@@%@%@",model.superKey,model.longS,model.title];
                                [pdic setObject:betNumber forKey:@"betNumber"];
                                [d addObject:pdic];
                            }else{
                                NSString * betNumber = [NSString stringWithFormat:@"%@@%@",model.superKey,model.title];
                                [pdic setObject:betNumber forKey:@"betNumber"];
                                [d addObject:pdic];
                            }
                            continue;
                        }
                    }
                }
            }else{
                for(CPTBuyLeftButton *btn in _leftView.btnArray){
                    for(CPTBuyBallModel *model in betList){
                        if([model.superPlayKey isEqualToString:btn.model.playType]){
                            type = [[CartTypeModel alloc] init];
                            type.name = btn.model.playType;
                            type.categoryId = [btn.model.categoryId integerValue];
                            type.ID = [btn.model.ID integerValue];
                            NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                            //    |—— playId    Integer    （必须）玩法id
                            //    |—— settingId    Integer    （必须）玩法配置id
                            //    |—— betNumber    String    （必须）投注号码
                            //    |—— betAmount    double    （必须）投注金额
                            //    |—— betCount    Integer    （必须）总注数  1
                            [pdic setObject:@(type.ID) forKey:@"playId"];
                            [pdic setObject:@(model.settingId) forKey:@"settingId"];
                            [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"betAmount"];
                            [pdic setObject:@(1) forKey:@"betCount"];
                            if(model.longS){
                                NSString * betNumber = [NSString stringWithFormat:@"%@@%@%@",model.superKey,model.longS,model.title];
                                [pdic setObject:betNumber forKey:@"betNumber"];
                                [d addObject:pdic];
                            }else{
                                NSString * betNumber = [NSString stringWithFormat:@"%@@%@",model.superKey,model.title];
                                [pdic setObject:betNumber forKey:@"betNumber"];
                                [d addObject:pdic];
                            }
                            continue;
                        }
                    }
                }
            }

            for(CPTBuyLeftButton *btn in _subTypeView.btnArray){
                for(CPTBuyBallModel *model in betList){
                    if([model.superPlayKey isEqualToString:btn.model.playType]){
                        type = [[CartTypeModel alloc] init];
                        type.name = btn.model.playType;
                        type.categoryId = [btn.model.categoryId integerValue];
                        type.ID = [btn.model.ID integerValue];
                        NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                        //    |—— playId    Integer    （必须）玩法id
                        //    |—— settingId    Integer    （必须）玩法配置id
                        //    |—— betNumber    String    （必须）投注号码
                        //    |—— betAmount    double    （必须）投注金额
                        //    |—— betCount    Integer    （必须）总注数  1
                        [pdic setObject:@(type.ID) forKey:@"playId"];
                        [pdic setObject:@(model.settingId) forKey:@"settingId"];
                        [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"betAmount"];
                        [pdic setObject:@(1) forKey:@"betCount"];
                        NSString * betNumber = [NSString stringWithFormat:@"%@@%@",model.superKey,model.title];
                        [pdic setObject:betNumber forKey:@"betNumber"];
                        [d addObject:pdic];
                        continue;
                    }
                }
            }
        }else{
            BOOL isOK = NO;
            if(_currentPlayModel.superType.length>0){
                isOK = NO;
            }else{
                for(CPTBuyLeftButton *btn in _leftView.btnArray){
                    for(CPTBuyBallModel *model in betList){
                        if([model.superPlayKey isEqualToString:btn.model.playType]){
                            type = [[CartTypeModel alloc] init];
                            type.name = btn.model.playType;
                            type.categoryId = [btn.model.categoryId integerValue];
                            type.ID = [btn.model.ID integerValue];
                            NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                            [pdic setObject:@(type.ID) forKey:@"playId"];
                            [pdic setObject:@(model.settingId) forKey:@"settingId"];
                            [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"betAmount"];
                            [pdic setObject:@(totleA) forKey:@"betCount"];
                            NSString * betNumber = [NSString stringWithFormat:@"%@",betList[0].superKey];
                            NSString * betdd = @"";
                            NSString * betNumber2;
                        
                                for(NSInteger i=0;i<betList.count;i++){
                                    CPTBuyBallModel *model = betList[i];
                                    if(i == betList.count-1){
                                        betdd = [betdd stringByAppendingFormat:@"%@",model.title];
                                    }else{
                                        betdd = [betdd stringByAppendingFormat:@"%@,",model.title];
                                    }
                                }
                                betNumber2 = [NSString stringWithFormat:@"%@@%@",betNumber,betdd];
                            [pdic setObject:betNumber2 forKey:@"betNumber"];
                            [d addObject:pdic];
                            isOK = YES;
                            break;
                        }
                    }
                    if(isOK){
                        break;
                    }
                }

            }
            if(!isOK){
                for(CPTBuyLeftButton *btn in _subTypeView.btnArray){
                    for(CPTBuyBallModel *model in betList){
                        if([model.superKey isEqualToString:btn.model.playType] || [model.superPlayKey isEqualToString:btn.model.playType]){
                            type = [[CartTypeModel alloc] init];
                            type.name = btn.model.playType;
                            type.categoryId = [btn.model.categoryId integerValue];
                            type.ID = [btn.model.ID integerValue];
                            NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
                            //    |—— playId    Integer    （必须）玩法id
                            //    |—— settingId    Integer    （必须）玩法配置id
                            //    |—— betNumber    String    （必须）投注号码
                            //    |—— betAmount    double    （必须）投注金额
                            //    |—— betCount    Integer    （必须）总注数  1
                            [pdic setObject:@(type.ID) forKey:@"playId"];
                            [pdic setObject:@(betList[0].settingId) forKey:@"settingId"];
                            [pdic setObject:@([_bottomView.textField.text integerValue]) forKey:@"betAmount"];
                            [pdic setObject:@(totleA) forKey:@"betCount"];
                            NSString * betNumber = [NSString stringWithFormat:@"%@",betList[0].superKey];
                            NSString * betdd = @"";
                            for(NSInteger i=0;i<betList.count;i++){
                                CPTBuyBallModel *model = betList[i];
                                if(i == betList.count-1){
                                    betdd = [betdd stringByAppendingFormat:@"%@",model.title];
                                }else{
                                    betdd = [betdd stringByAppendingFormat:@"%@,",model.title];
                                }
                            }
                            NSString *betNumber2 = [NSString stringWithFormat:@"%@@%@",betNumber,betdd];
                            [pdic setObject:betNumber2 forKey:@"betNumber"];
                            [d addObject:pdic];
                            isOK = YES;
                            break;
                        }
                    }
                    if(isOK){
                        break;
                    }
                }
            }
        }
    }
    [dic setValue:d forKey:@"orderBetList"];
    MBLog(@"%@",dic);
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];
        @weakify(self)
        login.loginBlock = ^(BOOL result) {
            @strongify(self)
            [self postDataWithnumber:sender];
        };
        return;
    }
    [WebTools postWithURL:@"/order/orderBet.json" params:dic success:^(BaseData *data) {
        @strongify(self)
        sender.enabled = YES;
        [MBProgressHUD showSuccess:data.info];
        [[Person person]myAccount];
//        self.pricelab.text = [NSString stringWithFormat:@"￥%.2f",[Person person].balance];
        if(self.type == CPTBuyTicketType_AoZhouACT){
            [self->_actLotteryView.lotteryView deleteSelectBtns];
        }else{
            [self clearModelState];
            [self collectViewReloadData];
            [self->_currentBtn showUnSelPoint];
        }

    } failure:^(NSError *error) {
        sender.enabled = YES;
//        [MBProgressHUD showError:@"投注失败"];
    } showHUD:YES];
}

- (void)updateBalance{
    self.pricelab.text = [NSString stringWithFormat:@"￥%.2f",[Person person].balance];
    [self->_headView checkMoney];
}

- (BOOL)isLiuHeCai:(CPTBuyTicketType)type{
    switch (type) {
        case CPTBuyTicketType_LiuHeCai: case CPTBuyTicketType_OneLiuHeCai: case CPTBuyTicketType_FiveLiuHeCai: case CPTBuyTicketType_ShiShiLiuHeCai:
            {
                return YES;
            }
            break;
            
        default:
            break;
    }
    return NO;
}

#pragma mark - 获取购彩一级分类
-(void)getTypeRootData {
    __weak typeof(self) weakSelf = self;
    [WebTools postWithURL:@"/lottery/queryFirstPlayByCateId.json" params:@{@"categoryId":@(self.categoryId)} success:^(BaseData *data) {
        _cartTypeModelArray = [CartTypeModel mj_objectArrayWithKeyValuesArray:data.data];
        if ([weakSelf isLiuHeCai:weakSelf.type]) {
            CartTypeModel *model = _cartTypeModelArray.firstObject;
            [weakSelf getsubTypeData:model];
        }else{
            weakSelf.selectModel = _cartTypeModelArray.firstObject;
            [weakSelf getsixUIData];
        }
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 获取二级分类
-(void)getsubTypeData:(CartTypeModel *)model {
    
    
    model.selected = YES;
    __weak typeof(self) weakSelf = self;

    [WebTools postWithURL:@"/lottery/queryTwoLevelPlay.json" params:@{@"categoryId":@(self.categoryId),@"parentId":@(model.ID)} success:^(BaseData *data) {
        
        NSArray *array = [CartTypeModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [model.type1Array addObjectsFromArray:array];
        
        weakSelf.selectModel = model.type1Array.firstObject;

        
        [weakSelf getsixUIData];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}


-(void)shakeM{
    [self clearModelState];
    [self->_currentBtn showUnSelPoint];
    [self->_collectView reloadData];
    [self performSelector:@selector(random) withObject:nil afterDelay:0.1];
}

#pragma mark - 获取赔率
-(void)getsixUIData {
    __weak typeof(self) weakSelf = self;
    if(!_hadgetedOddsArray){
        _hadgetedOddsArray = [NSMutableSet set];
    }
    [WebTools postWithURL:@"/lottery/queryLhcBuy.json" params:@{@"lotteryId":@(self.lotteryId),@"playId":@(self.selectModel.ID)} success:^(BaseData *data) {
        weakSelf.oddsArray = [CartOddsModel mj_objectArrayWithKeyValuesArray:data.data];
        [_hadgetedOddsArray addObject:_currentPlayModel.playType];
        for(CartOddsModel * model in weakSelf.oddsArray){
            switch ([model.setting.matchtype integerValue]) {
                case 1:
                    {
                        for(OddsList * oddsList in model.oddsList){
                            for(CPTSixsubPlayTypeModel * subPlayTypeModel in _currentPlayModel.subTypes){
//                                if([subPlayTypeModel.subPlayType isEqualToString:oddsList.name]){
                                    for(CPTBuyBallModel * ballModel in subPlayTypeModel.balls){
                                            ballModel.subTitle = oddsList.odds;
                                            ballModel.settingId = oddsList.settingId;
                                        }
//                                }
                            }
                        }
                    }
                    break;
                case 2:
                {
                    for(OddsList * oddsList in model.oddsList){
                        for(CPTSixsubPlayTypeModel * subPlayTypeModel in _currentPlayModel.subTypes){
                            for(CPTBuyBallModel * ballModel in subPlayTypeModel.balls){
                                if([ballModel.title isEqualToString:oddsList.name]){
                                    ballModel.subTitle = oddsList.odds;
                                    ballModel.settingId = oddsList.settingId;
                                }
                            }
                        }
                    }
                }
                    break;
                    
                default:
                    break;
            }

        }
        [weakSelf collectViewReloadData];

//CartOddsModel
        
    } failure:^(NSError *error) {

    } showHUD:NO];
}


- (void)loadFootView{
    // AFan<<<
    self.bottomView = [[BuyLotBottomView alloc] init];
    
    self.hub = [[RKNotificationHub alloc]initWithView:self.bottomView.cartBtn.titleLabel];
    self.bottomView.cartBtn.titleLabel.clipsToBounds = NO;
    [self.hub moveCircleByX:58 Y:-10];
    [self.view addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-SAFE_HEIGHT);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
    @weakify(self)
    self.bottomView.bottomClickBlock = ^(NSInteger type,UIButton *sender) {
        @strongify(self)
        if (type == 1) { //清空
            if(self.type == CPTBuyTicketType_AoZhouACT){
                [self->_actLotteryView.lotteryView deleteSelectBtns];
            }else{
                [self clearModelState];
                [self->_collectView reloadData];
                [self->_currentBtn showUnSelPoint];
            }
        } else if (type == 2) {//机选
            if(self.type == CPTBuyTicketType_AoZhouACT){
                [self->_actLotteryView.lotteryView getRandomBtn];
            }else{
                [self clearModelState];
                [self->_currentBtn showUnSelPoint];
                [self->_collectView reloadData];
                [self performSelector:@selector(random) withObject:nil afterDelay:0.1];
            }
        } else if (type == 3) {//玩法设置

        } else if (type == 4) { //加入购彩
            NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
            if(now - self->_headView.finishLongLongTime>0){
                return;
            }
            if([[[CPTBuyDataManager shareManager] dataTmpCartArray] count]<=0){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择投注号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            
            if([self.bottomView checkIsOkToBuy]==0){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"不够一注，请选择投注号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
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
            if(self.type == CPTBuyTicketType_AoZhouACT){
                [self addDataToCartShop];
                [self->_actLotteryView.lotteryView deleteSelectBtns];
            }else{
                [self addDataToCartShop];
                [self clearModelState];
                [self->_collectView reloadData];
            }
        } else if (type == 5) {//立即投注
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self presentViewController:login animated:YES completion:nil];
                login.loginBlock = ^(BOOL result) {
                    
                };
                return;
            }
            NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
            if(now - self->_headView.finishLongLongTime>0){
                [MBProgressHUD showError:@"封盘中"];
                return;
            }
            if(self.type == CPTBuyTicketType_AoZhouACT){
                [self postDataWithnumber:sender];
            }else{
                [self postDataWithnumber:sender];
            }
        } else { //购物篮
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self presentViewController:login animated:YES completion:nil];
                login.loginBlock = ^(BOOL result) {
                    
                };
                return;
            }
            [self.bottomView.textField resignFirstResponder];
            CartListCtrl *list = [[CartListCtrl alloc]init];
            list.dataSource = [[CPTBuyDataManager shareManager] dataCartArray] ;
            list.lotteryId = self.lotteryId;
            list.type = self.type;
            list.lottery_type = self.type;
            @weakify(self)
            list.updataArray = ^(NSArray *array) {
                @strongify(self)
                [self.hub setCount:array.count];
                [self.hub bump];
            };
            PUSH(list);
        }
    };
    
    
}

- (void)showFootView:(NSNotification*)noti{
    @weakify(self)
    if(!_pickMoneyView){
        _pickMoneyView = [[CPTBuyPickMoneyView alloc] init];
        [self.view addSubview:_pickMoneyView];
        [_pickMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.right.equalTo(self->_bottomView);
            make.height.offset(0);
            make.bottom.equalTo(self->_bottomView.mas_top);
        }];
        [self.view bringSubviewToFront:_pickMoneyView];
        [_pickMoneyView configUIWith:^(NSInteger money) {
            @strongify(self)
            self->_bottomView.textField.text = [NSString stringWithFormat:@"%ld",(long)money];
            [self refreshBottomViewUI];
        }];
    }

}

- (void)random{

    NSInteger limitCount = [self.bottomView checkLimitCount];
    NSInteger indexP = 0;
    if(self.type == CPTBuyTicketType_3D && [_currentPlayModel.playType isEqualToString:@"2D"]){
        limitCount = 3;
        indexP = arc4random()%_currentPlayModel.subTypes.count;

    }
    NSMutableSet * set = [NSMutableSet set];
        for(NSInteger i=0;i<100;i++){
            NSInteger n = i;
            if(i>_currentPlayModel.subTypes.count-1){
                n = _currentPlayModel.subTypes.count-1;
            }
            if(limitCount ==1 && _currentPlayModel.subTypes.count>1){
                n = arc4random()%_currentPlayModel.subTypes.count;
            }

            CPTSixsubPlayTypeModel * model = _currentPlayModel.subTypes[n];
                NSInteger count = model.balls.count;
                CPTBuyBallModel *ball = [model.balls objectAtIndex:arc4random()%count];
                ball.selected = YES;
                [_currentBtn.selectModels addObject:ball];
                [[CPTBuyDataManager shareManager] addBallModelToTmpCartArray:ball];
                _bottomView.superType = ball.superKey;
                _bottomView.superPlayKey = ball.superPlayKey;
            [set addObject:ball];

            if(set.count == limitCount){
                if(self.type == CPTBuyTicketType_3D && [_currentPlayModel.playType isEqualToString:@"2D"]){
                    CPTBuyBallModel *ball = _currentBtn.selectModels[indexP];
                    ball.selected = NO;
                    [[CPTBuyDataManager shareManager] removeBallModelFromTmpCartArray:ball];
                    [_currentBtn.selectModels removeObjectAtIndex:indexP];
                }
                break;
            }
        }
    
        [_collectView reloadData];
        [_currentBtn checkPointState];
        [self refreshBottomViewUI];
        [set removeAllObjects];
        set = nil;

}

- (void)showMoneyUI{
    @weakify(self)
    if(!_pickMoneyView){
        _pickMoneyView = [[CPTBuyPickMoneyView alloc] init];
        [self.view addSubview:_pickMoneyView];
        [_pickMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.right.equalTo(self->_bottomView);
            make.height.offset(0);
            make.bottom.equalTo(self->_bottomView.mas_top);
        }];
        [self.view bringSubviewToFront:_pickMoneyView];
        [_pickMoneyView configUIWith:^(NSInteger money) {
            @strongify(self)
            self->_bottomView.textField.text = [NSString stringWithFormat:@"%ld",(long)money];
            [self refreshBottomViewUI];
        }];
    }
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
            make.height.offset(0.);
        }];
        [self.view layoutIfNeeded];
    }];
}

- (void)showInfoView:(NSNotification*)noti{
    if(self.type != CPTBuyTicketType_AoZhouACT){
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        NSString * playremark1 = [_currentPlayModel.playRemark stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        NSString * exampleNum1 = [_currentPlayModel.exampleNum stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        NSString * example1 = [_currentPlayModel.example stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        NSString * playremarkSx1 = [_currentPlayModel.playRemarkSx stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        
        NSString * playremarkSx = [playremarkSx1 stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
        NSString * playremark = [playremark1 stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
        NSString * exampleNum = [exampleNum1 stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
        NSString * example = [example1 stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
        [alert buildCPTBuyInfoViewWithStr1:playremarkSx andStr2:playremark andStr3:[NSString stringWithFormat:@"%@\n%@",example,exampleNum]];
        [alert show];
    }else{
        NSString *shuoming;
        NSString *example;
        //    if(_categoryId == CPTBuyCategoryId_FT){
        NSDictionary * plistDic = [[CPTBuyDataManager shareManager] configOtherDataByTicketType:self.type];
        NSDictionary *dic = [plistDic objectForKey:@"setting"];
        NSString *sx = [dic objectForKey:@"playRemarkSx"];
        sx = [BallTool resetTheExplainTxWithString:sx];
        shuoming = [dic objectForKey:@"playRemark"];
        shuoming = [BallTool resetTheExplainTxWithString:shuoming];
        //    shuoming = [NSString stringWithFormat:@"%@/n%@",shuoming,sx];
        NSString *ddd = [dic objectForKey:@"example"];
        if([ddd hasPrefix:@"投注方案"]){
            MBLog(@"====");
        }
        example = [NSString stringWithFormat:@"%@/n%@",[dic objectForKey:@"example"],[dic objectForKey:@"exampleNum"]];
        example = [BallTool resetTheExplainTxWithString:example];
        //    }
        //    NSArray *arr = [[CPTBuyDataManager shareManager] configDataByTicketType:self.type];
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        //    [alert buildCPTBuyInfoViewWithInfo:shuoming eg:example];
        [alert buildCPTBuyInfoViewWithStr1:sx andStr2:shuoming andStr3:example];
        [alert show];
    }

}

@end
