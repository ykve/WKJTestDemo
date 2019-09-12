//
//  CartBeijinPK10Ctrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/29.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartBeijinPK10Ctrl.h"
#import "CartChongqinCell.h"
#import "CartBeijinHeadCell.h"
#import "CartChongqinHeadView.h"
#import "CartTypeView.h"
#import "SQMenuShowView.h"
#import "CartSetView.h"
#import "CartListCtrl.h"
#import "CartChongqin2Cell.h"
#import "IGKbetListCtrl.h"
#import "CartBeijingModel.h"
#import "CartbeijinGYHCell.h"
#import "BettingRecordViewController.h"
#import "PK10VersionTrendCtrl.h"
#import "FormulaCtrl.h"
#import "PK10FreeRecommendCtrl.h"
#import "CartBeijinMissModel.h"
#import "PK10HistoryModel.h"
#import "CartOddsModel.h"
#import "TopUpViewController.h"
#import "LoginAlertViewController.h"
#import "KeFuViewController.h"
#import "BuyLotBottomView.h"

@interface CartBeijinPK10Ctrl ()<WB_StopWatchDelegate>

@property (nonatomic, strong) CartChongqinHeadView *headView;

@property (nonatomic, strong) BuyLotBottomView *bottomView;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) UILabel *pricelab;

@property (nonatomic, strong) CartTypeView *typeView;

@property (nonatomic, strong) SQMenuShowView *showView;

@property (nonatomic, strong) UIView *footView;

@property (nonatomic, strong) IQTextView *textView;
/**
 展示section = 0的列表
 */
@property (nonatomic, assign) BOOL showhead;
/**
 展示表尾，并section =1的列表收回
 */
@property (nonatomic, assign) BOOL showfoot;
/**
 选择不同选号方式展示不同列表
 1:PK10两面135
 2:PK10猜名次猜冠军136
 3:PK10猜名次猜前二137
 4:PK10单式前二138
 5:PK10猜名次猜前三139
 6:PK10单式前三141
 7:PK10猜名次猜前四142
 8:PK10单式前四143
 9:PK10猜名次猜前五144
 10:PK10单式前五145
 11:PK10定位胆前五146
 12:PK10定位胆后五147
 13:PK10冠亚组合和值148
 */

//@property (nonatomic, assign) NSInteger selecttype;

@property (nonatomic, strong) CartTypeModel *selectModel;

@property (nonatomic, strong) NSArray *categoryArray;

@property (nonatomic, strong) CartBeijinMissModel *missmodel;

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

@property (nonatomic, strong) CartOddsModel *oddmodel;

@end

@implementation CartBeijinPK10Ctrl

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.stopwatch reset];
    
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
    
    if (self.lottery_type == 6) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_bjpks" object:nil];
    }
    else{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_xyft" object:nil];
    }
    
}

-(void)removenotification {
    
    if (self.lottery_type == 6) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_bjpks" object:nil];
    }
    else{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xyft" object:nil];
    }
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
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CartChongqinCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CartBeijinHeadCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJHeaderIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CartChongqin2Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJFooterIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CartbeijinGYHCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJOtherIdentifier];
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
            
            if(model.ID == 135 || model.ID == 148) {
                
                [weakSelf gettwofaceloss];
            }else{
                [weakSelf getquerymiss];
            }
        };

    }
    return _typeView;
}

-(CartChongqinHeadView *)headView {
    
    if (!_headView) {
        WS(weakSelf);
        _headView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CartChongqinHeadView class]) owner:self options:nil]firstObject];
        for (UILabel *lab in _headView.numberlabs) {
            
            lab.hidden = NO;
        }
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
        
        self.stopwatch = [[WB_Stopwatch alloc]initWithLabel:_headView.endtimelab andTimerType:WBTypeTimer];
        self.stopwatch.delegate = self;
        [self.stopwatch setTimeFormat:@"HH:mm:ss"];
        
        _headView.lookallBlock = ^{
            
            IGKbetListCtrl *list = [[IGKbetListCtrl alloc]init];
            list.lottery_type = weakSelf.lottery_type;
            list.titlestring = @"开奖历史";
            WEAKPUSH(list);
        };
    }
    return _headView;
}

-(UIView *)footView {
    
    if (!_footView) {
        
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        
        [_footView addSubview:self.textView];
        
        UIButton *clearBtn = [Tools createButtonWithFrame:CGRectMake(SCREEN_WIDTH - 73, 210, 63, 30) andTitle:@"清空选注" andTitleColor:WHITE andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(clearClick) andType:UIButtonTypeCustom];
        clearBtn.layer.cornerRadius = 5;
        clearBtn.backgroundColor = kColor(152, 28, 34);
        clearBtn.titleLabel.font = FONT(12);
        [_footView addSubview:clearBtn];
    }
    
    return _footView;
}

-(IQTextView *)textView {
    
    if (!_textView) {
        
        _textView = [[IQTextView alloc]initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH - 20, 180)];
        _textView.placeholder = @"说明：单注号码之间用空格分隔、[],每注号码之间的间隔符支持回车、逗号、[,]、分号、[;]";
        _textView.backgroundColor = kColor(250, 250, 250);
        _textView.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _textView.delegate = self;
    }
    return _textView;
}

-(void)buildtopandfootView {
    
    UIView *top = [[UIView alloc]initWithFrame:CGRectZero];
    top.backgroundColor = WHITE;
    [self.view addSubview:top];
    
    self.typeBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"" andTitleColor:YAHEI andBackgroundImage:nil andImage:IMAGE(@"cartdown2") andTarget:self andAction:@selector(typeClick:) andType:UIButtonTypeCustom];
    [self.typeBtn setImage:IMAGE(@"cartup2") forState:UIControlStateSelected];
    [self.typeBtn setImagePosition:WPGraphicBtnTypeRight spacing:2];
    [top addSubview:self.typeBtn];
    
    UIButton *cartInfoBtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE(@"PCdandanwenhao") andTarget:self andAction:@selector(cartinfoClick) andType:UIButtonTypeCustom];
    [top addSubview:cartInfoBtn];
    
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
    
    [cartInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.typeBtn.mas_right).offset(8);
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
    self.bottomView.bottomClickBlock = ^(NSInteger type,UIButton *sender) {
        
        if (type == 1) { //清空
            
            for (CartBeijingModel *model in weakSelf.dataSource) {
                
                [model.selectnumbers removeAllObjects];
                
                model.segmenttype = 5;
            
            }
            [weakSelf.tableView reloadData];
        }
        else if (type == 2) {//机选
            
            [weakSelf random];
        }
        else if (type == 3) {//玩法设置
            
            CartSetView *set = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CartSetView class]) owner:weakSelf options:nil]firstObject];
            
            set.SureCartSetBlock = ^(NSInteger pricetype, NSInteger times) {
                
                weakSelf.pricetype = pricetype;
                
                weakSelf.times = times;
                
                [weakSelf gettotallotteryCount];
                
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
            list.lotteryId = weakSelf.lotteryId;
            list.lottery_type = weakSelf.lottery_type;
            list.updataArray = ^(NSArray *array) {
                
                [weakSelf.cartArray removeAllObjects];
                
                [weakSelf.cartArray addObjectsFromArray:array];
                
                weakSelf.hub.count = weakSelf.cartArray.count;
            };
            WEAKPUSH(list);
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
        return self.showfoot == YES ? 0 : self.dataSource.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return section == 0 ? 80 : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return section == 0 ? 24 : self.showfoot == YES ? 230 : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.section == 0 ? 30 : self.selectModel.ID == 148 ? 460/SCAL : 185/SCAL;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return section == 0 ? self.headView : nil;
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
        
        CartBeijinHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:RJHeaderIdentifier];
        
        PK10HistoryModel *model = [self.dataArray objectAtIndex:indexPath.row];
        
        NSArray *numarray = [model.number componentsSeparatedByString:@","];
        
        for (UILabel *lab in cell.numberlabs) {
            
            lab.text = numarray[lab.tag-100];
        }
        
        cell.titlelab.text = [NSString stringWithFormat:@"%@期开奖",model.issue];
        
        return cell;
    }
    else {
        
        CartBeijingModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        if (self.selectModel.ID == 135) {
            
            CartChongqin2Cell *cell = [tableView dequeueReusableCellWithIdentifier:RJFooterIdentifier];
            
            cell.titlelab.text = model.title;
            
            cell.misstitlelab.hidden = NO;
            cell.misstitlelab.text = @"赔率";
            
            for (UIButton *btn in cell.numbersBtns) {
                
                btn.hidden = YES;
            }
            for (UILabel *lab in cell.numberlabs) {
                
                lab.hidden = YES;
            }
            for (int i = 0 ; i< model.odds.count ; i++) {
                
                OddsList *list = model.odds[i];
                
                NSString *str = list.name;
                
                if ([str containsString:@"第"]) {
                    
                    str = [str substringFromIndex:3];
                }
                
                UIButton *btn = [cell.contentView viewWithTag:100+i];
                
                [btn setTitle:str forState:UIControlStateNormal];
                
                btn.hidden = NO;
                
                UILabel *lab = [cell.contentView viewWithTag:200+i];
                
                lab.text = list.odds;
                
                lab.hidden = NO;
            }
            
            for (UIButton *btn in cell.numbersBtns) {
                
                btn.selected = NO;
            }
            for (OddsList *list in model.selectnumbers) {
                
                for (UIButton *btn in cell.numbersBtns) {
                    
                    if ([list.name containsString:btn.titleLabel.text]) {
                        
                        btn.selected = YES;
                    }
                    
                }
            }
            WS(weakSelf);
            cell.selectBlock = ^(UIButton *btn) {
                
                OddsList *list = [model.odds objectAtIndex:btn.tag - 100];
                
                if ([model.selectnumbers containsObject:list]) {
                    
                    [model.selectnumbers removeObject:list];
                }
                else {
                    [model.selectnumbers addObject:list];
                }
                
                [weakSelf gettotallotteryCount];
                
                [weakSelf getmaxprice];
                
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
            };
            return cell;
        }
        else if (self.selectModel.ID == 148) {
            
            CartbeijinGYHCell *cell = [tableView dequeueReusableCellWithIdentifier:RJOtherIdentifier];
            
            CartBeijingModel *model = self.dataSource.firstObject;
            
            for (int i = 0; i< model.odds.count; i++) {
                
                OddsList *list = model.odds[i];
                UIButton *btn = cell.numberBtns[i];
                UILabel *lab = cell.numberLabels[i];
                [btn setTitle:list.name forState:UIControlStateNormal];
                lab.text = [NSString stringWithFormat:@"(%@)",list.odds];
            }
            
            for (UIButton *btn in cell.numberBtns) {
                
                btn.selected = NO;
                UILabel *lab = [cell.numberLabels objectAtIndex:btn.tag-100];
                lab.textColor = [UIColor colorWithHex:@"aaaaaa"];
            }
            for (OddsList *list in model.selectnumbers) {
                
                for (UIButton *btn in cell.numberBtns) {
                    
                    if ([list.name isEqualToString:btn.titleLabel.text]) {
                        
                        btn.selected = YES;
                        
                        UILabel *lab = [cell.numberLabels objectAtIndex:btn.tag-100];
                        lab.textColor = [UIColor colorWithHex:@"FFFFFF"];
                    }
                    
                }
            }
            WS(weakSelf);
            cell.selectBlock = ^(UIButton *btn) {
                
                OddsList *list = [model.odds objectAtIndex:btn.tag - 100];
                
                if ([model.selectnumbers containsObject:list]) {
                    
                    [model.selectnumbers removeObject:list];
                }
                else {
                    [model.selectnumbers addObject:list];
                }
                
                [weakSelf gettotallotteryCount];
                
                [weakSelf getmaxprice];
                
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
            };
            
            return cell;
        }
        else {
            
            CartChongqinCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
            
            cell.segment.selectedSegmentIndex = model.segmenttype == 5 ? -1 : model.segmenttype;
            
            cell.misstitlelab.hidden = !self.showView.showmiss;
            
            for (UIButton *btn in cell.numberBtns) {
                
                btn.selected = NO;
                [btn setTitle:[NSString stringWithFormat:@"%02ld",btn.tag-100+1] forState:UIControlStateNormal];
            }
            for (NSString *num in model.selectnumbers) {
                
                for (UIButton *btn in cell.numberBtns) {
                    
                    if ([num isEqualToString:btn.titleLabel.text]) {
                        
                        btn.selected = YES;
                    }
                    
                }
            }
            
            cell.typelab.text = model.title;
            
            __weak __typeof(&*cell)weakcell = cell;
            WS(weakSelf);
            cell.segmentBlock = ^(NSInteger segment) {
                
                model.segmenttype = segment;
                
                [model.selectnumbers removeAllObjects];
                
                if (segment == 0) {
                    
                    for (UIButton *btn in weakcell.numberBtns) {
                        
                        [model.selectnumbers addObject:btn.titleLabel.text];
                    }
                }
                else if (segment == 1) {
                    
                    for (UIButton *btn in weakcell.numberBtns) {
                        
                        if (btn.titleLabel.text.integerValue > 5) {
                            
                            [model.selectnumbers addObject:btn.titleLabel.text];
                        }
                    }
                }
                else if (segment == 2) {
                    
                    for (UIButton *btn in weakcell.numberBtns) {
                        
                        if (btn.titleLabel.text.integerValue < 6) {
                            
                            [model.selectnumbers addObject:btn.titleLabel.text];
                        }
                    }
                }
                else if (segment == 3) {
                    
                    for (UIButton *btn in weakcell.numberBtns) {
                        
                        if (btn.titleLabel.text.integerValue & 1) {
                            
                            [model.selectnumbers addObject:btn.titleLabel.text];
                        }
                    }
                }
                else if (segment == 4) {
                    
                    for (UIButton *btn in weakcell.numberBtns) {
                        
                        if ((btn.titleLabel.text.integerValue & 1) == NO) {
                            
                            [model.selectnumbers addObject:btn.titleLabel.text];
                        }
                    }
                }
                
                [weakSelf gettotallotteryCount];
                
                [weakSelf.tableView reloadData];
            };
            
            cell.selectBlock = ^(NSString *string) {
                
                if ([model.selectnumbers containsObject:string]) {
                    
                    [model.selectnumbers removeObject:string];
                }
                else {
                    [model.selectnumbers addObject:string];
                }
                
                model.segmenttype = -1;
                weakcell.segment.selectedSegmentIndex = -1;
                [weakSelf gettotallotteryCount];
                
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
            };
            
            for (int i = 0; i< cell.missnumlabs.count ; i++) {
                
                NSString *key = [NSString stringWithFormat:@"missing%d",i];
                
                NSNumber *missnum = model.missdata[key];
                
                UILabel *misslab = cell.missnumlabs[i];
                
                misslab.text = missnum.stringValue;
                
                misslab.hidden = !self.showView.showmiss;
            }
            
            
            return cell;
            
        }
    }
}






-(void)typeClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected ) {
        
        [self.typeView show:self.view Withtype:2 Withmodel:self.categoryArray];
    }
    else {
        [self.typeView dismiss];
    }
}

-(void)cartinfoClick {
    
    ShowAlertView *show = [[ShowAlertView alloc]initWithFrame:CGRectZero];
    
    [show buildCartBeijinInfoView:self.selectModel.ID];
    
    [show show];
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

-(void)clearClick{
    
    [self clearUI];
}

- (SQMenuShowView *)showView{
    
    if (_showView) {
        return _showView;
    }
    
    _showView = [[SQMenuShowView alloc]initWithFrame:(CGRect){CGRectGetWidth(self.view.frame)-100-10,NAV_HEIGHT+5,100,0}
                                               items:@[@"遗漏",@"投注记录",@"在线客服",@"横版走势",@"公式杀号",@"免费推荐"]
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
            
            PK10VersionTrendCtrl *trend = [[PK10VersionTrendCtrl alloc]init];
            trend.lottery_type = self.lottery_type;
            PUSH(trend);
        }
        else if (index == 4) {
            
            FormulaCtrl *forumla = [[FormulaCtrl alloc]init];
            forumla.lottery_type = self.lottery_type;
            PUSH(forumla);
        }
        else if (index == 5) {
            
            PK10FreeRecommendCtrl *recommend = [[PK10FreeRecommendCtrl alloc]init];
            recommend.lottery_type = self.lottery_type;
            PUSH(recommend);
        }
        
    }];
    _showView.showmissBlock = ^(BOOL showmiss) {
        
        [weakSelf.tableView reloadData];
    };
    [self.view addSubview:_showView];
    return _showView;
}

-(void)buildDataSource {
    
    [self.dataSource removeAllObjects];
    
    self.showfoot = NO;
    
    [self gettotallotteryCount];
    
    [[BuyTools tools]getpk10DataSource:self.dataSource With:self.selectModel With:self.missmodel With:self.oddmodel With:self.textView With:self.showfoot];

    [self.tableView reloadData];
    
}

#pragma mark - 获取购彩一级分类
-(void)getTypeRootData {
    
    [WebTools postWithURL:@"/lottery/queryFirstPlayByCateId.json" params:@{@"categoryId":@(self.categoryId)} success:^(BaseData *data) {
        
        self.categoryArray = [CartTypeModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self getfirstCategoryData];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
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
                [model.type2Array addObjectsFromArray:arrlist];
            }
            i++;
        }
        
        self.selectModel = model.type1Array.firstObject;
        
        [self gettwofaceloss];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 获取直选遗漏
-(void)getquerymiss {
    
    [WebTools postWithURL:@"/lottery/querySelection.json" params:@{@"lotteryId":@(self.lotteryId),@"playId":@(self.selectModel.ID)} success:^(BaseData *data) {
        
        self.missmodel = [CartBeijinMissModel mj_objectWithKeyValues:data.data];
        
        [self buildDataSource];
        
        [self getmaxprice];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

//#pragma mark - 两面遗漏
//-(void)gettwofacemiss {
//
//    [WebTools postWithURL:@"/lottery/queryBjpksLm.json" params:@{@"lotteryId":@(self.lotteryId),@"playId":@(self.selectModel.ID)} success:^(BaseData *data) {
//
//        if (self.selectModel.ID == 135 || self.selectModel.ID == 148) {
//
//            [self gettwofaceloss];
//        }
//        else {
//            self.missmodel = [CartBeijinMissModel mj_objectWithKeyValues:data.data];
//
//            [self buildDataSource];
//        }
//
//
//        [self getmaxprice];
//
//    } failure:^(NSError *error) {
//
//    } showHUD:NO];
//}

#pragma mark - 获取PK10两面和冠亚和的UI及赔率
-(void)gettwofaceloss {
    
    [WebTools postWithURL:@"/lottery/queryPcddBuy.json" params:@{@"playId":@(self.selectModel.ID),@"lotteryId":@(self.lotteryId)} success:^(BaseData *data) {
   
        self.oddmodel = [CartOddsModel mj_objectWithKeyValues:data.data];
        
        [self buildDataSource];
        
        [self getmaxprice];
        
    } failure:^(NSError *error) {
        
        
        
    } showHUD:NO];
}

#pragma mark - 获取历史开奖
-(void)inithistoryData {
    
    NSString *url = nil;
    if (self.lottery_type == 6) {
        
        url = @"/bjpksSg/lishiSg.json";
    }
    else if (self.lottery_type == 7) {
        url = @"/xyftSg/lishiSg.json";
    }
    
    [WebTools postWithURL:url params:@{@"pageNum":@1,@"pageSize":@5} success:^(BaseData *data) {
        
        self.dataArray = [PK10HistoryModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
        
        PK10HistoryModel *firstmodel = [self.dataArray firstObject];
        
        self.headView.currentversionslab.text = firstmodel.issue;
        
        self.headView.waitinglab.hidden = YES;
        
        NSArray *numarray = [firstmodel.number componentsSeparatedByString:@","];
        
        for (UILabel *lab in self.headView.numberlabs) {
            
            lab.text = numarray[lab.tag-100];
            lab.hidden = NO;
        }
        
    } failure:^(NSError *error) {
        
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

#pragma mark - 获取下注注数
-(void)gettotallotteryCount {
    
    NSInteger count = 0;
//    self.bottomView.numlab.text = INTTOSTRING(count);
    self.bottomView.pricelab.text = [NSString stringWithFormat:@"%.2f",[Tools lotteryprice:self.pricetype] * self.times * count];
    
    [[BuyTools tools] getpk10totallotteryCountWith:self.selectModel With:self.dataSource With:self.pricetype With:self.times success:^(NSString * _Nonnull cout, NSString * _Nonnull price) {
        
        self.bottomView.numlab.text = cout;
        
        self.bottomView.pricelab.text = price;
    }];
}


/**
 选择不同选号方式展示不同列表
 1:PK10两面135
 2:PK10猜名次猜冠军136
 3:PK10猜名次猜前二137
 4:PK10单式前二138
 5:PK10猜名次猜前三139
 6:PK10单式前三141
 7:PK10猜名次猜前四142
 8:PK10单式前四143
 9:PK10猜名次猜前五144
 10:PK10单式前五145
 11:PK10定位胆前五146
 12:PK10定位胆后五147
 13:PK10冠亚组合和值148
 */
#pragma mark - NO:号码投注/YES:号码加购物车
-(void)publishlotteryData:(BOOL)cart {
    
    [[BuyTools tools] publishpk10lotteryData:cart With:self.selectModel With:self.missmodel With:self.dataSource Withcar:self.cartArray With:self.textView With:self.pricetype With:self.times Withcount:self.bottomView.numlab.text.integerValue success:^(NSString * _Nonnull data) {
        
        if (cart) {
            
            [self clearUI];
            
            self.hub.count = self.cartArray.count;
        }
        else{
            [self postDataWithnumber:data];
        }
    }];
    
}

#pragma mark - 请求数据
-(void)postDataWithnumber:(NSString *)str{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:self.headView.nextversionslab.text forKey:@"issue"];
    [dic setValue:@(self.lotteryId) forKey:@"lotteryId"];
    [dic setValue:[Person person].uid forKey:@"userId"];
    NSMutableArray *betlist = [[NSMutableArray alloc]init];
    
    
    if (self.selectModel.ID == 135 || self.selectModel.ID == 148 || self.selectModel.ID == 136) {
        NSArray *array = [str componentsSeparatedByString:@","];
        for (NSString *mstr in array) {
            
            NSMutableDictionary *listdic = [[NSMutableDictionary alloc]init];
            [listdic setValue:@(self.selectModel.ID) forKey:@"playId"];
            if (self.selectModel.ID == 136) {
                [listdic setValue:self.missmodel.play[@"settingId"] forKey:@"settingId"];
            }
            else{
                [listdic setValue:@(self.oddmodel.oddsList.firstObject.settingId) forKey:@"settingId"];
            }
            
            [listdic setValue:@(1) forKey:@"betCount"];
            [listdic setValue:mstr forKey:@"betNumber"];
            CGFloat amount = self.times * [Tools lotteryprice:self.pricetype] * 1;
            [listdic setValue:[NSNumber numberWithFloat:amount] forKey:@"betAmount"];
            [betlist addObject:listdic];
        }
        
    }
    else {
        NSMutableDictionary *listdic = [[NSMutableDictionary alloc]init];
        [listdic setValue:@(self.selectModel.ID) forKey:@"playId"];
        [listdic setValue:self.missmodel.play[@"settingId"] forKey:@"settingId"];
        [listdic setValue:@(self.bottomView.numlab.text.integerValue) forKey:@"betCount"];
        [listdic setValue:str forKey:@"betNumber"];
        CGFloat amount = self.times * [Tools lotteryprice:self.pricetype] * self.bottomView.numlab.text.integerValue;
        [listdic setValue:[NSNumber numberWithFloat:amount] forKey:@"betAmount"];
        [betlist addObject:listdic];
    }
    
    
    [dic setValue:betlist forKey:@"orderBetList"];
    
    [WebTools postWithURL:@"/order/orderBet.json" params:dic success:^(BaseData *data) {
        
        [MBProgressHUD showSuccess:data.info];
        
        [Person person].balance = [Person person].balance - self.bottomView.pricelab.text.floatValue;
        
        self.pricelab.text = [NSString stringWithFormat:@"￥%.2f",[Person person].balance];
        
        [self clearUI];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 清除选中数据，重置
-(void)clearUI {
    
    for (CartBeijingModel *model in self.dataSource) {
        
        [model.selectnumbers removeAllObjects];
        
        model.segmenttype = 5;
    }
    self.textView.text = nil;
    self.bottomView.numlab.text = @"0";
    self.bottomView.pricelab.text = @"0.00";
    [self.tableView reloadData];
}

#pragma mark - 最高可中
-(void)getmaxprice {
    
    [[BuyTools tools] getpk10maxpriceWith:self.selectModel With:self.missmodel With:self.dataSource With:self.pricetype With:self.times success:^(NSString * _Nonnull price) {
        
        self.bottomView.maxpricelab.text = price;
    }];
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    NSInteger count = 0;
    self.bottomView.numlab.text = INTTOSTRING(count);
    self.bottomView.pricelab.text = [NSString stringWithFormat:@"%.2f",[Tools lotteryprice:self.pricetype] * self.times * count];
    
    [[BuyTools tools]getpk10textlotterycountWith:self.selectModel With:self.textView With:self.pricetype With:self.times success:^(NSString * _Nonnull cout, NSString * _Nonnull price) {
        
        self.bottomView.numlab.text = cout;
        
        self.bottomView.pricelab.text = price;
    }];
    
    return YES;
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

    for (CartBeijingModel *model in self.dataSource) {
        
        [model.selectnumbers removeAllObjects];
        
        model.segmenttype = 5;
    }
    
    if (self.selectModel.ID == 135) {
        
        NSInteger index = arc4random() % (self.dataSource.count - 1);
        
        CartBeijingModel *model = [self.dataSource objectAtIndex:index];
        
        [model.selectnumbers addObject:[model.odds objectAtIndex:arc4random()%model.odds.count]];
    }
    else if (self.selectModel.ID == 148) {
        
        CartBeijingModel *model = self.dataSource.firstObject;
        
        [model.selectnumbers addObject:[model.odds objectAtIndex:arc4random()%model.odds.count]];
    }
    else{
        
        NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",nil];
        int i = 0;
        for (CartBeijingModel *model in self.dataSource) {
            
            NSString *num = [array objectAtIndex:arc4random() % (array.count-i)];
            
            [model.selectnumbers addObject:num];
            
            [array removeObject:num];
            i++;
        }
    }
    
    
    [self gettotallotteryCount];
    [self getmaxprice];
    [self.tableView reloadData];
    
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
