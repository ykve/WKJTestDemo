//
//  CalculateView.m
//  BuyLotteryBanner
//
//  Created by 研发中心 on 2018/12/28.
//  Copyright © 2018 研发中心. All rights reserved.
//

#import "CPTBuyHeadViewStyleMore.h"
#import "PCInfoModel.h"
#import "IGKbetModel.h"
#import "CPTBuyHeadViewTableViewCell.h"
#import "CPTBuyHeadViewTableViewHeadView.h"
#import "CountDown.h"
#import "BallTool.h"
#import "OpenButton.h"

@interface CPTBuyHeadViewStyleMore()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{
    NSMutableArray<UIButton *> *_titleBtnArray;
    NSMutableArray<UILabel *> *_subTitleArray;
    __block NSMutableArray* _historyArray;
    __block NSInteger _page;
    CGFloat xx;
    CGFloat yy;
    NSString *_lastIssue;

}
@property (strong, nonatomic) UITableView *historyTableView;
@property (strong, nonatomic)  CountDown *countDownForLabel;
@property (strong, nonatomic)  CountDown *countDownForEndTime;
@property (copy, nonatomic) NSString *currentIssue;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *titleLbs;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *title1Lbs;

@end

@implementation CPTBuyHeadViewStyleMore

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
    self.rightViewH.constant = self.rightViewH.constant;
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
        make.top.equalTo(self.rightView.mas_bottom);
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
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        self.historyTableView.backgroundColor =WHITE;
        self.hourView.borderColor = [UIColor colorWithHex:@"999999"];
        self.typeLabel.textColor = [UIColor colorWithHex:@"333333"];
        self.hourView.borderWidth = 0.5;
        [self.addBtn setImage:IMAGE(@"tw_bug_head_add") forState:UIControlStateNormal];
        self.historyTableView.backgroundColor = CLEAR;
    }
    [self.downIV setImage:[[CPTThemeConfig shareManager]Fantan_FloatImgDown]];
    for(UILabel* label in self.titleLbs){
        label.textColor = [[CPTThemeConfig shareManager] Buy_HeadView_Title_C];
    }
    for(UILabel* label in self.title1Lbs){
        label.textColor = [[CPTThemeConfig shareManager] Fantan_MoneyColor];
    }
    [self.speakerBtn setImage:[[CPTThemeConfig shareManager] Fantan_SpeakerImg] forState:UIControlStateNormal];
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
    CGFloat tmpXX = 10.0;
    @weakify(self)
    switch (self.type) {
        case CPTBuyTicketType_LiuHeCai: case CPTBuyTicketType_OneLiuHeCai: case CPTBuyTicketType_FiveLiuHeCai: case CPTBuyTicketType_ShiShiLiuHeCai:
        {
            CGFloat width = 33/SCAL;
            CGFloat tmpX = (SCREEN_WIDTH-16- width*7-34/SCAL-33/SCAL)/5;
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<7;i++){
                OpenButton * btn = [OpenButton buttonWithType:UIButtonTypeCustom];
                btn.type = CPTOpenButtonType_LHCBall;
                btn.backgroundColor = CLEAR;
                btn.titleLabel.font = BOLDFONT(15);
                [btn setTitleColor:BLACK forState:UIControlStateNormal];
                [self.rightView addSubview:btn];
                btn.userInteractionEnabled = NO;
                btn.titleEdgeInsets = UIEdgeInsetsMake(-3, 0, 0, 0);

                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    @strongify(self)
                    if(i==0){
                        make.left.offset(10);
                    }else if(i!=6){
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(34/SCAL);
                    }
                    make.top.equalTo(self.currentDateL.mas_bottom);
                    make.width.height.offset(width);
                }];
                if(i==6){
                    UIButton * im = [UIButton buttonWithType:UIButtonTypeCustom];
                    im.backgroundColor = CLEAR;
                    im.titleLabel.font = FONT(25);
                    im.userInteractionEnabled = NO;
                    [im setTitleColor:WHITE forState:UIControlStateNormal];
                    [im setTitleEdgeInsets:UIEdgeInsetsMake(-3, 0, 0, 0)];
                    [im setTitle:@"+" forState:UIControlStateNormal];
                    [self.rightView addSubview:im];
                    
                    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
                        [im setTitleColor:[UIColor colorWithHex:@"999999"] forState:UIControlStateNormal];
                    }
                    
                    [im mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(tmpBtn.mas_right);
                        make.top.bottom.equalTo(tmpBtn);
                        make.width.offset(34/SCAL);
                    }];
                }
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
                make.width.offset(43/SCAL);
            }];
            
            
            if(self.categoryId == CPTBuyCategoryId_FT||self.categoryId == CPTBuyCategoryId_NN){//番摊
                
            }else{
                for(NSInteger i=0;i<_titleBtnArray.count;i++){
                    UILabel * la = [[UILabel alloc] init];
                    la.font = FONT(12);
                    la.textAlignment = NSTextAlignmentCenter;
                    la.textColor = [UIColor colorWithHex:@"d8d9d6"];
                    la.backgroundColor = CLEAR;
                    [self.rightView addSubview:la];
                    UIButton *btn = _titleBtnArray[i];
                    [la mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(btn.mas_bottom);
                        make.centerX.equalTo(btn);
                        make.width.equalTo(btn).offset(tmpX);
                        make.height.offset(20);
                    }];
                    [_subTitleArray addObject:la];
                    
                    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_Dark){
                        la.textColor = [UIColor colorWithHex:@"d8d9d6"];
                    }else if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
                        la.textColor = [UIColor colorWithHex:@"666666"];
                    }
                }
            }
        }
            break;
        case CPTBuyTicketType_PK10:case CPTBuyTicketType_TenPK10:case CPTBuyTicketType_FivePK10:case CPTBuyTicketType_JiShuPK10:case CPTBuyTicketType_AoZhouF1:case CPTBuyTicketType_XYFT:case CPTBuyTicketType_FantanPK10:case CPTBuyTicketType_FantanXYFT:
            {
                CGFloat width = 25/SCAL;
                CGFloat tmpX = 9/SCAL;
                self->_currentDateL.textAlignment = NSTextAlignmentLeft;
                [self->_currentDateL mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self).offset(10.);
                }];
                __block UIButton * tmpBtn;
                for(NSInteger i=0;i<10;i++){
                    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.backgroundColor = CLEAR;
                    btn.titleLabel.font = BOLDFONT(15);
                    btn.userInteractionEnabled = NO;
                    [btn setTitleColor:WHITE forState:UIControlStateNormal];
                    [self.rightView addSubview:btn];
                    
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        @strongify(self)
                        if(i==0){
                            make.left.offset(10);
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
                    make.left.equalTo(tmpBtn.mas_right);
                    make.top.bottom.equalTo(tmpBtn);
                    make.width.offset(33/SCAL);
                }];
                if(self.categoryId == CPTBuyCategoryId_FT){
                    self->_currentDateL.textAlignment = NSTextAlignmentCenter;

                }else{
                    for(NSInteger i=0;i<_titleBtnArray.count-2;i++){
                        UILabel * la = [[UILabel alloc] init];
                        la.layer.borderWidth = 0.5;
                        la.layer.borderColor = [UIColor colorWithHex:@"666666"].CGColor;
                        la.layer.cornerRadius = 3;
                        la.font = BOLDFONT(12);
                        la.textAlignment = NSTextAlignmentCenter;
                        la.textColor = [UIColor colorWithHex:@"d8d9d6"];
                        la.backgroundColor = CLEAR;
                        [self.rightView addSubview:la];
                        UIButton *btn = _titleBtnArray[i];
                        [la mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo(btn.mas_bottom).offset(7);
                            make.centerX.equalTo(btn);
                            make.width.offset(19);
                            make.height.offset(19);
                        }];
                        [_subTitleArray addObject:la];
                        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_Dark){//
                            la.layer.borderColor = [UIColor colorWithHex:@"666666"].CGColor;
                            la.textColor = [UIColor colorWithHex:@"d8d9d6"];
                        }else if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
                            la.layer.borderColor = [UIColor colorWithHex:@"999999"].CGColor;
                            la.textColor = [UIColor colorWithHex:@"999999"];
                        }
                    }
                }
            }
            break;
        
        case CPTBuyTicketType_AoZhouACT:
        {
            self.rightViewH.constant = 120;
            CGFloat width = 25/SCAL;
            CGFloat tmpX = 8/SCAL;

            __block UIButton * tmpBtn;
            @weakify(self)
            for(NSInteger i=0;i<20;i++){
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.userInteractionEnabled = NO;
                btn.titleLabel.font = BOLDFONT(14);
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.rightView addSubview:btn];
                
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    @strongify(self)
                    if(i<10){
                        if(i==0){
                            make.left.offset(17./SCAL);
                        }else{
                            make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                        }
                        make.top.equalTo(self.currentDateL.mas_bottom);
                    }else{
                        if(i==10){
                            make.left.offset(17./SCAL);
                        }else{
                            make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                        }
                        make.top.equalTo(self.currentDateL.mas_bottom).offset(8/SCAL+width);

//                        make.top.offset(10 + width +8);
                    }
                    
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
                make.top.bottom.equalTo(tmpBtn).offset(-width/2-8/SCAL/2);
                make.width.offset(33/SCAL);
            }];

            UILabel * tmpL;

            for(NSInteger i=0;i<4;i++){
                UILabel * la = [[UILabel alloc] init];
                la.layer.borderWidth = 0.5;
                la.layer.borderColor = [UIColor colorWithHex:@"666666"].CGColor;
                la.layer.cornerRadius = 3;
                la.font = FONT(13);
                la.textAlignment = NSTextAlignmentCenter;
                la.textColor = [UIColor colorWithHex:@"d8d9d6"];
                la.backgroundColor = CLEAR;
                [self.rightView addSubview:la];
                UIButton *btn = _titleBtnArray[i+10];
                [la mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(btn.mas_bottom).offset(8);
                    if(i==0){
                        make.left.offset(17./SCAL);
                    }else{
                        make.left.equalTo(tmpL.mas_right).offset(10);
                    }
                    make.height.offset(19);
                    make.width.offset(36);
                }];
                tmpL = la;
                [_subTitleArray addObject:la];
                if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_Dark){//
                    la.layer.borderColor = [UIColor colorWithHex:@"666666"].CGColor;
                    la.textColor = [UIColor colorWithHex:@"d8d9d6"];
                }else if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
                    la.layer.borderColor = [UIColor colorWithHex:@"999999"].CGColor;
                    la.textColor = [UIColor colorWithHex:@"999999"];
                }
            }
            self.currentDateL.textAlignment = NSTextAlignmentLeft;
            [self.currentDateL mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(17./SCAL);
            }];
            
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
- (void)configUIByModel:(IGKbetModel *)data target:(CPTBuyHeadViewStyleMore *)weakSelf{
    if(_titleBtnArray.count==0){
        return;
    }
    long long finishLongLong = 0;
    IGKbetModel * model = data;
    BOOL isOpenLottery = NO;
    switch (self.type) {
        case CPTBuyTicketType_AoZhouACT:{
            LotteryInfoModel * infoModel = data.aoZhouACT;
            if([infoModel.nextIssue integerValue]-[infoModel.issue integerValue]>1){
                isOpenLottery = YES;
            }
            weakSelf.nextDateL.text = [NSString stringWithFormat:@"%@",infoModel.nextIssue];
            weakSelf.currentDateL.text = [NSString stringWithFormat:@"%@期  开奖结果",infoModel.issue];
            finishLongLong = infoModel.nextTime;
            weakSelf.issue = infoModel.nextIssue;
            self.currentIssue = infoModel.issue;
            NSArray *numarray = [infoModel.number componentsSeparatedByString:@","];
            UIColor *color0 = [UIColor colorWithHex:@"C6202C"];
            UIColor *color1 = [UIColor colorWithHex:@"006AB4"];
            UIColor *color2 = [UIColor colorWithHex:@"00833D"];
            UIColor *color3 = [UIColor colorWithHex:@"F9A800"];
            UIColor *color4 = [UIColor colorWithHex:@"B52996"];
            UIColor *color5 = [UIColor colorWithHex:@"F15000"];
            UIColor *color6 = [UIColor colorWithHex:@"8CAAC2"];
            UIColor *color7 = [UIColor colorWithHex:@"533190"];
            if(_titleBtnArray.count < 1){
                return;
            }
            NSInteger totle = 0;
                for (NSInteger i = 0; i< numarray.count; i++) {
                    NSString *num = numarray[i];
                    UIButton *btn = [_titleBtnArray objectAtIndex:i];
                    [btn setTitle:num forState:UIControlStateNormal];

                    [btn setBackgroundImage:nil forState:UIControlStateNormal];
                    btn.layer.masksToBounds = YES;
                    btn.layer.cornerRadius = 5;
                    if (0<num.intValue  && num.intValue < 11) {
                        btn.backgroundColor = color0;
                    }else if (10<num.intValue  && num.intValue < 21){
                        btn.backgroundColor = color1;
                     }else if (20<num.intValue  && num.intValue < 31){
                        btn.backgroundColor = color2;
                    }else if (30<num.intValue  && num.intValue < 41){
                        btn.backgroundColor = color3;
                    }else if (40<num.intValue  && num.intValue < 51){
                        btn.backgroundColor = color4;
                    }else if (50<num.intValue  && num.intValue < 61){
                        btn.backgroundColor = color5;
                    }else if (60<num.intValue  && num.intValue < 71){
                        btn.backgroundColor = color6;
                    }else if (70<num.intValue  && num.intValue < 81){
                        btn.backgroundColor = color7;
                    }
                    totle = totle + num.integerValue;
                }
            if(_subTitleArray.count!=4)
            {
                return;
            }
            NSString * oneS;
            NSString * twoS;
            NSString * threeS;
            for (NSInteger i = 0; i < 4; i++) {
                UILabel *lbl = _subTitleArray[i];
                switch (i) {
                    case 0:{
                            if(totle>810){
                                oneS = @"大";
                            }else if (totle<810){
                                oneS = @"小";
                            }else{
                                oneS = @"和";
                            }
                        lbl.text = [NSString stringWithFormat:@"%@",oneS];
                        }
                        break;
                    case 1:{
                        if(totle%2 ==0){
                            twoS = @"双";
                        }else{
                            twoS = @"单";
                        }
                        lbl.text = [NSString stringWithFormat:@"%@%@",oneS,twoS];
                    }
                        break;
                    case 2:{
//                        金（210～695）、木（696～763）、水（764～855）、火（856～923）和土（924～1410）
                        if(totle>=210 && totle <=695){
                            threeS = @"金";
                        }else if(totle>=696 && totle <=763){
                            threeS = @"木";
                        }else if(totle>=764 && totle <=855){
                            threeS = @"水";
                        }else if(totle>=856 && totle <=923){
                            threeS = @"火";
                        }else if(totle>=924 && totle <=1410){
                            threeS = @"土";
                        }
                        lbl.text = [NSString stringWithFormat:@"%@",threeS];
                    }
                        break;
                    case 3:{
                        lbl.text = [NSString stringWithFormat:@"%ld",(long)totle];
                    }
                        break;
                    default:
                        break;
                }
            }
            
                //    UILabel *lbl = _subTitleArray[0];
                //    lbl.text = [NSString stringWithFormat:@"P5和值：%ld        P3和值：%ld",(long)p5,(long)p3];
        }break;
        case CPTBuyTicketType_LiuHeCai: case CPTBuyTicketType_OneLiuHeCai: case CPTBuyTicketType_FiveLiuHeCai: case CPTBuyTicketType_ShiShiLiuHeCai:
        {
            SixInfoModel * sixModel;
            if(self.type ==CPTBuyTicketType_LiuHeCai){
                sixModel = model.lhc;
            }else if(self.type ==CPTBuyTicketType_OneLiuHeCai){
                sixModel = model.onelhc;
            }else if(self.type ==CPTBuyTicketType_FiveLiuHeCai){
                sixModel = model.fivelhc;
            }else if(self.type ==CPTBuyTicketType_ShiShiLiuHeCai){
                sixModel = model.sslhc;
            }
            if([sixModel.nextIssue integerValue]-[sixModel.issue integerValue]>1){
                isOpenLottery = YES;
            }
            weakSelf.issue = sixModel.nextIssue;
            weakSelf.nextDateL.text = [NSString stringWithFormat:@"%@",sixModel.nextIssue];
            finishLongLong = sixModel.nextTime;
            self.currentIssue = sixModel.issue;
            weakSelf.currentDateL.text = [NSString stringWithFormat:@"%@期  开奖结果",sixModel.issue];
            NSArray * numberArry = [sixModel.number componentsSeparatedByString:@","];
            NSArray * shengxiaoArry = [sixModel.shengxiao componentsSeparatedByString:@","];
            if(_titleBtnArray.count<1)return;
            if(numberArry.count<5)return;
            for (int i = 0; i< 7; i++) {
                NSString *number = numberArry[i];
                NSString *shengxiao = shengxiaoArry[i];
                NSString *wuxin = [Tools numbertowuxin:number];
                UIButton *btn = _titleBtnArray[i];
                UILabel  *lab = _subTitleArray[i];
                lab.text = [NSString stringWithFormat:@"%@/%@",shengxiao,wuxin];
                [btn setTitle:number forState:UIControlStateNormal];
                [btn setBackgroundImage:[Tools numbertoimage:number Withselect:NO] forState:UIControlStateNormal];
            }
        }
            break;
        case CPTBuyTicketType_PK10:case CPTBuyTicketType_TenPK10:case CPTBuyTicketType_FivePK10:case CPTBuyTicketType_JiShuPK10:case CPTBuyTicketType_AoZhouF1:case CPTBuyTicketType_XYFT:case CPTBuyTicketType_FantanXYFT:case CPTBuyTicketType_FantanPK10:{
            PK10InfoModel * pk10Model;
            if(self.type == CPTBuyTicketType_XYFT){
                pk10Model = model.xyft;
            }else if(self.type == CPTBuyTicketType_PK10){
                pk10Model = model.bjpks;
            }else if(self.type == CPTBuyTicketType_TenPK10){
                pk10Model = model.tenpks;
            }else if(self.type == CPTBuyTicketType_FivePK10){
                pk10Model = model.fivepks;
            }else if(self.type == CPTBuyTicketType_JiShuPK10){
                pk10Model = model.jspks;
            }else if(self.type == CPTBuyTicketType_AoZhouF1){
                pk10Model = [[PK10InfoModel alloc] init];
                pk10Model.nextTime = model.aozhouF1.nextTime;
                pk10Model.issue = model.aozhouF1.issue;
                pk10Model.nextIssue = [model.aozhouF1.nextIssue integerValue];
                pk10Model.nextTime = model.aozhouF1.nextTime;
                pk10Model.number = model.aozhouF1.number;
            }else if (self.type == CPTBuyTicketType_FantanPK10){
                pk10Model = [[PK10InfoModel alloc] init];
                pk10Model.nextTime = model.fantanPK10.nextTime;
                pk10Model.issue = model.fantanPK10.issue;
                pk10Model.nextIssue = [model.fantanPK10.nextIssue integerValue];
                pk10Model.nextTime = model.fantanPK10.nextTime;
                pk10Model.number = model.fantanPK10.number;
            }else if(self.type == CPTBuyTicketType_FantanXYFT){
                pk10Model = [[PK10InfoModel alloc] init];
                pk10Model.nextTime = model.fantanXYFT.nextTime;
                pk10Model.issue = model.fantanXYFT.issue;
                pk10Model.nextIssue = [model.fantanXYFT.nextIssue integerValue];
                pk10Model.nextTime = model.fantanXYFT.nextTime;
                pk10Model.number = model.fantanXYFT.number;
            }
            if(pk10Model.nextIssue -[pk10Model.issue integerValue]>1){
                isOpenLottery = YES;
            }
            weakSelf.nextDateL.text = [NSString stringWithFormat:@"%ld",(long)pk10Model.nextIssue];
            weakSelf.issue = weakSelf.nextDateL.text;
            self.currentIssue = pk10Model.issue;

            weakSelf.currentDateL.text = [NSString stringWithFormat:@"%@期  开奖结果",pk10Model.issue];
            if(weakSelf.nextDateL.text.length>10){
                NSInteger index = 8;
                NSString * tmpt = weakSelf.nextDateL.text;
                NSString*bStr = [tmpt substringFromIndex:index];
                weakSelf.nextDateL.text = bStr;
            }

            finishLongLong = pk10Model.nextTime;
            
            NSArray *numbers = [pk10Model.number componentsSeparatedByString:@","];
            if(numbers.count<2){
                return;
            }
            //冠亚
            NSInteger guanInt = [[NSString stringWithFormat:@"%@", numbers[0]] intValue];
            NSInteger yaInt = [[NSString stringWithFormat:@"%@", numbers[1]] intValue];
            NSInteger jiInt = [[NSString stringWithFormat:@"%@", numbers[2]] intValue];
            NSInteger fourthInt = [[NSString stringWithFormat:@"%@", numbers[3]] intValue];
            NSInteger fifthInt = [[NSString stringWithFormat:@"%@", numbers[4]] intValue];
            NSInteger sixthInt = [[NSString stringWithFormat:@"%@", numbers[5]] intValue];
            NSInteger sevenInt = [[NSString stringWithFormat:@"%@", numbers[6]] intValue];
            
            NSString *guanYaStr = [NSString stringWithFormat:@"%ld", guanInt + yaInt];
            NSInteger tenthNum = [[NSString stringWithFormat:@"%@", numbers[9]] intValue];
            
            NSInteger ninethNum = [[NSString stringWithFormat:@"%@", numbers[8]] intValue];
            NSInteger eightthNum = [[NSString stringWithFormat:@"%@", numbers[7]] intValue];
            
            for (NSInteger i = 0; i < _subTitleArray.count; i++) {
                UILabel *lbl = _subTitleArray[i];
                switch (i) {
                    case 0://1冠亚
                        lbl.text = guanYaStr;
                        break;
                    case 1://冠亚大小
                        if (guanInt + yaInt > 11) {
                            lbl.text = @"大";
                        }else{
                            lbl.text = @"小";
                        }
                        break;
                    case 2://1冠亚单双
                        if ((guanInt + yaInt)%2) {
                            lbl.text = @"单";
                        } else{
                            lbl.text = @"双";
                        }
                        break;
                    case 3://龙虎
                        if (guanInt > tenthNum) {
                            lbl.text = @"龙";
                        }else{
                            lbl.text = @"虎";
                        }
                        break;
                    case 4://
                        if (yaInt > ninethNum) {
                            lbl.text = @"龙";
                        }else{
                            lbl.text = @"虎";
                        }
                        break;
                    case 5://
                        if (jiInt > eightthNum) {
                            lbl.text = @"龙";
                        }else{
                            lbl.text = @"虎";
                        }
                        break;
                    case 6:
                        if (fourthInt > sevenInt) {
                            lbl.text = @"龙";
                        }else{
                            lbl.text = @"虎";
                        }
                        break;
                    case 7:
                        if (fifthInt > sixthInt) {
                            lbl.text = @"龙";
                        }else{
                            lbl.text = @"虎";
                        }
                        break;
                    default:
                        break;
                }
            }
            if(self.categoryId == CPTBuyCategoryId_FT){
                NSInteger total = 0;
                for(NSInteger i = 0;i<3;i++){
                    NSString *num = numbers[i];
                    total += num.integerValue;
                    MBLog(@"%@",num);
                }
                MBLog(@"%ld",(long)total);
                NSInteger x = total%4;
                _fantanLabel.text = [NSString stringWithFormat:@"和值%ld %@ 4 = %ld",total,@"%",x==0?4:x];
                if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
                    _fantanLabel.textColor = [UIColor colorWithHex:@"999999"];
                } else{
                    _fantanLabel.textColor = WHITE;
                }
            }
            for (NSInteger i = 0; i< numbers.count; i++) {
                UIButton *btn = [_titleBtnArray objectAtIndex:i];
                [btn setTitle:numbers[i] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
                NSInteger num = [[NSString stringWithFormat:@"%@", numbers[i]] intValue];
                btn.layer.masksToBounds = YES;
                btn.layer.cornerRadius = 5;
                btn.backgroundColor = [BallTool getColorWithNum:num];
            }
        }
            break;
        default:
            break;
    }
    if(finishLongLong == 0)return;
    @weakify(self)
    self.finishLongLongTime = finishLongLong;
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval chaTime = finishLongLong - now;
    if( isOpenLottery){// 开奖中
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            //                        self.endTimeLabel.text = @"";
            NSInteger curr = [self.issue integerValue];
            NSString *currS = [NSString stringWithFormat:@"%d",curr-1] ;
            self.currentDateL.text = [NSString stringWithFormat:@"%@期  正在开奖",currS];
            if(self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC|| self.type == CPTBuyTicketType_TJSSC|| self.type == CPTBuyTicketType_TenSSC|| self.type == CPTBuyTicketType_FiveSSC|| self.type == CPTBuyTicketType_JiShuSSC|| self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_NiuNiu_KuaiLe || self.type == CPTBuyTicketType_PCDD || self.type == CPTBuyTicketType_FFC || self.type == CPTBuyTicketType_PaiLie35 || self.type == CPTBuyTicketType_FantanSSC || self.type == CPTBuyTicketType_AoZhouShiShiCai || self.type == CPTBuyTicketType_LiuHeCai|| self.type == CPTBuyTicketType_OneLiuHeCai || self.type == CPTBuyTicketType_FiveLiuHeCai|| self.type == CPTBuyTicketType_ShiShiLiuHeCai){
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
            if(self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC|| self.type == CPTBuyTicketType_TJSSC|| self.type == CPTBuyTicketType_TenSSC|| self.type == CPTBuyTicketType_FiveSSC|| self.type == CPTBuyTicketType_JiShuSSC|| self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_NiuNiu_KuaiLe || self.type == CPTBuyTicketType_PCDD || self.type == CPTBuyTicketType_FFC || self.type == CPTBuyTicketType_PaiLie35 || self.type == CPTBuyTicketType_FantanSSC || self.type == CPTBuyTicketType_AoZhouShiShiCai|| self.type == CPTBuyTicketType_LiuHeCai|| self.type == CPTBuyTicketType_OneLiuHeCai || self.type == CPTBuyTicketType_FiveLiuHeCai|| self.type == CPTBuyTicketType_ShiShiLiuHeCai){
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
                            if(self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC|| self.type == CPTBuyTicketType_TJSSC|| self.type == CPTBuyTicketType_TenSSC|| self.type == CPTBuyTicketType_FiveSSC|| self.type == CPTBuyTicketType_JiShuSSC|| self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_NiuNiu_KuaiLe || self.type == CPTBuyTicketType_PCDD || self.type == CPTBuyTicketType_FFC || self.type == CPTBuyTicketType_PaiLie35 || self.type == CPTBuyTicketType_FantanSSC || self.type == CPTBuyTicketType_AoZhouShiShiCai|| self.type == CPTBuyTicketType_LiuHeCai|| self.type == CPTBuyTicketType_OneLiuHeCai || self.type == CPTBuyTicketType_FiveLiuHeCai|| self.type == CPTBuyTicketType_ShiShiLiuHeCai){
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
            if(self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC|| self.type == CPTBuyTicketType_TJSSC|| self.type == CPTBuyTicketType_TenSSC|| self.type == CPTBuyTicketType_FiveSSC|| self.type == CPTBuyTicketType_JiShuSSC|| self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_NiuNiu_KuaiLe || self.type == CPTBuyTicketType_PCDD || self.type == CPTBuyTicketType_FFC || self.type == CPTBuyTicketType_PaiLie35 || self.type == CPTBuyTicketType_FantanSSC || self.type == CPTBuyTicketType_AoZhouShiShiCai|| self.type == CPTBuyTicketType_LiuHeCai|| self.type == CPTBuyTicketType_OneLiuHeCai || self.type == CPTBuyTicketType_FiveLiuHeCai|| self.type == CPTBuyTicketType_ShiShiLiuHeCai){
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
                    if(self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC|| self.type == CPTBuyTicketType_TJSSC|| self.type == CPTBuyTicketType_TenSSC|| self.type == CPTBuyTicketType_FiveSSC|| self.type == CPTBuyTicketType_JiShuSSC|| self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_NiuNiu_KuaiLe || self.type == CPTBuyTicketType_PCDD || self.type == CPTBuyTicketType_FFC || self.type == CPTBuyTicketType_PaiLie35 || self.type == CPTBuyTicketType_FantanSSC || self.type == CPTBuyTicketType_AoZhouShiShiCai|| self.type == CPTBuyTicketType_LiuHeCai|| self.type == CPTBuyTicketType_OneLiuHeCai || self.type == CPTBuyTicketType_FiveLiuHeCai|| self.type == CPTBuyTicketType_ShiShiLiuHeCai){
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
- (IBAction)moneyRefClick:(UIButton *)sender {
    if(self.delegate){
        [self.delegate reFmoneyClick];
    }
}
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
            ChongqinInfoModel *firstmodel = _historyArray[indexPath.row];
            [cell sscModel:firstmodel];
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
        case CPTBuyTicketType_AoZhouACT:
        {
            LotteryInfoModel *firstmodel = _historyArray[indexPath.row];
            [cell lotteryInfoModel:firstmodel];
        }
            break;
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
        case CPTBuyTicketType_SSC:case CPTBuyTicketType_XJSSC:case CPTBuyTicketType_TJSSC:case CPTBuyTicketType_TenSSC:case CPTBuyTicketType_FiveSSC:case CPTBuyTicketType_JiShuSSC:case CPTBuyTicketType_FFC:case CPTBuyTicketType_AoZhouShiShiCai:case CPTBuyTicketType_FantanSSC:case CPTBuyTicketType_HaiNanQiXingCai:{
            t = 75.0;
        }
        case CPTBuyTicketType_AoZhouACT:{
            t = 90.0;
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
