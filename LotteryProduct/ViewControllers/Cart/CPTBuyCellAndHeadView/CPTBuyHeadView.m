//
//  CalculateView.m
//  BuyLotteryBanner
//
//  Created by 研发中心 on 2018/12/28.
//  Copyright © 2018 研发中心. All rights reserved.
//

#import "CPTBuyHeadView.h"
#import "PCInfoModel.h"
#import "IGKbetModel.h"
#import "CPTBuyHeadViewTableViewCell.h"
#import "CPTBuyHeadViewTableViewHeadView.h"
#import "CountDown.h"
#import "BallTool.h"
#import "MSWeakTimer.h"
#import "OpenButton.h"

@interface CPTBuyHeadView()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{
    NSMutableArray<UIButton *> *_titleBtnArray;
    NSMutableArray<UILabel *> *_subTitleArray;
    __block NSMutableArray* _historyArray;
    __block NSInteger _page;
    CGFloat xx;
    CGFloat yy;
    NSString *_lastIssue;
    __block MSWeakTimer *_timer;

}
@property (strong, nonatomic) UITableView *historyTableView;
@property (strong, nonatomic)  CountDown *countDownForLabel;
@property (strong, nonatomic)  CountDown *countDownForEndTime;
@property (copy, nonatomic) NSString *currentIssue;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *titleLbs;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *title1Lbs;

@end

@implementation CPTBuyHeadView

- (void)dealloc{
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
    _timer = nil;
    if(_countDownForEndTime){
        _countDownForEndTime = nil;
    }
    _countDownForLabel= nil;
    [_historyArray removeAllObjects];
    [_subTitleArray removeAllObjects];
    [_titleBtnArray removeAllObjects];
    _historyArray = nil;
    _subTitleArray = nil;
    _titleBtnArray = nil;
    _historyTableView = nil;
}
- (void)removeNSNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%ld",(long)self.type] object:nil];
    [_countDownForLabel destoryTimer];
    if(_countDownForEndTime)
    {
        [_countDownForEndTime destoryTimer];
    }
    [_historyArray removeAllObjects];
    [_subTitleArray removeAllObjects];
    [_titleBtnArray removeAllObjects];
}

- (void)awakeFromNib{
    [super awakeFromNib];
     _page = 1;
    if(!_subTitleArray)_subTitleArray = [NSMutableArray array];
    if(!_titleBtnArray)_titleBtnArray = [NSMutableArray array];
    if(!_historyArray)_historyArray = [NSMutableArray array];
    
    self.clickTimes = 0;
    self.rightView.backgroundColor = self.leftView.backgroundColor = [UIColor colorWithHex:@"2d2f37"];

    self.historyTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    self.historyTableView.delegate = self;
    self.historyTableView.dataSource = self;
    self.historyTableView.tableFooterView = [UIView new];
    self.historyTableView.estimatedRowHeight =67;
    self.historyTableView.estimatedSectionHeaderHeight = 30;
    self.historyTableView.estimatedSectionFooterHeight = 0;
    self.historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    if (@available(iOS 11.0, *)) {
        self.historyTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.historyTableView.backgroundColor = self.hourView.backgroundColor;
    [self.historyTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CPTBuyHeadViewTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CPTBuyHeadViewTableViewCell"];

    [self addSubview:self.historyTableView];
    @weakify(self)
    [self.historyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.bottom.left.equalTo(self);
        make.top.equalTo(self.leftView.mas_bottom);
    }];
    self.historyTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self->_page ++ ;
        [self historyData];
    }];
    [self bringSubviewToFront:self.footerView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downBtnClick:)];
    [self.footerView addGestureRecognizer:tap];
    
    UITapGestureRecognizer * tapLeftView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRightView)];
    [self.rightView addGestureRecognizer:tapLeftView];
    self.leftView.backgroundColor = self.rightView.backgroundColor = [[CPTThemeConfig shareManager] Buy_HeadView_BackgroundC];
    self.footerView.backgroundColor = self.hourView.backgroundColor= [[CPTThemeConfig shareManager] Buy_HeadView_Footer_BackgroundC];
    self.backgroundColor= self.lineView.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionViewLine_C];
    [self.downIV setImage:[[CPTThemeConfig shareManager]Fantan_FloatImgDown]];
    for(UILabel* label in self.titleLbs){
        label.textColor = [[CPTThemeConfig shareManager] Buy_HeadView_Title_C];
    }
    for(UILabel* label in self.title1Lbs){
        label.textColor = [[CPTThemeConfig shareManager] Fantan_MoneyColor];
    }
    [self.speakerBtn setImage:[[CPTThemeConfig shareManager] Fantan_SpeakerImg] forState:UIControlStateNormal];
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        self.historyTableView.backgroundColor =WHITE;
        self.backgroundColor = [UIColor colorWithHex:@"D6D6D6"];
        self.typeLabel.textColor = [UIColor colorWithHex:@"333333"];
        self.lineFLabel.backgroundColor = self.headerView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        self.hourView.borderColor = [UIColor colorWithHex:@"999999"];
        self.hourView.borderWidth = 0.5;
        [self.addBtn setImage:IMAGE(@"tw_bug_head_add") forState:UIControlStateNormal];
    } else{
        self.lineFLabel.hidden = YES;
    }
}


- (void)tapRightView{
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(tapRightView)]){
            [self.delegate tapRightView];
        }
    }
}

#pragma mark - 界面绘制
- (void)configUIByData{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHeadView:) name:[NSString stringWithFormat:@"%ld",(long)self.type] object:nil];
    xx = SCREEN_WIDTH;
    yy = 42.;
    @weakify(self)
    switch (self.type) {
        case CPTBuyTicketType_3D:
        {
            CGFloat width = 35;
            CGFloat tmpX = (SCREEN_WIDTH-122- width*3-10)/4;
            self.currentDateL.textAlignment = NSTextAlignmentLeft;
            [self.currentDateL mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.leftView.mas_right).offset(tmpX);
            }];
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<3;i++){
                OpenButton * btn = [OpenButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.titleLabel.font = BOLDFONT(20);
                btn.userInteractionEnabled = NO;
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.rightView addSubview:btn];
                
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    @strongify(self)
                    if(i==0){
                        make.left.equalTo(self.leftView.mas_right).offset(tmpX);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }
                    make.top.equalTo(self.currentDateL.mas_bottom);
                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
            }
            UIButton * im = [UIButton buttonWithType:UIButtonTypeCustom];
            im.userInteractionEnabled = NO;
            [im setImage:IMAGE([[CPTThemeConfig shareManager] NextStepArrowImage]) forState:UIControlStateNormal];
            [self.rightView addSubview:im];
            
            [im mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.right.equalTo(self.rightView.mas_right);
                make.top.bottom.equalTo(tmpBtn);
                make.width.offset(width);
            }];

            for(NSInteger i=0;i<1;i++){
                __block UILabel * la = [[UILabel alloc] init];
  
                la.font = FONT(12);
                //
                la.textColor = [UIColor colorWithHex:@"d8d9d6"];
                la.backgroundColor = CLEAR;
                [self.rightView addSubview:la];
                [la mas_makeConstraints:^(MASConstraintMaker *make) {
                    @strongify(self)
                    if(i==0){
                        la.textAlignment = NSTextAlignmentLeft;
                        make.left.equalTo(self.leftView.mas_right).offset(tmpX);
                    }else{
                        la.textAlignment = NSTextAlignmentRight;
                        make.right.equalTo(tmpBtn.mas_right);
                    }
                    make.top.equalTo(tmpBtn.mas_bottom);
                    make.width.offset(70);
                    make.height.offset(25);
                }];
                [_subTitleArray addObject:la];
                
                la.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_LabelText];
            }
            
        }
            break;
        case CPTBuyTicketType_PaiLie35:
        {
            CGFloat width = 30;
            CGFloat tmpX = (SCREEN_WIDTH-122- width*5-10)/5;
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<5;i++){
                OpenButton * btn = [OpenButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.titleLabel.font = BOLDFONT(18);
                btn.userInteractionEnabled = NO;
//                btn.titleEdgeInsets = UIEdgeInsetsMake(-3, 0, 0, 0);
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.rightView addSubview:btn];
                
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    @strongify(self)
                    if(i==0){
                        make.left.equalTo(self.leftView.mas_right).offset(tmpX);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }
                    make.top.equalTo(self.currentDateL.mas_bottom);
                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
            }
            UIButton * im = [UIButton buttonWithType:UIButtonTypeCustom];
            im.userInteractionEnabled = NO;
            [im setImage:IMAGE([[CPTThemeConfig shareManager] NextStepArrowImage]) forState:UIControlStateNormal];
            [self.rightView addSubview:im];
            
            [im mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.right.equalTo(self.rightView.mas_right);
                make.top.bottom.equalTo(tmpBtn);
                make.width.offset((SCREEN_WIDTH-122- width*5-tmpX*4)/2);
            }];
            for(NSInteger i=0;i<2;i++){
                __block UILabel * la = [[UILabel alloc] init];
                //                    la.layer.borderWidth = 0.5;
                //                    la.layer.borderColor = [UIColor colorWithHex:@"d8d9d6"].CGColor;
                //                    la.layer.cornerRadius = 3;
                la.font = FONT(12);
//
                la.textColor = [UIColor colorWithHex:@"999999"];
                la.backgroundColor = CLEAR;
                [self.rightView addSubview:la];
                [la mas_makeConstraints:^(MASConstraintMaker *make) {
                    @strongify(self)
                    if(i==0){
                        la.textAlignment = NSTextAlignmentCenter;
                        make.left.equalTo(self.leftView.mas_right).offset(tmpX);
                    }else{
                        la.textAlignment = NSTextAlignmentCenter;
                        make.right.equalTo(tmpBtn.mas_right);
                    }
                    make.top.equalTo(tmpBtn.mas_bottom);
                    make.width.offset(100);
                    make.height.offset(25);
                }];
                [_subTitleArray addObject:la];
                
                la.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_LabelText];
            }
            
        }
            break;
        case CPTBuyTicketType_SSC:case CPTBuyTicketType_XJSSC:case CPTBuyTicketType_TJSSC:case CPTBuyTicketType_TenSSC:case CPTBuyTicketType_FiveSSC:case CPTBuyTicketType_JiShuSSC:case CPTBuyTicketType_FFC:case CPTBuyTicketType_AoZhouShiShiCai:case CPTBuyTicketType_NiuNiu_KuaiLe:case CPTBuyTicketType_FantanSSC:case CPTBuyTicketType_HaiNanQiXingCai:
        {
            CGFloat width = 30/SCAL;
            CGFloat tmpX = (SCREEN_WIDTH-122- width*5-4*13/SCAL)/2;
            __block OpenButton * tmpBtn;
            NSInteger cooo = 5;
            if(self.type == CPTBuyTicketType_HaiNanQiXingCai){
                cooo = 4;
                tmpX = (SCREEN_WIDTH-122- width*4-3*13/SCAL)/2;
            }
            self.currentDateL.textAlignment = NSTextAlignmentLeft;
            [self.currentDateL mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.leftView.mas_right).offset(tmpX);
            }];
            

            for(NSInteger i=0;i<cooo;i++){
                OpenButton * btn = [OpenButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.titleLabel.font = BOLDFONT(18);
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.rightView addSubview:btn];
                btn.userInteractionEnabled = NO;

                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    @strongify(self)
                    if(i==0){
                        make.left.equalTo(self.leftView.mas_right).offset(tmpX);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(13);
                    }
                    make.top.equalTo(self.currentDateL.mas_bottom);
                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
            }
            UIButton * im = [UIButton buttonWithType:UIButtonTypeCustom];
            im.userInteractionEnabled = NO;
            [im setImage:IMAGE([[CPTThemeConfig shareManager] NextStepArrowImage]) forState:UIControlStateNormal];
            [self.rightView addSubview:im];
            
            [im mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tmpBtn.mas_right);
                make.top.bottom.equalTo(tmpBtn);
                make.width.offset(tmpX/SCAL+13/SCAL);
            }];
            UILabel * tmpL;
            if(self.categoryId == CPTBuyCategoryId_FT||self.categoryId == CPTBuyCategoryId_NN){//番摊
                if(_niuWinBgView){
                    [self->_niuWinBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftView.mas_right).offset(tmpX);
                    }];
                }
                if(_fantanLabel){
                    _fantanLabel.textAlignment = NSTextAlignmentLeft;
                    [self->_fantanLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.leftView.mas_right).offset(tmpX);
                    }];
                }
            }else{
                NSInteger tmC = _titleBtnArray.count-1;
                if(self.type == CPTBuyTicketType_HaiNanQiXingCai){
                    tmC = 1;
                    for(NSInteger i=0;i<tmC;i++){
                        UILabel * la = [[UILabel alloc] init];
                        la.font = FONT(14);
                        la.textAlignment = NSTextAlignmentLeft;
                        la.textColor = [UIColor colorWithHex:@"d8d9d6"];
                        la.backgroundColor = CLEAR;
                        [self.rightView addSubview:la];
                        UIButton *btn = _titleBtnArray[i];
                        [la mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo(btn.mas_bottom).offset(6);
                            make.left.equalTo(btn);
                            make.width.offset(100);
                            make.height.offset(20);
                        }];
                        tmpL = la;
                        [_subTitleArray addObject:la];
                        la.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_LabelText];
                    }
                }else{
                    for(NSInteger i=0;i<tmC;i++){
                        UILabel * la = [[UILabel alloc] init];
                        la.layer.borderWidth = 0.5;
                        la.layer.borderColor = [UIColor colorWithHex:@"666666"].CGColor;
                        la.layer.cornerRadius = 3;
                        la.font = FONT(14);
                        la.textAlignment = NSTextAlignmentCenter;
                        la.textColor = [UIColor colorWithHex:@"d8d9d6"];
                        la.backgroundColor = CLEAR;
                        [self.rightView addSubview:la];
                        UIButton *btn = _titleBtnArray[i];
                        [la mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo(btn.mas_bottom).offset(6);
                            if(i==0){
                                make.centerX.equalTo(btn);
                            }else{
                                make.left.equalTo(tmpL.mas_right).offset(5);
                            }
                            make.width.offset(29);
                            make.height.offset(16);
                        }];
                        tmpL = la;
                        [_subTitleArray addObject:la];
                        la.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_LabelText];
                    }
                }

            }
            
        }
            break;
        case CPTBuyTicketType_PCDD:
        {
            CGFloat width = 30;
            CGFloat tmpX = (SCREEN_WIDTH-122- width*3-10-70)/4;
            self.currentDateL.textAlignment = NSTextAlignmentLeft;
            [self.currentDateL mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.leftView.mas_right).offset(tmpX);
            }];
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<3;i++){
                OpenButton * btn = [OpenButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.titleLabel.font = BOLDFONT(23);
                btn.userInteractionEnabled = NO;
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.rightView addSubview:btn];
                
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    @strongify(self)
                    if(i==0){
                        make.left.equalTo(self.leftView.mas_right).offset(tmpX);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }
                    make.top.equalTo(self.currentDateL.mas_bottom);
                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
            }
            UILabel * la = [[UILabel alloc] init];
            la.layer.borderWidth = 0.5;
            la.layer.borderColor = [UIColor colorWithHex:@"999999"].CGColor;
            la.layer.cornerRadius = 3;
            la.font = FONT(13);
            la.textAlignment = NSTextAlignmentCenter;
            la.textColor = [UIColor colorWithHex:@"FFFFFF"];
            la.backgroundColor = CLEAR;
            [self.rightView addSubview:la];
            [la mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                make.centerY.equalTo(tmpBtn);
                make.width.offset(60);
                make.height.offset(20);
            }];
            
            la.layer.borderColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_Label_border].CGColor;
            la.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_LabelText];
            
            if(self.categoryId == CPTBuyCategoryId_FT){
                
            }else{
                [_subTitleArray addObject:la];
            }
        }
            break;
        default:
            break;
    }
    [self checkMoney];

    if(!_countDownForLabel){
        _countDownForLabel = [[CountDown alloc] init];
    }
    [[CPTOpenLotteryManager shareManager] checkModelByIds:@[@(self.type)] callBack:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
        
        if(isSuccess){
            @strongify(self)
            [self configUIByModel:data target:self];
        }
    }];
    
//    [[CPTOpenLotteryManager shareManager] checkModel:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
//
//        if(isSuccess){
//            @strongify(self)
//            [self configUIByModel:data target:self];
//        }
//    }];

//    [self refresh];
}
-(void)refresh {
    _page = 1;
    [self historyData];
}

- (void)refreshHeadView:(NSNotification *)notification{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong __typeof(self) strongSelf = weakSelf;
        IGKbetModel * data = (IGKbetModel *)notification.object;
        [strongSelf configUIByModel:data target:weakSelf];
    });
}

#pragma mark - pk10动画
- (void)pk10Anmation{
    @weakify(self)
    switch (self.type) {
        case CPTBuyTicketType_PK10:case CPTBuyTicketType_TenPK10:case CPTBuyTicketType_FivePK10:case CPTBuyTicketType_JiShuPK10:case CPTBuyTicketType_AoZhouF1:case CPTBuyTicketType_XYFT:{
            NSInteger count = _titleBtnArray.count;
            NSInteger index = arc4random()%count;
            
            UIButton *firstBtn = [_titleBtnArray objectAtIndex:index];
//            UIButton *secendBtn = [_titleBtnArray objectAtIndex:arc4random()%count];
            CGFloat width = 20;
            CGFloat tmpX = (SCREEN_WIDTH-122- width*10-10)/9;
                [firstBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    @strongify(self)
                    make.left.equalTo(self.leftView.mas_right).offset(tmpX);
                }];
     
            [_titleBtnArray exchangeObjectAtIndex:0 withObjectAtIndex:index];
                for(NSInteger i=0;i<_titleBtnArray.count;i++){
                    UIButton * btn = [_titleBtnArray objectAtIndex:i];
                    __block UIButton * tmpBtn;
                    [UIView animateWithDuration:1.0 animations:^{
                        @strongify(self)
                        [btn mas_updateConstraints:^(MASConstraintMaker *make) {
                            @strongify(self)
                            if(i==0){
                                tmpBtn = btn;
                                make.left.equalTo(self.leftView.mas_right).offset(tmpX);
                            }else{
                                make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                            }
                        }];
                    [self.leftView layoutIfNeeded];
                    }completion:^(BOOL finished) {
                        
                    }];
                }
        }
            break;
            
        default:
            break;
    }
}
- (void)changeBallState:(BOOL)isPaile5{
    if(self.type == CPTBuyTicketType_PaiLie35){
        for (int i = 0; i< _titleBtnArray.count; i++) {
            UIButton *btn = [_titleBtnArray objectAtIndex:i];
            if(isPaile5 ){
                [btn setBackgroundImage:IMAGE(@"buy_zc_pailie_ball") forState:UIControlStateNormal];
            }else {
                if(i>=3){
                    [btn setBackgroundImage:IMAGE(@"buy_zc_ball2_red") forState:UIControlStateNormal];
                }
            }
        }
    }
}
#pragma mark - 界面刷新
- (void)configUIByModel:(IGKbetModel *)data target:(CPTBuyHeadView *)weakSelf{
    if(_titleBtnArray.count==0){
        return;
    }
    long long finishLongLong = 0;
    IGKbetModel * model = data;
    BOOL isOpenLottery = NO;
    switch (self.type) {
        case CPTBuyTicketType_3D:{
            LotteryInfoModel * pk10Model = model.threeD;
            if([pk10Model.nextIssue integerValue]-[pk10Model.issue integerValue]>1){
                isOpenLottery = YES;
            }
            weakSelf.nextDateL.text = [NSString stringWithFormat:@"%@",pk10Model.nextIssue];
            weakSelf.currentDateL.text = [NSString stringWithFormat:@"%@期  开奖结果",pk10Model.issue];
            finishLongLong = pk10Model.nextTime;
            NSArray * numberArry = [pk10Model.number componentsSeparatedByString:@","];
            weakSelf.issue = weakSelf.nextDateL.text;
            weakSelf.currentIssue = pk10Model.issue;
            if(_subTitleArray.count==1){
                NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"和值 %d",[numberArry[0]integerValue] + [numberArry[1]integerValue] + [numberArry[2]integerValue]]];
                
                [attrStr addAttribute:NSForegroundColorAttributeName value:[[CPTThemeConfig shareManager] KeyTitleColor] range:NSMakeRange(0, 2)];
                
                UILabel * jj = _subTitleArray[0];
                jj.attributedText = attrStr;
            }
            for (int i = 0; i< _titleBtnArray.count; i++) {
                UIButton *btn = [_titleBtnArray objectAtIndex:i];
                [btn setTitle:numberArry[i] forState:UIControlStateNormal];
//                if(i<=2){
//                    [btn setBackgroundImage:IMAGE(@"buy_zc_pailie_ball") forState:UIControlStateNormal];
//                }else{
                    [btn setBackgroundImage:IMAGE(@"buy_zc_ball2_red") forState:UIControlStateNormal];
//                }
            }
        }break;
        case CPTBuyTicketType_PaiLie35:{
            LotteryInfoModel * pk10Model = model.paiLie35;
            if([pk10Model.nextIssue integerValue]-[pk10Model.issue integerValue]>1){
                isOpenLottery = YES;
            }
            weakSelf.nextDateL.text = [NSString stringWithFormat:@"%@",pk10Model.nextIssue];
            weakSelf.currentDateL.text = [NSString stringWithFormat:@"%@期  开奖结果",pk10Model.issue];
            finishLongLong = pk10Model.nextTime;
            NSArray * numberArry = [pk10Model.number componentsSeparatedByString:@","];
            weakSelf.issue = weakSelf.nextDateL.text;
            weakSelf.currentIssue = pk10Model.issue;

            if(_subTitleArray.count==2){
                NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"P3和值 %ld",[numberArry[0]integerValue] + [numberArry[1]integerValue] + [numberArry[2]integerValue]]];

                [attrStr addAttribute:NSForegroundColorAttributeName value:[[CPTThemeConfig shareManager] Fantan_MoneyColor] range:NSMakeRange(0, 2)];

                
                NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"P5和值 %ld",[numberArry[0]integerValue] + [numberArry[1]integerValue] + [numberArry[2]integerValue]+ [numberArry[3]integerValue]+ [numberArry[4]integerValue]]];

                [attrStr1 addAttribute:NSForegroundColorAttributeName value:[[CPTThemeConfig shareManager] Fantan_MoneyColor] range:NSMakeRange(0, 2)];

                UILabel * jj = _subTitleArray[0];
                UILabel * jj1 = _subTitleArray[1];
                jj1.attributedText = attrStr1;
                jj.attributedText = attrStr;
            }
            for (int i = 0; i< _titleBtnArray.count; i++) {
                UIButton *btn = [_titleBtnArray objectAtIndex:i];
                [btn setTitle:numberArry[i] forState:UIControlStateNormal];
                    if(i<=2){
                        [btn setBackgroundImage:IMAGE(@"buy_zc_pailie_ball") forState:UIControlStateNormal];
                    }else{
                        [btn setBackgroundImage:IMAGE(@"buy_zc_ball2_red") forState:UIControlStateNormal];
                    }
            }
        }break;
        case CPTBuyTicketType_SSC:case CPTBuyTicketType_XJSSC:case CPTBuyTicketType_TJSSC:case CPTBuyTicketType_TenSSC:case CPTBuyTicketType_FiveSSC:case CPTBuyTicketType_JiShuSSC:case CPTBuyTicketType_FFC:case CPTBuyTicketType_AoZhouShiShiCai:case CPTBuyTicketType_NiuNiu_KuaiLe:case CPTBuyTicketType_FantanSSC:case CPTBuyTicketType_HaiNanQiXingCai:
        {
            ChongqinInfoModel * cqsscModel;
            LotteryInfoModel *kuaileNN_Model;
            if(self.type == CPTBuyTicketType_FFC){
                cqsscModel = model.txffc;
            }else if(self.type == CPTBuyTicketType_XJSSC){
                cqsscModel = model.xjssc;
            }else if(self.type == CPTBuyTicketType_SSC){
                cqsscModel = model.cqssc;
            }else if(self.type == CPTBuyTicketType_TJSSC){
                cqsscModel = model.tjssc;
            }else if(self.type == CPTBuyTicketType_TenSSC){
                cqsscModel = model.tenssc;
            }else if(self.type == CPTBuyTicketType_FiveSSC){
                cqsscModel = model.fivessc;
            }else if(self.type == CPTBuyTicketType_JiShuSSC){
                cqsscModel = model.jsssc;
            }else if (self.type == CPTBuyTicketType_AoZhouShiShiCai){
                cqsscModel = [[ChongqinInfoModel alloc] init];
                cqsscModel.nextTime = model.aozhouSSC.nextTime;
                cqsscModel.issue = model.aozhouSSC.issue;
                cqsscModel.nextIssue = model.aozhouSSC.nextIssue;
                cqsscModel.nextTime = model.aozhouSSC.nextTime;
                NSArray * ss = [model.aozhouSSC.number componentsSeparatedByString:@","];
                cqsscModel.numbers = ss;
                cqsscModel.number = model.aozhouSSC.number;

            }else if(self.type == CPTBuyTicketType_NiuNiu_KuaiLe){
                kuaileNN_Model = model.nnKuaile;
            }else if (self.type == CPTBuyTicketType_FantanSSC){
                kuaileNN_Model = model.fantanSSC;
            }else if (self.type == CPTBuyTicketType_HaiNanQiXingCai){
                kuaileNN_Model = model.haiNanQiXingCai;
                finishLongLong = kuaileNN_Model.nextTime;
            }
            if(cqsscModel){
                if([cqsscModel.nextIssue integerValue]-[cqsscModel.issue integerValue]>1){
                    isOpenLottery = YES;
                }
            }else{
                if([kuaileNN_Model.nextIssue integerValue]-[kuaileNN_Model.issue integerValue]>1){
                    isOpenLottery = YES;
                }
            }
            if(self.type == CPTBuyTicketType_NiuNiu_KuaiLe ){
                weakSelf.nextDateL.text = [NSString stringWithFormat:@"%@",kuaileNN_Model.nextIssue];
                weakSelf.currentDateL.text = [NSString stringWithFormat:@"%@期  开奖结果",kuaileNN_Model.issue];
                weakSelf.issue = weakSelf.nextDateL.text;
                finishLongLong = kuaileNN_Model.nextTime;
                weakSelf.currentIssue = kuaileNN_Model.issue;

                NSInteger cooo = kuaileNN_Model.number.length;
                if(self.type == CPTBuyTicketType_HaiNanQiXingCai){
                    cooo = 4;
                }
                for (NSInteger i = 0; i< cooo; i++) {
                    NSString *num = [kuaileNN_Model.number substringWithRange:NSMakeRange(i, 1)];
//                    NSString *num = numbers[i];
                    if(_titleBtnArray.count>i){
                        UIButton *btn = [_titleBtnArray objectAtIndex:i];
                        [btn setBackgroundImage:IMAGE(@"kj_hq") forState:UIControlStateNormal];
                        [btn setTitle:num forState:UIControlStateNormal];
                    }
                    
                }
            }else if(self.type == CPTBuyTicketType_FantanSSC|| self.type == CPTBuyTicketType_HaiNanQiXingCai){
                NSInteger total = 0;
                weakSelf.nextDateL.text = [NSString stringWithFormat:@"%@",kuaileNN_Model.nextIssue];
                weakSelf.currentDateL.text = [NSString stringWithFormat:@"%@期  开奖结果",kuaileNN_Model.issue];
                weakSelf.issue = weakSelf.nextDateL.text;
                self.currentIssue = kuaileNN_Model.issue;

                finishLongLong = kuaileNN_Model.nextTime;
                NSArray *numbers = [kuaileNN_Model.number componentsSeparatedByString:@","];
                NSInteger cooo = numbers.count;
                if(self.type == CPTBuyTicketType_HaiNanQiXingCai){
                    cooo = 4;
                    
                }
                for (NSInteger i = 0; i< cooo; i++) {

                    NSString *num = numbers[i];
                    total += num.integerValue;
                    UIButton *btn = [_titleBtnArray objectAtIndex:i];
                    [btn setBackgroundImage:IMAGE(@"kj_hq") forState:UIControlStateNormal];
                    [btn setTitle:num forState:UIControlStateNormal];
                }
                if(self.type == CPTBuyTicketType_FantanSSC){
                    NSInteger x = total%4;
                    _fantanLabel.text = [NSString stringWithFormat:@"和值%ld %@ 4 = %ld",total,@"%",x==0?4:x];
                    _fantanLabel.textColor = [[CPTThemeConfig shareManager] CO_Fantan_HeadView_Label];
                    
                    
                    
                }else if(self.type == CPTBuyTicketType_HaiNanQiXingCai){
                    for (NSInteger i = 0; i< _subTitleArray.count; i++) {
                        UILabel * lbl = _subTitleArray[i];
                        switch (i) {
                            case 0:
                                lbl.text = [NSString stringWithFormat:@"和值%ld",total];
                                break;
                            default:
                                break;
                        }
                    }
                }

            }else {
                weakSelf.nextDateL.text = [NSString stringWithFormat:@"%@",cqsscModel.nextIssue];
                weakSelf.currentDateL.text = [NSString stringWithFormat:@"%@期  开奖结果",cqsscModel.issue];
                weakSelf.issue = weakSelf.nextDateL.text;
                weakSelf.currentIssue = cqsscModel.issue;
                finishLongLong = cqsscModel.nextTime;
                NSMutableArray * sf = [NSMutableArray array];
                for (NSInteger i = 0; i< cqsscModel.numbers.count; i++) {
                    NSString * ke = cqsscModel.numbers[i];
                    if(![ke isEqualToString:@","]){
                        [sf addObject:ke];
                    }
                }
                for (NSInteger i = 0; i< sf.count; i++) {
                    NSString *num = sf[i];
                    UIButton *btn = [_titleBtnArray objectAtIndex:i];
                    [btn setBackgroundImage:IMAGE(@"kj_hq") forState:UIControlStateNormal];
                    [btn setTitle:num forState:UIControlStateNormal];
                }
            }
            
            if(self.categoryId == CPTBuyCategoryId_FT){
            if(self.type != CPTBuyTicketType_FantanSSC){
                NSInteger total = 0;
                for(NSInteger i = 0;i<cqsscModel.numbers.count;i++){
                    NSString *num = cqsscModel.numbers[i];
                    total += num.integerValue;
                    MBLog(@"%@",num);
                }
                MBLog(@"%ld",(long)total);
                NSInteger x = total%4;
                _fantanLabel.text = [NSString stringWithFormat:@"和值%ld %@ 4 = %ld",total,@"%",x==0?4:x];
                _fantanLabel.textColor = [[CPTThemeConfig shareManager] CO_Fantan_HeadView_Label];
            }
            }else if (self.categoryId == CPTBuyCategoryId_NN){
                LotteryInfoModel *nnModel = model.nnKuaile;
                NSArray *names = [nnModel.niuWinner componentsSeparatedByString:@","];
                for (UIView *v in _niuWinBgView.subviews) {
                    [v removeFromSuperview];
                }
                for(int i=0;i< names.count;i++){
                    NiuWinLabel *lab = [[NiuWinLabel alloc] initWithFrame:CGRectMake(34*i+2, 5, 32, 20)];
                    lab.text = names[i];
                    [_niuWinBgView addSubview:lab];
                }
            }

            if(weakSelf.nextDateL.text.length>=10){
                NSInteger index = 8;
                if(self.type == CPTBuyTicketType_FFC){
                    index = 9;
                }
                NSString * tmpt = weakSelf.nextDateL.text;
                NSString*bStr = [tmpt substringFromIndex:index];
                weakSelf.nextDateL.text = bStr;
            }

            if(self.type == CPTBuyTicketType_NiuNiu_KuaiLe ){
               
            }else{
                if(cqsscModel){
                    if([cqsscModel.number isKindOfClass:[NSString class]]){
                        if([cqsscModel.number containsString:@","]){
                            cqsscModel.number = [cqsscModel.number stringByReplacingOccurrencesOfString:@"," withString:@""];
                        }
                    }
                    if(cqsscModel.number.length <1 ){
                        return;
                    }
                    NSInteger num1;
                    NSInteger num2;
                    NSInteger num3;
                    NSInteger num4;
                    NSInteger num5;
                    
                    if(self.type == CPTBuyTicketType_HaiNanQiXingCai){
                        NSArray *numbers = [kuaileNN_Model.number componentsSeparatedByString:@","];
                        num1 = [numbers[0] integerValue];
                        num2 = [numbers[1]integerValue];
                        num3 = [numbers[2] integerValue];
                        num4 = [numbers[3] integerValue];
                        num5 = [numbers[4] integerValue];
                    }else{
                        num1 = [[cqsscModel.number substringWithRange:NSMakeRange(0, 1)] intValue];
                        num2 = [[cqsscModel.number substringWithRange:NSMakeRange(1, 1)] intValue];
                        num3 = [[cqsscModel.number substringWithRange:NSMakeRange(2, 1)] intValue];
                        num4 = [[cqsscModel.number substringWithRange:NSMakeRange(3, 1)] intValue];
                        num5 = [[cqsscModel.number substringWithRange:NSMakeRange(4, 1)] intValue];
                    }
                    
                    for (NSInteger i = 0; i< _subTitleArray.count; i++) {
                        UILabel * lbl = _subTitleArray[i];
                        switch (i) {
                            case 0:
                                lbl.text = [NSString stringWithFormat:@"%ld",(num1 + num2 + num3 + num4 + num5)];
                                break;
                            case 1:
                                if (num1 + num2 + num3 + num4 + num5 >= 23) {
                                    lbl.text = @"大";
                                }else{
                                    lbl.text = @"小";
                                }
                                break;
                            case 2:
                                if ((num1 + num2 + num3 + num4 + num5) % 2 == 0) {
                                    lbl.text = @"双";
                                }else{
                                    lbl.text = @"单";
                                }
                                break;
                            case 3:
                                if (num1 > num5) {
                                    lbl.text = @"龙";
                                }else if (num1 < num5){
                                    lbl.text = @"虎";
                                } else{
                                    lbl.text = @"和";
                                }
                                break;
                            default:
                                break;
                        }
                    }
                }

                }
            
        } break;

        case CPTBuyTicketType_PCDD:
        {
            LotteryInfoModel * pcddModel = model.pcegg;
            
//            if([pcddModel.issue isEqualToString:self.currentIssue]){
//                return;
//            }
            if([pcddModel.nextIssue integerValue]-[pcddModel.issue integerValue]>1){
                isOpenLottery = YES;
            }
            
            
            weakSelf.nextDateL.text = [NSString stringWithFormat:@"%@",pcddModel.nextIssue];
            weakSelf.currentDateL.text = [NSString stringWithFormat:@"%@期  开奖结果",pcddModel.issue];
            finishLongLong = pcddModel.nextTime;
            weakSelf.issue = weakSelf.nextDateL.text;
            self.currentIssue = pcddModel.issue;

            if([pcddModel.number length]<=0){
                return;
            }
            NSArray *numarray = [pcddModel.number componentsSeparatedByString:@","];
            NSInteger totle = [numarray[0]integerValue] + [numarray[1]integerValue] + [numarray[2]integerValue];
            NSString * totleString = [NSString stringWithFormat:@"%ld",(long)totle];
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"和值 %@",totleString]];

            [attrStr addAttribute:NSForegroundColorAttributeName value: [[CPTThemeConfig shareManager] Fantan_MoneyColor] range:NSMakeRange(3, [totleString length])];

            UILabel * jj = _subTitleArray[0];
            jj.attributedText = attrStr;
            for (int i = 0; i< _titleBtnArray.count; i++) {
                UIButton *btn = [_titleBtnArray objectAtIndex:i];
                [btn setTitle:numarray[i] forState:UIControlStateNormal];
                [btn setBackgroundImage:IMAGE(@"kj_hq") forState:UIControlStateNormal];
            }
        } break;

        default:
            break;
    }
    if(finishLongLong == 0)return;
    @weakify(self)
    self.finishLongLongTime = finishLongLong;

    MBLog(@"self.issue:%@",self.issue);
    MBLog(@"currentIssue:%@",self.currentIssue);

    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval chaTime = finishLongLong - now;
     if( isOpenLottery){// 开奖中
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                //                        self.endTimeLabel.text = @"";
                NSInteger curr = [self.issue integerValue];
                NSString *currS = [NSString stringWithFormat:@"%ld",curr-1] ;
                self.currentDateL.text = [NSString stringWithFormat:@"%@期  正在开奖",currS];
                if(self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC|| self.type == CPTBuyTicketType_TJSSC|| self.type == CPTBuyTicketType_TenSSC|| self.type == CPTBuyTicketType_FiveSSC|| self.type == CPTBuyTicketType_JiShuSSC|| self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_NiuNiu_KuaiLe || self.type == CPTBuyTicketType_PCDD || self.type == CPTBuyTicketType_FFC || self.type == CPTBuyTicketType_PaiLie35 || self.type == CPTBuyTicketType_FantanSSC || self.type == CPTBuyTicketType_AoZhouShiShiCai){
                    for(OpenButton * bt in self->_titleBtnArray){
                        [bt showOpenGif];
                    }
                    for(UILabel * bt in self->_subTitleArray){
                        bt.hidden = YES;
                    }
                }
                if(self.delegate){
                    [self.delegate dismissStopView];
                }
            });
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
            self->_timer = [MSWeakTimer scheduledTimerWithTimeInterval:sec target:self selector:@selector(loadNewData) userInfo:nil repeats:YES dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];

            [self->_countDownForLabel countDownWithStratTimeStamp:now+self.endTime finishTimeStamp:finishLongLong completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
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
                self.hourL.text = [NSString stringWithFormat:@"%@:%@:%@",hourS,minS,secondS];
                NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
                if(totoalSecond ==0){

                }
            }];
    }
    else if(chaTime > self.endTime) {//封盘前

                self.endTimeLabel.text = @"截止时间";
                if(_timer){
                    [_timer invalidate];
                    _timer = nil;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    if(self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC|| self.type == CPTBuyTicketType_TJSSC|| self.type == CPTBuyTicketType_TenSSC|| self.type == CPTBuyTicketType_FiveSSC|| self.type == CPTBuyTicketType_JiShuSSC|| self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_NiuNiu_KuaiLe || self.type == CPTBuyTicketType_PCDD || self.type == CPTBuyTicketType_FFC || self.type == CPTBuyTicketType_PaiLie35 || self.type == CPTBuyTicketType_FantanSSC || self.type == CPTBuyTicketType_AoZhouShiShiCai){
                        for(OpenButton * bt in self->_titleBtnArray){
                            [bt dismissOpenGif];
                        }
                        for(UILabel * bt in self->_subTitleArray){
                            bt.hidden = NO;
                        }
                        self.currentDateL.text = [NSString stringWithFormat:@"%@期  开奖结果",weakSelf.currentIssue];
                    }
                    if(self.delegate){
                        [self.delegate dismissStopView];
                    }
                });
                
                [self->_countDownForLabel countDownWithStratTimeStamp:now+self.endTime finishTimeStamp:finishLongLong completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
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
                    self.hourL.text = [NSString stringWithFormat:@"%@:%@:%@",hourS,minS,secondS];
                    NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
                    if(totoalSecond ==0){//开始封盘
                        dispatch_async(dispatch_get_main_queue(), ^{
                            @strongify(self)
                            self.endTimeLabel.text = @"截止时间";
                            if(self.delegate){
                                [self.delegate showStopView];
                            }
                        });
                        
                        if(!weakSelf->_countDownForEndTime){
                            self->_countDownForEndTime = [[CountDown alloc] init];
                        }
                        NSTimeInterval now2 = [[NSDate date] timeIntervalSince1970];
                        self.endTimeLabel.text = @"封盘时间";
                        [self->_countDownForEndTime countDownWithStratTimeStamp:now2 finishTimeStamp:finishLongLong completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
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
                            self.hourL.text = [NSString stringWithFormat:@"%@:%@:%@",hourS,minS,secondS];
                            
                            NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
                            if(totoalSecond ==0){//开奖中
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    @strongify(self)
                                    //                        self.endTimeLabel.text = @"";
                                    NSInteger curr = [self.issue integerValue];
                                    NSString *currS = [NSString stringWithFormat:@"%ld",curr-1] ;
                                    self.currentDateL.text = [NSString stringWithFormat:@"%@期  正在开奖",currS];
//                                    self.currentDateL.text = [NSString stringWithFormat:@"%@期  正在开奖",self.issue];
                                    if(self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC|| self.type == CPTBuyTicketType_TJSSC|| self.type == CPTBuyTicketType_TenSSC|| self.type == CPTBuyTicketType_FiveSSC|| self.type == CPTBuyTicketType_JiShuSSC|| self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_NiuNiu_KuaiLe || self.type == CPTBuyTicketType_PCDD || self.type == CPTBuyTicketType_FFC || self.type == CPTBuyTicketType_PaiLie35 || self.type == CPTBuyTicketType_FantanSSC || self.type == CPTBuyTicketType_AoZhouShiShiCai){
                                        for(OpenButton * bt in self->_titleBtnArray){
                                            [bt showOpenGif];
                                        }
                                        for(UILabel * bt in self->_subTitleArray){
                                            bt.hidden = YES;
                                        }
                                    }
                                    if(self.delegate){
                                        [self.delegate dismissStopView];
                                    }
                                });
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
                                self->_timer = [MSWeakTimer scheduledTimerWithTimeInterval:sec target:self selector:@selector(loadNewData) userInfo:nil repeats:YES dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
                            }
                        }];
                    }
                }];

            
    }else if(chaTime <= self.endTime && chaTime >0){//封盘中
        if(!weakSelf->_countDownForEndTime){
            self->_countDownForEndTime = [[CountDown alloc] init];
        }
        NSTimeInterval now2 = [[NSDate date] timeIntervalSince1970];
        if(_timer){
            [_timer invalidate];
            _timer = nil;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            if(self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC|| self.type == CPTBuyTicketType_TJSSC|| self.type == CPTBuyTicketType_TenSSC|| self.type == CPTBuyTicketType_FiveSSC|| self.type == CPTBuyTicketType_JiShuSSC|| self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_NiuNiu_KuaiLe || self.type == CPTBuyTicketType_PCDD || self.type == CPTBuyTicketType_FFC || self.type == CPTBuyTicketType_PaiLie35 || self.type == CPTBuyTicketType_FantanSSC || self.type == CPTBuyTicketType_AoZhouShiShiCai){
                for(OpenButton * bt in self->_titleBtnArray){
                    [bt dismissOpenGif];
                }
                for(UILabel * bt in self->_subTitleArray){
                    bt.hidden = NO;
                }
                self.currentDateL.text = [NSString stringWithFormat:@"%@期  开奖结果",self.currentIssue];
                self.endTimeLabel.text = @"封盘时间";
            }
            if(self.delegate){
                [self.delegate showStopView];
            }
        });
        [self->_countDownForEndTime countDownWithStratTimeStamp:now2 finishTimeStamp:finishLongLong completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
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
            self.hourL.text = [NSString stringWithFormat:@"%@:%@:%@",hourS,minS,secondS];
            NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
            if(totoalSecond ==0){//封盘结束
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.endTimeLabel.text = @"截止时间";
                    self.currentDateL.text = [NSString stringWithFormat:@"%@期  正在开奖",self.issue];
                    if(self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC|| self.type == CPTBuyTicketType_TJSSC|| self.type == CPTBuyTicketType_TenSSC|| self.type == CPTBuyTicketType_FiveSSC|| self.type == CPTBuyTicketType_JiShuSSC|| self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_NiuNiu_KuaiLe || self.type == CPTBuyTicketType_PCDD || self.type == CPTBuyTicketType_FFC || self.type == CPTBuyTicketType_PaiLie35 || self.type == CPTBuyTicketType_FantanSSC || self.type == CPTBuyTicketType_AoZhouShiShiCai){
                        for(OpenButton * bt in self->_titleBtnArray){
                            [bt showOpenGif];
                        }
                        for(UILabel * bt in self->_subTitleArray){
                            bt.hidden = YES;
                        }
                    }
                    if(self.delegate){
                        [self.delegate dismissStopView];
                    }
                });
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
                self->_timer = [MSWeakTimer scheduledTimerWithTimeInterval:sec target:self selector:@selector(loadNewData) userInfo:nil repeats:YES dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
            }
        }];
    }else if (chaTime<0){
        dispatch_async(dispatch_get_main_queue(), ^{
        if(self.delegate){
            [self.delegate dismissStopView];
        }
        });
    }
}

- (void)loadNewData{
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        [[CPTOpenLotteryManager shareManager] checkModelByIds:@[@(self.type)] callBack:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
            if(isSuccess){
                @strongify(self)
                [self configUIByModel:data target:self];
            }
        }];
    });
}

- (void)downBtnClick:(UITapGestureRecognizer *)sender {

    if(self.delegate){
        self.clickTimes = self.clickTimes+1;
        [self.delegate clickDownBtn:self.clickTimes];
        if(self.clickTimes ==2){
            self.clickTimes = 0;
        }
        if(self.clickTimes ==1){
            [self historyData];
            [self.downIV setImage:[[CPTThemeConfig shareManager]Fantan_FloatImgUp] ];
        }else{
            [self.downIV setImage:[[CPTThemeConfig shareManager]Fantan_FloatImgDown] ];
        }
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
        CGPoint point = CGPointMake(self.footerView.center.x, self.footerView.center.y);
        
        
        if (point.x >= xx / 2) {
            point.x = xx / 2;
        };
        if (point.x <= self.center.x - (xx - SCREEN_WIDTH) / 2) {
            point.x = self.center.x - (xx - SCREEN_WIDTH) / 2;
        };
        if (point.y >= yy / 2 + 64) {
            point.y = yy / 2 + 64;
        };
        if (point.y <= self.center.y - (yy - SCREEN_HEIGHT) / 2) {
            point.y = self.center.y - (yy - SCREEN_HEIGHT) / 2;
        };
        
        self.footerView.center = CGPointMake(self.footerView.center.x, point.y);
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(21+point.y);
        }];
    }else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded){
        MBLog(@"-centerX:%f===centerY:%f",self.footerView.center.x,self.footerView.center.y);
//        MBLog(@"%f====%f",self.view.center.x,self.view.center.y)
        
//        CGPoint point = CGPointMake(self.footerView.center.x, self.footerView.center.y);
//
//
//        if (point.x >= xx / 2) {
//            point.x = xx / 2;
//        };
//        if (point.x <= self.center.x - (xx - SCREEN_WIDTH) / 2) {
//            point.x = self.center.x - (xx - SCREEN_WIDTH) / 2;
//        };
//        if (point.y >= yy / 2 + 64) {
//            point.y = yy / 2 + 64;
//        };
//        if (point.y <= self.center.y - (yy - SCREEN_HEIGHT) / 2) {
//            point.y = self.center.y - (yy - SCREEN_HEIGHT) / 2;
//        };
//
//        self.footerView.center = CGPointMake(self.footerView.center.x, point.y);
//        [self mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.offset(21+point.y);
//        }];
    }
}

#pragma mark - 检测余额 & 充值
- (void)checkMoney{
    NSString * money = [NSString stringWithFormat:@"￥ %.2f",[Person person].balance];
//    NSMutableAttributedString *maxWinttr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ ",money]];
//    [maxWinttr addAttribute:NSForegroundColorAttributeName value: range:NSMakeRange(0, money.length)];
//    [maxWinttr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(5, money.length)];
    self.moneyL.text = money;
}

-(IBAction)addmoneyBtnClick {
    if(self.delegate){
        [self.delegate addmoneyClick];
    }
}

- (IBAction)moneyRefClick:(UIButton *)sender {
    if(self.delegate){
        [self.delegate reFmoneyClick];
    }
}

- (IBAction)showInfo{
    [[NSNotificationCenter defaultCenter] postNotificationName:CPTSHOWINFO object:nil];
}

#pragma mark - 获取历史开奖
-(void)historyData {
    NSString *historyurl = @"/sg/lishiSg.json";
    @weakify(self)
    [WebTools postWithURL:historyurl params:@{@"id":@(self.type),@"pageNum":@(_page),@"pageSize":@10} success:^(BaseData *data) {
        @strongify(self)
            if (self->_page == 1) {
                [self->_historyArray removeAllObjects];
            }
        switch (self.type) {
            case CPTBuyTicketType_3D:
            {
                if([data.data isKindOfClass:[NSString class]]){
                    return ;
                }
                NSArray * a = [ChongqinInfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                if(a.count == 0){
                    [self.historyTableView.mj_footer endRefreshingWithNoMoreData];
                    return ;
                }
                [self->_historyArray addObjectsFromArray:a];
            }
                break;
            case CPTBuyTicketType_PaiLie35:
            {
                if([data.data isKindOfClass:[NSString class]]){
                    return ;
                }
                NSArray * a = [LotteryInfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                if(a.count == 0){
                    [self.historyTableView.mj_footer endRefreshingWithNoMoreData];
                    return ;
                }
                [self->_historyArray addObjectsFromArray:a];
            }
                break;
            case CPTBuyTicketType_LiuHeCai: case CPTBuyTicketType_OneLiuHeCai: case CPTBuyTicketType_FiveLiuHeCai: case CPTBuyTicketType_ShiShiLiuHeCai:
                {
                    if([data.data isKindOfClass:[NSString class]]){
                        return;
                    }
                    NSArray * a = [SixInfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                    if(a.count == 0){
                        [self.historyTableView.mj_footer endRefreshingWithNoMoreData];
                        return ;
                    }
                    [self->_historyArray addObjectsFromArray:a];
                }
                break;
            case CPTBuyTicketType_PK10:case CPTBuyTicketType_TenPK10:case CPTBuyTicketType_FivePK10:case CPTBuyTicketType_JiShuPK10:case CPTBuyTicketType_AoZhouF1:case CPTBuyTicketType_XYFT:case CPTBuyTicketType_FantanXYFT:case CPTBuyTicketType_FantanPK10:
            {
                if(![data.data isKindOfClass:[NSString class]]){
                    NSArray * a = [PK10InfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                    if(a.count == 0){
                        [self.historyTableView.mj_footer endRefreshingWithNoMoreData];
                        return ;
                    }
                    [self->_historyArray addObjectsFromArray:a];
                }
            }
                break;
            case CPTBuyTicketType_HaiNanQiXingCai:{
                if(![data.data isKindOfClass:[NSString class]]){
                    NSArray * a = [LotteryInfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                    if(a.count == 0){
                        [self.historyTableView.mj_footer endRefreshingWithNoMoreData];
                        return ;
                    }
                    [self->_historyArray addObjectsFromArray:a];
                }
            }break;
            case CPTBuyTicketType_SSC:case CPTBuyTicketType_XJSSC:case CPTBuyTicketType_TJSSC:case CPTBuyTicketType_TenSSC:case CPTBuyTicketType_FiveSSC:case CPTBuyTicketType_JiShuSSC:case CPTBuyTicketType_FFC:case CPTBuyTicketType_FantanSSC:
            {
                NSArray * a = [ChongqinInfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                if(a.count == 0){
                    [self.historyTableView.mj_footer endRefreshingWithNoMoreData];
                    return ;
                }
                [self->_historyArray addObjectsFromArray:a];
            }
                break;
            case CPTBuyTicketType_PCDD:
            {
                NSArray * a = [PCInfoNewModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                if(a.count == 0){
                    [self.historyTableView.mj_footer endRefreshingWithNoMoreData];
                    return ;
                }
                [self->_historyArray addObjectsFromArray:a];
            }
                break;
            default:{
                NSArray * a = [LotteryInfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                if(a.count == 0){
                    [self.historyTableView.mj_footer endRefreshingWithNoMoreData];
                    return ;
                }
                [self->_historyArray addObjectsFromArray:a];
            }
                break;
        }
//        if (self->_page == 1) {
//            if(self->_historyArray.count>0){
//                [self->_historyArray removeObjectAtIndex:0];
//            }
//        }
        [self.historyTableView reloadData];
        [self.historyTableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
    } showHUD:NO];
}

#pragma mark - tableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _historyArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CPTBuyHeadViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CPTBuyHeadViewTableViewCell"];
    cell.type = self.type;
    cell.categoryId = self.categoryId;
    [cell configUI];
    switch (self.type) {
        case CPTBuyTicketType_3D:
        {
//            ChongqinInfoModel *firstmodel = _historyArray[indexPath.row];
//            [cell sscModel:firstmodel];
            
            LotteryInfoModel *firstmodel = _historyArray[indexPath.row];
            [cell lotteryInfoModel:firstmodel];
        }
            break;
        case CPTBuyTicketType_PaiLie35:
        {
            LotteryInfoModel *firstmodel = _historyArray[indexPath.row];
            [cell lotteryInfoModel:firstmodel];
        }
            break;
        case CPTBuyTicketType_LiuHeCai: case CPTBuyTicketType_OneLiuHeCai: case CPTBuyTicketType_FiveLiuHeCai: case CPTBuyTicketType_ShiShiLiuHeCai:
        {
            SixInfoModel *firstmodel = _historyArray[indexPath.row];
            [cell sixModel:firstmodel];
        }
            break;
        case CPTBuyTicketType_PK10:case CPTBuyTicketType_TenPK10:case CPTBuyTicketType_FivePK10:case CPTBuyTicketType_JiShuPK10:case CPTBuyTicketType_AoZhouF1:case CPTBuyTicketType_XYFT:case CPTBuyTicketType_FantanPK10:case CPTBuyTicketType_FantanXYFT:
        {
            PK10InfoModel *firstmodel = _historyArray[indexPath.row];
            [cell pk10Model:firstmodel];
        }
            break;
        case CPTBuyTicketType_SSC:case CPTBuyTicketType_XJSSC:case CPTBuyTicketType_TJSSC:case CPTBuyTicketType_TenSSC:case CPTBuyTicketType_FiveSSC:case CPTBuyTicketType_JiShuSSC:case CPTBuyTicketType_FFC:case CPTBuyTicketType_FantanSSC:
        {
            ChongqinInfoModel *firstmodel = _historyArray[indexPath.row];
            [cell sscModel:firstmodel];
        } break;
        case CPTBuyTicketType_PCDD:
        {
            PCInfoNewModel *firstmodel = _historyArray[indexPath.row];
            [cell pcddModel:firstmodel];
        } break;
        case CPTBuyTicketType_HaiNanQiXingCai: {
            LotteryInfoModel *firstmodel = _historyArray[indexPath.row];
            [cell lotteryInfoModel:firstmodel];
        }break;
        case CPTBuyTicketType_NiuNiu_KuaiLe:{
            LotteryInfoModel *firstmodel = _historyArray[indexPath.row];
            ChongqinInfoModel *mod = [[ChongqinInfoModel alloc] init];
            mod.issue = firstmodel.issue;
            mod.number = firstmodel.number;
            mod.niuWinner = firstmodel.niuWinner;
            [cell sscModel:mod];
        }break;
        default:{
            LotteryInfoModel *firstmodel = _historyArray[indexPath.row];
            [cell lotteryInfoModel:firstmodel];

        }
            break;
    }
    if(indexPath.row%2 == 0){
        cell.contentView.backgroundColor = [[CPTThemeConfig shareManager] Buy_HeadView_historyV_Cell1_C];
    }else{
        cell.contentView.backgroundColor = [[CPTThemeConfig shareManager] Buy_HeadView_historyV_Cell2_C];
    }
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CPTBuyHeadViewTableViewHeadView *header =[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CPTBuyHeadViewTableViewHeadView class]) owner:self options:nil]firstObject];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat t = 67.0;
    switch (self.type) {
        case CPTBuyTicketType_XJSSC:case CPTBuyTicketType_TJSSC:case CPTBuyTicketType_TenSSC:case CPTBuyTicketType_FiveSSC:case CPTBuyTicketType_JiShuSSC:case CPTBuyTicketType_FFC:case CPTBuyTicketType_AoZhouShiShiCai:case CPTBuyTicketType_FantanSSC:case CPTBuyTicketType_HaiNanQiXingCai:case CPTBuyTicketType_3D:{
            t = 75.0;
        }break;
        case CPTBuyTicketType_SSC:{
            t = 70.0;
        }break;

        default:
            break;
    }
    return t;
}

- (void)destroyTimer{
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
}

@end
