//
//  SixHelpCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/7.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixHelpCtrl.h"
#import "SixHelpCell.h"
#import "VersionsPickerView.h"
#import "ConditionView.h"
#import "SixModel.h"
@interface SixHelpCtrl ()
@property (nonatomic, strong) UIButton *yearBtn;
/**
 生肖 号码 五行 波色 家野 尾数
 */
@property (nonatomic, strong) ConditionModel *conditonmodel;

@property (nonatomic, copy) NSString *year;
/**
 仅显示出现的期数集合
 */
@property (nonatomic, strong) NSMutableArray *filterArray;

@property (nonatomic, assign) BOOL onlyshowfilter;

@property (nonatomic, strong) ConditionView *conditionview;
@end

@implementation SixHelpCtrl

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [ConditionView tearDown];
    
    self.conditionview = nil;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"查询助手";
    
    @weakify(self)
    [self rigBtn:@"条件" Withimage:@"玩法筛选" With:^(UIButton *sender) {
        
        _conditionview = [ConditionView share];
        @strongify(self)
        self.conditionview.conditionBlock = ^(ConditionModel *model) {
            @strongify(self)
            self.conditonmodel = model;
            
            [sender setTitle:model.title forState:UIControlStateNormal];
            
            [self getfilterData];
            
            [self.tableView reloadData];
        };
        self.conditionview.conditionclearBlock = ^{
            @strongify(self)
            self.conditonmodel = nil;
            
            [sender setTitle:@"条件" forState:UIControlStateNormal];
            
            [self.tableView reloadData];
        };
        
        [self.conditionview show];
    }];
    
    self.yearBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"年份" andTitleColor:WHITE andBackgroundImage:nil andImage:IMAGE(@"玩法筛选") andTarget:self andAction:@selector(yearClick:) andType:UIButtonTypeCustom];
    [self.navView addSubview:self.yearBtn];
    
    [self.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.navView).offset(-8);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.centerY.equalTo(self.titlelab);
    }];
    
    [self.yearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.rightBtn.mas_left).offset(-8);
        make.size.mas_equalTo(CGSizeMake(55, 30));
        make.centerY.equalTo(self.titlelab);
    }];
    
    [self setbuttonlayer:self.rightBtn];
    [self setbuttonlayer:self.yearBtn];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SixHelpCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    self.tableView.rowHeight = 30;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT, 0, 0, 0));
    }];
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.onlyshowfilter == YES ? self.filterArray.count : self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    view.backgroundColor = [UIColor colorWithHex:@"dddddd"];
    
    UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:@"仅显示出现的期数" andTitleColor:[UIColor darkGrayColor] andBackgroundImage:nil andImage:IMAGE(@"六合彩助手未勾选") andTarget:self andAction:@selector(showversionClick:) andType:UIButtonTypeCustom];
    [btn setImage:IMAGE(@"六合彩助手勾选") forState:UIControlStateSelected];
    btn.titleLabel.font = FONT(12);
    [btn setImagePosition:WPGraphicBtnTypeLeft spacing:3];
    [view addSubview:btn];
    btn.selected = self.onlyshowfilter;
    btn.hidden = self.conditonmodel == nil ? YES : NO;
    UIButton *infobtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"" andTitleColor:[UIColor darkGrayColor] andBackgroundImage:nil andImage:IMAGE(@"六合彩帮助说明") andTarget:self andAction:@selector(showInfoClick:) andType:UIButtonTypeCustom];
    [view addSubview:infobtn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view).offset(8);
        make.top.equalTo(view).offset(4);
        make.height.equalTo(@30);
    }];
    
    [infobtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-8);
        make.top.equalTo(view).offset(0);
        make.height.width.equalTo(@30);
    }];
    
    SixHelpCell *cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([SixHelpCell class]) owner:self options:nil]firstObject];
    cell.frame = CGRectMake(0, 30, SCREEN_WIDTH, 30);
    [view addSubview:cell];
    
    NSArray *titles = @[@"年份/期数",@"一",@"二",@"三",@"四",@"五",@"六",@"特码"];
    int i = 0;
    for (UILabel *lab in cell.numberlabs) {
        
        lab.text = titles[i];
        lab.backgroundColor = BASECOLOR;
        i++;
    }
    
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SixHelpCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];

    int i = 0;
    
    NSArray *array = nil;
    
    if (self.onlyshowfilter) {
        
        array = [self.filterArray objectAtIndex:indexPath.row];
    }
    else{
        array = [self.dataSource objectAtIndex:indexPath.row];
    }
    
    for (Drawlab *lab in cell.numberlabs) {
        
        SixModel *model = array[i];
        
        lab.backgroundColor = indexPath.row%2 == 0 ? WHITE : [UIColor groupTableViewBackgroundColor];
        lab.textColor = [UIColor darkGrayColor];
        lab.showbg = NO;
        lab.bgColor = CLEAR;
        
        if (i == 0) {
            
            NSArray *time = [model.time componentsSeparatedByString:@"-"];
            lab.text = [NSString stringWithFormat:@"%@/%@",time.firstObject,model.value];
        }
        else {
            lab.text = model.number;
            
            if (self.conditonmodel == nil) {
                
                lab.text = model.number;
            }
            else {
                int i = 0;
                for (ConditionClassModel *classmodel in self.conditonmodel.classmodelArray) {
                    
                    if (classmodel.selected) {
                        
                        if (self.conditonmodel.ID == 0) { //生肖
                            
                            lab.text = model.value;
                            
                            if ([model.value isEqualToString:classmodel.subtitle]) {
                                
                                lab.showbg = YES;
                                lab.bgColor = i == 0 ? [UIColor colorWithHex:@"f15347"] : i == 1 ? [UIColor colorWithHex:@"0587c5"] : [UIColor colorWithHex:@"46be64"];
                                lab.textColor = WHITE;
                            }
                            i ++;
                        }
                        else if (self.conditonmodel.ID == 1) { //号码
                            
                            lab.text = model.number;
                            if ([model.number isEqualToString:classmodel.subtitle]) {
                                
                                lab.showbg = YES;
                                lab.bgColor = i == 0 ? [UIColor colorWithHex:@"f15347"] : i == 1 ? [UIColor colorWithHex:@"0587c5"] : [UIColor colorWithHex:@"46be64"];
                                lab.textColor = WHITE;
                            }
                            i++;
                        }
                        else if (self.conditonmodel.ID == 2) { // 五行
                            
                            lab.text = model.wuxin;
                            if ([model.wuxin isEqualToString:classmodel.subtitle]) {
                                
                                lab.showbg = YES;
                                lab.bgColor = [UIColor redColor];
                                lab.textColor = WHITE;
                            }
                        }
                        else if (self.conditonmodel.ID == 3) { //波色
                            
                            lab.text = [model.bosestring substringToIndex:1];
                            if ([model.bosestring isEqualToString:classmodel.subtitle]) {
                                
                                lab.showbg = YES;
                                lab.bgColor = model.bose;
                                lab.textColor = WHITE;
                            }
                        }
                        else if (self.conditonmodel.ID == 4) { //家野
                            
                            lab.text = model.jiaye;
                            if ([model.jiaye isEqualToString:[classmodel.subtitle substringToIndex:1]]) {
                                
                                lab.showbg = YES;
                                lab.bgColor = [UIColor redColor];
                                lab.textColor = WHITE;
                            }
                        }
                        else if (self.conditonmodel.ID == 5) { // 尾数
                            
                            if ([model.last isEqualToString:classmodel.subtitle]) {
                                
                                lab.showbg = YES;
                                lab.bgColor = [UIColor redColor];
                                lab.textColor = WHITE;
                            }
                        }
                        else{
                            lab.showbg = NO;
                            lab.bgColor = CLEAR;
                        }
                        [lab setNeedsDisplay];
                    }

                }
            }
        }
        
        i++;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/getInfoF.json" params:@{@"type":@661,@"year":self.year,@"sort":@0,@"pageNum":@(self.page),@"pageSize":pageSize} success:^(BaseData *data) {
        
        @strongify(self)
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }
        
        NSArray *array = data.data;
        
        for (NSArray *arr in array) {
            
            NSArray *dataarr = [SixModel mj_objectArrayWithKeyValuesArray:arr];
            
            [self.dataSource addObject:dataarr];
        }
        
        [self getfilterData];
        
        [self endRefresh:self.tableView WithdataArr:data.data];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self endRefresh:self.tableView WithdataArr:nil];
    }];
}





-(void)setbuttonlayer:(UIButton *)sender {
    
    sender.layer.cornerRadius = 4;
    sender.layer.borderColor = WHITE.CGColor;
    sender.layer.borderWidth = 1.0f;
    [sender setImagePosition:WPGraphicBtnTypeRight spacing:3];
}

#pragma mark - 选择年份
-(void)yearClick:(UIButton *)sender {
    
    VersionsPickerView *picker = [VersionsPickerView shareWithDate:self.year];
    [picker setpicker];

    picker.onlyshowyear = YES;
    
    @weakify(self)
    picker.VersionBlock = ^(NSString *time, NSString *version, NSString *url) {
        @strongify(self)
        self.year = time;
        
        [sender setTitle:time forState:UIControlStateNormal];
        
        [sender setImagePosition:WPGraphicBtnTypeRight spacing:2];
        
        [self.tableView.mj_header beginRefreshing];
    };
    
    [picker show];
}

-(void)showversionClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    self.onlyshowfilter = sender.selected;
    
    [self.tableView reloadData];
}

-(void)showInfoClick:(UIButton *)sender {
    
    ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
    [alert buildsixhelpInfoView];
    [alert show];
}

-(NSMutableArray *)filterArray {
    
    if (!_filterArray) {
        
        _filterArray = [[NSMutableArray alloc]init];
    }
    return _filterArray;
}

-(void)getfilterData {
    
    [self.filterArray removeAllObjects];
    
    for (NSArray *array in self.dataSource) {
        
        int i = 0;
        
        for (SixModel *model in array) {
            
            for (ConditionClassModel *classmodel in self.conditonmodel.classmodelArray) {
                
                if (classmodel.selected) {
                    
                    if (self.conditonmodel.ID == 0) { //生肖
                        
                        if ([model.value isEqualToString:classmodel.subtitle]) {
                            
                            i++;
                        }
                    }
                    else if (self.conditonmodel.ID == 1) { //号码
                        
                        if ([model.number isEqualToString:classmodel.subtitle]) {
                            
                           i++;
                        }
                    }
                    else if (self.conditonmodel.ID == 2) { // 五行
                        
                        if ([model.wuxin isEqualToString:classmodel.subtitle]) {
                            
                            i++;
                        }
                    }
                    else if (self.conditonmodel.ID == 3) { //波色
                        
                        if ([model.bosestring isEqualToString:classmodel.subtitle]) {
                            
                            i++;
                        }
                    }
                    else if (self.conditonmodel.ID == 4) { //家野
                        
                        if ([model.jiaye isEqualToString:[classmodel.subtitle substringToIndex:1]]) {
                            
                            i++;
                        }
                    }
                    else if (self.conditonmodel.ID == 5) { // 尾数
                        
                        if ([model.last isEqualToString:classmodel.subtitle]) {
                            
                            i++;
                        }
                    }
                }
            }
        }
        
        if (i > 0) {
            
            [self.filterArray addObject:array];
        }
    }
    
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
