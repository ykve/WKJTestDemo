//
//  CPTBuyFantanCtrl.m
//  LotteryProduct
//
//  Created by pt c on 2019/3/6.
//  Copyright © 2019年 vsskyblue. All rights reserved.
//

#import "CPTBuyFantanCtrl.h"
#import "CPTBuyHeadView.h"
#import "CPTBuy_FantanCell.h"
#import "CPTBuyHeadViewTableViewCell.h"
#import "SQMenuShowView.h"
#import "BettingRecordViewController.h"
#import "SixRecommendCtrl.h"
#import "TemaHistoryCtrl.h"
#import "SixRecommendCtrl.h"
#import "PK10VersionTrendCtrl.h"
#import "FormulaCtrl.h"
#import "PK10FreeRecommendCtrl.h"
#import "CPTBuy_DoubleColorCell.h"
#import "CartListCtrl.h"
#import "CPTBuyPickMoneyView.h"
#import "RedOrBlueBallCell.h"
#import "CPTBuyHeadViewTableViewHeadView.h"
#import "CountDown.h"
#import "CPTBuy_NNCell.h"
#import "CPTBuy_AZNNCell.h"
#import "IGKbetModel.h"
#import "PCInfoModel.h"
#import "CPTBuy_HistoryCell.h"
#import "Fantan_OddModel.h"
#import "BallTool.h"
#import "NiuWinLabel.h"
#import "IGKbetListCtrl.h"
#import "MSWeakTimer.h"
#import "LoginAlertViewController.h"
#import "CPTBuyHeadViewStyleMore.h"
#import "ChatRoomCtrl.h"
#import "KeFuViewController.h"
#import "UIViewController+HDHUD.h"
#import "PublicInterfaceTool.h"


@interface CPTBuyFantanCtrl (CPTBuyHeadViewDelegate)<CPTBuyHeadViewDelegate,CPTBuyHeadViewStyleMoreDelegate>

@property (nonatomic,weak) NSArray *selectedArr;//选中的玩法
@property (strong, nonatomic)  CountDown *countDownForLabel;
@property (nonatomic,assign)NSInteger page;
@end

@implementation CPTBuyFantanCtrl
{
    BOOL _isClear;
    BOOL _isRandom;
    BOOL _isOpening;
    SQMenuShowView *_showView;
    
    CPTBuyHeadViewStyleMore *_headView;//番摊才有的head
    NSArray *_selectedArr;//番摊选中的玩法
    NSArray *_redBallSelectedArr;//选中的红球
    NSArray *_blueBallSelectedArr;//选中的蓝球
    CPTBuyPickMoneyView *_pickMoneyView;
    RKNotificationHub *_hub;
    
    NSInteger totalNum;//总注数
    NSInteger totalCost;//总消耗
    
    NSMutableArray *_playTypes;
    NSMutableArray *_historyDataArray;//开奖历史
    NSArray *_latestResultArray;//最近开奖号码
    LotteryInfoModel *_lastestModel;//最新开奖信息 双色球,大乐透,七乐彩
    PK10InfoModel *_lastestModelNN;//最新开奖信息 澳洲牛牛、
    NSArray *_typesArr;//需要请求历史开奖的彩种

    NSMutableArray *_oddsArr;
    CountDown *_countDownForLabel;
    NSString *_nextIssue;//下一期期号
    
    MSWeakTimer *_timer;//倒计时结束后 定时查询开奖信息
    UIView *_jbView;
    BOOL _addLayer;
    BOOL _opening;
}

- (void)popback{
    if(_headView){
        [_headView destroyTimer];
    }
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)jumpToHistoryList:(UIButton *)sender {
    IGKbetListCtrl *list = [[IGKbetListCtrl alloc]init];
    list.type = self.type;
    list.titlestring = [[CPTBuyDataManager shareManager] changeTypeToString:self.type];
    PUSH(list);
}

#pragma mark -显示挖法说明
- (IBAction)showPlayExplain:(UIButton *)sender {
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
#pragma mark 请求历史开奖
- (void)getHistoryData{
    NSString *historyurl = @"/sg/lishiSg.json";
//    __weak typeof(self) weakSelf = self;
    @weakify(self)
    NSDictionary *dic = @{@"id":@(self.type),@"pageNum":@(self.page),@"pageSize":@10};
    [WebTools postWithURL:historyurl params:dic success:^(BaseData *data) {
        @strongify(self)
        if (self.page == 1) {
            [self->_historyDataArray removeAllObjects];
        }
        switch (self.type) {
            case CPTBuyTicketType_Shuangseqiu:
            case CPTBuyTicketType_DaLetou:
            case CPTBuyTicketType_QiLecai:
            case CPTBuyTicketType_NiuNiu_JiShu:
            case CPTBuyTicketType_NiuNiu_AoZhou:
            {
                if(!data.data)return;
                NSArray * a = [PCInfoNewModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                if(a.count == 0){
                    [self.historyTableView.mj_footer endRefreshingWithNoMoreData];
                    return ;
                }
                [self->_historyDataArray addObjectsFromArray:a];
//                [self->_historyDataArray removeObjectAtIndex:0];
            }break;
                
            default:
                break;
        }
        [self.historyTableView reloadData];
        [self.historyTableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
    } showHUD:NO];
}
#pragma mark - 加入购彩
- (IBAction)addToBasket:(UIButton *)sender {
    @weakify(self)
    if((self.categoryId == CPTBuyCategoryId_FT&&self->_selectedArr.count==0)||(self.lotteryId == CPTBuyTicketType_Shuangseqiu&&![self checkShuangseqiuIsLegal])||(self.lotteryId == CPTBuyTicketType_DaLetou&&![self checkDaletouIsLegal])||(self.lotteryId == CPTBuyTicketType_QiLecai&&![self checkQilecaiIsLegal])||(self.categoryId == CPTBuyCategoryId_NN&&_selectedArr.count==0)){//番摊
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择至少一注投注号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if([self->_textField.text length]<=0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入每注金额" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self)
            [self->_textField becomeFirstResponder];
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [self addDataToCartShop];
    [self->_centerTableView reloadData];
}
- (void)tapRightView{
    IGKbetListCtrl *list = [[IGKbetListCtrl alloc]init];
    list.type = self.type;
    list.titlestring = [[CPTBuyDataManager shareManager] changeTypeToString:self.type];
    PUSH(list);
}
#pragma mark 跳转 购彩篮
- (IBAction)pushToBasket:(UIButton *)sender {
    [_textField resignFirstResponder];
    @weakify(self)
    CartListCtrl *list = [[CartListCtrl alloc]init];
    list.dataSource = [[CPTBuyDataManager shareManager] dataCartArray] ;
    list.lotteryId = self.lotteryId;
    list.type = self.type;
    list.lottery_type = self.type;
    list.updataArray = ^(NSArray *array) {
        @strongify(self)
        [self->_hub setCount:array.count];
        [self->_hub bump];
    };
    PUSH(list);
}
#pragma mark 根据当前皮肤设置
- (void)updateUIModel{
    self.nextImgView.image = IMAGE([[CPTThemeConfig shareManager] NextStepArrowImage]);
    self.lineView.backgroundColor = [[CPTThemeConfig shareManager] Fantan_headerLineColor];
    self.historyTableView.backgroundColor = [[CPTThemeConfig shareManager] FantanColor4];
    self.balanceLabel.textColor = [[CPTThemeConfig shareManager] Fantan_MoneyColor];
    self.centerTableView.backgroundColor = [[CPTThemeConfig shareManager] Buy_fantanCellBgColor];
    
    self.headerInsideView.backgroundColor = [[CPTThemeConfig shareManager] Buy_HeadView_BackgroundC];
    self.bootomCenterView.backgroundColor = [[CPTThemeConfig shareManager] FantanColor2];
    self.bottomLeftView.backgroundColor = [UIColor colorWithHex:@"AC1E2D"];
    [self.addBalanceBtn setImage:[UIImage imageNamed:@"cartaddmoney"] forState:UIControlStateNormal];
    self.basketBtn.backgroundColor = [[CPTThemeConfig shareManager] FantanColor1];
    self.floatImgView.image = [[CPTThemeConfig shareManager] Fantan_FloatImgDown];
    self.floatView.backgroundColor = [[CPTThemeConfig shareManager] FantanColor3];
    self.bottomTopView.backgroundColor = [[CPTThemeConfig shareManager] FantanColor4];
    self.textField.backgroundColor = [[CPTThemeConfig shareManager] Fantan_textFieldColor];
    [self.textField setValue:[[CPTThemeConfig shareManager] Fantan_tfPlaceholdColor] forKeyPath:@"_placeholderLabel.textColor"];
    UIImage *jianImg = [[CPTThemeConfig shareManager] Fantan_JianImg];
    UIImage *addImg = [[CPTThemeConfig shareManager] Fantan_AddImg];
    UIImage *speakerImg = [[CPTThemeConfig shareManager] Fantan_SpeakerImg];
    [self.speakImgView setImage:speakerImg forState:UIControlStateNormal];
    [self.jianBtn setImage:jianImg forState:UIControlStateNormal];
    [self.addBtn setImage:addImg forState:UIControlStateNormal];
    UIImage *delImg =[[CPTThemeConfig shareManager] Fantan_DelImg];
    UIImage *shakeImg =[[CPTThemeConfig shareManager] Fantan_ShakeImg];
    UIImage *addToImg =[[CPTThemeConfig shareManager] Fantan_AddToBasketImg];
    UIImage *basketImg =[[CPTThemeConfig shareManager] Fantan_basketImg];
    [self.basketBtn setImage:basketImg forState:UIControlStateNormal];
    [self.clearBtn setImage:delImg forState:UIControlStateNormal];
    [self.shakeBtn setImage:shakeImg forState:UIControlStateNormal];
    [self.addToBasketBtn setImage:addToImg forState:UIControlStateNormal];
    self.openIssueLabel.textColor = [[CPTThemeConfig shareManager] Fantan_labelColor];
    self.label1.textColor = [[CPTThemeConfig shareManager] Fantan_labelColor];
    self.label2.textColor = [[CPTThemeConfig shareManager] Fantan_labelColor];
    self.label3.textColor = [[CPTThemeConfig shareManager] Fantan_labelColor];
    self.label4.textColor = [[CPTThemeConfig shareManager] Fantan_labelColor];
    self.label5.textColor = [[CPTThemeConfig shareManager] Fantan_labelColor];
    
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        self.playNameLabel.textColor = [UIColor colorWithHex:@"333333"];
        [self.addBalanceBtn setImage:IMAGE(@"tw_bug_head_add") forState:UIControlStateNormal];
        self.bottomLeftView.backgroundColor = [UIColor colorWithHex:@"FF8610"];
        self.textField.textColor = [UIColor hexStringToColor:@"ff8610"];
        [self.addToBasketBtn setTitleColor:[UIColor hexStringToColor:@"333333"] forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CPTBuyDataManager shareManager] clearTmpCartArray];
    [[CPTBuyDataManager shareManager] clearCartArray];
    [self updateUIModel];
[_textField addTarget:self action:@selector(textFieldDidChangeValue:) forControlEvents:UIControlEventEditingChanged];    self.navView.hidden = YES;
    _oddsArr = [NSMutableArray array];
    self.page = 1;
    _playNameLabel.text = self.lotteryName;
    _historyDataArray = [NSMutableArray array];
    [_textField addTarget:self action:@selector(refreshBottomViewUI) forControlEvents:UIControlEventEditingChanged];
    [_latestOpenResultCollectionView registerNib:[UINib nibWithNibName:@"RedOrBlueBallCell" bundle:nil] forCellWithReuseIdentifier:@"RedOrBlueBallCell"];
    [_historyTableView registerNib:[UINib nibWithNibName:@"CPTBuy_HistoryCell" bundle:nil] forCellReuseIdentifier:@"CPTBuy_HistoryCell"];
    NSDictionary * plistDic = [[CPTBuyDataManager shareManager] configOtherDataByTicketType:self.type];
    NSMutableArray *tempArr = [NSMutableArray array];
    NSString  *playTagId = [NSString stringWithFormat:@"%@",[plistDic objectForKey:@"playTagId"]];
    if([plistDic.allKeys containsObject:@"oddsList"]){
        NSArray *oddsList = [plistDic objectForKey:@"oddsList"];
        //        MBLog(@"%@",oddsList[0]);
        for (NSDictionary *dic in oddsList) {
            Fantan_OddModel *model = [Fantan_OddModel mj_objectWithKeyValues:dic];
            MBLog(@"%@",model.name);
            model.playTagId = playTagId;
            [tempArr addObject:model];
        }
        if(_categoryId == CPTBuyCategoryId_FT){
            _oddsArr = [BallTool sortingFantanWithArray:tempArr];
        }else{
            _oddsArr = tempArr;
        }
    }
    [self.textField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downBtnClick:)];
    [self.floatView addGestureRecognizer:tap];
    
    @weakify(self)
    
    [self rigBtn:@"助手" Withimage:nil With:^(UIButton *sender) {
        @strongify(self)
        [self showView];
    }];
    //聊天
    [self rigBtn2:nil Withimage:@"chat_right" With:^(UIButton *sender) {
        @strongify(self)
        if ([Person person].uid == nil) {
            LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
            login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:login animated:YES completion:nil];
            
        }else{
            [self chatroomAction];
            
        }
    }];
    
    if(_categoryId == CPTBuyCategoryId_FT && _lotteryId != CPTBuyTicketType_FantanSSC){
        _headNewView.hidden = YES;
        _headView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CPTBuyHeadViewStyleMore class]) owner:self options:nil]firstObject];
        _headView.lotteryId = self.lotteryId;
        _headView.type = self.type;

        _headView.delegate = self;
        
        _headView.footerView.hidden = YES;
        _headView.categoryId = self.categoryId;
        _headView.endTime = self.endTime;
        [self.view addSubview:_headView];
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.view);
            make.top.offset(0);
            make.height.offset(450);
            make.width.offset(SCREEN_WIDTH);
        }];
        [self.view sendSubviewToBack:_headView];
        [_headView configUIByData];
//        [_headView historyData];
        self.playNameLabel.text = @"番摊";
    }else if(_lotteryId == CPTBuyTicketType_NiuNiu_KuaiLe||_lotteryId == CPTBuyTicketType_FantanSSC){
        _headNewView.hidden = YES;
        _headView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CPTBuyHeadView class]) owner:self options:nil]firstObject];
        _headView.lotteryId = self.lotteryId;
        _headView.type = self.type;
        _headView.delegate = self;
        _headView.footerView.hidden = YES;
        _headView.categoryId = self.categoryId;
        _headView.endTime = self.endTime;
        [self.view addSubview:_headView];
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.view);
            make.top.offset(0);
            make.height.offset(450);
            make.width.offset(SCREEN_WIDTH);
        }];
        [self.view sendSubviewToBack:_headView];
        [_headView configUIByData];
    } else{
        _historyTableView.tag = 1;//历史开奖
        _historyTableView.dataSource = self;
        _historyTableView.delegate = self;
        _latestOpenResultCollectionView.dataSource = self;
        _latestOpenResultCollectionView.delegate = self;
        [_historyTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CPTBuyHeadViewTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CPTBuyHeadViewTableViewCell"];
        self.historyTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            self.page ++ ;
            [self getHistoryData];
        }];
        [self getHistoryData];
        _countDownForLabel = [[CountDown alloc] init];
    }
    if(_categoryId == CPTBuyCategoryId_NN){
        self.playNameLabel.text = @"牛牛";
    }
    self.centerTableView.estimatedRowHeight = 0;
//    [[CPTOpenLotteryManager shareManager] checkModelByIds:@[@(self.type)] callBack:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
//        MBLog(@"%@",data);
//    }];
    _typesArr = @[@(CPTBuyTicketType_Shuangseqiu),@(CPTBuyTicketType_DaLetou),@(CPTBuyTicketType_QiLecai),@(CPTBuyTicketType_NiuNiu_AoZhou),@(CPTBuyTicketType_NiuNiu_JiShu)];
    if([_typesArr containsObject:@(self.type)]){
        _latestOpenResultCollectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        [self checkLastestData];
    }
    
    _balanceLabel.text = [NSString stringWithFormat:@"￥%.2f",[Person person].balance];
    _textField.delegate = self;
    _hub = [[RKNotificationHub alloc]initWithView:_basketBtn.titleLabel];
    self->_hub.hubcolor = [UIColor redColor];
    _basketBtn.titleLabel.clipsToBounds = NO;
    [self->_hub moveCircleByX:50 Y:-10];
    [self.view addSubview:self.bottomView];
    
    [self showFootView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBalance) name:@"updateBalance" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:kLoginSuccessNotification object:nil];
    MBLog(@"%ld",(long)self.type);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recievedNew:) name:[NSString stringWithFormat:@"%ld",(long)self.type] object:nil];
    
    if(_lotteryId == CPTBuyTicketType_NiuNiu_AoZhou||_lotteryId == CPTBuyTicketType_NiuNiu_JiShu){
        _openIssueLabel.textAlignment = NSTextAlignmentLeft;
        _niuniuRetViewWidth.constant = SCREEN_WIDTH-180;
    }else{
        _openIssueLabel.textAlignment = NSTextAlignmentCenter;
        _niuniuRetViewWidth.constant = 0;
    }
    CGFloat top;
    if(self.type == CPTBuyTicketType_FantanSSC||self.type == CPTBuyTicketType_NiuNiu_KuaiLe){
        top = 88;
    }else{
        top = 118;
    }
    self.floatViewTopSpace.constant = top;
}

- (void)chatroomAction {
    __weak __typeof(self)weakSelf = self;
    [PublicInterfaceTool getWechatInfoSuccess:^(BaseData * _Nonnull data) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if ([data.data[@"chatRoom"] integerValue] == 1) {
            [MBProgressHUD showError:kGoInChatRoomMessage];
        } else {
            [strongSelf gotoChatRoom];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:kGoInChatRoomMessage];
    }];
}

- (void)gotoChatRoom {
   
    ChatRoomCtrl *chatVC = [[ChatRoomCtrl alloc] init];
    chatVC.lotteryId = self.type;
    chatVC.roomName = self.lotteryName;
    PUSH(chatVC);
}

- (void)viewDidLayoutSubviews{
  
}
- (void)checkLastestData{
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{

        [[CPTOpenLotteryManager shareManager] checkModelByIds:@[@(self.type)] callBack:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
            @strongify(self)
            if(self){
                [self setNewData:data];
            }
        }];
    });
}
- (void)setNewData:(IGKbetModel *)data{
    switch (self.type) {
        case CPTBuyTicketType_Shuangseqiu:
        {
            self->_lastestModel = data.shuangseqiu;
        }break;
        case CPTBuyTicketType_DaLetou:
        {
            self->_lastestModel = data.daLetou;
        }break;
        case CPTBuyTicketType_QiLecai:
        {
            self->_lastestModel = data.qiLecai;
        }break;
        case CPTBuyTicketType_NiuNiu_AoZhou:
        {
            self->_lastestModel = data.nnAozhou;
        }break;
        case CPTBuyTicketType_NiuNiu_JiShu:
        {
            self->_lastestModel = data.nnJisu;
        }break;
        default:
            break;
    }
    MBLog(@"nextTime: %ld",(long)self->_lastestModel.nextTime);
    MBLog(@"nextIssue: %@",self->_lastestModel.nextIssue);
    MBLog(@"issue: %@",self->_lastestModel.issue);
    if(self->_nextIssue.length == 0){
        self->_nextIssue = [NSString stringWithFormat:@"%@",self->_lastestModel.nextIssue];
    }else{
        if(self->_lastestModel.nextIssue.integerValue > self->_nextIssue.integerValue){
            if(self->_timer!=nil){
                [self->_timer invalidate];
                self->_timer = nil;
            }
        }
    }
    [self updateHeader];
}
#pragma mark 刷新开奖信息
- (void)updateHeader{
    if(_lastestModel != nil){
        if(_lastestModel.niuWinner){
            if([_lastestModel.niuWinner containsString:@","]){
                NSArray *names = [_lastestModel.niuWinner componentsSeparatedByString:@","];
                for (UIView *v in _niuWinBgView.subviews) {
                    [v removeFromSuperview];
                }
                for(int i=0;i< names.count;i++){
                    NiuWinLabel *lab = [[NiuWinLabel alloc] initWithFrame:CGRectMake(34*i, 0, 32, 20)];
                    lab.text = names[i];
                    [_niuWinBgView addSubview:lab];
                }
            }else{
                NiuWinLabel *lab = [[NiuWinLabel alloc] initWithFrame:CGRectMake(34, 0, 32, 20)];
                lab.text = _lastestModel.niuWinner;
                [_niuWinBgView addSubview:lab];
            }
            
        }
        NSMutableArray *tempArr = [NSMutableArray array];
        if([_lastestModel.number containsString:@"+"]){
            NSArray *arr1 = [_lastestModel.number componentsSeparatedByString:@"+"];
            if(arr1.count){
                for(int i = 0; i<arr1.count;i++){
                    NSString *str = arr1[i];
                    NSArray *arr2 = [str componentsSeparatedByString:@","];
                    [tempArr addObjectsFromArray:arr2];
                }
                _latestResultArray = [NSArray arrayWithArray:tempArr];
            }
        }else{
            NSArray *nums = [_lastestModel.number componentsSeparatedByString:@","];
            _latestResultArray = [NSArray arrayWithArray:nums];
        }
//        NSArray *nums = [_lastestModel.number componentsSeparatedByString:@","];
//        NSArray *array;
//        NSString *last = [nums lastObject];
//        if([last containsString:@"+"]){
//            NSArray *arr1 = [nums subarrayWithRange:NSMakeRange(0, nums.count-1)];
//            NSMutableArray *retArr = [NSMutableArray arrayWithArray:arr1];
//            NSArray *last2 = [last componentsSeparatedByString:@"+"];
//            array = [retArr arrayByAddingObjectsFromArray:last2];
//            _latestResultArray = [NSArray arrayWithArray:array];
//        }else{
//            _latestResultArray = [NSArray arrayWithArray:nums];
//        }
        _isOpening = NO;
        [_latestOpenResultCollectionView reloadData];
        _nextOpenLabel.text =[NSString stringWithFormat:@"%@期",_lastestModel.nextIssue];
        _openIssueLabel.text = [NSString stringWithFormat:@"%@期   开奖结果",_lastestModel.issue];
        [self startCountDownWithTime:_lastestModel.nextTime];
        if(_lastestModel.nextIssue.integerValue>_nextIssue.integerValue){
            self.page = 1;
            [self getHistoryData];
            _nextIssue = _lastestModel.nextIssue;
        }
    }
    
}
- (void)showStopView{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.stopView.hidden = NO;
        [self.view bringSubviewToFront:self.stopView];
    });
}
- (void)dismissStopView{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.stopView.hidden = YES;
    });
}
#pragma mark 倒计时
- (void)startCountDownWithTime:(NSInteger )time{
//    NSTimeInterval now = [[NSDate date] timeIntervalSince1970] + self.endTime;
    long long finishLongLong = time;
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval chaTime = finishLongLong - now;
    BOOL isOpenLottery = NO;

    if(_lastestModel.nextIssue.integerValue - _lastestModel.issue.integerValue >1){
        isOpenLottery = YES;
    }
    if(isOpenLottery){
        [self dismissStopView];
        sleep(0.5);
        if(_timer){
            [_timer invalidate];
            _timer = nil;
        }
        NSInteger sec = 2;
        if( ![[CPTBuyDataManager shareManager] isOurL:self.type]){
            sec = 2;
        }else{
            sec = 2;
        }
        self->_timer = [MSWeakTimer scheduledTimerWithTimeInterval:sec target:self selector:@selector(checkLastestData) userInfo:nil repeats:YES dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
        NSTimeInterval now1 = [[NSDate date] timeIntervalSince1970];
        @weakify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            self->_isOpening = YES;
            [self.latestOpenResultCollectionView reloadData];
            self.openIssueLabel.text = [NSString stringWithFormat:@"%@期   正在开奖",self->_nextIssue];
            [self dismissStopView];
            self.label2.text = @"";
        });


        [self->_countDownForLabel countDownWithStratTimeStamp:now1+self.endTime finishTimeStamp:finishLongLong completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
            NSInteger totoalSecond1 =day*24*60*60+hour*60*60 + minute*60+second;
            NSString *hourStr;
            NSString *minuteStr;
            NSString *secondStr;
            if (hour<10) {
                hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
            }else{
                hourStr = [NSString stringWithFormat:@"%ld",(long)hour];
            }
            if (minute<10) {
                minuteStr = [NSString stringWithFormat:@"0%ld",(long)minute];
            }else{
                minuteStr = [NSString stringWithFormat:@"%ld",(long)minute];
            }
            if (second<10) {
                secondStr = [NSString stringWithFormat:@"0%ld",(long)second];
            }else{
                secondStr = [NSString stringWithFormat:@"%ld",(long)second];
            }
            self.hourLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr];
            if(totoalSecond1 == 0){
       
            }
        }];
    }else if(chaTime > self.endTime) {//封盘前
        [self dismissStopView];
        if(_timer){
            [_timer invalidate];
            _timer = nil;
        }
        @weakify(self)
        [_countDownForLabel countDownWithStratTimeStamp:now+self.endTime finishTimeStamp:finishLongLong completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
            @strongify(self)
            NSString *hourStr;
            NSString *minuteStr;
            NSString *secondStr;
            if (hour<10) {
                hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
            }else{
                hourStr = [NSString stringWithFormat:@"%ld",(long)hour];
            }
            if (minute<10) {
                minuteStr = [NSString stringWithFormat:@"0%ld",(long)minute];
            }else{
                minuteStr = [NSString stringWithFormat:@"%ld",(long)minute];
            }
            if (second<10) {
                secondStr = [NSString stringWithFormat:@"0%ld",(long)second];
            }else{
                secondStr = [NSString stringWithFormat:@"%ld",(long)second];
            }
            self.hourLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr];
            NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
            if(totoalSecond ==0){
                MBLog(@"totoalSecond %ld====",(long)totoalSecond);
                [self showStopView];
                self.label2.text = @"封盘时间:";
                NSTimeInterval now1 = [[NSDate date] timeIntervalSince1970];
                NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970] +self.endTime;
                //            NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970] +5;
                [self->_countDownForLabel countDownWithStratTimeStamp:now1 finishTimeStamp:endTime completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
                    //                self.hourLabel.text = @"封";
                    //                self.minuteLabel.text = @"盘";
                    //                self.secondLabel.text = @"中";
                    NSInteger totoalSecond1 =day*24*60*60+hour*60*60 + minute*60+second;
                    NSString *hourStr;
                    NSString *minuteStr;
                    NSString *secondStr;
                    if (hour<10) {
                        hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
                    }else{
                        hourStr = [NSString stringWithFormat:@"%ld",(long)hour];
                    }
                    if (minute<10) {
                        minuteStr = [NSString stringWithFormat:@"0%ld",(long)minute];
                    }else{
                        minuteStr = [NSString stringWithFormat:@"%ld",(long)minute];
                    }
                    if (second<10) {
                        secondStr = [NSString stringWithFormat:@"0%ld",(long)second];
                    }else{
                        secondStr = [NSString stringWithFormat:@"%ld",(long)second];
                    }
                    self.hourLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr];
                    if(totoalSecond1 == 0){
                        
                        self->_isOpening = YES;
                        @weakify(self)
                        dispatch_async(dispatch_get_main_queue(), ^{
                            @strongify(self)
                            [self.latestOpenResultCollectionView reloadData];
                            self.openIssueLabel.text = [NSString stringWithFormat:@"%@期   正在开奖",self->_nextIssue];
                            [self dismissStopView];
                            self.label2.text = @"";
                        });
                        NSInteger sec = 2;
                        if( ![[CPTBuyDataManager shareManager] isOurL:self.type]){
                            sec = 2;
                        }else{
                            sec = 2;
                        }
                        self->_timer = [MSWeakTimer scheduledTimerWithTimeInterval:sec target:self selector:@selector(checkLastestData) userInfo:nil repeats:YES dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
                    }
                }];
            }else{
                self.label2.text = @"截止时间:";
            }
        }];
    }else if(chaTime <= self.endTime && chaTime >0){//封盘中
        [self showStopView];
        NSTimeInterval now2 = [[NSDate date] timeIntervalSince1970];
        if(_timer){
            [_timer invalidate];
            _timer = nil;
        }
        @weakify(self)
        [_countDownForLabel countDownWithStratTimeStamp:now2 finishTimeStamp:finishLongLong completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
            @strongify(self)
            NSString *hourStr;
            NSString *minuteStr;
            NSString *secondStr;
            if (hour<10) {
                hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
            }else{
                hourStr = [NSString stringWithFormat:@"%ld",(long)hour];
            }
            if (minute<10) {
                minuteStr = [NSString stringWithFormat:@"0%ld",(long)minute];
            }else{
                minuteStr = [NSString stringWithFormat:@"%ld",(long)minute];
            }
            if (second<10) {
                secondStr = [NSString stringWithFormat:@"0%ld",(long)second];
            }else{
                secondStr = [NSString stringWithFormat:@"%ld",(long)second];
            }
            self.hourLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr];
            NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
            if(totoalSecond ==0){
                MBLog(@"totoalSecond %ld====",(long)totoalSecond);
                dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissStopView];
                self.label2.text = @"截止时间:";
                    self.openIssueLabel.text = [NSString stringWithFormat:@"%@期   正在开奖",self->_nextIssue];
                });
                
                NSInteger sec = 2;
                if( ![[CPTBuyDataManager shareManager] isOurL:self.type]){
                    sec = 2;
                }else{
                    sec = 2;
                }
                self->_timer = [MSWeakTimer scheduledTimerWithTimeInterval:sec target:self selector:@selector(checkLastestData) userInfo:nil repeats:YES dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.label2.text = @"截止时间:";
                });
            }
        }];
    }
    if(finishLongLong == 0||now>finishLongLong){
        [self showStopView];
        return;
    }

}
- (void)recievedNew:(NSNotification *)notification{
    IGKbetModel *model = notification.object;
    MBLog(@"SSSSSSS++++->%@",model.nnJisu.number);
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong __typeof(self) strongSelf = weakSelf;
        IGKbetModel * data = (IGKbetModel *)notification.object;
        if(strongSelf){
            [strongSelf setNewData:data];
        }
    });
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _latestResultArray.count;
}
- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RedOrBlueBallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RedOrBlueBallCell" forIndexPath:indexPath];
    NSString *num = _latestResultArray[indexPath.row];
    BOOL isRed = NO;
    if(_categoryId == CPTBuyCategoryId_NN){
        isRed = YES;
        cell.isNN = YES;
    }else{
        if(self.type == CPTBuyTicketType_Shuangseqiu){
            isRed = indexPath.row<6?YES:NO;
        }else if(self.type == CPTBuyTicketType_DaLetou){
            isRed = indexPath.row<5?YES:NO;
        }else if(self.type == CPTBuyTicketType_QiLecai){
            isRed = indexPath.row<7?YES:NO;
        }
    }
    if(_categoryId  ==  CPTBuyCategoryId_NN && _isOpening){
        num = @"-";
    }
    [cell setNum:num isRed:isRed opening:_isOpening];
    return cell;
}
//- (CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 5;
//}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat wid = SCREEN_WIDTH-35;
    if(_lotteryId == CPTBuyTicketType_NiuNiu_JiShu||_lotteryId == CPTBuyTicketType_NiuNiu_AoZhou){
        return CGSizeMake(wid/10, wid/10);
    }
    if(_lotteryId == CPTBuyTicketType_Shuangseqiu||_lotteryId == CPTBuyTicketType_DaLetou){
        return CGSizeMake(wid/7, wid/7);
    }else if (_lotteryId == CPTBuyTicketType_QiLecai){
        return CGSizeMake(wid/8, wid/8);
    }
    return CGSizeMake(40/SCAL, 40/SCAL);
}

#pragma mark 减号 点击事件
- (IBAction)jjClick:(UIButton *)sender {
    NSInteger money = [self.textField.text integerValue];
    money = money -1;
    if(money<=0){
        money = 0;
    }
    if(money<=0){
        self.textField.text = @"";
    }else{
        self.textField.text = [NSString stringWithFormat:@"%ld",(long)money];
    }
    [self refreshBottomViewUI];
}
#pragma mark + 点击事件
- (IBAction)addClick:(UIButton *)sender {
    NSInteger money = [self.textField.text integerValue];
    money = money +1;
    self.textField.text = [NSString stringWithFormat:@"%ld",(long)money];
    [self refreshBottomViewUI];
}

#pragma mark 加入购彩2
-(void)addDataToCartShop{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    if(_lastestModel.nextTime){
        if(now - _lastestModel.nextTime>0 && _lastestModel.nextTime>=0){
            return;
        }
    }
    else if(now - self->_headView.finishLongLongTime>0){
        return;
    }
    [self configCartData];
    _isClear = YES;
    [_hub setCount:[[CPTBuyDataManager shareManager] dataCartArray].count];
    [_hub bump];
}
#pragma mark - 加入购彩3
- (void)configCartData{
    [self configC];
//    CartTypeModel * type = [[CartTypeModel alloc] init];
//    type.name = _playNameLabel.text;
//    type.categoryId = _categoryId;
//    type.ID = self.type;
//
//    NSMutableDictionary *pdic = [[NSMutableDictionary alloc]init];
//    [pdic setObject:@([_textField.text integerValue]) forKey:@"pricetype"];
//    [pdic setObject:@(1) forKey:@"times"];
//    [pdic setObject:@(totalNum) forKey:@"count"];
//    [pdic setObject:type forKey:@"type"];
//    NSDictionary *params = [self getparams];
//    [pdic setObject:params forKey:@"params"];
//    if(_redBallSelectedArr){
//        [pdic setObject:_redBallSelectedArr forKey:@"red"];
//    }
//    if(_blueBallSelectedArr){
//        [pdic setObject:_blueBallSelectedArr forKey:@"blue"];
//    }
//    NSMutableString *number = [NSMutableString string];
//    if(_type == CPTBuyTicketType_Shuangseqiu||_type == CPTBuyTicketType_DaLetou||_type == CPTBuyTicketType_QiLecai){
//        number = [NSMutableString stringWithFormat:@"红球:"];
//        for(int i = 0; i< _redBallSelectedArr.count;i++){
//            if(i == _redBallSelectedArr.count-1){
//                [number appendString:[NSString stringWithFormat:@"%@",_redBallSelectedArr[i]]];
//            }else{
//                [number appendString:[NSString stringWithFormat:@"%@, ",_redBallSelectedArr[i]]];
//            }
//        }
//        [number appendFormat:@"\n蓝球:"];
//        for(int i = 0; i< _blueBallSelectedArr.count;i++){
//            if(i == _blueBallSelectedArr.count - 1){
//                [number appendString:[NSString stringWithFormat:@"%@ ",_blueBallSelectedArr[i]]];
//            }else{
//                [number appendString:[NSString stringWithFormat:@"%@, ",_blueBallSelectedArr[i]]];
//            }
//        }
//    }else if(_categoryId == CPTBuyCategoryId_NN){
//        if(_selectedArr){
//            [pdic setObject:_selectedArr forKey:@"betNumber"];
//            for(int i = 0; i< _selectedArr.count;i++){
//                NSString *n = _selectedArr[i];
//                if(n.integerValue == 0){
//                    [number appendString:[NSString stringWithFormat:@"闲一%@",i==_selectedArr.count-1?@"":@","]];
//                }else if(n.integerValue == 1){
//                    [number appendString:[NSString stringWithFormat:@"闲二%@",i==_selectedArr.count-1?@"":@","]];
//                }else if(n.integerValue == 2){
//                    [number appendString:[NSString stringWithFormat:@"闲三%@",i==_selectedArr.count-1?@"":@","]];
//                }else if(n.integerValue == 3){
//                    [number appendString:[NSString stringWithFormat:@"闲四%@",i==_selectedArr.count-1?@"":@","]];
//                }else if(n.integerValue == 4){
//                    [number appendString:[NSString stringWithFormat:@"闲五%@",i==_selectedArr.count-1?@"":@","]];
//                }
//            }
//        }
//    }else if (_categoryId == CPTBuyCategoryId_FT){
//        if(_selectedArr){
//            [pdic setObject:_selectedArr forKey:@"betNumber"];
//            for(int i = 0; i< _selectedArr.count;i++){
//                NSString *n = _selectedArr[i];
//                Fantan_OddModel *model = _oddsArr[n.integerValue];
//                if(i == _selectedArr.count-1){
//                    [number appendFormat:@"%@",model.name];
//                }else{
//                    [number appendFormat:@"%@,",model.name];
//                }
//            }
//        }
//    }
//    [pdic setObject:number forKey:@"number"];
//    [pdic setObject:@(_lotteryId) forKey:@"lotteryId"];
//    [[CPTBuyDataManager shareManager] addBallModelToCartArray:pdic];
//
////    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
////    NSString*bStr = _headView.issue;
////    [dic setValue:bStr forKey:@"issue"];
////    [dic setValue:@(self.type) forKey:@"lotteryId"];
////    [dic setValue:[Person person].uid forKey:@"userId"];
    
    _redBallSelectedArr = @[];
    _blueBallSelectedArr = @[];
    _selectedArr = @[];
//    _textField.text = @"2";
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    if(_categoryId == CPTBuyCategoryId_FT||self.type == CPTBuyTicketType_NiuNiu_JiShu){
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPostData:) name:@"RefreshOpenLotteryUI" object:nil];
//    }
    //摇一摇
//    BOOL isOn = [[[NSUserDefaults standardUserDefaults] valueForKey:@"lottery_shake"]boolValue];
//    if(isOn){
//        [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
//        [self becomeFirstResponder];
//    }else{
//        [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:NO];
//        [self resignFirstResponder];
//    }
//    MBLog(@"%d",isOn);
    if([Person person].uid){
        [[Person person]myAccount];
    }else{
        _balanceLabel.text = @"￥0.00";
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"lottery_shake"]boolValue]){
        [self resignFirstResponder];
    }
//    if(_categoryId == CPTBuyCategoryId_FT||self.type == CPTBuyTicketType_NiuNiu_JiShu){
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RefreshOpenLotteryUI" object:nil];
//    }
    [self resignFirstResponder];
}
#pragma mark - ShakeToEdit 摇动手机之后的回调方法
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //检测到摇动开始
    if (motion == UIEventSubtypeMotionShake)
    {
        MBLog(@"检测到摇动开始");
    }
}
- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //摇动取消
    MBLog(@"摇动取消");
}
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //摇动结束
    if (event.subtype == UIEventSubtypeMotionShake)
    {
        // your code
        MBLog(@"摇动结束");
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"lottery_shake"]boolValue]){
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//振动效果 需要#import <AudioToolbox/AudioToolbox.h>
            _isRandom = YES;
            [self.centerTableView reloadData];
        }
    }
}
#pragma mark 显示/隐藏开奖历史 点击
- (void)downBtnClick:(UITapGestureRecognizer *)recognizer{
    CGFloat top;
    if(self.type == CPTBuyTicketType_FantanSSC||self.type == CPTBuyTicketType_NiuNiu_KuaiLe){
        top = 88;
    }else{
        top = 118;
    }
    if(self.floatViewTopSpace.constant == top){
        [_headView historyData];
        [UIView animateWithDuration:0.3 animations:^{
            self.floatImgView.image = [[CPTThemeConfig shareManager] Fantan_FloatImgUp];
            self.floatViewTopSpace.constant = 330+top-44;
            [self.view layoutIfNeeded];
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.floatImgView.image = [[CPTThemeConfig shareManager] Fantan_FloatImgDown];
            self.floatViewTopSpace.constant = top;
            [self.view layoutIfNeeded];
        }];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.categoryId == CPTBuyCategoryId_FT){
        if(tableView.tag == 0){
            return SCREEN_WIDTH+50;
        }
    }else{
        if(tableView.tag == 0){//
            if(self.lotteryId == CPTBuyTicketType_Shuangseqiu){//双色球
                return SCREEN_WIDTH*1.6;
            }else if (self.lotteryId == CPTBuyTicketType_DaLetou){//大乐透
                return SCREEN_WIDTH*1.5;
            }else if (self.lotteryId == CPTBuyTicketType_QiLecai){
                return SCREEN_WIDTH*1;//七乐彩
            }else if (self.lotteryId == CPTBuyTicketType_NiuNiu_AoZhou||self.lotteryId == CPTBuyTicketType_NiuNiu_JiShu||self.lotteryId == CPTBuyTicketType_NiuNiu_KuaiLe){//牛牛
                return SCREEN_WIDTH*1.2;
            }
        }else if (tableView.tag == 1){//开奖历史
            CGFloat t = 0;
            switch (self.type) {
                case CPTBuyTicketType_Shuangseqiu: case CPTBuyTicketType_DaLetou: case CPTBuyTicketType_QiLecai:case CPTBuyTicketType_NiuNiu_AoZhou:case CPTBuyTicketType_NiuNiu_JiShu:{
                    t = 72;
                }
                default:
                    break;
            }
            return t;
        }
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if(self.categoryId == 14){
//        if(tableView.tag == 0){
//            return 1;
//        }
//    }else{
//        if(self.lotteryId == 29){
//            if(tableView.tag == 0){
//                return 1;
//            }
//        }
//    }
    if(_categoryId == CPTBuyCategoryId_FT){
        return 1;
    }else{
        if(tableView.tag == 0){
            return 1;
        }else if (tableView.tag == 1){
            return _historyDataArray.count;
        }
    }
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CPTBuyHeadViewTableViewHeadView *header =[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CPTBuyHeadViewTableViewHeadView class]) owner:self options:nil]firstObject];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView.tag == 1){
        return 30.0;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag == 1){//历史开奖记录
        CPTBuy_HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CPTBuy_HistoryCell"];
        cell.type = self.type;
        cell.categoryId = self.categoryId;
        PCInfoNewModel *model =  _historyDataArray[indexPath.row];
        [cell setDataWithModel:model andIndex:indexPath.row];
        return cell;
    }
    if(self.categoryId == CPTBuyCategoryId_FT){//番摊
        if(tableView.tag == 0){
            CPTBuy_FantanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CPTBuy_FantanCell"];
            if(cell == nil){
                cell = [[[NSBundle mainBundle] loadNibNamed:@"CPTBuy_FantanCell" owner:nil options:nil]lastObject];
            }
            [cell setODDsWithArray:_oddsArr];
            @weakify(self);
            cell.updateSelectedArray = ^(NSArray * _Nonnull selectArr) {
                @strongify(self)
                self->_selectedArr = selectArr;
//                MBLog(@"===%@",self->_selectedArr);
                [self refreshBottomViewUI];
            };
            if(_isClear){
                [cell clearAllWithRandom:NO];
                _isClear = NO;
            }
            if(_isRandom){
                [cell clearAllWithRandom:YES];
                _isRandom = NO;
            }
            return cell;
        }
    }else if (self.lotteryId == CPTBuyTicketType_Shuangseqiu||self.lotteryId == CPTBuyTicketType_DaLetou||self.lotteryId == CPTBuyTicketType_QiLecai){//双色球/大乐透/七乐彩
        CPTBuy_DoubleColorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CPTBuy_DoubleColorCell"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CPTBuy_DoubleColorCell" owner:nil options:nil]lastObject];
        }
        cell.lotteryId = self.type;
        if(_isClear){
            [cell clearAllWithRandom:NO];
            _isClear = NO;
        }
        if(_isRandom){
            [cell clearAllWithRandom:YES];
            _isRandom = NO;
        }
        @weakify(self);
        //选号
        cell.didChangeSelection = ^(NSArray * redArr, NSArray * blueArr) {
            @strongify(self)
            self->_redBallSelectedArr = redArr;
            self->_blueBallSelectedArr = blueArr;
            MBLog(@"%@",redArr);
            MBLog(@"%@",blueArr);
            [self refreshBottomViewUI];
        };
        return cell;
    }else if(_lotteryId == CPTBuyTicketType_NiuNiu_AoZhou||_lotteryId == CPTBuyTicketType_NiuNiu_JiShu){
        CPTBuy_AZNNCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CPTBuy_AZNNCell"];
        if(cell == nil){
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CPTBuy_AZNNCell" owner:nil options:nil]lastObject];
        }
        @weakify(self);
        cell.updateSelection = ^(NSArray * selectArr) {
            @strongify(self)
            MBLog(@"%@",selectArr);
            self->_selectedArr = selectArr;
            [self refreshBottomViewUI];
        };
        if(_isClear){
            [cell clearAllWithRandom:NO];
            _isClear = NO;
        }
        if(_isRandom){
            [cell clearAllWithRandom:YES];
            _isRandom = NO;
        }
        return cell;
    }else if (_lotteryId == CPTBuyTicketType_NiuNiu_KuaiLe){
        CPTBuy_NNCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CPTBuy_NNCell"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CPTBuy_NNCell" owner:nil options:nil]lastObject];
        }
        @weakify(self);
        cell.updateSelection = ^(NSArray * selectArr) {
            @strongify(self)
            MBLog(@"%@",selectArr);
            self->_selectedArr = selectArr;
            [self refreshBottomViewUI];
        };
        if(_isClear){
            [cell clearAllWithRandom:NO];
            _isClear = NO;
        }
        if(_isRandom){
            [cell clearAllWithRandom:YES];
            _isRandom = NO;
        }
        return cell;
    }
    return [UITableViewCell new];
}

- (IBAction)chongzhiClick:(UIButton *)sender {
    [self addmoneyClick];
}
#pragma mark 清除所有选择
- (IBAction)ClearSelect:(UIButton *)sender {
    _isClear = YES;
    [self.centerTableView reloadData];
}
- (IBAction)randomSelectClick:(UIButton *)sender {
    _isRandom = YES;
    [self.centerTableView reloadData];
}
- (void)dealloc{
    MBLog(@"FantanVC ==========dealloc");
    [_countDownForLabel destoryTimer];
    [_headView removeNSNotification];
    [_pickMoneyView brokeBlock];
    [[CPTBuyDataManager shareManager] clearTmpCartArray];
    [[CPTBuyDataManager shareManager] clearCartArray];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateBalance" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginSuccessNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%ld",(long)self.type] object:nil];
    
    [_timer invalidate];
    _timer = nil;
}
- (void)showFootView{
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
            self->_textField.text = [NSString stringWithFormat:@"%ld",(long)money];
            [self refreshBottomViewUI];
        }];
    }
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
//检查所选双色球是否合法
- (BOOL)checkShuangseqiuIsLegal{
    if(self->_redBallSelectedArr.count >=6&&self->_blueBallSelectedArr.count>=1){
        return YES;
    }
    return NO;
}


- (BOOL)checkDaletouIsLegal{
    if(self->_redBallSelectedArr.count>=5&&self->_blueBallSelectedArr.count>=2){
        return YES;
    }
    return NO;
}
- (BOOL)checkQilecaiIsLegal{
    if(self->_redBallSelectedArr.count >=7){
//        if(self->_redBallSelectedArr.count >=7&&self->_blueBallSelectedArr.count>=1){
        return YES;
    }
    return NO;
}
- (void)updateBottomValue{
    if(_textField.text.length>0){
        NSString *num = [NSString stringWithFormat:@"%ld",(long)totalNum];
        NSString *total = [NSString stringWithFormat:@"%ld",_textField.text.integerValue*totalNum];
        MBLog(@"%@",total);
        UIColor *c = [[CPTThemeConfig shareManager] Buy_CollectionHeadV_ViewC];
        NSMutableAttributedString *totlettr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 注 %@ 元",num,total]];
        [totlettr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(0, num.length)];
        [totlettr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(num.length + 3, total.length)];
        _totalCountAndCostLabel.attributedText = totlettr;
//        if(_categoryId == CPTBuyCategoryId_NN){
//            float sum = 0;
//            for (NSString *index in _selectedArr) {
//                Fantan_OddModel *model = _oddsArr[index.integerValue];
//                float oneBet = _textField.text.floatValue*model.odds.floatValue;
//                sum += oneBet;
//            }
//            MBLog(@"oneBet:%f",sum);
//
//            NSMutableAttributedString *totlettr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最高赢%@元",total]];
//            [totlettr2 addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(3, total.length)];
//            _winTotalLabel.attributedText = totlettr2;
//        }else
            if (_categoryId == CPTBuyCategoryId_FT || _categoryId == CPTBuyCategoryId_NN){
            MBLog(@"%@",_selectedArr);
            float sum = 0;
            for (NSString *index in _selectedArr) {
                Fantan_OddModel *model = _oddsArr[index.integerValue];
                float oneBet = _textField.text.floatValue*model.odds.floatValue;
                sum += oneBet;
                MBLog(@"%f",oneBet);
            }
            NSMutableAttributedString *totlettr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最高赢%.2f元",sum]];
            NSString *sumStr = [NSString stringWithFormat:@"%.2f",sum];
            [totlettr2 addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(3, sumStr.length)];
            _winTotalLabel.attributedText = totlettr2;
        }else{
            Fantan_OddModel *model = _oddsArr[0];
            NSArray *allOdds = [model.odds componentsSeparatedByString:@"/"];
            NSString *retStr = allOdds[0];
            retStr = [NSString stringWithFormat:@"%.2f",retStr.floatValue*_textField.text.floatValue];
            NSMutableAttributedString *totlettr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最高赢%@元",retStr]];
            [totlettr2 addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(3, retStr.length)];
            _winTotalLabel.attributedText = totlettr2;
        }
    }else{
        [self setBottomZero];//归零
    }
}
- (void)setBottomZero{
    UIColor *c = [[CPTThemeConfig shareManager] Buy_CollectionHeadV_ViewC];
    NSMutableAttributedString *totlettr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 注 %@ 元",@"0",@"0"]];
    [totlettr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(0, 1)];
    [totlettr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(1 + 3, 1)];
    _totalCountAndCostLabel.attributedText = totlettr;
    NSString *total = @"0.00";
    NSMutableAttributedString *totlettr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最高中%@元",total]];
    [totlettr2 addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(3, total.length)];
    _winTotalLabel.attributedText = totlettr2;
}
#pragma mark - 刷新底部UI
- (void)textFieldDidChangeValue:(UITextField *)textFeild{
    NSInteger num = [textFeild.text integerValue];
    if (num <= 1) {
       textFeild.text = @"1";
    }else    if (num >= 99999999) {
        num = 99999999;
        self.textField.text = @"99999999";
    }
}
- (void)refreshBottomViewUI{
    if(_lotteryId == CPTBuyTicketType_Shuangseqiu){//双色球,七乐彩
        if([self checkShuangseqiuIsLegal]){
            NSInteger redNum = _redBallSelectedArr.count;
            NSInteger blueNum = _blueBallSelectedArr.count;
            NSInteger redRet = [self zuheWithNum:redNum andMinNum:_lotteryId == CPTBuyTicketType_Shuangseqiu?6:7];
            NSInteger blueRet = [self zuheWithNum:blueNum andMinNum:1];
            totalNum = redRet*blueRet;
            totalCost = totalNum*_textField.text.integerValue;
            MBLog(@"红球 %ld",redNum);
            MBLog(@"蓝球 %ld",blueNum);
            MBLog(@"注数 %ld",totalNum);
            [self updateBottomValue];
        }else{
            [self setBottomZero];
        }
    }
    else if( _lotteryId == CPTBuyTicketType_QiLecai){//双色球,七乐彩
        if([self checkQilecaiIsLegal]){
            NSInteger redNum = _redBallSelectedArr.count;
            NSInteger blueNum = _blueBallSelectedArr.count;
            NSInteger redRet = [self zuheWithNum:redNum andMinNum:_lotteryId == CPTBuyTicketType_Shuangseqiu?6:7];
//            NSInteger blueRet = [self zuheWithNum:blueNum andMinNum:1];
            totalNum = redRet;
            totalCost = totalNum*_textField.text.integerValue;
            MBLog(@"红球 %ld",redNum);
            MBLog(@"蓝球 %ld",blueNum);
            MBLog(@"注数 %ld",totalNum);
            [self updateBottomValue];
        }else{
            [self setBottomZero];
        }
    }
    else if (_lotteryId == CPTBuyTicketType_DaLetou){//大乐透
        NSInteger redNum = _redBallSelectedArr.count;
        NSInteger blueNum = _blueBallSelectedArr.count;
        NSInteger redRet = [self zuheWithNum:redNum andMinNum:5];
        NSInteger blueRet = [self zuheWithNum:blueNum andMinNum:2];
        totalNum = redRet*blueRet;
        totalCost = totalNum*_textField.text.integerValue;
        NSString *num = [NSString stringWithFormat:@"%ld",redRet*blueRet];
        MBLog(@"红球 %ld",redNum);
        MBLog(@"蓝球 %ld",blueNum);
        MBLog(@"注数 %@",num);
        [self updateBottomValue];
    }else if (_categoryId == CPTBuyCategoryId_FT){//番摊
        totalNum = _selectedArr.count;
        totalCost = totalNum*_textField.text.integerValue;
        [self updateBottomValue];
    }else if (_categoryId == CPTBuyCategoryId_NN){//牛牛
        totalNum = _selectedArr.count;
        totalCost = totalNum*_textField.text.integerValue;
        [self updateBottomValue];
    }
}

- (NSInteger)pailieWithN:(NSInteger)n andM:(NSInteger)m{
    if (n<m) {
        return 0;
    }
    NSInteger total=1;
    for (NSInteger i = 0; i < m; i++) {
        total=total*n;
        n--;
    }
    return total;
}
- (NSInteger)jiechengWithM:(NSInteger)n{
    if (n<0) {
        return 0;
    }
    if(n==1){
        return 1;
    }else{
        return n*[self jiechengWithM:n-1];
    }
}
- (NSInteger)zuheWithNum:(NSInteger)n andMinNum:(NSInteger)m{
    return [self pailieWithN:n andM:m]/[self jiechengWithM:m];
}
- (void)showView{
    [_showView removeFromSuperview];

    //@[@"遗漏",@"投注记录",@"在线客服",@"水心推荐",@"正码历史",@"特码历史"]
    NSArray * itmes = @[@"投注记录",@"在线客服"];//,@"横版走势",@"公式杀号",@"免费推荐"
    _showView = [[SQMenuShowView alloc]initWithFrame:(CGRect){CGRectGetWidth(self.view.frame)-100-10,NAV_HEIGHT+5,100,0}
                                               items:itmes
                                           showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-25,10}];
    _showView.sq_backGroundColor = MAINCOLOR;
    _showView.itemTextColor = WHITE;
    @weakify(self)
    [_showView selectBlock:^(SQMenuShowView *view, NSInteger index) {
        @strongify(self)
        if (index == 0) {
            
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                
                [self presentViewController:login animated:YES completion:nil];
                @weakify(self)
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
        else if (index == 1) {
            
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                
                [self presentViewController:login animated:YES completion:nil];
                @weakify(self)
                login.loginBlock = ^(BOOL result) {
                    @strongify(self)
                    // 在线客服
//                    if ([[ChatHelp shareHelper]login]){
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
//                HDChatViewController *chatVC = [[HDChatViewController alloc] initWithConversationChatter:HX_IM]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
//                [self.navigationController pushViewController:chatVC animated:YES];
//            }
            KeFuViewController *kefuVc = [[KeFuViewController alloc] init];
            
            PUSH(kefuVc);
        }
        switch (self.type) {
            case CPTBuyTicketType_LiuHeCai:
            {
                if (index == 2) {
                    SixRecommendCtrl *recommend = [[SixRecommendCtrl alloc]init];
                    PUSH(recommend);
                }
                else if (index == 3) {
                    TemaHistoryCtrl *tema = [[TemaHistoryCtrl alloc]initWithNibName:NSStringFromClass([TemaHistoryCtrl class]) bundle:[NSBundle mainBundle]];
                    tema.type = 622;
                    PUSH(tema);
                }
                else {
                    TemaHistoryCtrl *tema = [[TemaHistoryCtrl alloc]initWithNibName:NSStringFromClass([TemaHistoryCtrl class]) bundle:[NSBundle mainBundle]];
                    tema.type = 621;
                    PUSH(tema);
                }
            }
                break;
            case CPTBuyTicketType_PK10:{
                if (index == 2) {
                    PK10VersionTrendCtrl *trend = [[PK10VersionTrendCtrl alloc]init];
                    trend.lottery_type = self.lottery_type;
                    PUSH(trend);
                }
                else if (index == 3) {
                    
                    FormulaCtrl *forumla = [[FormulaCtrl alloc]init];
                    forumla.lottery_type = self.lottery_type;
                    PUSH(forumla);
                }
                else if (index == 4) {
                    PK10FreeRecommendCtrl *recommend = [[PK10FreeRecommendCtrl alloc]init];
                    recommend.lottery_type = self.lottery_type;
                    PUSH(recommend);
                }
            } break;
                
            default:
                break;
        }
    }];
    [_showView setShowmissBlock:^(BOOL showmiss) {
        @strongify(self)
        [self.tableView reloadData];
    }];
    [self.view addSubview:_showView];
    [_showView showView];
//    return _showView;
}
#pragma mark 立即购彩
- (IBAction)buyRightNowClick:(UIButton *)sender {
    switch (self.type) {
        case CPTBuyTicketType_Shuangseqiu://双色球
        {
            if(![self checkShuangseqiuIsLegal]){
                [self showHint:@"请输入正确的号码"];
                return;
            }
        }break;
        case CPTBuyTicketType_DaLetou://大乐透
        {
            if(![self checkDaletouIsLegal]){
                [self showHint:@"请输入正确的号码"];
                return;
            }
        }break;
        case CPTBuyTicketType_QiLecai://七乐彩
        {
            if(![self checkQilecaiIsLegal]){
                [self showHint:@"请输入正确的号码"];
                return;
            }
        }break;
        default:
            if(_selectedArr.count == 0){
                [self showHint:@"请选择投注"];
                return;
            }
            break;
    }
    if(_textField.text.length == 0){
        [self showHint:@"请输入每注金额"];
        return;
    }
    
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];
        @weakify(self)
        login.loginBlock = ^(BOOL result) {
            @strongify(self)
            [self buyRightNowClick:sender];
        };
        return;
    }
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
//    if(self.type == CPTBuyTicketType_Shuangseqiu || self.type == CPTBuyTicketType_DaLetou || self.type == CPTBuyTicketType_QiLecai){

//    }else{
        if(_lastestModel.nextTime){
            if(now - _lastestModel.nextTime>0 && _lastestModel.nextTime>=0){
                return;
            }
        }
        else if(now - self->_headView.finishLongLongTime>0 && self->_headView.finishLongLongTime>=0){
            return;
        }
//    }

    self.bottomLeftView.enabled = NO;
    @weakify(self)
    NSDictionary *dic = [self getparams];
    [WebTools postWithURL:@"/order/orderBet.json" params:dic success:^(BaseData *data) {
        @strongify(self)
        [MBProgressHUD showSuccess:data.info];
        [[Person person]myAccount];
        
        if(![_typesArr containsObject:@(self.type)]){
            [self->_headView checkMoney];
        }
        if(data.status.integerValue == 1){
            self->_isClear = YES;;
            //        self.textField.text = @"2";
            [self.centerTableView reloadData];
        }
        self.bottomLeftView.enabled = YES;
    } failure:^(NSError *error) {
        self.bottomLeftView.enabled = YES;
    } showHUD:YES];
    
    
}
- (void)updateBalance{
    self.balanceLabel.text = [NSString stringWithFormat:@"￥%.2f",[Person person].balance];
}

-(void)shakeM{
    _isRandom = YES;
    [self.centerTableView reloadData];
}

#pragma mark 获取投注 parme
- (void)configC{
    CartTypeModel * type = [[CartTypeModel alloc] init];
    type.name = _playNameLabel.text;
    type.categoryId = _categoryId;
    type.ID = self.type;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(_categoryId == CPTBuyCategoryId_FT || _lotteryId == CPTBuyTicketType_NiuNiu_KuaiLe){
        _nextIssue = _headView.issue;
    }
    if(_type == CPTBuyTicketType_Shuangseqiu||_type == CPTBuyTicketType_DaLetou||_type == CPTBuyTicketType_QiLecai){
        NSMutableDictionary *betDic = [NSMutableDictionary dictionary];
        Fantan_OddModel *model = _oddsArr[0];
        [betDic setObject:model.playTagId forKey:@"playId"];
        [betDic setObject:model.settingId forKey:@"settingId"];
        [betDic setObject:@(_textField.text.doubleValue) forKey:@"pricetype"];
        [betDic setObject:@(totalNum) forKey:@"count"];
        //[betDic setValue:@(self.type) forKey:@"lotteryId"];
        [betDic setValue:@(_textField.text.doubleValue) forKey:@"betPrice"];
        [betDic setObject:type forKey:@"type"];
        [betDic setObject:@(1) forKey:@"times"];

        NSMutableString *betNumStr = [NSMutableString stringWithFormat:@"红球区@"];
        for(int i = 0;i<_redBallSelectedArr.count;i++){
            NSString *redNum = _redBallSelectedArr[i];
            MBLog(@"%@",redNum);
            if(i==_redBallSelectedArr.count-1){
                [betNumStr appendFormat:@"%@",redNum];
            }else{
                [betNumStr appendFormat:@"%@,",redNum];
            }
        }
        if(_type != CPTBuyTicketType_QiLecai){
            [betNumStr appendFormat:@"_蓝球区@"];
            for(int i = 0;i<_blueBallSelectedArr.count;i++){
                NSString *blueNum = _blueBallSelectedArr[i];
                
                if(i==_blueBallSelectedArr.count-1){
                    [betNumStr appendFormat:@"%@",blueNum];
                }else{
                    [betNumStr appendFormat:@"%@,",blueNum];
                }
            }
        }
        
        [betDic setObject:betNumStr forKey:@"number"];
        MBLog(@"%@",betNumStr);
        [[CPTBuyDataManager shareManager] addBallModelToCartArray: betDic];
    }
    else if(_categoryId == CPTBuyCategoryId_NN||_categoryId == CPTBuyCategoryId_FT){
        for (NSString *index in _selectedArr) {
            NSMutableDictionary *betDic = [NSMutableDictionary dictionary];
            Fantan_OddModel *model = _oddsArr[index.integerValue];
            [betDic setObject:model.playTagId forKey:@"playId"];
            [betDic setObject:model.settingId forKey:@"settingId"];
            [betDic setObject:@(_textField.text.doubleValue) forKey:@"pricetype"];
            [betDic setObject:@(1) forKey:@"count"];
            MBLog(@"%@",model.name);
            [betDic setObject:[NSString stringWithFormat:@"%@@%@",self.playNameLabel.text,model.name] forKey:@"number"];
            [betDic setValue:@(self.type) forKey:@"lotteryId"];
            [betDic setValue:@(_textField.text.doubleValue) forKey:@"betPrice"];
            [betDic setObject:type forKey:@"type"];
            [betDic setObject:@(1) forKey:@"times"];
            [[CPTBuyDataManager shareManager] addBallModelToCartArray: betDic];
        }
    }
}

- (NSMutableDictionary *)getparams{
    CartTypeModel * type = [[CartTypeModel alloc] init];
    type.name = _playNameLabel.text;
    type.categoryId = _categoryId;
    type.ID = self.type;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(_categoryId == CPTBuyCategoryId_FT || _lotteryId == CPTBuyTicketType_NiuNiu_KuaiLe){
        _nextIssue = _headView.issue;
    }
    [dic setValue:_nextIssue forKey:@"issue"];
    [dic setValue:@(self.type) forKey:@"lotteryId"];
    [dic setValue:[Person person].uid forKey:@"userId"];
    NSMutableArray *betArr = [NSMutableArray array];
    if(_type == CPTBuyTicketType_Shuangseqiu||_type == CPTBuyTicketType_DaLetou||_type == CPTBuyTicketType_QiLecai){
        NSMutableDictionary *betDic = [NSMutableDictionary dictionary];
        Fantan_OddModel *model = _oddsArr[0];
        [betDic setObject:model.playTagId forKey:@"playId"];
        [betDic setObject:model.settingId forKey:@"settingId"];
        [betDic setObject:@(_textField.text.doubleValue) forKey:@"betAmount"];
        [betDic setObject:@(totalNum) forKey:@"betCount"];
        [betDic setValue:@(self.type) forKey:@"lotteryId"];
        [betDic setValue:@(_textField.text.doubleValue) forKey:@"betPrice"];

        NSMutableString *betNumStr = [NSMutableString stringWithFormat:@"红球区@"];
        for(int i = 0;i<_redBallSelectedArr.count;i++){
            NSString *redNum = _redBallSelectedArr[i];
            MBLog(@"%@",redNum);
            if(i==_redBallSelectedArr.count-1){
                [betNumStr appendFormat:@"%@",redNum];
            }else{
                [betNumStr appendFormat:@"%@,",redNum];
            }
        }
        if(_type != CPTBuyTicketType_QiLecai){
            [betNumStr appendFormat:@"_蓝球区@"];
            for(int i = 0;i<_blueBallSelectedArr.count;i++){
                NSString *blueNum = _blueBallSelectedArr[i];
                
                if(i==_blueBallSelectedArr.count-1){
                    [betNumStr appendFormat:@"%@",blueNum];
                }else{
                    [betNumStr appendFormat:@"%@,",blueNum];
                }
            }
        }
        
        [betDic setObject:betNumStr forKey:@"betNumber"];
        MBLog(@"%@",betNumStr);
        [betArr addObject:betDic];
    }else if(_categoryId == CPTBuyCategoryId_NN||_categoryId == CPTBuyCategoryId_FT){
        for (NSString *index in _selectedArr) {
            NSMutableDictionary *betDic = [NSMutableDictionary dictionary];
            Fantan_OddModel *model = _oddsArr[index.integerValue];
            [betDic setObject:model.playTagId forKey:@"playId"];
            [betDic setObject:model.settingId forKey:@"settingId"];
            [betDic setObject:@(_textField.text.doubleValue) forKey:@"betAmount"];
            [betDic setObject:@(1) forKey:@"betCount"];
            MBLog(@"%@",model.name);
            [betDic setObject:[NSString stringWithFormat:@"%@@%@",self.playNameLabel.text,model.name] forKey:@"betNumber"];
            [betDic setValue:@(self.type) forKey:@"lotteryId"];
            [betDic setValue:@(_textField.text.doubleValue) forKey:@"betPrice"];
            [betArr addObject:betDic];
        }
        MBLog(@"%@",betArr);
    }
    [dic setObject:betArr forKey:@"orderBetList"];
    return dic;
}

- (IBAction)reFmoneyClick1:(id)sender{
    [self reFmoneyClick];

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
@end
