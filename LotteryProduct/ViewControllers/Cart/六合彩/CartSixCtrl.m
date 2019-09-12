//
//  CartSixCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartSixCtrl.h"
#import "CartSixBallView.h"
#import "CartSixBlockView.h"
#import "CartSixHeadView.h"
#import "IGKbetSixCell.h"
#import "CartTypeView.h"
#import "SQMenuShowView.h"
#import "IGKbetListCtrl.h"
#import "CartSetView.h"
#import "CartListCtrl.h"
#import "CartSixCell.h"
#import "CartSixModel.h"
#import "ZodiacModel.h"
#import "BettingRecordViewController.h"
#import "SixRecommendCtrl.h"
#import "TemaHistoryCtrl.h"
#import "PCInfoModel.h"
#import "CartOddsModel.h"
#import "TopUpViewController.h"
#import "LoginAlertViewController.h"
#import "KeFuViewController.h"
#import "BuyLotBottomView.h"

@interface CartSixCtrl ()<WB_StopWatchDelegate>

@property (nonatomic, strong) CartSixHeadView *headView;

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
 展示单元格，YES展示列表，隐藏表尾，NO收回列表，展示表尾
 */
@property (nonatomic, assign) BOOL showcell;

/**
 选择不同选号方式展示不同列表
 1：特码A-------------- 297
 2：特码B-------------- 313
 3：正码A--------------298
 4：正码B--------------321
 5：正码1-6------------299
 6：正特1--------------300
 7：正特2--------------328
 8：正特3--------------330
 9：正特4--------------332
 10：正特5-------------333
 11：正特6-------------334
 12：三全中-------------343
 13：三中二-------------345
 14：二全中-------------372
 15：二中特-------------346
 16：特串---------------301
 17：红波、蓝波、绿波-----302
 18：全尾--------------  303
 19：特尾--------------  341
 20：五不中 ------342
 21：六不中--------347
 22：七不中--------348
 23：八不中---------349
 24：九不中---------350
 25：十不中---------351
 26：平特-----------305
 27：特肖-----------306
 28：六肖连中--------352
 29：六肖连不中------353
 30：二连肖（中）-----360
 31：二连肖（不中）----361
 32：三连肖（中）------362
 33：三连肖（不中）-----363
 34：四连肖（中）------364
 35：四连肖（不中）-----365
 36：二连尾（中）-------366
 37：二连尾（不中）------367
 38：三连尾（中）-------368
 39：三连尾（不中）------369
 40：四连尾（中）-------370
 41：四连尾（不中）------371
 42：1-6龙虎----------- 310
 43：五行-------------311
 */
@property (nonatomic, strong) CartTypeModel *selectModel;

@property (nonatomic, strong) NSArray *categoryArray;

@property (nonatomic, strong) CartSixBallView *ballView;
/**
 表尾球数字1-49数据集
 */
@property (nonatomic, strong) NSMutableArray *ballDataArray;

@property (nonatomic, strong) CartSixBlockView *blockView;
/**
 表尾块单双大小龙虎数据集
 */
@property (nonatomic, strong) NSMutableArray *blockDataArray;

@property (nonatomic, strong) CartSixBlockView *blockView2;
/**
 表尾块单双大小龙虎数据集
 */
@property (nonatomic, strong) NSMutableArray *block2DataArray;

@property (nonatomic, assign) CGFloat foot_height;

/**
 200：红波
 201：蓝波
 202：绿波
 */
@property (nonatomic, assign) NSInteger color_type;
/**
 300-305:正码1~6
 */
@property (nonatomic, assign) NSInteger zhengma_type;

@property (nonatomic, strong) WB_Stopwatch *stopwatch;

/**
 玩法设置模式
 */
@property (nonatomic, assign) NSInteger pricetype;
/**
 玩法设置倍数
 */
@property (nonatomic, assign) NSInteger times;

/**
 加入购彩篮集合
 */
@property (nonatomic, strong) NSMutableArray *cartArray;

@property (nonatomic, strong) RKNotificationHub *hub;
/**
 赔率数组集合
 */
@property (nonatomic, strong) NSArray<CartOddsModel *> *oddsArray;

@end

@implementation CartSixCtrl

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.typeView dismiss];
    
    self.typeView = nil;
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_xglhc" object:nil];
    
}

-(void)removenotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xglhc" object:nil];
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CartSixCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"IGKbetSixCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJHeaderIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT+40, 0, SAFE_HEIGHT + 100,0 ));
    }];
    
    self.color_type = 200;
    
    self.zhengma_type = 300;
    
    self.pricetype = 3;
    
    self.times = 1;

    [self buildtopandfootView];
    
    [self getTypeRootData];
    
    [self setshake];
    
}

-(NSMutableArray *)ballDataArray {
    
    if (!_ballDataArray) {
        
        _ballDataArray = [[NSMutableArray alloc]init];
    }
    return _ballDataArray;
}

-(NSMutableArray *)blockDataArray {
    
    if (!_blockDataArray) {
        
        _blockDataArray = [[NSMutableArray alloc]init];
    }
    return _blockDataArray;
}

-(NSMutableArray *)block2DataArray {
    
    if (!_block2DataArray) {
        
        _block2DataArray = [[NSMutableArray alloc]init];
    }
    return _block2DataArray;
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
            
            weakSelf.typeBtn.selected = NO;
            
            [weakSelf.typeBtn setImagePosition:WPGraphicBtnTypeRight spacing:2];
            
            weakSelf.selectModel = model;
            
            [weakSelf getsixUIData];
        };
    }
    return _typeView;
}

-(CartSixHeadView *)headView {
    
    if (!_headView) {
        @weakify(self)

        _headView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CartSixHeadView class]) owner:self options:nil]firstObject];
        
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 121);
        self.stopwatch = [[WB_Stopwatch alloc]initWithLabel:_headView.endtimelab andTimerType:WBTypeTimer];
        self.stopwatch.delegate = self;
        [self.stopwatch setTimeFormat:@"dd天HH时mm分ss秒"];
        _headView.lookallBlock = ^{
            @strongify(self)
            IGKbetListCtrl *list = [[IGKbetListCtrl alloc]init];
            list.lottery_type = 4;
            list.titlestring = @"六合彩";
            PUSH(list);
        };
    }
    return _headView;
}

-(CartSixBallView *)ballView {
    
    if (!_ballView) {
        
        _ballView = [[CartSixBallView alloc]init];
        @weakify(self)
        _ballView.refreshpriceBlock = ^{
            @strongify(self)
            [self getlotteryCount];
        };
    }
    return _ballView;
}

-(CartSixBlockView *)blockView {
    
    if (!_blockView) {
        
        _blockView = [[CartSixBlockView alloc]init];
        @weakify(self)
        _blockView.refreshpriceBlock = ^{
            @strongify(self)
            [self getlotteryCount];
        };
    }
    return _blockView;
}

-(CartSixBlockView *)blockView2 {
    
    if (!_blockView2) {
        
        _blockView2 = [[CartSixBlockView alloc]init];
        @weakify(self)
        _blockView2.refreshpriceBlock = ^{
            @strongify(self)
            [self getlotteryCount];
        };
    }
    return _blockView2;
}

-(UIView *)footView {
    
    if (!_footView) {
        
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        
        _footView.backgroundColor = WHITE;
        
    }
    
    return _footView;
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
    
    
    @weakify(self)
    self.bottomView.bottomClickBlock = ^(NSInteger type,UIButton *sender) {
        
        if (type == 1) { //清空
            @strongify(self)
            [self clearUI];
            
            [self getlotteryCount];
        }
         /*
         1：特码A-------------- 297
         2：特码B-------------- 313
         3：正码A--------------298
         4：正码B--------------321
         */
        else if (type == 2) {//机选
            @strongify(self)

            [self random];
            
        }
        else if (type == 3) {//玩法设置
            @strongify(self)
            CartSetView *set = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CartSetView class]) owner:self options:nil]firstObject];

            set.SureCartSetBlock = ^(NSInteger pricetype, NSInteger times) {
                @strongify(self)
                self.pricetype = pricetype;
                
                self.times = times;
                
                [self getlotteryCount];
            };
            [set showWithtype:self.pricetype Withtimes:self.times];
        }
        else if (type == 4) { //加入购彩
            @strongify(self)

            [self publishlotteryData:YES];
        }
        else if (type == 5) {//立即投注
            @strongify(self)

            [self publishlotteryData:NO];
        }
        else { //购物篮
            
            if (self.cartArray.count == 0) {
                
                [MBProgressHUD showError:@"还没有彩票加入购彩篮"];
            }
            @strongify(self)
            CartListCtrl *list = [[CartListCtrl alloc]init];
            list.dataSource = self.cartArray.mutableCopy;
            list.lotteryId = self.lotteryId;
            list.lottery_type = 4;
            list.updataArray = ^(NSArray *array) {
                @strongify(self)

                [self.cartArray removeAllObjects];
                
                [self.cartArray addObjectsFromArray:array];
                
                self.hub.count = self.cartArray.count;
            };
            PUSH(list);
        }
    };

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.showhead == YES ? self.dataArray.count : 0;
    }
    else {
        
        return self.dataSource.count;

    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return section == 0 ? 121 : self.showcell == YES ? self.selectModel.ID == 302 ? 60 : 25 : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return section == 0 ? 24 : self.foot_height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.section == 0 ? 103 : 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.headView;
    }
    else {
        
        UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        head.backgroundColor = [UIColor whiteColor];
        
        if (self.selectModel.ID == 302) {
            
            NSArray *array = @[@"红波",@"蓝波",@"绿波"];
            for (int i = 0; i< array.count; i++) {
                
                UIButton *btn = [Tools createButtonWithFrame:CGRectMake(SCREEN_WIDTH/array.count *i, 0, SCREEN_WIDTH/array.count, 35) andTitle:array[i] andTitleColor:[UIColor darkGrayColor] andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(selectcolorClick:) andType:UIButtonTypeCustom];
                btn.tag = 200 + i;
                btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
                [btn setTitleColor:BUTTONCOLOR forState:UIControlStateSelected];
                [head addSubview:btn];
                
                if (self.color_type == btn.tag) {
                    
                    btn.selected = YES;
                }
            }
        }
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = BUTTONCOLOR;
        [head addSubview:line];
        
        UILabel *titlelab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(15) andTitleColor:BUTTONCOLOR andBackgroundColor:CLEAR andTextAlignment:0];
        [head addSubview:titlelab];
        
        if (self.selectModel.ID == 302) {
            
            titlelab.text = self.color_type == 200 ? @"红波" : self.color_type == 201 ? @"蓝波" : @"绿波";
        }
        else {
            titlelab.text = self.typeBtn.titleLabel.text;
        }
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE(@"PCdandanwenhao") andTarget:self andAction:@selector(cartinfoClick) andType:UIButtonTypeCustom];
        [head addSubview:btn];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(head);
            make.top.equalTo(head).offset(self.selectModel.ID == 302 ? 40 : 5);
            make.size.mas_equalTo(CGSizeMake(2, 15));
        }];
        
        [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(line.mas_right).offset(12);
            make.centerY.equalTo(line);
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(titlelab.mas_right).offset(12);
            make.centerY.equalTo(line);
        }];
        
        return head;
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        
        UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 24)];
        footview.backgroundColor = WHITE;
        
        UIView *colorview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,16)];
        colorview.backgroundColor = [UIColor colorWithHex:@"F8E8CC"];
        [footview addSubview:colorview];
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectMake(0, 0, 24, 24) andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE(@"cartdown1") andTarget:self andAction:@selector(showheadClick:) andType:UIButtonTypeCustom];
        [btn setImage:IMAGE(@"cartup1") forState:UIControlStateSelected];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, -4, 0)];
        btn.backgroundColor = [UIColor colorWithHex:@"F8E8CC"];
        btn.selected = self.showhead;
        btn.layer.cornerRadius = 12;
        [footview addSubview:btn];
        btn.center = footview.center;
        return footview;
    }
    else {
        return self.footView;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        IGKbetSixCell *cell = [tableView dequeueReusableCellWithIdentifier:RJHeaderIdentifier];
        
        cell.nextimgv.hidden = YES;
        
        cell.versionslab.hidden = YES;
        
        cell.subtitlelab.hidden = NO;
        
        cell.contentView.backgroundColor = [UIColor colorWithHex:@"F8E8CC"];
        
        SixInfoModel *model = [self.dataArray objectAtIndex:indexPath.row];
        NSArray * numberArry = [model.number componentsSeparatedByString:@","];
        NSArray * shengxiaoArry = [model.shengxiao componentsSeparatedByString:@","];

        for (int i = 0; i< 7; i++) {
            
            NSString *number = numberArry[i];
            NSString *shengxiao = shengxiaoArry[i];
            NSString *wuxin = [Tools numbertowuxin:number];
            
            UIButton *btn = cell.numberBtns[i];
            UILabel  *lab = cell.numberlabs[i];
            
            lab.text = [NSString stringWithFormat:@"%@/%@",shengxiao,wuxin];
            [btn setTitle:number forState:UIControlStateNormal];
            [btn setBackgroundImage:[Tools numbertoimage:number Withselect:NO] forState:UIControlStateNormal];
        }
        
        cell.subtitlelab.text = [NSString stringWithFormat:@"%@期:",model.issue];
//        cell.subtitlelab.textColor = [UIColor colorWithHex:@"999999"];
        
        return cell;
    }
    else {
        
        CartSixCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
        
        CartSixModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        NSString *yearinfo = [Tools getChineseYearWithDate:[NSDate date]];
        
        NSString *sx = [yearinfo componentsSeparatedByString:@","].lastObject; //今年生肖
        
        if ([model.odds containsString:@"/"]) {
            
            NSArray *odds = [model.odds componentsSeparatedByString:@"/"];
            
            if ([model.title isEqualToString:sx]) {
                
                model.odds = odds.lastObject;
            }
            else{
                model.odds = odds.firstObject;
            }
        }
        
        [cell.blockBtn setTitle:model.title forState:UIControlStateNormal];
        
        cell.Oddslab.text = model.odds;
        
        for (UIButton *btn in cell.numberBtns) {
            
            btn.hidden = YES;
        }
        for (int i = 0; i< model.array.count; i++) {
            
            UIButton *btn = [cell.contentView viewWithTag:100+i];
            
            btn.hidden = NO;
            
            [btn setTitle:model.array[i] forState:UIControlStateNormal];
            
            [btn setBackgroundImage:[Tools numbertoimage:model.array[i] Withselect:NO] forState:UIControlStateNormal];
            
            [btn setBackgroundImage:[Tools numbertoimage:model.array[i] Withselect:YES] forState:UIControlStateSelected];
        }
        
        cell.blockBtn.selected = model.select;
        
        cell.cartsixBlock = ^(UIButton *sender) {
            
            model.select = sender.selected;
            
            [self getlotteryCount];
            
            [self.tableView reloadData];
        };
        
        return cell;
    }
}


-(void)typeClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected ) {
        
        [self.typeView show:self.view Withtype:4 Withmodel:self.categoryArray];
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
                                               items:@[@"遗漏",@"投注记录",@"在线客服",@"水心推荐",@"正码历史",@"特码历史"]
                                           showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-25,10}];
    _showView.sq_backGroundColor = MAINCOLOR;
    _showView.itemTextColor = WHITE;
    __weak typeof(self) weakSelf = self;
    [_showView selectBlock:^(SQMenuShowView *view, NSInteger index) {
        
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
            
            SixRecommendCtrl *recommend = [[SixRecommendCtrl alloc]init];
            
            PUSH(recommend);
        }
        else if (index == 4) {
            
            TemaHistoryCtrl *tema = [[TemaHistoryCtrl alloc]initWithNibName:NSStringFromClass([TemaHistoryCtrl class]) bundle:[NSBundle mainBundle]];
            tema.type = 622;
            PUSH(tema);
        }
        else {
            TemaHistoryCtrl *tema = [[TemaHistoryCtrl alloc]initWithNibName:NSStringFromClass([TemaHistoryCtrl class]) bundle:[NSBundle mainBundle]];
            tema.type = 621;
            PUSH(tema);
        }
    }];
    [_showView setShowmissBlock:^(BOOL showmiss) {
        
        [weakSelf.tableView reloadData];
    }];
    [self.view addSubview:_showView];
    return _showView;
}

-(void)addsubviewtofootview {
    
    for (id view in self.footView.subviews) {
        
        [view removeFromSuperview];
    }
    [self.dataSource removeAllObjects];
    [self.ballDataArray removeAllObjects];
    [self.block2DataArray removeAllObjects];
    [self.blockDataArray removeAllObjects];
    self.ballView = nil;
    self.blockView = nil;
    self.blockView2 = nil;
    self.showcell = NO;
    [self getlotteryCount];
    WS(weakSelf);
    /*
     1：特码A-------------- 297
     2：特码B-------------- 313
     */
    self.ballView.selectModel = self.selectModel;
    if (self.selectModel.ID == 297 || self.selectModel.ID == 313) {
        
        self.ballView.titlelab.text = self.oddsArray.firstObject.name;
        
        self.ballView.segment.selectedSegmentIndex = -1;
        self.ballView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/4*0.85*13);
        [self reloadBallviewData];
        self.blockView.titlelab.text = self.oddsArray.lastObject.name;
        CGFloat itemHeight = (SCREEN_WIDTH - 1 * (3 + 1)) / 3 * 0.65 * 7 + 40;
        self.blockView.frame = CGRectMake(0, CGRectGetHeight(self.ballView.bounds), SCREEN_WIDTH, itemHeight);
        NSArray *titeleArray = @[@[@"1-10",@"11-20",@"21-30",@"31-40",@"41-49"],@[@"单",@"双",@"大",@"小",@"合单",@"合双"],@[@"家禽",@"野兽"],@[@"尾大",@"尾小"],@[@"红波",@"蓝波",@"绿波"]];
        
        [self reloadBlockviewData:titeleArray];
        
        [self.footView addSubview:self.ballView];
        [self.footView addSubview:self.blockView];
        self.foot_height = self.blockView.y + self.blockView.height;
        
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.foot_height);
        
        self.ballView.cartInfoBlock = ^{
            
            [weakSelf showalert:1];
        };
        self.blockView.cartInfoBlock = ^{
            
            [weakSelf showalert:2];
        };
       
    }
    /*
     3：正码A--------------298
     4：正码B--------------321
     */
    else if (self.selectModel.ID == 298 || self.selectModel.ID == 321) {
        
        self.ballView.titlelab.text = self.oddsArray.firstObject.name;
        self.ballView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/4*0.85*13);
        self.ballView.segment.selectedSegmentIndex = -1;
        [self reloadBallviewData];
        self.blockView.titlelab.text = self.oddsArray.lastObject.name;
        CGFloat itemHeight = (SCREEN_WIDTH - 1 * (3 + 1)) / 3 * 0.65 * 3 + 40;
        self.blockView.frame = CGRectMake(0, CGRectGetHeight(self.ballView.bounds), SCREEN_WIDTH, itemHeight);
        NSArray *titeleArray = @[@[@"总单",@"总双",@"总大",@"总小",@"总尾大",@"总尾小",@"龙",@"虎"]];
        [self reloadBlockviewData:titeleArray];

        [self.footView addSubview:self.ballView];
        [self.footView addSubview:self.blockView];
        self.foot_height = self.blockView.y + self.blockView.height;
        
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.foot_height);
        
        self.ballView.cartInfoBlock = ^{
            
            [weakSelf showalert:3];
        };
        self.blockView.cartInfoBlock = ^{
            
            [weakSelf showalert:4];
        };
    }
    //5：正码1-6------------299
    else if (self.selectModel.ID == 299) {
        
        NSArray *array = @[@"正码一",@"正码二",@"正码三",@"正码四",@"正码五",@"正码六"];
        for (int i = 0; i< array.count; i++) {
            
            UIButton *btn = [Tools createButtonWithFrame:CGRectMake(SCREEN_WIDTH/array.count *i, 0, SCREEN_WIDTH/array.count, 35) andTitle:array[i] andTitleColor:[UIColor darkGrayColor] andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(selectzhengmaClick:) andType:UIButtonTypeCustom];
            btn.tag = 200 + i;
            btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [btn setTitleColor:BUTTONCOLOR forState:UIControlStateSelected];
            if (i == 0) {
                
                [self selectzhengmaClick:btn];
            }
            [self.footView addSubview:btn];
        }
        
        self.blockView.titlelab.text = @"正码一";
        CGFloat itemHeight = (SCREEN_WIDTH - 1 * (3 + 1)) / 3 * 0.65 * 4 + 40;
        
        self.blockView.frame = CGRectMake(0, 35, SCREEN_WIDTH, itemHeight);
        NSArray *titeleArray = @[@[@"大",@"小",@"单",@"双",@"合单",@"合双",@"红波",@"蓝波",@"绿波",@"尾大",@"尾小"]];
        [self reloadBlockviewData:titeleArray];
        [self.footView addSubview:self.blockView];
        self.foot_height = self.blockView.y + self.blockView.height;
        
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.foot_height);
        
    }
    /*
     6：正特1--------------300
     7：正特2--------------328
     8：正特3--------------330
     9：正特4--------------332
     10：正特5-------------333
     11：正特6-------------334
     */
    else if (self.selectModel.ID == 300 || (self.selectModel.ID == 328 || self.selectModel.ID == 330 || self.selectModel.ID == 332 || self.selectModel.ID == 333 || self.selectModel.ID == 334)) {
        
        self.ballView.titlelab.text = self.oddsArray.firstObject.name;
        self.ballView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/4*0.85*13);
        self.ballView.segment.selectedSegmentIndex = -1;
        [self reloadBallviewData];
        
        self.blockView.titlelab.text = self.oddsArray.lastObject.name;
        CGFloat itemHeight = (SCREEN_WIDTH - 1 * (3 + 1)) / 3 * 0.65 * 4 + 40;
        self.blockView.frame = CGRectMake(0, CGRectGetHeight(self.ballView.bounds), SCREEN_WIDTH, itemHeight);
        NSArray *titeleArray = @[@[@"大",@"小",@"单",@"双",@"合单",@"合双",@"红波",@"蓝波",@"绿波",@"尾大",@"尾小"]];
        [self reloadBlockviewData:titeleArray];
        [self.footView addSubview:self.ballView];
        [self.footView addSubview:self.blockView];
        self.foot_height = self.blockView.y + self.blockView.height;
        
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.foot_height);
        
        self.ballView.cartInfoBlock = ^{
            //11,12,13,14,15,16
            [weakSelf showalert:self.selectModel.ID == 300 ? 11 : self.selectModel.ID == 328 ? 12 : self.selectModel.ID == 330 ? 13 : self.selectModel.ID == 332 ? 14 : self.selectModel.ID == 333 ? 15 : 16];
        };
        self.blockView.cartInfoBlock = ^{
            //5,6,7,8,9,10
            [weakSelf showalert:self.selectModel.ID == 300 ? 5 : self.selectModel.ID == 328 ? 6 : self.selectModel.ID == 330 ? 7 : self.selectModel.ID == 332 ? 8 : self.selectModel.ID == 333 ? 9 : 10];
        };
    }
    /*
     12：三全中-------------343
     13：三中二-------------345
     14：二全中-------------372
     15：二中特-------------346
     16：特串---------------301
     */
    else if (self.selectModel.ID == 343 || self.selectModel.ID == 345 || self.selectModel.ID == 346 || self.selectModel.ID == 372 || self.selectModel.ID == 301) {
        
        self.ballView.titlelab.text =self.oddsArray.firstObject.name;
        self.ballView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/4*0.85*13);
        self.ballView.segment.selectedSegmentIndex = -1;
        [self reloadBallviewData];
        [self.footView addSubview:self.ballView];
        self.foot_height = self.ballView.y + self.ballView.height;
        
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.foot_height);
        
        self.ballView.cartInfoBlock = ^{
            //17,18,19,20,21
            [weakSelf showalert:self.selectModel.ID == 343 ? 17 : self.selectModel.ID == 345 ? 18 : self.selectModel.ID == 346 ? 20 : self.selectModel.ID == 372 ? 19 : 21];
        };
    }
    /*
     17：红波、蓝波、绿波-----302
     18：全尾-------------- 303
     19：特尾-------------- 341
     */
    else if (self.selectModel.ID == 302 || self.selectModel.ID == 303 || self.selectModel.ID == 341) {
        
        self.showcell = YES;
        self.foot_height = self.ballView.y + self.ballView.height;
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.foot_height);
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CartSixData" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
        if (self.selectModel.ID == 302){
            
            for (CartOddsModel *model in self.oddsArray) {
                
                if (model.ID == 324) {
                    
                    NSArray *array = [CartSixModel mj_objectArrayWithKeyValuesArray:[dic valueForKey:model.name]];
                    
                    for (CartSixModel *sixmodel in array) {
                        
                        for (OddsList *list in model.oddsList) {
                            
                            if ([sixmodel.title isEqualToString:list.name]) {
                                
                                sixmodel.odds = list.odds;
                                
                                [self.dataSource addObject:sixmodel];
                            }
                        }
                    }
                }
                
            }
            
            
        }
        else {
            
            NSArray *array = [CartSixModel mj_objectArrayWithKeyValuesArray:[dic valueForKey:[NSString stringWithFormat:@"%ld",(long)self.selectModel.ID]]];
            
            CartOddsModel *model = self.oddsArray.firstObject;
            
            for (CartSixModel *sixmodel in array) {
                
                NSInteger index = [[sixmodel.title substringToIndex:1]integerValue];
                
                for (OddsList *list in model.oddsList) {
                    
                    if (list.name.integerValue == index) {
                        
                        sixmodel.odds = list.odds;
                        
                        [self.dataSource addObject:sixmodel];
                    }
                }
            }
        }
    }
    /*
     20：五不中 ------342
     21：六不中--------347
     22：七不中--------348
     23：八不中---------349
     24：九不中---------350
     25：十不中---------351
     */
    else if ((self.selectModel.ID >= 347 && self.selectModel.ID <= 351) || self.selectModel.ID == 342) {
        
        self.ballView.titlelab.text = self.oddsArray.firstObject.name;
        self.ballView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/4*0.85*13);
        self.ballView.segment.selectedSegmentIndex = -1;
        [self reloadBallviewData];
        [self.footView addSubview:self.ballView];
        self.foot_height = self.ballView.y + self.ballView.height;
        
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.foot_height);
        
        self.ballView.cartInfoBlock = ^{
            //27,28,29,30,31,32
            [weakSelf showalert:self.selectModel.ID == 342 ? 27 : self.selectModel.ID == 347 ? 28 : self.selectModel.ID == 348 ? 29 : self.selectModel.ID == 349 ? 30 : self.selectModel.ID == 350 ? 31 : 32];
        };
    }
    /*
     26：平特-----------305
     27：特肖-----------306
     28：六肖连中--------352
     29：六肖连不中------353
     30：二连肖（中）-----360
     31：二连肖（不中）----361
     32：三连肖（中）------362
     33：三连肖（不中）-----363
     34：四连肖（中）------364
     35：四连肖（不中）-----365
     
     */
    else if ((self.selectModel.ID >=360 && self.selectModel.ID <= 365) || self.selectModel.ID == 305 || self.selectModel.ID == 306 || self.selectModel.ID == 352 || self.selectModel.ID == 353) {
        
        self.showcell = YES;
        self.foot_height = self.ballView.y + self.ballView.height;
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.foot_height);
        
        ZodiacModel *zo = [[ZodiacModel alloc]init];
        
        CartOddsModel *model = self.oddsArray.firstObject;
        
        NSArray *zoarr = [zo getnumber:model];
        
        NSArray *array = [CartSixModel mj_objectArrayWithKeyValuesArray:zoarr];
        
        [self.dataSource addObjectsFromArray:array];
    }
    /*
     36：二连尾（中）-------366
     37：二连尾（不中）------367
     38：三连尾（中）-------368
     39：三连尾（不中）------369
     40：四连尾（中）-------370
     41：四连尾（不中）------371
     */
    else if (self.selectModel.ID >=366 && self.selectModel.ID <= 371) {
        
        self.showcell = YES;
        self.foot_height = self.ballView.y + self.ballView.height;
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.foot_height);
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CartSixData" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        NSArray *array = [CartSixModel mj_objectArrayWithKeyValuesArray:[dic valueForKey:[NSString stringWithFormat:@"%ld",(long)self.selectModel.ID]]];
        
        CartOddsModel *model = self.oddsArray.firstObject;
        
        OddsList *list = model.oddsList.firstObject;
        
        for (CartSixModel *sixmodel in array) {
            
            sixmodel.odds = list.odds;
            
            [self.dataSource addObject:sixmodel];
        }
        
//        [self.dataSource addObjectsFromArray:array];
    }
    //42：1-6龙虎----------- 310
    else if (self.selectModel.ID == 310) {
        
        self.blockView.titlelab.text = @"龙";
        CGFloat itemHeight = (SCREEN_WIDTH - 1 * (3 + 1)) / 3 * 0.65 * 5 + 40;
        self.blockView.frame = CGRectMake(0, 0, SCREEN_WIDTH, itemHeight);
        NSArray *titeleArray = @[@[@"1-2球",@"1-3球",@"1-4球",@"1-5球",@"1-6球",@"2-3球",@"2-4球",@"2-5球",@"2-6球",@"3-4球",@"3-5球",@"3-6球",@"4-5球",@"4-6球",@"5-6球"]];
        [self reloadBlockviewData:titeleArray];
        
        CartOddsModel *model = self.oddsArray.firstObject;
        OddsList *list = model.oddsList.firstObject;
        self.blockView2.titlelab.text = @"虎";
        self.blockView2.frame = CGRectMake(0, CGRectGetHeight(self.blockView.bounds), SCREEN_WIDTH, SCREEN_WIDTH/3*0.7*5);
        for (NSArray *array in titeleArray) {
            
            NSMutableArray *marray = [[NSMutableArray alloc]init];
            
            for (NSString *str in array) {
                
                CartSixModel *sixmodel = [[CartSixModel alloc]init];
                sixmodel.number = str;
                sixmodel.odds = list.odds;
                
                [marray addObject:sixmodel];
            }
            
            [self.block2DataArray addObject:marray];
        }
        self.blockView2.titeleArray = self.block2DataArray;
        
        [self.footView addSubview:self.blockView2];
        [self.footView addSubview:self.blockView];
        self.foot_height = self.blockView2.y + self.blockView2.height;
        
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.foot_height);
        
        self.blockView.cartInfoBlock = ^{
            
            [weakSelf showalert:49];
        };
        self.blockView2.cartInfoBlock = ^{
            
            [weakSelf showalert:49];
        };
    }
    else {// 五行
        
        self.showcell = YES;
        self.foot_height = self.ballView.y + self.ballView.height;
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.foot_height);
        
        NSArray *array = [CartSixModel mj_objectArrayWithKeyValuesArray:[Tools getwuxin]];
        
        CartOddsModel *model = self.oddsArray.firstObject;
        OddsList *list = model.oddsList.firstObject;
        for (CartSixModel *sixmodel in array) {
            
            sixmodel.odds = list.odds;
            
            [self.dataSource addObject:sixmodel];
        }
    }
   
     [self.tableView reloadData];
    
}

#pragma mark - 创建球UI的数据模型
-(void)reloadBallviewData {
    
    for (int i = 0; i<49 ;i++) {
        
        CartOddsModel *odds = self.oddsArray.firstObject;
        CartSixModel *model = [[CartSixModel alloc]init];
        model.number = [NSString stringWithFormat:@"%02ld",(long)i+1];
        model.odds = odds.oddsList.firstObject.odds;
        [self.ballDataArray addObject:model];
    }
    self.ballView.array = self.ballDataArray;
}

#pragma mark - 创建块UI的数据模型
-(void)reloadBlockviewData:(NSArray *)titeleArray {
    
    CartOddsModel *odds = self.oddsArray.lastObject;
    for (NSArray *array in titeleArray) {
        
        NSMutableArray *marray = [[NSMutableArray alloc]init];
        
        for (NSString *str in array) {
            
            if (odds.oddsList.count == 1) {
                
                OddsList *list = odds.oddsList.firstObject;
                CartSixModel *model = [[CartSixModel alloc]init];
                model.number = str;
                model.odds = list.odds;
                
                [marray addObject:model];
            }
            else {
                for (OddsList *list in odds.oddsList) {
                    
                    if ([str isEqualToString:list.name]) {
                        
                        CartSixModel *model = [[CartSixModel alloc]init];
                        model.number = str;
                        model.odds = list.odds;
                        
                        [marray addObject:model];
                    }
                }
            }

        }
        
        [self.blockDataArray addObject:marray];
    }
    
    self.blockView.titeleArray = self.blockDataArray;
}

#pragma mark - 正码1-6选择事件
-(void)selectzhengmaClick:(UIButton *)sender {
    
    for (UIButton *btn in self.footView.subviews) {
        
        if (btn.tag >=200 && btn.tag < 206) {
            
            btn.selected = NO;
        }
    }
    
    sender.selected = YES;
    self.zhengma_type = sender.tag + 100;
    self.blockView.titlelab.text = sender.titleLabel.text;
    for (NSArray *array in self.blockDataArray) {
        
        for (CartSixModel *model in array) {
            
            model.select = NO;
        }
    }
    self.blockView.titeleArray = self.blockDataArray;
    
    WS(weakSelf);
    self.blockView.cartInfoBlock = ^{
        
        [weakSelf showalert:sender.tag - 200 + 5];
    };
}
#pragma mark - 红波蓝波绿波选择事件
-(void)selectcolorClick:(UIButton *)sender {
    
    for (id view in sender.superview.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)view;
            
            btn.selected = NO;
        }
    }
    
    self.color_type = sender.tag;
    
    sender.selected = YES;
    
    [self.dataSource removeAllObjects];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CartSixData" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    if (self.selectModel.ID == 302){
      
        for (CartOddsModel *model in self.oddsArray) {
            
            if ([model.name isEqualToString:sender.titleLabel.text]) {
                
                NSArray *array = [CartSixModel mj_objectArrayWithKeyValuesArray:[dic valueForKey:model.name]];
                
                for (CartSixModel *sixmodel in array) {
                    
                    for (OddsList *list in model.oddsList) {
                        
                        if ([sixmodel.title isEqualToString:list.name]) {
                            
                            sixmodel.odds = list.odds;
                            
                            [self.dataSource addObject:sixmodel];
                        }
                    }
                }
            }
            
        }
    }
    [self.tableView reloadData];
}

-(void)cartinfoClick {
    
    if (self.selectModel.ID == 302) {
        
        {
            if (self.color_type == 200) {
                
                [self showalert:22];
            }
            else if (self.color_type == 201) {
                
                [self showalert:23];
            }
            else {
                [self showalert:24];
            }
        }
    }
    /*
     18：全尾--------------  303
     19：特尾--------------  341
     */
    else if (self.selectModel.ID == 303) {
        
        [self showalert:25];
    }
    else if (self.selectModel.ID == 341) {
        
        [self showalert:26];
    }
    /*
     26：平特-----------305
     27：特肖-----------306
     28：六肖连中--------352
     29：六肖连不中------353
     30：二连肖（中）-----360
     31：二连肖（不中）----361
     32：三连肖（中）------362
     33：三连肖（不中）-----363
     34：四连肖（中）------364
     35：四连肖（不中）-----365
     36：二连尾（中）-------366
     37：二连尾（不中）------367
     38：三连尾（中）-------368
     39：三连尾（不中）------369
     40：四连尾（中）-------370
     41：四连尾（不中）------371
     */
    else if (self.selectModel.ID >= 360 && self.selectModel.ID <= 371) {
        
        //37,38,39...48
        [self showalert:self.selectModel.ID -323];
    }
    else if (self.selectModel.ID == 305 || self.selectModel.ID == 306 || self.selectModel.ID == 352 || self.selectModel.ID == 353 ) {
        
        //33,34,35,36
        [self showalert:self.selectModel.ID == 305 ? 33 : self.selectModel.ID == 306 ? 34 : self.selectModel.ID == 352 ? 35 : 36];
    }
    else if (self.selectModel.ID == 311) {
        
        [self showalert:50];
    }
}

-(void)showalert:(NSInteger)index {
    
    ShowAlertView *show = [[ShowAlertView alloc]init];
    [show buildCartsixInfoView:index];
    [show show];
}

#pragma mark - 获取购彩一级分类
-(void)getTypeRootData {
    
    [WebTools postWithURL:@"/lottery/queryFirstPlayByCateId.json" params:@{@"categoryId":@(self.categoryId)} success:^(BaseData *data) {
        
        self.categoryArray = [CartTypeModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self getsubTypeData];
      
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 获取二级分类
-(void)getsubTypeData {
    
    CartTypeModel *model = self.categoryArray.firstObject;
    
    model.selected = YES;
    
    [WebTools postWithURL:@"/lottery/queryTwoLevelPlay.json" params:@{@"categoryId":@(self.categoryId),@"parentId":@(model.ID)} success:^(BaseData *data) {
        
        NSArray *array = [CartTypeModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [model.type1Array addObjectsFromArray:array];
        
        self.selectModel = model.type1Array.firstObject;
        
        self.selectModel.selected = YES;
        
        [self.typeBtn setTitle:self.selectModel.name forState:UIControlStateNormal];
        
        [self.typeBtn setImagePosition:WPGraphicBtnTypeRight spacing:2];
        
        [self getsixUIData];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 获取六合彩购彩UI
-(void)getsixUIData {
    
    [WebTools postWithURL:@"/lottery/queryLhcBuy.json" params:@{@"lotteryId":@(self.lotteryId),@"playId":@(self.selectModel.ID)} success:^(BaseData *data) {
        
        self.oddsArray = [CartOddsModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self addsubviewtofootview];
        
    } failure:^(NSError *error) {
        
        for (id view in self.footView.subviews) {
            
            [view removeFromSuperview];
        }
        [self.dataSource removeAllObjects];
        [self.ballDataArray removeAllObjects];
        [self.block2DataArray removeAllObjects];
        [self.blockDataArray removeAllObjects];
        self.ballView = nil;
        self.blockView = nil;
        self.blockView2 = nil;
        self.showcell = NO;
        [self.tableView reloadData];
    } showHUD:NO];
}

#pragma mark - 获取历史开奖
-(void)inithistoryData {
    
    [WebTools postWithURL:@"/lhcSg/lishiSg.json" params:@{@"pageNum":@1,@"pageSize":@5} success:^(BaseData *data) {
        
        self.dataArray = [SixInfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
        
        SixInfoModel *firstmodel = [self.dataArray firstObject];
        
        self.headView.currentversionslab.text = [NSString stringWithFormat:@"%@期",firstmodel.issue];
        self.headView.jialab.hidden = NO;
        self.headView.waitinglab.hidden = YES;
        NSArray * numberArry = [firstmodel.number componentsSeparatedByString:@","];
        NSArray * shengxiaoArry = [firstmodel.shengxiao componentsSeparatedByString:@","];

        for (int i = 0; i< 7; i++) {
            
            NSString *number = numberArry[i];
            NSString *shengxiao = shengxiaoArry[i];
            NSString *wuxin = [Tools numbertowuxin:number];
            
            UIButton *btn = self.headView.numberBtns[i];
            UILabel  *lab = self.headView.numberlabs[i];
            btn.hidden = NO;
            lab.hidden = NO;
            
            lab.text = [NSString stringWithFormat:@"%@/%@",shengxiao,wuxin];
            [btn setTitle:number forState:UIControlStateNormal];
            [btn setBackgroundImage:[Tools numbertoimage:number Withselect:NO] forState:UIControlStateNormal];
        }
        
    } failure:^(NSError *error) {
        
        
    } showHUD:NO];
    
}

#pragma mark - 获取下期开奖期数和时间
-(void)getnextissue {
    
    [Tools getNextOpenTime:self.lottery_type Withresult:^(NSDictionary *dic) {
        
        self.headView.nextversionslab.text = STRING(dic[@"issue"]);
        self.stopwatch.startTimeInterval = [dic[@"start"]integerValue];
        
        if ([dic[@"time"]integerValue]>=0) {
            [self.stopwatch setCountDownTime:[dic[@"time"]integerValue]];//多少秒 （1分钟 == 60秒）
            [self.stopwatch start];
        }
        else{
            if ([dic[@"opentime"]integerValue] > [dic[@"start"]integerValue]) {
                
                self.headView.endtimelab.text = @"正在开奖";
            }
            else{
                self.headView.endtimelab.text = @"后台还没有配置预设开盘时间";
            }
            
        }
        
    }];
}

//时间到了
-(void)timerLabel:(WB_Stopwatch*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    [self inithistoryData];
    
    [self getnextissue];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(120 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [self inithistoryData];
//
//        [self getnextissue];
//    });
    
//    for (int i = 0; i< 7; i++) {
//
//        UIButton *btn = self.headView.numberBtns[i];
//        UILabel  *lab = self.headView.numberlabs[i];
//        btn.hidden = YES;
//        lab.hidden = YES;
//    }
//    self.headView.waitinglab.hidden = NO;
    self.headView.jialab.hidden = YES;
    self.bottomView.publishBtn.userInteractionEnabled = NO;
    self.bottomView.cartBtn.userInteractionEnabled = NO;
    self.bottomView.publishBtn.selected = YES;
    self.bottomView.cartBtn.selected = YES;
    NSInteger curent = self.headView.currentversionslab.text.integerValue;
    
    self.headView.currentversionslab.text = [NSString stringWithFormat:@"%ld",curent + 1];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(120 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self inithistoryData];
        
        [self getnextissue];
        self.bottomView.publishBtn.userInteractionEnabled = YES;
        self.bottomView.cartBtn.userInteractionEnabled = YES;
        self.bottomView.publishBtn.selected = NO;
        self.bottomView.cartBtn.selected = NO;
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

#pragma mark - 获取下注注数及金额
-(void)getlotteryCount {
    
    [[BuyTools tools] getsixlotteryCountWith:self.selectModel WithballArr:self.ballDataArray WithblockArr:self.blockDataArray Withblock2Arr:self.block2DataArray WithdatasourceArr:self.dataSource With:self.pricetype With:self.times With:self.tableView success:^(NSString * _Nonnull countstr, NSString * _Nonnull pricestr, NSString * _Nonnull maxprice) {
        
//        self.bottomView.numlab.text = countstr;
        self.bottomView.pricelab.text = pricestr;
        self.bottomView.maxpricelab.text = maxprice;
    }];
}

#pragma mark - cart = no:立即购买/cart = yes:加入购彩篮，
-(void)publishlotteryData:(BOOL)cart {
    
//    if (self.bottomView.numlab.text.integerValue == 0) {
//        [MBProgressHUD showError:@"还没选择任何有效投注"];
//        return;
//    }
    
//    [[BuyTools tools]publishsixlotteryData:cart With:self.selectModel WithballArr:self.ballDataArray WithblockArr:self.blockDataArray Withblock2Arr:self.block2DataArray WithdatasourceArr:self.dataSource Withodds:self.oddsArray WithcartArr:self.cartArray With:self.pricetype With:self.times With:self.zhengma_type With:self.color_type Withcount:self.bottomView.numlab.text.integerValue success:^(NSArray * _Nonnull dataArray) {
//
//        if (cart) {
//
//            [self clearUI];
//        }else{
//
//            [self postDataWithnumber:dataArray];
//        }
//    }];
    
    [[BuyTools tools]publishsixlotteryData:cart With:self.selectModel WithballArr:self.ballDataArray WithblockArr:self.blockDataArray Withblock2Arr:self.block2DataArray WithdatasourceArr:self.dataSource Withodds:self.oddsArray WithcartArr:self.cartArray With:self.pricetype With:self.times With:self.zhengma_type With:self.color_type Withcount:0 success:^(NSArray * _Nonnull dataArray) {
        
        if (cart) {
            
            [self clearUI];
        }else{
            
            [self postDataWithnumber:dataArray];
        }
    }];
    
    
}

#pragma mark - 请求数据
-(void)postDataWithnumber:(NSArray *)betlist{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:self.headView.nextversionslab.text forKey:@"issue"];
    [dic setValue:@(self.lotteryId) forKey:@"lotteryId"];
    [dic setValue:[Person person].uid forKey:@"userId"];
    
    [dic setValue:betlist forKey:@"orderBetList"];
    
    [WebTools postWithURL:@"/order/orderBet.json" params:dic success:^(BaseData *data) {
        
        [MBProgressHUD showSuccess:data.info];
        
        [Person person].balance = [Person person].balance - self.bottomView.pricelab.text.floatValue;
        
        self.pricelab.text = [NSString stringWithFormat:@"￥%.2f",[Person person].balance];
        
        [self getlotteryCount];
        
        [self clearUI];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)clearUI {
    
    for (CartSixModel *model in self.ballDataArray) {
        
        model.select = NO;
        
    }
    for (NSArray *array in self.blockDataArray) {
        
        for (CartSixModel *model in array) {
            
            model.select = NO;
        }
    }
    for (NSArray *array in self.block2DataArray) {
        
        for (CartSixModel *model in array) {
            
            model.select = NO;
        }
    }
    for (CartSixModel *model in self.dataSource) {
        
        model.select = NO;
    }
    [self.tableView reloadData];
    
    self.ballView.array = self.ballDataArray;
    self.ballView.segment.selectedSegmentIndex = -1;
    
    self.blockView.titeleArray = self.blockDataArray;
    
    self.blockView2.titeleArray = self.block2DataArray;
    
    [self getlotteryCount];
    
    self.hub.count = self.cartArray.count;
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
    
    [self clearUI];
    
    if (self.selectModel.ID == 297 || self.selectModel.ID == 313 || self.selectModel.ID == 298 || self.selectModel.ID == 321) {
        
        for (CartSixModel *model in self.ballDataArray) {
            
            model.select = NO;
        }
        for (NSArray *array in self.blockDataArray) {
            
            for (CartSixModel *model in array) {
                
                model.select = NO;
            }
        }
        if (arc4random()%2 == 0) {
            
            CartSixModel *model = [self.ballDataArray objectAtIndex:arc4random()%49];
            
            model.select = YES;
        }
        else {
            NSArray *array = [self.blockDataArray objectAtIndex:arc4random()%self.blockDataArray.count];
            
            CartSixModel *model = [array objectAtIndex:arc4random()%array.count];
            
            model.select = YES;
        }
        self.ballView.array = self.ballDataArray;
        self.selectModel = self.selectModel;
        self.blockView.titeleArray = self.blockDataArray;
    }
    //5：正码1-6------------299
    else if (self.selectModel.ID == 299) {
        
        for (NSArray *array in self.blockDataArray) {
            
            for (CartSixModel *model in array) {
                
                model.select = NO;
            }
        }
        NSArray *array = [self.blockDataArray objectAtIndex:arc4random()%self.blockDataArray.count];
        
        CartSixModel *model = [array objectAtIndex:arc4random()%array.count];
        
        model.select = YES;
        
        self.blockView.titeleArray = self.blockDataArray;
    }
    /*
     6：正特1--------------300
     7：正特2--------------328
     8：正特3--------------330
     9：正特4--------------332
     10：正特5-------------333
     11：正特6-------------334
     */
    else if (self.selectModel.ID == 300 || (self.selectModel.ID == 328 || self.selectModel.ID == 330 || self.selectModel.ID == 332 || self.selectModel.ID == 333 || self.selectModel.ID == 334)) {
        
        for (CartSixModel *model in self.ballDataArray) {
            
            model.select = NO;
        }
        for (NSArray *array in self.blockDataArray) {
            
            for (CartSixModel *model in array) {
                
                model.select = NO;
            }
        }
        if (arc4random()%2 == 0) {
            
            CartSixModel *model = [self.ballDataArray objectAtIndex:arc4random()%49];
            
            model.select = YES;
        }
        else {
            
            NSArray *array = [self.blockDataArray objectAtIndex:arc4random()%self.blockDataArray.count];
            
            CartSixModel *model = [array objectAtIndex:arc4random()%array.count];
            
            model.select = YES;
        }
        self.ballView.array = self.ballDataArray;
        self.selectModel = self.selectModel;
        self.blockView.titeleArray = self.blockDataArray;
    }
    /*
     12：三全中-------------343
     13：三中二-------------345
     14：二全中-------------372
     15：二中特-------------346
     16：特串---------------301
     */
    else if (self.selectModel.ID == 343 || self.selectModel.ID == 345 || self.selectModel.ID == 346 || self.selectModel.ID == 372 || self.selectModel.ID == 301) {
        
        for (CartSixModel *model in self.ballDataArray) {
            
            model.select = NO;
        }
        
        int i = self.selectModel.ID == 301 ? 2 : self.selectModel.ID == 343 ? 3 : self.selectModel.ID == 345 ? 3 : self.selectModel.ID == 346 ? 2 : 2;
        NSArray * array = [Tools getDifferentRandomWithNum:i Withfrome:49];
        
        for (NSString *str in array) {
            
            CartSixModel *model = [self.ballDataArray objectAtIndex:str.intValue];
            
            model.select = YES;
        }
        
        CartSixModel *model = [self.ballDataArray objectAtIndex:arc4random()%49];
        
        model.select = YES;
        
        self.ballView.array = self.ballDataArray;
        self.selectModel = self.selectModel;
    }
    /*
     17：红波、蓝波、绿波-----302
     18：全尾--------------  303
     19：特尾-------------- 341
     */
    else if (self.selectModel.ID == 302 || self.selectModel.ID == 303 || self.selectModel.ID == 341) {
        
        for (CartSixModel *model in self.dataSource) {
            
            model.select = NO;
        }
        CartSixModel *model = [self.dataSource objectAtIndex:arc4random()%self.dataSource.count];
        
        model.select = YES;
        
        [self.tableView reloadData];
    }
    /*
     20：五不中 ------342
     21：六不中--------347
     22：七不中--------348
     23：八不中---------349
     24：九不中---------350
     25：十不中---------351
     */
    else if ((self.selectModel.ID >= 347 && self.selectModel.ID <= 351) || self.selectModel.ID == 342) {
        
        for (CartSixModel *model in self.ballDataArray) {
            
            model.select = NO;
        }
        int i = self.selectModel.ID == 342 ? 5 : self.selectModel.ID == 347 ? 6 : self.selectModel.ID == 348 ? 7 : self.selectModel.ID == 349 ? 8 : self.selectModel.ID == 350 ? 9 : 10;
        NSArray * array = [Tools getDifferentRandomWithNum:i Withfrome:49];
        
        for (NSString *str in array) {
            
            CartSixModel *model = [self.ballDataArray objectAtIndex:str.intValue];
            
            model.select = YES;
        }
        
        
        self.ballView.array = self.ballDataArray;
        self.selectModel = self.selectModel;
    }
    /*
     26：平特-----------305
     27：特肖-----------306
     28：六肖连中--------352
     29：六肖连不中------353
     30：二连肖（中）-----360
     31：二连肖（不中）----361
     32：三连肖（中）------362
     33：三连肖（不中）-----363
     34：四连肖（中）------364
     35：四连肖（不中）-----365
     36：二连尾（中）-------366
     37：二连尾（不中）------367
     38：三连尾（中）-------368
     39：三连尾（不中）------369
     40：四连尾（中）-------370
     41：四连尾（不中）------371
     */
    else if (self.selectModel.ID == 305 || self.selectModel.ID == 306 || self.selectModel.ID == 352 || self.selectModel.ID == 353 || (self.selectModel.ID >=360 && self.selectModel.ID <= 371)) {
        
        for (CartSixModel *model in self.dataSource) {
            
            model.select = NO;
        }
        int i = self.selectModel.ID == 305 ? 1 : self.selectModel.ID == 306 ? 1 : self.selectModel.ID == 352 ? 6 : self.selectModel.ID == 353 ? 6 : self.selectModel.ID == 360 ? 2 : self.selectModel.ID == 361 ? 2 : self.selectModel.ID == 362 ? 3 : self.selectModel.ID == 363 ? 3 : self.selectModel.ID == 364 ? 4 : self.selectModel.ID == 365 ? 4 : self.selectModel.ID == 366 ? 2 : self.selectModel.ID == 367 ? 2 : self.selectModel.ID == 368 ? 3 : self.selectModel.ID == 369 ? 3 : self.selectModel.ID == 370 ? 4 : 4;
        int j = self.selectModel.ID == 305 ? 12 : self.selectModel.ID == 306 ? 12 : self.selectModel.ID == 352 ? 12 : self.selectModel.ID == 353 ? 12 : self.selectModel.ID == 360 ? 12 : self.selectModel.ID == 361 ? 12 : self.selectModel.ID == 362 ? 12 : self.selectModel.ID == 363 ? 12 : self.selectModel.ID == 364 ? 12 : self.selectModel.ID == 365 ? 12 : self.selectModel.ID == 366 ? 10 : self.selectModel.ID == 367 ? 2 : self.selectModel.ID == 368 ? 10 : self.selectModel.ID == 369 ? 10 : self.selectModel.ID == 370 ? 10 : 10;
        
        NSArray *array = [Tools getDifferentRandomWithNum:i Withfrome:j];
        
        for (NSString *str in array) {
            
            CartSixModel *model = [self.dataSource objectAtIndex:str.intValue];
            
            model.select = YES;
        }
        [self.tableView reloadData];
    }
    //42：1-6龙虎----------- 310
    else if (self.selectModel.ID == 310) {
        
        for (NSArray *array in self.block2DataArray) {
            
            for (CartSixModel *model in array) {
                
                model.select = NO;
            }
            
        }
        for (NSArray *array in self.blockDataArray) {
            
            for (CartSixModel *model in array) {
                
                model.select = NO;
            }
        }
        if (arc4random()%2 == 0) {
            
            NSArray *array = [self.block2DataArray objectAtIndex:arc4random()%self.block2DataArray.count];
            
            CartSixModel *model = [array objectAtIndex:arc4random()%array.count];
            
            model.select = YES;
        }
        else {
            
            NSArray *array = [self.blockDataArray objectAtIndex:arc4random()%self.blockDataArray.count];
            
            CartSixModel *model = [array objectAtIndex:arc4random()%array.count];
            
            model.select = YES;
        }
        self.blockView2.titeleArray = self.block2DataArray;
        self.blockView.titeleArray = self.blockDataArray;
    }
    else {//43：五行-------------311
        
        for (CartSixModel *model in self.dataSource) {
            
            model.select = NO;
        }
        CartSixModel *model = [self.dataSource objectAtIndex:arc4random()%self.dataSource.count];
        
        model.select = YES;
        
        [self.tableView reloadData];
        
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
