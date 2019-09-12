//
//  CartPCCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartPCCtrl.h"
#import "CartPCdandanView1.h"
#import "CartPCdandanView2.h"
#import "CartTypeView.h"
#import "SQMenuShowView.h"
#import "CartSetView.h"
#import "CartListCtrl.h"
#import "CartChongqinHeadView.h"
#import "CartChongqinHeadCell.h"
#import "IGKbetListCtrl.h"
#import "BettingRecordViewController.h"
#import "PCNumberTrendCtrl.h"
#import "PCFreeRecommendCtrl.h"
#import "PCHistoryModel.h"
#import "CartChongqinMissModel.h"
#import "TopUpViewController.h"
#import "LoginAlertViewController.h"
#import "KeFuViewController.h"
#import "BuyLotBottomView.h"

@interface CartPCCtrl ()<WB_StopWatchDelegate>

@property (nonatomic, strong) CartChongqinHeadView *headView;

@property (nonatomic, strong) BuyLotBottomView *bottomView;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) UILabel *pricelab;

@property (nonatomic, strong) CartTypeView *typeView;

@property (nonatomic, strong) SQMenuShowView *showView;

@property (nonatomic, strong) UIView *footView;

/**
 展示section = 0的列表
 */
@property (nonatomic, assign) BOOL showhead;
/**
 选择不同选号方式展示不同列表
 1:两面----------10
 2：色波---------11
 3：豹子---------12
 4：特码包三------13
 5：特码---------14
 */
//@property (nonatomic, assign) NSInteger selecttype;

@property (nonatomic, strong) CartTypeModel *selectModel;

@property (nonatomic, strong) NSArray *categoryArray;

@property (nonatomic, strong) CartPCdandanView1 *pc1;

@property (nonatomic, strong) CartPCdandanView2 *pc2;

@property (nonatomic, strong) WB_Stopwatch *stopwatch;

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
 加入购彩篮集合
 */
@property (nonatomic, strong) NSMutableArray *cartArray;

@property (nonatomic, strong) RKNotificationHub *hub;
@end

@implementation CartPCCtrl

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.typeView dismiss];
    
    self.typeView = nil;
    
    [self.stopwatch reset];
    
    [self resignFirstResponder];
    
    [self removenotification];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self refresh];
    
    self.pricelab.text = [NSString stringWithFormat:@"￥%.2f",[Person person].balance];
    
    [self addnotification];
}

-(void)addnotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_pcegg" object:nil];
    
}

-(void)removenotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_pcegg" object:nil];
}

-(void)refresh {
    
    [self getnextissue];
    
    [self inithistoryData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self rigBtn:@"助手" Withimage:@"carthelp" With:^(UIButton *sender) {
        
        [self.typeView dismiss];
        
        [self.showView showView];
    }];
    
    [self.rightBtn setTitleColor:BASECOLOR forState:UIControlStateNormal];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CartChongqinHeadCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJHeaderIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT+40, 0, SAFE_HEIGHT + 100,0 ));
    }];
    
    self.pricetype = 3;
    
    self.times = 1;
    
    [self buildtopandfootView];
    
    [self getTypeRootData];
    
    [self setshake];
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
            
            if (model.ID < 13) {
                
                weakSelf.pc1.hidden = NO;
                weakSelf.pc1.alpha = 1;
                weakSelf.pc2.hidden = YES;
                weakSelf.pc2.alpha = 0;
                weakSelf.pc1.type = model.ID;
            }
            else{
                weakSelf.pc1.hidden = YES;
                weakSelf.pc1.alpha = 0;
                weakSelf.pc2.hidden = NO;
                weakSelf.pc2.alpha = 1;
                weakSelf.pc2.type = model.ID;
            }
            
            [weakSelf getquerymiss];
            
            if (model.ID < 13) {
                
                [weakSelf.pc1 clear];
            }
            else {
                [weakSelf.pc2 clear];
            }
            
            [weakSelf getlotteryCount];
            
            [weakSelf getmaxprice];
            
             [weakSelf.tableView reloadData];
        };

    }
    return _typeView;
}

-(CartChongqinHeadView *)headView {
    
    if (!_headView) {
        WS(weakSelf);
        _headView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CartChongqinHeadView class]) owner:self options:nil]firstObject];
        
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 58);
        
        self.stopwatch = [[WB_Stopwatch alloc]initWithLabel:_headView.endtimelab andTimerType:WBTypeTimer];
        self.stopwatch.delegate = self;
        [self.stopwatch setTimeFormat:@"HH:mm:ss"];
        
        for (UILabel *lab in _headView.numberlabs) {
            
            if (lab.tag > 102) {
                
                lab.hidden = YES;
            }
        }
        
        _headView.lookallBlock = ^{
            
            IGKbetListCtrl *list = [[IGKbetListCtrl alloc]init];
            list.lottery_type = 5;
            list.titlestring = @"PC蛋蛋";
            WEAKPUSH(list);
        };
    }
    return _headView;
}

-(UIView *)footView {
    
    if (!_footView) {
        
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        
        _footView.backgroundColor = WHITE;
        
        UIView *colorview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,16)];
        colorview.backgroundColor = [UIColor colorWithHex:@"F8E8CC"];
        [_footView addSubview:colorview];
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectMake(SCREEN_WIDTH/2-12, 0, 24, 24) andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE(@"cartdown1") andTarget:self andAction:@selector(showheadClick:) andType:UIButtonTypeCustom];
        [btn setImage:IMAGE(@"cartup1") forState:UIControlStateSelected];
        btn.backgroundColor = [UIColor colorWithHex:@"F8E8CC"];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, -4, 0)];
        btn.selected = self.showhead;
        btn.layer.cornerRadius = 12;
        [_footView addSubview:btn];
    
        [_footView addSubview:self.pc1];
        [_footView addSubview:self.pc2];
        self.pc2.hidden = YES;
        self.pc2.alpha = 0;
    }
    
    return _footView;
}

-(CartPCdandanView1 *)pc1 {
    
    if (!_pc1) {
        
        WS(weakSelf);
        _pc1 = [[[NSBundle mainBundle]loadNibNamed:@"CartPCdandanView1" owner:self options:nil]firstObject];
        _pc1.lotteryId = self.lotteryId;
        _pc1.frame = CGRectMake(0, 24, SCREEN_WIDTH, 275/SCAL);
        _pc1.cartInfoBlock = ^{
            
            ShowAlertView *show = [[ShowAlertView alloc]initWithFrame:CGRectZero];
            [show buildCartPCInfoView:weakSelf.selectModel.ID];
            [show show];
        };
        _pc1.selectBlock = ^{
            
            [weakSelf getlotteryCount];
        };
    }
    return _pc1;
}

-(CartPCdandanView2 *)pc2 {
    
    if (!_pc2) {
        WS(weakSelf);
        _pc2 = [[[NSBundle mainBundle]loadNibNamed:@"CartPCdandanView2" owner:self options:nil]firstObject];
        _pc2.lotteryId = self.lotteryId;
        _pc2.frame = CGRectMake(0, 24, SCREEN_WIDTH, 275/SCAL);
        _pc2.cartInfoBlock = ^{
            
            ShowAlertView *show = [[ShowAlertView alloc]initWithFrame:CGRectZero];
            [show buildCartPCInfoView:weakSelf.selectModel.ID];
            [show show];
        };
        _pc2.selectBlock = ^{
            
            [weakSelf getlotteryCount];
        };
    }
    return _pc2;
}

-(void)buildtopandfootView {
    
    UIView *top = [[UIView alloc]initWithFrame:CGRectZero];
    top.backgroundColor = WHITE;
    [self.view addSubview:top];
    
    self.typeBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"" andTitleColor:YAHEI andBackgroundImage:nil andImage:IMAGE(@"cartdown2") andTarget:self andAction:@selector(typeClick:) andType:UIButtonTypeCustom];
    [self.typeBtn setImage:IMAGE(@"cartup2") forState:UIControlStateSelected];
    [self.typeBtn setImagePosition:WPGraphicBtnTypeRight spacing:2];
    [top addSubview:self.typeBtn];
    
    UIButton *addbtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE(@"cartaddmoney") andTarget:self andAction:@selector(addmoneyClick) andType:UIButtonTypeCustom];
    [top addSubview:addbtn];
    
    self.pricelab = [Tools createLableWithFrame:CGRectZero andTitle:[NSString stringWithFormat:@"￥%.2f",[Person person].balance] andfont:FONT(13) andTitleColor:BUTTONCOLOR andBackgroundColor:CLEAR andTextAlignment:2];
    [top addSubview:self.pricelab];
    
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(NAV_HEIGHT);
        make.height.equalTo(@40);
    }];
    
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(top).offset(12);
        make.centerY.equalTo(top);
    }];
    
    [addbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.top.bottom.equalTo(top);
        make.width.equalTo(@40);
    }];
    
    [self.pricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(addbtn.mas_left).offset(-12);
        make.centerY.equalTo(top);
    }];

    self.bottomView = [[BuyLotBottomView alloc] init];
    
    self.hub = [[RKNotificationHub alloc]initWithView:self.bottomView.cartBtn.titleLabel];
    self.hub.hubcolor = [UIColor redColor];
    self.bottomView.cartBtn.titleLabel.clipsToBounds = NO;
    [self.hub moveCircleByX:50 Y:0];
    [self.view addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-SAFE_HEIGHT);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
    
    WS(weakSelf);
    self.bottomView.bottomClickBlock = ^(NSInteger type,UIButton* sender) {
        
        if (type == 1) { //清空
            
            if (self.selectModel.ID < 13) {
                
                [weakSelf.pc1 clear];
            }
            else {
                [weakSelf.pc2 clear];
            }
            
            [weakSelf getlotteryCount];
        }
        else if (type == 2) {//机选
            
            [weakSelf random];
        }
        else if (type == 3) {//玩法设置
            
            CartSetView *set = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CartSetView class]) owner:weakSelf options:nil]firstObject];
            
            set.SureCartSetBlock = ^(NSInteger pricetype, NSInteger times) {
                
                weakSelf.pricetype = pricetype;
                
                weakSelf.times = times;
                
                [weakSelf getlotteryCount];
                
                [weakSelf getmaxprice];
            };
            
            [set showWithtype:weakSelf.pricetype Withtimes:weakSelf.times];
        }
        else if (type == 4) { //加入购彩
            
            [weakSelf publishlotteryData:YES];
        }
        else if (type == 5) {//立即投注
            
            [weakSelf publishlotteryData:NO];
        }
        else { //购物篮
            
            if (self.cartArray.count == 0) {
                
                [MBProgressHUD showError:@"还没有彩票加入购彩篮"];
            }
            CartListCtrl *list = [[CartListCtrl alloc]init];
            list.dataSource = weakSelf.cartArray.mutableCopy;
            list.lottery_type = 5;
            list.lotteryId = weakSelf.lotteryId;
            list.updataArray = ^(NSArray *array) {
                
                [weakSelf.cartArray removeAllObjects];
                
                [weakSelf.cartArray addObjectsFromArray:array];
                
                weakSelf.hub.count = weakSelf.cartArray.count;
            };
            WEAKPUSH(list);
        }
    };

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.showhead == YES ? self.dataArray.count : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return section == 0 ? 58 : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 300;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return section == 0 ? self.headView : nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return self.footView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CartChongqinHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:RJHeaderIdentifier];
    
    PCHistoryModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.versionslab.text = [NSString stringWithFormat:@"%@期开奖结果:",model.issue];
    
    NSArray *numarray = [model.number componentsSeparatedByString:@","];
    
    for (UILabel *lab in cell.numberlabs) {
        
        if (lab.tag > 102) {
            
            lab.hidden = YES;
        }
        else {
            lab.hidden = NO;
            lab.text = numarray[lab.tag-100];
        }
    }
    
    return cell;
}






-(void)typeClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected ) {
        
        [self.typeView show:self.view Withtype:3 Withmodel:self.categoryArray];
    }
    else {
        [self.typeView dismiss];
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

-(void)showheadClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    self.showhead = sender.selected;
    
    [self.tableView reloadData];
}

- (SQMenuShowView *)showView{
    
    if (_showView) {
        return _showView;
    }
    
    _showView = [[SQMenuShowView alloc]initWithFrame:(CGRect){CGRectGetWidth(self.view.frame)-100-10,NAV_HEIGHT+5,100,0}
                                               items:@[@"遗漏",@"投注记录",@"在线客服",@"曲线图",@"免费推荐"]
                                           showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-25,10}];
    _showView.sq_backGroundColor = MAINCOLOR;
    _showView.itemTextColor = WHITE;
    [_showView selectBlock:^(SQMenuShowView *view, NSInteger index) {
        
        NSLog(@"点击第%ld个item",index+1);
        
        if (index == 1) {
            
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
            
            PCNumberTrendCtrl *trend = [[PCNumberTrendCtrl alloc]init];
            
            PUSH(trend);
        }
        else {
            
            PCFreeRecommendCtrl *recommend = [[PCFreeRecommendCtrl alloc]init];
            
            PUSH(recommend);
        }
    }];
    [self.view addSubview:_showView];
    return _showView;
}

#pragma mark - 获取购彩一级分类
-(void)getTypeRootData {
    
    [WebTools postWithURL:@"/lottery/queryFirstPlayByCateId.json" params:@{@"categoryId":@(self.categoryId)} success:^(BaseData *data) {
        
        self.categoryArray = [CartTypeModel mj_objectArrayWithKeyValuesArray:data.data];
        
        self.selectModel = self.categoryArray.firstObject;
        
        [self.typeBtn setTitle:self.selectModel.name forState:UIControlStateNormal];
        
        [self.typeBtn setImagePosition:WPGraphicBtnTypeRight spacing:2];
        
        self.selectModel.selected = YES;
        
        if (self.selectModel.ID < 13) {
            
            self.pc1.hidden = NO;
            self.pc1.alpha = 1;
            self.pc2.hidden = YES;
            self.pc2.alpha = 0;
            self.pc1.type = self.selectModel.ID;
        }
        else{
            self.pc1.hidden = YES;
            self.pc1.alpha = 0;
            self.pc2.hidden = NO;
            self.pc2.alpha = 1;
            self.pc2.type = self.selectModel.ID;
        }
        
        [self getquerymiss];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 获取直选遗漏
-(void)getquerymiss {
    
    [WebTools postWithURL:@"/lottery/querySelection.json" params:@{@"lotteryId":@(self.lotteryId),@"playId":@(self.selectModel.ID)} success:^(BaseData *data) {
        
        self.missmodel = [CartChongqinMissModel mj_objectWithKeyValues:data.data];
        
        [self getmaxprice];
  
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 获取历史开奖
-(void)inithistoryData {
    
    [WebTools postWithURL:@"/pceggSg/getSgHistoryList.json" params:@{@"pageNum":@1,@"pageSize":@5} success:^(BaseData *data) {
        
        self.dataArray = [PCHistoryModel mj_objectArrayWithKeyValuesArray:data.data];
        
        PCHistoryModel *firstmodel = [self.dataArray firstObject];
        
        self.headView.currentversionslab.text = firstmodel.issue;
        
        self.headView.waitinglab.hidden = YES;
        
        NSArray *numarray = [firstmodel.number componentsSeparatedByString:@","];
        
        for (UILabel *lab in self.headView.numberlabs) {
            
            if (lab.tag<103) {
                
                lab.text = numarray[lab.tag-100];
                
                lab.hidden = NO;
            }
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];

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
    
    [self inithistoryData];
    
    [self getnextissue];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(100 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self inithistoryData];
        
        [self getnextissue];
    });
   
}

//开始倒计时
-(void)timerLabel:(WB_Stopwatch*)timerlabel
       countingTo:(NSTimeInterval)time
        timertype:(WB_StopwatchLabelType)timerType {
    //    NSLog(@"time:%f",time);
    
}

-(void)dealloc {
    
    [self.stopwatch reset];
}

#pragma mark - 获取彩票下注注数
-(void)getlotteryCount {
    
//    self.bottomView.numlab.text = @"0";
    self.bottomView.pricelab.text = @"0.00";
    
    [[BuyTools tools] getpclotteryCountWith:self.selectModel With:self.pricetype With:self.times Withface:self.pc1.faceDataArray Withcolor:self.pc1.colorDataArray Withsame:self.pc1.sameDataArray Withnumber:self.pc2.numberDataArray success:^(NSString * _Nonnull cout, NSString * _Nonnull price) {
        
//        self.bottomView.numlab.text = cout;
        self.bottomView.pricelab.text = price;
    }];
    
   
}

#pragma mark - cart = no:立即购买/cart = yes:加入购彩篮，
-(void)publishlotteryData:(BOOL)cart {
    
//    if (self.bottomView.numlab.text.integerValue == 0) {
//        [MBProgressHUD showError:@"还没选择任何有效投注"];
//        return;
//    }
    
//    [[BuyTools tools] publishpclotteryData:cart With:self.selectModel With:self.missmodel With:self.pricetype With:self.times Withface:self.pc1.faceDataArray Withcolor:self.pc1.colorDataArray Withsame:self.pc1.sameDataArray Withnumber:self.pc2.numberDataArray Withcar:self.cartArray Withcount:self.bottomView.numlab.text.integerValue success:^(NSString * _Nonnull data, NSArray * _Nonnull dataArray) {
//
//        if (cart) {
//
//            if (self.selectModel.ID < 13) {
//
//                [self.pc1 clear];
//            }
//            else {
//                [self.pc2 clear];
//            }
//
//            [self getlotteryCount];
//
//            self.hub.count = self.cartArray.count;
//        }
//        else {
//
//            [self postDataWithnumber:data Withcount:self.bottomView.numlab.text.integerValue Withdic:dataArray];
//        }
//
//    }];
    
    [[BuyTools tools] publishpclotteryData:cart With:self.selectModel With:self.missmodel With:self.pricetype With:self.times Withface:self.pc1.faceDataArray Withcolor:self.pc1.colorDataArray Withsame:self.pc1.sameDataArray Withnumber:self.pc2.numberDataArray Withcar:self.cartArray Withcount:0 success:^(NSString * _Nonnull data, NSArray * _Nonnull dataArray) {
        
        if (cart) {
            
            if (self.selectModel.ID < 13) {
                
                [self.pc1 clear];
            }
            else {
                [self.pc2 clear];
            }
            
            [self getlotteryCount];
            
            self.hub.count = self.cartArray.count;
        }
        else {
            
            [self postDataWithnumber:data Withcount:0 Withdic:dataArray];
        }
        
    }];
   
}

#pragma mark - 请求数据
-(void)postDataWithnumber:(NSString *)str Withcount:(NSInteger)count Withdic:(NSArray *)listarray{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:self.headView.nextversionslab.text forKey:@"issue"];
    [dic setValue:@(self.lotteryId) forKey:@"lotteryId"];
    [dic setValue:[Person person].uid forKey:@"userId"];
    
    if (str.length) {
        NSMutableArray *betlist = [[NSMutableArray alloc]init];
        NSMutableDictionary *listdic = [[NSMutableDictionary alloc]init];
        [listdic setValue:@(self.selectModel.ID) forKey:@"playId"];
        [listdic setValue:self.missmodel.play[@"settingId"] forKey:@"settingId"];
        [listdic setValue:@(count) forKey:@"betCount"];
        
        [listdic setValue:str forKey:@"betNumber"];
        CGFloat amount = self.times * [Tools lotteryprice:self.pricetype] * count;
        [listdic setValue:[NSNumber numberWithFloat:amount] forKey:@"betAmount"];
        [betlist addObject:listdic];
        [dic setValue:betlist forKey:@"orderBetList"];
    }
    else{
        [dic setValue:listarray forKey:@"orderBetList"];
    }
    
    [WebTools postWithURL:@"/order/orderBet.json" params:dic success:^(BaseData *data) {
        
        [MBProgressHUD showSuccess:data.info];
    
        [Person person].balance = [Person person].balance - self.bottomView.pricelab.text.floatValue;
        
        self.pricelab.text = [NSString stringWithFormat:@"￥%.2f",[Person person].balance];
        
        if (self.selectModel.ID < 13) {
            
            [self.pc1 clear];
        }
        else {
            [self.pc2 clear];
        }
        
        [self getlotteryCount];
        
    } failure:^(NSError *error) {
        
    }];
}

-(NSDictionary *)getlistdicWithcount:(NSInteger)count Withnumber:(NSString *)str {
    
    NSMutableDictionary *listdic = [[NSMutableDictionary alloc]init];
    [listdic setValue:@(self.selectModel.ID) forKey:@"playId"];
    [listdic setValue:self.missmodel.play[@"settingId"] forKey:@"settingId"];
    [listdic setValue:@(count) forKey:@"betCount"];
    [listdic setValue:str forKey:@"betNumber"];
    CGFloat amount = self.times * [Tools lotteryprice:self.pricetype] * count;
    [listdic setValue:[NSNumber numberWithFloat:amount] forKey:@"betAmount"];
    
    return listdic;
}

#pragma mark - 最高可中
-(void)getmaxprice {
    
    CGFloat price = [Tools lotteryprice:self.pricetype] * self.times * [self.missmodel.play[@"odds"]floatValue];
    self.bottomView.maxpricelab.text = [NSString stringWithFormat:@"最高可中%.2f元",price];
    
}

-(NSMutableArray *)cartArray {
    
    if (!_cartArray) {
        
        _cartArray = [[NSMutableArray alloc]init];
    }
    return _cartArray;
}

#pragma mark - ShakeToEdit 摇动手机之后的回调方法
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ([UIApplication sharedApplication].applicationSupportsShakeToEdit == NO) {
        
        return;
    }
    //检测到摇动开始
    if (motion == UIEventSubtypeMotionShake)
    {
        // your code
        NSLog(@"检测到摇动开始");
        
    }
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ([UIApplication sharedApplication].applicationSupportsShakeToEdit == NO) {
        
        return;
    }
    //摇动取消
    NSLog(@"摇动取消");
    
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ([UIApplication sharedApplication].applicationSupportsShakeToEdit == NO) {
        
        return;
    }
    //摇动结束
    if (event.subtype == UIEventSubtypeMotionShake)
    {
        // your code
        NSLog(@"摇动结束");
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        [self random];
    }
}

-(void)random {
    
    if (self.selectModel.ID < 13) {
        
        [self.pc1 clear];
        
        [self.pc1 random];
    }
    else {
        [self.pc2 clear];
        
        [self.pc2 random];
    }
    
    [self getlotteryCount];
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
