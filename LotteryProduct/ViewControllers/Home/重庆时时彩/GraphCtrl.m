//
//  GraphCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "GraphCtrl.h"
#import "GraphTypeView.h"
#import "RightTableViewCell.h"
#import "GraphModel.h"
#import "GraphSetView.h"
#define LeftTableViewWidth 160

@interface GraphCtrl ()

@property (nonatomic, strong)UIButton *typeBtn;

@property (nonatomic, strong)GraphTypeView *graph;

@property (nonatomic, strong)  CJScroViewBar*BarView;

@property (nonatomic, strong) UITableView *leftTableView, *rightTableView;

@property (nonatomic, strong) NSArray *rightTitles;

@property (nonatomic, strong) UIScrollView *buttomScrollView;

@property (nonatomic, assign) CGFloat righttablecell_width;

@property (nonatomic, assign) BOOL graphtypechange;

@property (nonatomic, strong)CAShapeLayer * layer;

@property (nonatomic, strong)NSMutableArray *layerArray;
/**
 圆点展示的UIlabel
 */
@property (nonatomic, strong)NSMutableArray *selectnumArray;

@property (nonatomic, strong)UIView *rightbottomView;

@property (nonatomic, strong)UIView *leftbottomView;

@property (nonatomic, strong)UIView *lefttitleView;

@property (nonatomic, strong)UIView *righttitleView;
/**
 最近多少期
 */
@property (nonatomic, assign) NSInteger issue;

@property (nonatomic, strong) NSDictionary *setDic;
/**
 1:五星基本走势图
 2:三星基本走势图
 3:二星基本走势图
 4:大小单双走势图
 5:二星直选走势图1
 6:二星直选走势图2
 7:三星组选走势图
 8:二星组选走势图
 9:三星大小号码分布图
 10:三星奇偶号码分布图
 11:三星质合号码分布图
 12:三星跨度走势图
 13:二星跨度走势图
 14:五星和值走势图
 15:三星和值走势图
 16:二星和值走势图
 17:个位(一星)走势图
 18:十位走势图
 19:百位走势图
 20:千位走势图
 21:万位走势图
 */
@property (nonatomic, assign) NSInteger selecttype;
/**
 BarView 选中的第几个
 */
@property (nonatomic, assign) NSInteger selectindex;
/**
 有些曲线图不需要底部
 */
@property (nonatomic, assign) BOOL hiddenbottom;

@end

@implementation GraphCtrl

-(NSMutableArray *)layerArray {
    
    if (!_layerArray) {
        
        _layerArray = [[NSMutableArray alloc]init];
    }
    return _layerArray;
}

-(NSMutableArray *)selectnumArray {
    
    if (!_selectnumArray) {
        
        _selectnumArray = [[NSMutableArray alloc]init];
    }
    return _selectnumArray;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"曲线图";
    @weakify(self)

    [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] IC_Nav_Setting_Gear] With:^(UIButton *sender) {
        @strongify(self)

        GraphSetView *set = [GraphSetView share];
        
        if (self.setDic) {
            
            [set showWithInfo:self.setDic];
        }
        else {
            
            self.setDic = @{@"version":@0,@"line":@0,@"miss":@0,@"sort":@0,@"statistic":@0};
            [set showWithInfo:self.setDic];
        }
        
        set.setBlock = ^(NSDictionary *dic) {
            @strongify(self)

            self.setDic = dic;
            
            self.issue = [dic[@"version"]integerValue] == 0 ? 30 : [dic[@"version"]integerValue] == 1 ? 50 : [dic[@"version"]integerValue] == 2 ? 100 : 200;
            
            [self reloadDataWithtype:self.selecttype];
            
        };
        
    }];
    
    self.typeBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"五星基本走势图" andTitleColor:WHITE andBackgroundImage:nil andImage:IMAGE(@"玩法筛选") andTarget:self andAction:@selector(selectTypeClick:) andType:UIButtonTypeCustom];
    self.typeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.typeBtn setImagePosition:WPGraphicBtnTypeRight spacing:3];
    [self.navView addSubview:self.typeBtn];
    
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)

        make.left.equalTo(self.leftBtn.mas_right).offset(2);

        make.centerY.equalTo(self.leftBtn);
        make.height.equalTo(@30);
    }];
    
    [self.titlelab mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)

        make.left.equalTo(self.typeBtn.mas_right).offset(10);
        make.centerY.equalTo(self.typeBtn);
    }];
    [self buildTimeViewWithType:self.lottery_type With:nil With:^{
        @strongify(self)
        [self refresh];
    }];
    
    [self loadLeftTableView];
    [self loadRightTableView];
    
    self.issue = 30;
    
    self.selecttype = 1;
    self.selectindex = 0;
    
    [self reloadDataWithtype:self.selecttype];
    
    //投注按钮
    [self buildBettingBtn];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self addnotification];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self removenotification];
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

-(void)refresh {
    
    [self reloadDataWithtype:self.selecttype];
}

-(void)removenotification {
    
    switch (self.lottery_type) {
        case 1:
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_cqssc" object:nil];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xjssc" object:nil];
            break;
        case 3:
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_txffc" object:nil];
            break;
        default:
            
            break;
    }
    
}



//设置分割线顶格
- (void)viewDidLayoutSubviews{
    [self.leftTableView setLayoutMargins:UIEdgeInsetsZero];
    [self.rightTableView setLayoutMargins:UIEdgeInsetsZero];
}

- (void)loadLeftTableView{
    //    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LeftTableViewWidth, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.leftTableView = [[UITableView alloc] init];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTableView.rowHeight = 30;
    [self.view addSubview:self.leftTableView];
    
    @weakify(self)
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.BarView.mas_bottom).offset(40);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100 - SAFE_HEIGHT);
        make.width.equalTo(@(LeftTableViewWidth));
    }];
    
    UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100, LeftTableViewWidth, 100)];
    bottom.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];
    self.leftbottomView = bottom;
    [self.view addSubview:bottom];
    NSArray *array = @[@"出现总次数",@"平均遗漏值",@"最大遗漏值",@"最大连出值"];
    for (int i = 0 ; i< array.count; i++) {
        
        UILabel *lab = [Tools createLableWithFrame:CGRectMake(0, 25*i, LeftTableViewWidth, 25) andTitle:array[i] andfont:FONT(14) andTitleColor:BASECOLOR andBackgroundColor:i%2 == 0 ? CLEAR : [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack] andTextAlignment:1];
        [bottom addSubview:lab];
    }
    
    UIView *leftView = [UIView viewWithLabelNumber:2 Withlabelwidth:CGSizeMake(LeftTableViewWidth/2, 40)];
    leftView.frame = CGRectMake(0, self.BarView.y + self.BarView.height, leftView.size.width, leftView.size.height);
    leftView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:leftView];
    self.lefttitleView = leftView;
    for (UILabel *lab in leftView.subviews) {
        
        if (lab.tag == 200) {
            
            lab.text = @"期号";
        }
        else {
            lab.text = @"开奖号码";
        }
        lab.font = FONT(13);
        lab.textColor = BLACK;
    }
}

- (void)loadRightTableView{
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH - LeftTableViewWidth, SCREEN_HEIGHT - NAV_HEIGHT - 70 - 100) style:UITableViewStylePlain];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.rowHeight = 30;
    
    self.buttomScrollView = [[UIScrollView alloc] init];
    self.buttomScrollView.contentSize = CGSizeMake(self.rightTableView.bounds.size.width, 0);
    self.buttomScrollView.backgroundColor = CLEAR;
    self.buttomScrollView.bounces = NO;
    self.buttomScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.buttomScrollView addSubview:self.rightTableView];
    [self.view addSubview:self.buttomScrollView];
    @weakify(self)
    [self.buttomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.and.equalTo(self.view);
        make.left.equalTo(self.leftTableView.mas_right);
        make.top.equalTo(self.BarView.mas_bottom);
        make.bottom.equalTo(self.view).offset(-SAFE_HEIGHT);
    }];
    
    self.rightbottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.rightTableView.bounds) + 40, CGRectGetWidth(self.rightTableView.bounds), 100)];
    self.rightbottomView.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];//MAINCOLOR;
    [self.buttomScrollView addSubview:self.rightbottomView];

    UIView *rightHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.rightTableView.bounds), 40)];
    rightHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.righttitleView = rightHeaderView;
    [self.buttomScrollView addSubview:self.righttitleView];
}

#pragma mark - table view dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:2 Withsize:CGSizeMake(LeftTableViewWidth/2, 30)];
        
        if (self.dataSource.count == 0) {
            
            return cell;
        }
        GraphModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        UIView *view = [cell.contentView viewWithTag:100];
        
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        for (UILabel *label in view.subviews) {
            label.text = nil;
            label.text = label.tag == 200 ? [[model.version substringFromIndex:self.lottery_type == 3 ? 9 : 8] stringByAppendingString:@"期"]:model.number;
            label.font = FONT(13);
            label.textColor = [UIColor darkGrayColor];
            label.adjustsFontSizeToFitWidth = YES;
            label.backgroundColor = WHITE;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
        return cell;
    }else{
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.rightTitles.count Withsize:CGSizeMake(self.righttablecell_width, 30)];
        
        if (self.graphtypechange) {
            
            [cell updateViewWithNumberOfDrawlabs:self.rightTitles.count Withsize:CGSizeMake(self.righttablecell_width, 25)];
        }
        if (self.dataSource.count == 0) {
            
            return cell;
        }
        GraphModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        UIView *view = [cell.contentView viewWithTag:100];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        int i = 0;
        for (Drawlab *label in view.subviews) {
            label.text = nil;
            if ([[model.array1 objectAtIndex:i] isKindOfClass:[NSNumber class]]) {
                
                label.text = [[model.array1 objectAtIndex:i] stringValue];
            }
            else {
                label.text = [model.array1 objectAtIndex:i];
            }
            label.font = FONT(13);
            label.textColor = [self.setDic[@"miss"]integerValue] == 1 ? CLEAR : [UIColor darkGrayColor];
            label.backgroundColor = [UIColor whiteColor];
            label.showbg = NO;
            label.bgColor = WHITE;
            if (model.showbigandsinger==1) {
                
                if (label.text.integerValue == 0) {
                    
                    label.text = [self.rightTitles objectAtIndex:i];
                    
                    label.showbg = YES;
                    label.textColor = WHITE;
                    label.bgColor = i>3 ? kColor(146, 164, 202) : i < 2 ? kColor(123, 175, 174) : kColor(218, 165, 92);
                }

            }
            else if (model.showbigandsinger == 2) {
                
                if ([[model.array1 objectAtIndex:i] isKindOfClass:[NSNumber class]]) {
                    
                    label.showbg = NO;
                    label.textColor = [UIColor darkGrayColor];
                }
                else {
                    
                    label.showbg = YES;
                    label.bgColor = kColor(218, 165, 92);
                    label.textColor = WHITE;
                }
            }
            i++;
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}
//设置cell分割线顶格
- (void)resetSeparatorInsetForCell:(UITableViewCell *)cell {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
/*
#pragma mark -- 设置左右两个table View的自定义头部View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.rightTableView) {
        UIView *rightHeaderView = [UIView viewWithLabelNumber:self.rightTitles.count Withlabelwidth:CGSizeMake(self.righttablecell_width, 40)];
        int i = 0;
        for (UILabel *label in rightHeaderView.subviews) {
            label.text = self.rightTitles[i++];
            label.font = FONT(13);
            label.textColor = [UIColor darkGrayColor];
        }
        rightHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return rightHeaderView;
    }else{
        
        UIView *leftView = [UIView viewWithLabelNumber:2 Withlabelwidth:CGSizeMake(LeftTableViewWidth/2, 40)];
        leftView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        for (UILabel *lab in leftView.subviews) {
            
            if (lab.tag == 200) {
                
                lab.text = @"期号";
            }
            else {
                lab.text = @"开奖号码";
            }
            lab.font = FONT(13);
            lab.textColor = BLACK;
        }
        return leftView;
    }
}
 */
//必须实现以下方法才可以使用自定义头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.rightTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - 两个tableView联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.leftTableView) {
        [self tableView:self.rightTableView scrollFollowTheOther:self.leftTableView];
    }else{
        [self tableView:self.leftTableView scrollFollowTheOther:self.rightTableView];
    }
}

- (void)tableView:(UITableView *)tableView scrollFollowTheOther:(UITableView *)other{
    
    CGFloat offsetY= other.contentOffset.y;
    CGPoint offset=tableView.contentOffset;
    offset.y=offsetY;
    tableView.contentOffset=offset;
}


-(CJScroViewBar*)BarView {
    
    if (!_BarView){
    
        _BarView = [[CJScroViewBar alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT + 35, SCREEN_WIDTH, 35)];
        _BarView.lineColor = [[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor];
        _BarView.backgroundColor = [[CPTThemeConfig shareManager] pushDanSubbarBackgroundcolor];
       
        [self.view addSubview:_BarView];
    }
    return _BarView;
}

-(void)reloadDataWithtype:(NSInteger)type {
    
    self.selecttype = type;
    
    for (UIButton *btn in self.BarView.subviews) {
        
        [btn removeFromSuperview];
    }
    for (id view in self.righttitleView.subviews) {
        
        [view removeFromSuperview];
    }
    NSArray *array = nil;
    
    if (type == 1) {
        
        array = @[@"万位走势",@"千位走势",@"百位走势",@"十位走势",@"个位走势"];
    }
    else if (type == 2) {
        
        array = @[@"百位走势",@"十位走势",@"个位走势",@"组选分布"];
    }
    else if (type == 3) {
        
        array = @[@"组选分布",@"十位走势",@"个位走势",@"大小",@"奇偶",@"跨度"];
    }
    else if (type == 4) {
        
        array = @[@"十位",@"个位",@"大小单双位置分布",@"大小单双个数分布"];
    }
    else if (type == 5) {
        
        array = @[@"十位走势",@"个位走势",@"跨度"];
    }
    else if (type == 6) {
        
        array = @[@"十位走势",@"十位形态",@"个位走势",@"个位形态"];
    }
    else if (type == 7) {
        
        array = @[@"组选分布",@"大小比",@"奇偶比",@"质合比",@"号码类型",@"和值",@"跨度"];
    }
    else if (type == 8) {
        
        array = @[@"组选分布",@"大小比",@"奇偶比",@"质合比",@"跨度"];
    }
    else if (type == 9) {
        
        array = @[@"百位号码分布",@"十位号码分布",@"个位号码分布",@"组合号码分布"];
    }
    else if (type == 10) {
        
        array = @[@"百位号码分布",@"十位号码分布",@"个位号码分布",@"组合号码分布"];
    }
    else if (type == 11) {
        
        array = @[@"百位号码分布",@"十位号码分布",@"个位号码分布",@"组合号码分布"];
    }
    else if (type == 12) {
        
        array = @[@"跨度",@"最大号码",@"最小号码"];
    }
    else if (type == 13) {
        
        array = @[@"跨度",@"最大号码",@"最小号码"];
    }
    else if (type == 14) {
        
        array = @[@"和值分布",@"和尾分布"];
    }
    else if (type == 15) {
        
        array = @[@"和值分布",@"和尾分布"];
    }
    else if (type == 16) {
        
        array = @[@"和值走势",@"奇偶质合",@"012路",@"和尾走势"];
    }
    else if (type == 17) {
        
        array = @[@"个位走势",@"个位形态",@"012路",@"个位走向",@"个位振幅"];
    }
    else if (type == 18) {
        
        array = @[@"十位走势",@"十位形态",@"012路",@"十位走向",@"十位振幅"];
    }
    else if (type == 19) {
        
        array = @[@"百位走势",@"百位形态",@"012路",@"百位走向",@"百位振幅"];
    }
    else if (type == 20) {
        
        array = @[@"千位走势",@"千位形态",@"012路",@"千位走向",@"千位振幅"];
    }
    else if (type == 21) {
        
        array = @[@"万位走势",@"万位形态",@"012路",@"万位走向",@"万位振幅"];
    }
    
    [self.BarView layoutIfNeeded];
    
    for (id view in self.BarView.subviews) {
        
        [view removeFromSuperview];
    }
    
    [self.BarView setData:array NormalColor:[[CPTThemeConfig shareManager] pushDanSubBarNormalTitleColor] SelectColor:[[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor] Font:[UIFont systemFontOfSize:14]];
    @weakify(self)
    [self.BarView getViewIndex:^(NSString *title, NSInteger index) {
        
        @strongify(self)
        self.selectindex = index;
        
        self.hiddenbottom = NO;
        
        [self.dataSource removeAllObjects];
        
        if (type == 1) {
            
            self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
            
            [self initDataWithzhixuan:index+1 Withtype:0];
        }
        else if (type == 2) {
            
            self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
            
            if (index == 3) {
                
                [self initDataWithzuxuan:3 Withtype:0];
            }
            else {
                
                [self initDataWithzhixuan:index+3 Withtype:0];
            }
        }
        else if (type == 3) {
            
            if (index < 3) {
            
                self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
                
                if (index == 0) {
                    
                    [self initDataWithzuxuan:2 Withtype:0];
                }
                else {
                    [self initDataWithzhixuan:index+3 Withtype:0];
                }
            }
            else if (index == 3 || index == 4) {
                
                self.rightTitles = @[@"十位",@"个位"];
                
                self.hiddenbottom = YES;
                
                [self.leftTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    @strongify(self)
                    make.top.equalTo(self.BarView.mas_bottom).offset(40);
                    make.left.equalTo(self.view);
                    make.bottom.equalTo(self.view).offset(-SAFE_HEIGHT);
                    make.width.equalTo(@(LeftTableViewWidth));
                }];
                
                self.rightTableView.frame = CGRectMake(0, 40, SCREEN_WIDTH - LeftTableViewWidth, SCREEN_HEIGHT - NAV_HEIGHT - 70 - 40);
                
                self.leftbottomView.alpha = 0;
                self.rightbottomView.alpha = 0;
                
                [self initDataWithsizecount:index];
            }
            else {
                self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
                
                self.hiddenbottom = YES;
                
                [self.leftTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    @strongify(self)
                    make.top.equalTo(self.BarView.mas_bottom).offset(40);
                    make.left.equalTo(self.view);
                    make.bottom.equalTo(self.view).offset(-SAFE_HEIGHT);
                    make.width.equalTo(@(LeftTableViewWidth));
                }];
                
                self.rightTableView.frame = CGRectMake(0, 40, SCREEN_WIDTH - LeftTableViewWidth, SCREEN_HEIGHT - NAV_HEIGHT - 70 - 40);
                
                self.leftbottomView.alpha = 0;
                self.rightbottomView.alpha = 0;
                
                [self initDataWithkuaku:2];
            }
        }
        else if (type == 4) {
            
            if (index == 0 || index == 1 || index == 3) {
                
                self.rightTitles = @[@"大",@"小",@"单",@"双"];
                
                switch (index) {
                    case 0:
                        [self initDataWithxintai:4 Withshowprime:NO];
                        break;
                    case 1:
                        [self initDataWithxintai:5 Withshowprime:NO];
                        break;
                    case 3:
                        [self initDataWithdaxiaodanshuanggeshu];
                        break;
                    default:
                        break;
                }
            }
            else {
                self.rightTitles = @[@"大大",@"大小",@"大单",@"大双",@"小大",@"小小",@"小单",@"小双",@"单大",@"单小",@"单单",@"单双",@"双大",@"双小",@"双单",@"双双"];
                
                [self initDataWithdaxiaodanshuangweizhi];
            }
        }
        else if (type == 5) {
            
            self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
            
            if (index == 2) {
                
                [self initDataWithkuaku:2];
            }
            else {
                [self initDataWithzhixuan:index+4 Withtype:0];
            }
        }
        else if (type == 6) {
            
            if (index == 0 || index == 2) {
                
                self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
                
                [self initDataWithzhixuan:index == 0 ? 4 : 5 Withtype:0];
            }
            else {
                
                self.rightTitles = @[@"大",@"小",@"奇",@"偶",@"质",@"合"];
                
                [self initDataWithxintai:index == 1 ? 4 : 5 Withshowprime:YES];
            }
        }
        else if (type == 7) {
            
            if (index == 0) {
                
                self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
                
                [self initDataWithzuxuan:3 Withtype:0];
            }
            else if (index == 1 || index == 2 || index == 3) {
                
                self.rightTitles = @[@"3:0",@"2:1",@"1:2",@"0:3"];
                
                [self initDataWithRatio:index Withnumber:3];
            }
            else if (index == 4) {
                
                self.rightTitles = @[@"组三",@"组六",@"豹子"];
                
                [self initDataWithnumbertype];
            }
            else if (index == 5) {
                self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27"];
                
                [self initDataWithsumvalue:3];
            }
            else {
                self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
                
                [self initDataWithkuaku:3];
            }
        }
        else if (type == 8) {
            
            if (index == 0 || index == 4) {
                
                self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
                
                if (index == 0) {
                    
                    [self initDataWithzuxuan:2 Withtype:0];
                }
                else {
                    [self initDataWithkuaku:2];
                }
            }
            else  {
                
                self.rightTitles = @[@"2:0",@"1:1",@"0:2"];
                
                [self initDataWithRatio:index Withnumber:2];
            }
        }
        else if (type == 9) {
            
            self.rightTitles = @[@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1",@"0"];
            
            if (index < 3) {
                
                [self initDataWithzhixuan:index + 3 Withtype:1];
            }
            else {
                
                [self initDataWithzuxuan:3 Withtype:1];
            }
            
        }
        else if (type == 10) {
            
            self.rightTitles = @[@"1",@"3",@"5",@"7",@"9",@"0",@"2",@"4",@"6",@"8"];
            
            if (index < 3) {
            
                [self initDataWithzhixuan:index + 3 Withtype:2];
            }
            else {
                
                [self initDataWithzuxuan:3 Withtype:2];
            }
            
        }
        else if (type == 11) {
            
            self.rightTitles = @[@"1",@"2",@"3",@"5",@"7",@"0",@"4",@"6",@"8",@"9"];
            
            if (index < 3) {
                
                [self initDataWithzhixuan:index + 3 Withtype:3];
            }
            else {
                
                [self initDataWithzuxuan:3 Withtype:3];
            }
        }
        else if (type == 12) {
            
            self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
            
            if (index == 0) {
                
                [self initDataWithkuaku:3];
            }
            else {
                [self initDataWithmaxmin:index Withnumber:3];
            }
        }
        else if (type == 13) {
            
            self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
            
            if (index == 0) {
                
                [self initDataWithkuaku:2];
            }
            else {
                [self initDataWithmaxmin:index Withnumber:2];
            }
        }
        else if (type == 14) {
            
            if (index == 0) {
                
                self.rightTitles = @[@"0-13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35-45"];
                
                [self initDataWithsumvalue:5];
            }
            else {
                self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
                
                [self initDataWithsumtail:5];
            }
        }
        else if (type == 15) {
            
            if (index == 0) {
                
                self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27"];
                
                [self initDataWithsumvalue:3];
            }
            else {
                self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
                
                [self initDataWithsumtail:3];
            }
        }
        else if (type == 16) {
            
            if (index == 0) {
                
                self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18"];
                
                [self initDataWithsumvalue:2];
            }
            else if (index == 1) {
                
                self.rightTitles = @[@"奇",@"偶",@"质",@"合"];
                
                [self initDataWithxintai:6 Withshowprime:NO];
            }
            else if (index == 2) {
                
                self.rightTitles = @[@"0",@"1",@"2"];
                
                [self initDataWith012way:6];
            }
            else {
                self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
                
                [self initDataWithsumtail:2];
            }
        }
        else {
            
            if (index == 0 || index == 4) {
                
                self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
                
                if (index == 0) {
                    
                    [self initDataWithzhixuan:22-type Withtype:0];
                }
                else {
                    [self initDataWithzhengfu:22-type];
                }
            }
            else if (index == 1) {
                
                self.rightTitles = @[@"大",@"小",@"奇",@"偶",@"质",@"合"];
                
                [self initDataWithxintai:22-type Withshowprime:YES];
            }
            else if (index == 2) {
                
                self.rightTitles = @[@"0",@"1",@"2"];
                
                [self initDataWith012way:22-type];
            }
            else if (index == 3) {
                
                self.rightTitles = @[@"升",@"平",@"降"];
                
                [self initDataWithshengjiang:22-type];
            }
        
        }
        CGFloat righttable_width = 0;
        if ((SCREEN_WIDTH - LeftTableViewWidth)/ self.rightTitles.count < 30) {
            
            righttable_width = 30 * self.rightTitles.count;
            
            self.righttablecell_width = 30;
        }
        else {
            righttable_width = SCREEN_WIDTH - LeftTableViewWidth;
            
            self.righttablecell_width = (SCREEN_WIDTH - LeftTableViewWidth)/ self.rightTitles.count;
        }
        
//        if ((self.setDic && [[self.setDic valueForKey:@"statistic"]integerValue]==1) || self.hiddenbottom == YES) {
//            
//            self.rightTableView.frame = CGRectMake(0, 40, SCREEN_WIDTH - LeftTableViewWidth, SCREEN_HEIGHT - NAV_HEIGHT - 70 - 40);
//        }
//        else{
//            self.rightTableView.frame = CGRectMake(0, 40, righttable_width, SCREEN_HEIGHT - NAV_HEIGHT - 70 - 100 - 40);
//        }
        
        @weakify(self)
        if ((self.setDic && [[self.setDic valueForKey:@"statistic"]integerValue]==1) || self.hiddenbottom == YES) {
            
            [self.leftTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.top.equalTo(self.BarView.mas_bottom).offset(40);
                make.left.equalTo(self.view);
                make.bottom.equalTo(self.view).offset(-SAFE_HEIGHT);
                make.width.equalTo(@(LeftTableViewWidth));
            }];
            
            self.rightTableView.frame = CGRectMake(0, 40, righttable_width, SCREEN_HEIGHT - NAV_HEIGHT - 70 - 40);
            
            self.leftbottomView.alpha = 0;
            self.rightbottomView.alpha = 0;
        }
        else{
            
            [self.leftTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.top.equalTo(self.BarView.mas_bottom).offset(40);
                make.left.equalTo(self.view);
                make.bottom.equalTo(self.view).offset(-100 - SAFE_HEIGHT);
                make.width.equalTo(@(LeftTableViewWidth));
            }];
            
            self.rightTableView.frame = CGRectMake(0, 40, righttable_width, SCREEN_HEIGHT - NAV_HEIGHT - 70 - 100 - 40);
            
            self.leftbottomView.alpha = 1;
            self.rightbottomView.alpha = 1;
        }
        
        self.buttomScrollView.contentSize = CGSizeMake(self.rightTableView.bounds.size.width, 0);
        self.rightbottomView.frame = CGRectMake(0, CGRectGetHeight(self.rightTableView.bounds) + 40, CGRectGetWidth(self.rightTableView.bounds), 100);
        self.graphtypechange = YES;
        
        UIView *rightHeaderView = [UIView viewWithLabelNumber:self.rightTitles.count Withlabelwidth:CGSizeMake(self.righttablecell_width, 40)];
        int i = 0;
        for (UILabel *label in rightHeaderView.subviews) {
            label.text = self.rightTitles[i++];
            label.font = FONT(13);
            label.textColor = [UIColor darkGrayColor];
        }
        rightHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.righttitleView addSubview:rightHeaderView];
    }];
    
    [self.BarView setViewIndex:self.selectindex];
}

#pragma mark - 直选走势通用接口 number = 1:万位 2:千位 3:百位 4:十位 5:个位 reverse 倒序 type 0:小到大 1：大到小 2 ： 奇偶 3:质合
-(void)initDataWithzhixuan:(NSInteger)number Withtype:(NSInteger)type {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscTrend.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscTrend.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcTrend.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"pageSize":@(self.issue),@"number":@(number)} success:^(BaseData *data) {
        
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            
            if (type == 0) {//小到大
                
                [model.array1 addObjectsFromArray:@[dic[@"missing0"],dic[@"missing1"],dic[@"missing2"],dic[@"missing3"],dic[@"missing4"],dic[@"missing5"],dic[@"missing6"],dic[@"missing7"],dic[@"missing8"],dic[@"missing9"]]];
            }
            else if (type == 1) {//大到小
                
                [model.array1 addObjectsFromArray:@[dic[@"missing9"],dic[@"missing8"],dic[@"missing7"],dic[@"missing6"],dic[@"missing5"],dic[@"missing4"],dic[@"missing3"],dic[@"missing2"],dic[@"missing1"],dic[@"missing0"]]];
            }
            else if (type == 2) {//奇偶
                
                [model.array1 addObjectsFromArray:@[dic[@"missing1"],dic[@"missing3"],dic[@"missing5"],dic[@"missing7"],dic[@"missing9"],dic[@"missing0"],dic[@"missing2"],dic[@"missing4"],dic[@"missing6"],dic[@"missing8"]]];
            }
            else if (type == 3) {//质合
                
                [model.array1 addObjectsFromArray:@[dic[@"missing1"],dic[@"missing2"],dic[@"missing3"],dic[@"missing5"],dic[@"missing7"],dic[@"missing0"],dic[@"missing4"],dic[@"missing6"],dic[@"missing8"],dic[@"missing9"]]];
            }
            
            [self.dataSource addObject:model];
        }
        
        [self setsort];
        
        [self.leftTableView reloadData];
        
        [self.rightTableView reloadData];
        
        [self removelayer];
        
        [self drawLine:YES];
        
        if (type == 0) {//小到大
            [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:1];
        }
        else if (type == 1) {//大到小
            
            [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:11];
        }
        else if (type == 2) {//奇偶
            [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:12];
        }
        else if (type == 3) {//质合
            
            [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:13];
        }
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 组选走势通用接口 类型 ： 2 二星组选 | 3 三星组选
-(void)initDataWithzuxuan:(NSInteger)type Withtype:(NSInteger)type2 {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscTrendGroup.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscTrendGroup.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcTrendGroup.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"pageSize":@(self.issue),@"type":@(type)} success:^(BaseData *data) {
        
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            if (type == 0) {//小到大
                
                [model.array1 addObjectsFromArray:@[dic[@"missing0"],dic[@"missing1"],dic[@"missing2"],dic[@"missing3"],dic[@"missing4"],dic[@"missing5"],dic[@"missing6"],dic[@"missing7"],dic[@"missing8"],dic[@"missing9"]]];
            }
            else if (type == 1) {//大到小
                
                [model.array1 addObjectsFromArray:@[dic[@"missing9"],dic[@"missing8"],dic[@"missing7"],dic[@"missing6"],dic[@"missing5"],dic[@"missing4"],dic[@"missing3"],dic[@"missing2"],dic[@"missing1"],dic[@"missing0"]]];
            }
            else if (type == 2) {//奇偶
                
                [model.array1 addObjectsFromArray:@[dic[@"missing1"],dic[@"missing3"],dic[@"missing5"],dic[@"missing7"],dic[@"missing9"],dic[@"missing0"],dic[@"missing2"],dic[@"missing4"],dic[@"missing6"],dic[@"missing8"]]];
            }
            else if (type == 3) {//质合
                
                [model.array1 addObjectsFromArray:@[dic[@"missing1"],dic[@"missing2"],dic[@"missing3"],dic[@"missing5"],dic[@"missing7"],dic[@"missing0"],dic[@"missing4"],dic[@"missing6"],dic[@"missing8"],dic[@"missing9"]]];
            }
            [self.dataSource addObject:model];
        }
        
        [self setsort];
        
        [self.leftTableView reloadData];
        
        [self.rightTableView reloadData];
        
        [self removelayer];
        
        [self drawLine:NO];
        
        if (type == 0) {//小到大
            [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:1];
        }
        else if (type == 1) {//大到小
            
            [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:11];
        }
        else if (type == 2) {//奇偶
            [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:12];
        }
        else if (type == 3) {//质合
            
            [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:13];
        }
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 大小单双个数分布 3:大小 4：单双
-(void)initDataWithsizecount:(NSInteger)type {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscrSizeCount.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscrSizeCount.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcrSizeCount.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"pageSize":@(self.issue)} success:^(BaseData *data) {
        
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            NSString *shi = [[model.selectnumber componentsSeparatedByString:@","]firstObject];
            NSString *ge = [[model.selectnumber componentsSeparatedByString:@","]lastObject];
            if (type == 3) {
                [model.array1 addObjectsFromArray:@[shi.integerValue > 4 ? @"大" : @"小",ge.integerValue > 4 ? @"大" : @"小"]];
            }
            else{
                [model.array1 addObjectsFromArray:@[shi.integerValue %2 == 0 ? @"偶" : @"奇",ge.integerValue %2 == 0 ? @"偶" : @"奇"]];
            }
            [self.dataSource addObject:model];
        }
        
        [self setsort];
        
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        [self removelayer];

        [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:type];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 组合跨度通用 2 二星组选 | 3 三星组选
-(void)initDataWithkuaku:(NSInteger)type {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscSpan.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscSpan.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcSpan.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@(type),@"pageSize":@(self.issue)} success:^(BaseData *data) {
        
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            [model.array1 addObjectsFromArray:@[dic[@"missing0"],dic[@"missing1"],dic[@"missing2"],dic[@"missing3"],dic[@"missing4"],dic[@"missing5"],dic[@"missing6"],dic[@"missing7"],dic[@"missing8"],dic[@"missing9"]]];
            [self.dataSource addObject:model];
        }
        
        [self setsort];
        
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        [self removelayer];
        
        [self drawLine:YES];
        
        [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:1];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 形态 1 万位 | 2 千位 | 3 百位 | 4 十位 | 5 个位 | 6 二星和  prime 是否显示质合
-(void)initDataWithxintai:(NSInteger)type Withshowprime:(BOOL)prime{
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscShape.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscShape.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcShape.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@(type),@"pageSize":@(self.issue)} success:^(BaseData *data) {
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
          
            if (type == 6) {
                
                [model.array1 addObjectsFromArray:@[dic[@"singular"],dic[@"quantity"],dic[@"prime"],dic[@"composite"]]];
                
                model.showbigandsinger = 1;
            }
            else {
                
                if (prime) {
                    
                    [model.array1 addObjectsFromArray:@[dic[@"big"],dic[@"small"],dic[@"singular"],dic[@"quantity"],dic[@"prime"],dic[@"composite"]]];
                }
                else {
                    [model.array1 addObjectsFromArray:@[dic[@"big"],dic[@"small"],dic[@"singular"],dic[@"quantity"]]];
                }
                
                model.showbigandsinger = 1;
            }
            [self.dataSource addObject:model];
        }
        
        [self setsort];
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        [self removelayer];
        if (type == 4 || type == 5) {
            
            if (prime) {
                
                [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:7];
            }
            else {
                [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:5];
            }
            
        }
        else if (type == 6) {
            
            [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:16];
        }
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 大小单双位置分布
-(void)initDataWithdaxiaodanshuangweizhi {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscrSizePosition.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscrSizePosition.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcrSizePosition.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"pageSize":@(self.issue)} success:^(BaseData *data) {
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            NSArray *numarr = [model.selectnumber componentsSeparatedByString:@","];
            NSString *str1 = numarr.firstObject;
            NSString *str2 = numarr.lastObject;
            NSString *str3 = str1.integerValue>4 ? @"大" : @"小";
            NSString *str4 = str1.integerValue%2==0? @"双" : @"单";
            NSString *str5 = str2.integerValue>4 ? @"大" : @"小";
            NSString *str6 = str2.integerValue%2==0? @"双" : @"单";
            NSString *str7 = [str3 stringByAppendingString:str5];
            NSString *str8 = [str3 stringByAppendingString:str6];
            NSString *str9 = [str4 stringByAppendingString:str5];
            NSString *str10 = [str4 stringByAppendingString:str6];
  
            NSInteger num1 = [self.rightTitles indexOfObject:str7];
            NSInteger num2 = [self.rightTitles indexOfObject:str8];
            NSInteger num3 = [self.rightTitles indexOfObject:str9];
            NSInteger num4 = [self.rightTitles indexOfObject:str10];
            
            for (int i = 0; i< self.rightTitles.count; i++) {
                
                NSString *key = [NSString stringWithFormat:@"num%d",i];
                NSNumber *num = dic[key];
                
                if (i == num1) {
                    
                    [model.array1 addObject:str7];
                }
                else if (i == num2) {
                    
                    [model.array1 addObject:str8];
                }
                else if (i == num3) {
                    
                    [model.array1 addObject:str9];
                }
                else if (i == num4) {
                    
                    [model.array1 addObject:str10];
                }
                else {
                    [model.array1 addObject:num];
                }
            }
     
            model.showbigandsinger = 2;
            [self.dataSource addObject:model];
        }
        [self setsort];
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        [self removelayer];
        [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:6];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 大小单双个数分布
-(void)initDataWithdaxiaodanshuanggeshu {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscrSizeCount.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscrSizeCount.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcrSizeCount.json";
    }
    
    @weakify(self)
    
    [WebTools postWithURL:url params:@{@"pageSize":@(self.issue)} success:^(BaseData *data) {
        
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            [model.array1 addObjectsFromArray:@[dic[@"big"],dic[@"small"],dic[@"singular"],dic[@"quantity"]]];
            [self.dataSource addObject:model];
        }
        [self setsort];
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        [self removelayer];
        [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:5];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 比例 number:2 二星组选， 3 三星组选 type: 1 大小比 2 奇偶比 3 质合比
-(void)initDataWithRatio:(NSInteger)type Withnumber:(NSInteger)number {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscrRatio.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscrRatio.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcrRatio.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"number":@(number),@"type":@(type),@"pageSize":@(self.issue)} success:^(BaseData *data) {
        
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            
            NSArray *array = number == 2 ? @[dic[@"ratio1"],dic[@"ratio2"],dic[@"ratio3"]] : @[dic[@"ratio1"],dic[@"ratio2"],dic[@"ratio3"],dic[@"ratio4"]];
            [model.array1 addObjectsFromArray:array];
            
            for (NSNumber *num in array) {
                
                if (num.integerValue == 0) {
                    
                    model.selectnumber = [self.rightTitles objectAtIndex:[array indexOfObject:num]];
                }
            }
            
            [self.dataSource addObject:model];
        }
        [self setsort];
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        [self removelayer];
        
        [self drawratioline:1];
        
        [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:number == 2 ? 9 : 8];
        
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 号码类型
-(void)initDataWithnumbertype {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscrNumType.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscrNumType.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcrNumType.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"pageSize":@(self.issue)} success:^(BaseData *data) {
        
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            
            NSArray *array = @[dic[@"ratio1"],dic[@"ratio2"],dic[@"ratio3"]];
            [model.array1 addObjectsFromArray:array];
            
            for (NSNumber *num in array) {
                
                if (num.integerValue == 0) {
                    
                    model.selectnumber = [self.rightTitles objectAtIndex:[array indexOfObject:num]];
                }
            }
            
            [self.dataSource addObject:model];
        }
        [self setsort];
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        [self removelayer];
        
        [self drawratioline:1];
        
        [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:9];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 跨度 最大 type: 最小 1 最大 / 2 最小，number:2 二星 / 3 三星
-(void)initDataWithmaxmin:(NSInteger)type Withnumber:(NSInteger)number {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscSpanMaxMin.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscSpanMaxMin.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcSpanMaxMin.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"pageSize":@(self.issue),@"type":@(type),@"number":@(number)} success:^(BaseData *data) {
        
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            [model.array1 addObjectsFromArray:@[dic[@"missing0"],dic[@"missing1"],dic[@"missing2"],dic[@"missing3"],dic[@"missing4"],dic[@"missing5"],dic[@"missing6"],dic[@"missing7"],dic[@"missing8"],dic[@"missing9"]]];
            [self.dataSource addObject:model];
        }
        [self setsort];
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        [self removelayer];
        
        [self drawLine:YES];
        
        [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:1];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 和值走势 type（2 二星 | 3 三星 | 5 五星）
-(void)initDataWithsumvalue:(NSInteger)type {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscrSumVal.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscrSumVal.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcrSumVal.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"pageSize":@(self.issue),@"type":@(type)} success:^(BaseData *data) {
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            for (int i = 0; i< self.rightTitles.count; i++) {
                
                NSString *key = [NSString stringWithFormat:@"num%d",i];
                
                [model.array1 addObject:dic[key]];
            }
            [self.dataSource addObject:model];
        }
        [self setsort];
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        [self removelayer];
        
        if (type == 5) {
            
            [self drawratioline:2];
            
            [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:14];
        }
        else {
            [self drawLine:YES];
            
            if (type == 2) {
                
                [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:15];
            }
            else {
                [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:10];
            }
        }
       
        
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 和尾走势 type（2 二星 | 3 三星 | 5 五星）
-(void)initDataWithsumtail:(NSInteger)type {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscSumTail.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscSumTail.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcSumTail.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@(type),@"pageSize":@(self.issue)} success:^(BaseData *data) {
        
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            for (int i = 0; i< self.rightTitles.count; i++) {
                
                NSString *key = [NSString stringWithFormat:@"missing%d",i];
                
                [model.array1 addObject:dic[key]];
            }
            [self.dataSource addObject:model];
        }
        [self setsort];
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        [self removelayer];
        
        [self drawLine:YES];
        
        [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:1];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 012路 type: 1 万位 | 2 千位 | 3 百位 | 4 十位 | 5 个位 | 6 二星和值
-(void)initDataWith012way:(NSInteger)type {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqssc012Way.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjssc012Way.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffc012Way.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@(type),@"pageSize":@(self.issue)} success:^(BaseData *data) {
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            for (int i = 0; i< self.rightTitles.count; i++) {
                
                NSString *key = [NSString stringWithFormat:@"missing%d",i];
                
                [model.array1 addObject:dic[key]];
            }
            [self.dataSource addObject:model];
        }
        [self setsort];
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        [self removelayer];
        
        [self drawLine:YES];
        
        [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:17];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 走向 （1 万位 | 2 千位 | 3 百位 | 4 十位 | 5 个位）
-(void)initDataWithshengjiang:(NSInteger)type {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscToGo.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscToGo.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcToGo.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@(type),@"pageSize":@(self.issue)} success:^(BaseData *data) {
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            NSArray *array =@[dic[@"big"],dic[@"composite"],dic[@"small"]];
            [model.array1 addObjectsFromArray:array];
            for (NSNumber *num in array) {
                
                if (num.integerValue == 0) {
                    
                    model.selectnumber = [self.rightTitles objectAtIndex:[array indexOfObject:num]];
                }
            }
            [self.dataSource addObject:model];
        }
        [self setsort];
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        [self removelayer];
        [self drawratioline:1];
        [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:18];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 振幅 1:万位 2:千位 3:百位 4:十位 5:个位
-(void)initDataWithzhengfu:(NSInteger)type {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscAmplitude.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscAmplitude.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcAmplitude.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"number":@(type),@"pageSize":@(self.issue)} success:^(BaseData *data) {
        
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *list = @[];
        
        if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
            
            list = [data.data valueForKey:@"list"];
        }
        
        for (NSDictionary *dic in list) {
            
            GraphModel *model = [[GraphModel alloc]init];
            model.version = dic[@"issue"];
            model.number = dic[@"openNumber"];
            model.selectnumber = dic[@"number"];
            
            [model.array1 addObjectsFromArray:@[dic[@"missing0"],dic[@"missing1"],dic[@"missing2"],dic[@"missing3"],dic[@"missing4"],dic[@"missing5"],dic[@"missing6"],dic[@"missing7"],dic[@"missing8"],dic[@"missing9"]]];
            
            [self.dataSource addObject:model];
        }
        [self setsort];
        [self.leftTableView reloadData];
        
        [self.rightTableView reloadData];
        
        [self removelayer];
        
        [self drawLine:YES];
        
        [self addsublabinrightbottomview:data.data[@"statistics"] Withtype:1];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}
-(void)removelayer {
    
    for (UILabel *lab in self.selectnumArray) {
        
        [lab removeFromSuperview];
        
    }
    for (CAShapeLayer *layer in self.layerArray) {
        
        [layer removeFromSuperlayer];
    }
    [self.selectnumArray removeAllObjects];
    [self.layerArray removeAllObjects];
    
    [self.layer removeFromSuperlayer];
    self.layer = nil;
}
-(void)addsublabinrightbottomview:(NSArray *)statistics Withtype:(NSInteger)type {
    
    for (id view in self.rightbottomView.subviews) {

        [view removeFromSuperview];
    }
    NSArray *array = nil;
    if (type == 1) {
        
        array = @[@"missing0",@"missing1",@"missing2",@"missing3",@"missing4",@"missing5",@"missing6",@"missing7",@"missing8",@"missing9"];
    }
    else if (type == 3) {
        
        array = @[@"big",@"small"];
    }
    else if (type == 4) {
        
        array = @[@"singular",@"quantity"];
    }
    else if (type == 5) {
        
        array = @[@"big",@"small",@"singular",@"quantity"];
    }
    else if (type == 6) {
        
        array = @[@"num0",@"num1",@"num2",@"num3",@"num4",@"num5",@"num6",@"num7",@"num8",@"num9",@"num10",@"num11",@"num12",@"num13",@"num14",@"num15"];
    }
    else if (type == 7) {
        
        array = @[@"big",@"small",@"singular",@"quantity",@"prime",@"composite"];
    }
    else if (type == 8) {
        
        array = @[@"ratio1",@"ratio2",@"ratio3",@"ratio4"];
    }
    else if (type == 9) {
        
        array = @[@"ratio1",@"ratio2",@"ratio3"];
    }
    else if (type == 10) {//三星和值
        
        array = @[@"num0",@"num1",@"num2",@"num3",@"num4",@"num5",@"num6",@"num7",@"num8",@"num9",@"num10",@"num11",@"num12",@"num13",@"num14",@"num15",@"num16",@"num17",@"num18",@"num19",@"num20",@"num21",@"num22",@"num23",@"num24",@"num25",@"num26",@"num27"];
    }
    else if (type == 11) {
        
        array = @[@"missing9",@"missing8",@"missing7",@"missing6",@"missing5",@"missing4",@"missing3",@"missing2",@"missing1",@"missing0"];
    }
    else if (type == 12) {
        
        array = @[@"missing1",@"missing3",@"missing5",@"missing7",@"missing9",@"missing0",@"missing2",@"missing4",@"missing6",@"missing8"];
    }
    else if (type == 13) {
        
        array = @[@"missing1",@"missing2",@"missing3",@"missing5",@"missing7",@"missing0",@"missing4",@"missing6",@"missing8",@"missing9"];
    }
    else if (type == 14) { //五星和值
        
        array = @[@"num0",@"num1",@"num2",@"num3",@"num4",@"num5",@"num6",@"num7",@"num8",@"num9",@"num10",@"num11",@"num12",@"num13",@"num14",@"num15",@"num16",@"num17",@"num18",@"num19",@"num20",@"num21",@"num22"];
    }
    else if (type == 15) {//二星和值
        
        array = @[@"num0",@"num1",@"num2",@"num3",@"num4",@"num5",@"num6",@"num7",@"num8",@"num9",@"num10",@"num11",@"num12",@"num13",@"num14",@"num15",@"num16",@"num17",@"num18"];
    }
    else if (type == 16) {
        
        array = @[@"singular",@"quantity",@"prime",@"composite"];
    }
    else if (type == 17) {
        
        array = @[@"missing0",@"missing1",@"missing2"];
    }
    else if (type == 18) {
        
        array = @[@"big",@"small",@"composite"];
    }
    
    for (int i = 0; i< statistics.count; i++) {
        
        UIView *view = [UIView viewWithLabelNumber:array.count Withlabelwidth:CGSizeMake(self.righttablecell_width, 25)];
        
        [self.rightbottomView addSubview:view];
        
        view.frame = CGRectMake(0, 25*i, self.rightTableView.bounds.size.width, 25);
        
        view.backgroundColor = i%2 == 0 ? [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack] : [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];
        
        NSDictionary *dic = statistics[i];
        
        for (UILabel *label in view.subviews) {
            
            label.text = nil;
            label.text = STRING(dic[array[label.tag-200]]);
            label.font = FONT(13);
            label.textColor = WHITE;
            label.backgroundColor = CLEAR;
        }
    }
}

/**
 1:五星基本走势图
 2:三星基本走势图
 3:二星基本走势图
 4:大小单双走势图
 5:二星直选走势图1
 6:二星直选走势图2
 7:三星组选走势图
 8:二星组选走势图
 9:三星大小号码分布图
 10:三星奇偶号码分布图
 11:三星质合号码分布图
 12:三星跨度走势图
 13:二星跨度走势图
 14:五星和值走势图
 15:三星和值走势图
 16:二星和值走势图
 17:个位(一星)走势图
 18:十位走势图
 19:百位走势图
 20:千位走势图
 21:万位走势图
 */
-(GraphTypeView *)graph {
    
    if (!_graph) {
        
        _graph = [[GraphTypeView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 0)];
        
        @weakify(self)
        _graph.graphTypeBlock = ^(TypeModel *model) {
            @strongify(self)
            [self.typeBtn setTitle:model.name forState:UIControlStateNormal];
            
            [self.typeBtn setImagePosition:WPGraphicBtnTypeRight spacing:3];
            
            [self.titlelab mas_remakeConstraints:^(MASConstraintMaker *make) {
                @strongify(self)
                make.left.equalTo(self.typeBtn.mas_right).offset(10);
                make.centerY.equalTo(self.typeBtn);
            }];
            
            self.selectindex = 0;
            
            [self reloadDataWithtype:model.type];
        };
    }
    return _graph;
}

-(void)selectTypeClick:(UIButton *)sender {
    
    if (self.graph.bounds.size.height > 0) {
        
        [self.graph dismiss];
    }
    else {
        [self.graph show:self.view];
    }
    
}

-(void)drawLine:(BOOL)showline{
    
    CGFloat startAngle = 0.0;
    CGFloat endAngle = M_PI * 2;
    
    UIBezierPath * linepath = [UIBezierPath bezierPath];
    
    for (int i= 0; i<self.dataSource.count; i++) {

        GraphModel *model = [self.dataSource objectAtIndex:i];
        
        if ([model.selectnumber containsString:@","]) {
            
            NSArray *numarray = [model.selectnumber componentsSeparatedByString:@","];
            
            for (NSString *num in numarray) {
                
//                NSInteger row = [model.array1[num.integerValue]integerValue];
                NSInteger row = [self.rightTitles indexOfObject:num];
                
                CGFloat x = (row + 0.5)*self.righttablecell_width;
                CGFloat y = (i + 0.5) * 30;
                CGPoint p = CGPointMake(x, y);
                i==0 ? [linepath moveToPoint:p] : [linepath addLineToPoint:p];
                
                UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:p radius:13 startAngle:startAngle endAngle:endAngle clockwise:true];
                
                // 画圆
                CAShapeLayer * layer = [[CAShapeLayer alloc] init];
                layer.path = path.CGPath;
                layer.fillColor = LINECOLOR.CGColor;
                [self.rightTableView.layer addSublayer:layer];
                [self.layerArray addObject:layer];
                
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.righttablecell_width, 25)];
                lab.center = p;
                lab.textColor = [UIColor whiteColor];
                lab.text = num;
                lab.textAlignment = NSTextAlignmentCenter;
                lab.font = [UIFont boldSystemFontOfSize:13];
                [self.selectnumArray addObject:lab];
            }
        }
        else {
            
            NSInteger row = [self.rightTitles indexOfObject:model.selectnumber];
    
            CGFloat x = (row + 0.5)*self.righttablecell_width;
            CGFloat y = (i + 0.5) * 30 ;
            CGPoint p = CGPointMake(x, y);
            i==0 ? [linepath moveToPoint:p] : [linepath addLineToPoint:p];
            
            UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:p radius:13 startAngle:startAngle endAngle:endAngle clockwise:true];
            
            // 画圆
            CAShapeLayer * layer = [[CAShapeLayer alloc] init];
            layer.path = path.CGPath;
            layer.fillColor = LINECOLOR.CGColor;
            [self.rightTableView.layer addSublayer:layer];
            [self.layerArray addObject:layer];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.righttablecell_width, 25)];
            lab.center = p;
            lab.textColor = [UIColor whiteColor];
            lab.text = model.selectnumber;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = [UIFont boldSystemFontOfSize:13];
            [self.selectnumArray addObject:lab];
            
        }
        
    }
    //画线
    if (showline) {
        
        if ([self.setDic[@"line"]integerValue]==0) {
            
            [self addline:linepath];
        }
    }
   
    for (UILabel * lbl in self.selectnumArray) {
        [self.rightTableView addSubview:lbl];
    }
}
#pragma mark - type=1:大小比、奇偶比、质合比、号码类型比 type=2:五星和值走势
-(void)drawratioline:(NSInteger)type {
    
    CGFloat startAngle = 0.0;
    CGFloat endAngle = M_PI * 2;
    
    UIBezierPath * linepath = [UIBezierPath bezierPath];
    
    for (int i= 0; i<self.dataSource.count; i++) {
        
        GraphModel *model = [self.dataSource objectAtIndex:i];
        
        NSInteger row = 0;
        if (type == 1) {
            
            row = [model.array1 indexOfObject:@0];
        }
        else {
            
            row = model.selectnumber.integerValue<14 ? 0 : model.selectnumber.integerValue > 34 ? 22 : [self.rightTitles indexOfObject:model.selectnumber];
     
        }
        
        CGFloat x = (row + 0.5)*self.righttablecell_width;
        CGFloat y = (i + 0.5) * 30;
        CGPoint p = CGPointMake(x, y);
        i==0 ? [linepath moveToPoint:p] : [linepath addLineToPoint:p];
        
        UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:p radius:13 startAngle:startAngle endAngle:endAngle clockwise:true];
        
        // 画圆
        CAShapeLayer * layer = [[CAShapeLayer alloc] init];
        layer.path = path.CGPath;
        layer.fillColor = LINECOLOR.CGColor;
        [self.rightTableView.layer addSublayer:layer];
        [self.layerArray addObject:layer];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.righttablecell_width, 25)];
        lab.center = p;
        lab.textColor = [UIColor whiteColor];
        lab.text = model.selectnumber;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont boldSystemFontOfSize:13];
        [self.selectnumArray addObject:lab];
    }
    
    //画线
    if ([self.setDic[@"line"]integerValue]==0) {
        
        [self addline:linepath];
    }
    
    for (UILabel * lbl in self.selectnumArray) {
        
        [self.rightTableView addSubview:lbl];
    }
}

-(void)addline:(UIBezierPath *) linepath {
    
    self.layer = [[CAShapeLayer alloc] init];
    self.layer.path = linepath.CGPath;
    self.layer.lineWidth = 2;
    self.layer.fillColor = [UIColor clearColor].CGColor;
    self.layer.strokeColor = LINECOLOR.CGColor;
    [self.rightTableView.layer addSublayer:self.layer];
    
    [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:UITableViewRowAnimationTop];
    [self.rightTableView reloadData];
}

-(void)setsort {
    
    if ([self.setDic[@"sort"]integerValue]==1) {
        
        NSArray *reversedArray = [[self.dataSource reverseObjectEnumerator] allObjects];
        
        [self.dataSource removeAllObjects];
        
        [self.dataSource addObjectsFromArray:reversedArray];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
