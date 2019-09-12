//
//  SixHistoryResultCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/8.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixHistoryResultCtrl.h"
#import "HistoryResultCell.h"
#import "VersionsPickerView.h"
#import "CalendarView.h"
#import "IGKbetDetailCtrl.h"
#import "PCInfoModel.h"
@interface SixHistoryResultCtrl ()

@property (nonatomic, strong)UILabel *yearlab;

@property (nonatomic, strong)UIButton *sortBtn;

@property (nonatomic, strong)UIButton *fiveBtn;

@property (nonatomic, strong)UIButton *historyBtn;

@property (nonatomic, strong)UIButton *calendarBtn;

@property (nonatomic, strong)CalendarView *calendarView;

@property (nonatomic, copy) NSString *year;

@property (nonatomic, assign) BOOL sort;

@property (nonatomic, assign) BOOL wuxin;

@end

@implementation SixHistoryResultCtrl

-(void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}
-(UIButton *)sortBtn {
    
    if (!_sortBtn) {
        
        _sortBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"升序" andTitleColor:YAHEI andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(sortClick:) andType:UIButtonTypeCustom];
        _sortBtn.layer.cornerRadius = 4;
        _sortBtn.layer.borderColor = YAHEI.CGColor;
        _sortBtn.layer.borderWidth = 1;
        [_sortBtn setTitle:@"降序" forState:UIControlStateSelected];
        [_sortBtn setTitleColor:BASECOLOR forState:UIControlStateSelected];
    }
    return _sortBtn;
}

-(UIButton *)fiveBtn {
    
    if (!_fiveBtn) {
        
        _fiveBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"五行" andTitleColor:YAHEI andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(fiveClick:) andType:UIButtonTypeCustom];
        _fiveBtn.layer.cornerRadius = 4;
        _fiveBtn.layer.borderWidth = 1;
        _fiveBtn.layer.borderColor = YAHEI.CGColor;
        [_fiveBtn setTitleColor:BASECOLOR forState:UIControlStateSelected];
    }
    return _fiveBtn;
}

-(UILabel *)yearlab {
    
    if (!_yearlab) {
        
        _yearlab = [Tools createLableWithFrame:CGRectZero andTitle:[NSString stringWithFormat:@"%lu年历史开奖记录",(unsigned long)[NSDate date].getYear] andfont:FONT(14) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    }
    return _yearlab;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titlestring = @"历史开奖";
    @weakify(self)
    [self rigBtn:@"选择年份" Withimage:@"玩法筛选" With:^(UIButton *sender) {
        @strongify(self)
        VersionsPickerView *picker = [VersionsPickerView shareWithDate:self.year];
        picker.lastDate = self.year;
        [picker setpicker];
        picker.onlyshowyear = YES;
        picker.VersionBlock = ^(NSString *time, NSString *version,NSString *url) {
            @strongify(self)
            [sender setTitle:time forState:UIControlStateNormal];
            
            [sender setImagePosition:WPGraphicBtnTypeRight spacing:3];
            
            self.year = time;
            
            self.yearlab.text = [NSString stringWithFormat:@"%@年历史开奖记录",time];
            
            [self.tableView.mj_header beginRefreshing];
        };
        
        [picker show];
    }];
    
    [self.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.navView).offset(-8);
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.centerY.equalTo(self.titlelab);
    }];
    self.rightBtn.layer.cornerRadius = 5;
    self.rightBtn.layer.borderColor = WHITE.CGColor;
    self.rightBtn.layer.borderWidth = 0.8;
    [self.rightBtn setImagePosition:WPGraphicBtnTypeRight spacing:2];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HistoryResultCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    self.tableView.rowHeight = 100;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT, 0, SAFE_HEIGHT + 40, 0));
    }];
    
    self.scrollView.backgroundColor = [[CPTThemeConfig shareManager] openLotteryCalendarBackgroundcolor];
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(SCREEN_WIDTH, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 40);
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 555);
    
//    self.calendarView = [[[NSBundle mainBundle]loadNibNamed:@"CalendarView" owner:self options:nil]firstObject];
//    self.calendarView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 555);
    self.calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 555)];
    
    self.calendarView.backgroundColor = [[CPTThemeConfig shareManager] openLotteryCalendarBackgroundcolor];
    [self.scrollView addSubview:self.calendarView];
    
    
    NSArray *array = @[@"历史开奖",@"开奖日期"];
    NSArray *imgarr = @[@"calendar_4",@"calendar_2"];
    NSString *KJRLSelectCalendar2 = [[CPTThemeConfig shareManager] KJRLSelectCalendar2];
    NSString *KJRLSelectCalendar4 = [[CPTThemeConfig shareManager] KJRLSelectCalendar4];

    NSArray *imgselectarr = @[KJRLSelectCalendar2,KJRLSelectCalendar4];
    for (int i = 0 ;i < array.count; i++) {
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectMake(SCREEN_WIDTH/2*i, SCREEN_HEIGHT - 40, SCREEN_WIDTH/2, 40) andTitle:array[i] andTitleColor:[[CPTThemeConfig shareManager] CO_OpenLetBtnText_Normal] andBackgroundImage:nil andImage:IMAGE(imgarr[i]) andTarget:self andAction:@selector(typeClick:) andType:UIButtonTypeCustom];
        
        [btn setTitleColor:[[CPTThemeConfig shareManager] CO_OpenLetBtnText_Selected] forState:UIControlStateSelected];
        [btn setImagePosition:WPGraphicBtnTypeLeft spacing:3];
        btn.backgroundColor = [[CPTThemeConfig shareManager] CO_OpenLot_BtnBack_Normal];
        
        
        [btn setImage:IMAGE(imgselectarr[i]) forState:UIControlStateSelected];
        if (i == 0) {
            self.historyBtn = btn;
        } else {
            self.calendarBtn = btn;
        }
        [self.view addSubview:btn];
    }
    
    if (self.type == 1) {
        [self typeClick:self.historyBtn];
    } else {
        [self typeClick:self.calendarBtn];
    }
    
    NSInteger year = [NSDate date].getYear;
    self.year = INTTOSTRING(year);
    self.page = 1;
    
    [self initData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        [self initData];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page ++ ;
        [self initData];
    }];
    
    //投注按钮
    [self buildBettingBtn];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 35;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    head.backgroundColor = BASECOLOR;
    [head addSubview:self.yearlab];
    [head addSubview:self.sortBtn];
    [head addSubview:self.fiveBtn];
    
    [self.yearlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(head).offset(12);
        make.centerY.equalTo(head);
    }];
    
    [self.fiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(head).offset(-12);
        make.centerY.equalTo(head);
        make.size.mas_equalTo(CGSizeMake(40, 23));
    }];
    @weakify(self)
    [self.sortBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.fiveBtn.mas_left).offset(-8);
        make.centerY.equalTo(head);
        make.size.mas_equalTo(CGSizeMake(40, 23));
    }];
    
    return head;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HistoryResultCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    NSArray *array = [self.dataSource objectAtIndex:indexPath.row];
    
    int i = 0;
    for (NSDictionary *dic in array) {
        
        if (i == 0) {
            
            cell.versionslab.text = [NSString stringWithFormat:@"%@ %@",dic[@"type"],dic[@"value"]];
        }
        else {
            
            UIButton *btn = [cell.numberBtns objectAtIndex:i-1];
            
            [btn setTitle:dic[@"type"] forState:UIControlStateNormal];
            
            [btn setBackgroundImage:[Tools numbertoimage:dic[@"type"] Withselect:NO] forState:UIControlStateNormal];
            
            UILabel *lab = [cell.numberlabs objectAtIndex:i-1];
            
            if (self.wuxin) {
            
                lab.text = [NSString stringWithFormat:@"%@/%@",dic[@"value"],[Tools numbertowuxin:dic[@"type"]]];
            }
            else {
                lab.text = dic[@"value"];
            }
        }
        i++;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IGKbetDetailCtrl *detail = [[IGKbetDetailCtrl alloc]init];
    detail.type = CPTBuyTicketType_LiuHeCai;
    SixInfoModel *model = [[SixInfoModel alloc]init];
    NSArray *array = [self.dataSource objectAtIndex:indexPath.row];
    NSMutableArray *numbers = [[NSMutableArray alloc]init];
    NSMutableArray *shengxiao = [[NSMutableArray alloc]init];

    for (int i = 0; i< array.count; i++) {
        NSDictionary *dic = array[i];
        if (i == 0) {
            
            model.issue = dic[@"value"];
            model.time = dic[@"type"];
        }
        else{
            [numbers addObject:dic[@"type"]];
            [shengxiao addObject:dic[@"value"]];
        }
    }
    
    NSString *numStr = [numbers componentsJoinedByString:@","];
    NSString *shengxiaoStr = [shengxiao componentsJoinedByString:@","];
    model.numberstr = numStr;
    model.shengxiao2 = shengxiaoStr;
    detail.sixmodel = model;
    
    PUSH(detail);
}




-(void)sortClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.backgroundColor = YAHEI;
    } else {
        sender.backgroundColor = CLEAR;
    }
    
    self.sort = sender.selected;

    self.page = 1;
    [self initData];
}

-(void)fiveClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        sender.backgroundColor = YAHEI;
    }
    else {
        sender.backgroundColor = CLEAR;
    }
    
    self.wuxin = sender.selected;
    
    [self.tableView reloadData];
}

-(void)typeClick:(UIButton *)sender {
    
    self.historyBtn.selected = NO;
    self.calendarBtn.selected = NO;
    self.historyBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.calendarBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    sender.backgroundColor = [[CPTThemeConfig shareManager] CO_OpenLot_BtnBack_Selected];
    sender.selected = YES;
    if (sender == self.historyBtn) {
        
        self.rightBtn.hidden = NO;
        self.titlestring = @"历史开奖";
        self.scrollView.frame = CGRectMake(SCREEN_WIDTH, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 40);
    } else {
        self.rightBtn.hidden = YES;
        self.titlestring = @"开奖日历";
        self.scrollView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - 40);
    }
}


-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/getInfoF.json" params:@{@"type":@"661",@"year":self.year,@"pageNum":@(self.page),@"pageSize":@30, @"sort" : self.sort ? @"1" : @"0"} success:^(BaseData *data) {
        @strongify(self)
                   
        [self.tableView.mj_header endRefreshing];
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        if (self.page == 1) {
            [self.dataSource removeAllObjects];
        }
        
        NSArray *array = data.data;
        
        if (array.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }

        [self.dataSource addObjectsFromArray:array];
        
        [self endRefresh:self.tableView WithdataArr:data.data];
        
        [self.tableView reloadData];
       
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self endRefresh:self.tableView WithdataArr:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
