//
//  PCTodayStatisticsCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PCTodayStatisticsCtrl.h"
#import "PCTodayCell.h"
#import "TodayTwoCell.h"
#import "PCTodayModel.h"
@interface PCTodayStatisticsCtrl ()

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) NSDictionary *setdic;

@end

@implementation PCTodayStatisticsCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"今日统计";
    
    [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] WFSMImage] With:^(UIButton *sender) {
        
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        [alert buildPCtodayInfoView];
        [alert show];
    }];
    
    UIButton *setBtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE([[CPTThemeConfig shareManager] IC_Nav_Setting_Gear]) andTarget:self andAction:@selector(setClick) andType:UIButtonTypeCustom];
    [self.navView addSubview:setBtn];
    
    @weakify(self)
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.rightBtn.mas_left).offset(-8);
        make.size.mas_equalTo(CGSizeMake(43, 43));
        make.centerY.equalTo(self.rightBtn);
    }];
    
    [self buildTimeViewWithType:5 With:^(UIButton *sender) {
        
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];

        [alert builddateView:^(NSString *date) {
            @strongify(self)
            [sender setTitle:date forState:UIControlStateNormal];
            
            self.time = date;
            
            [self initData];
        }];
        [alert show];
    }With:^{
        @strongify(self)
        [self initData];
    }];
    
    UIImage *imgv1 = [Tools createImageWithColor:[UIColor lightGrayColor] Withsize:CGSizeMake(4, 4)];
    UIImage *imgv2 = [Tools createImageWithColor:[UIColor darkGrayColor] Withsize:CGSizeMake(4, 4)];
    
    UIButton *btn1 = [Tools createButtonWithFrame:CGRectZero andTitle:@"未开次数" andTitleColor:[UIColor lightGrayColor] andBackgroundImage:nil andImage:imgv1 andTarget:self andAction:@selector(lightGrayColor) andType:UIButtonTypeCustom];
    btn1.titleLabel.font = FONT(10);
    UIButton *btn2 = [Tools createButtonWithFrame:CGRectZero andTitle:@"已开次数" andTitleColor:[UIColor darkGrayColor] andBackgroundImage:nil andImage:imgv2 andTarget:self andAction:@selector(darkGrayColor) andType:UIButtonTypeCustom];
    btn2.titleLabel.font = FONT(10);
    [self.selectdateView addSubview:btn1];
    [self.selectdateView addSubview:btn2];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.selectdateView).offset(4);
        make.left.equalTo(self.selectdateView).offset(8);
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.selectdateView).offset(-4);
        make.left.equalTo(self.selectdateView).offset(8);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PCTodayCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TodayTwoCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJHeaderIdentifier];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT+34, 0, SAFE_HEIGHT, 0));
    }];
    
    self.time = [Tools getlocaletime];
    
    [self initData];
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"kj_pcegg" object:nil];
    
}

-(void)removenotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_pcegg" object:nil];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 39;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        NSArray *array = @[@"号码",@"第一区",@"第二区",@"第三区"];
        UIView *v1 = [UIView viewWithLabelNumber:array.count Withlabelwidth:CGSizeMake(SCREEN_WIDTH/array.count, 30)];
        v1.backgroundColor = [UIColor colorWithHex:@"cccccc"];
        NSInteger index = 0;
        for (UILabel *lab in v1.subviews) {
            
            lab.text = array[index];
            lab.font = FONT(13);
            lab.textColor = [UIColor darkGrayColor];
            lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
            index ++;
        }
        
        return v1;
    }
    else {
    
        UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        v2.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:@"开奖号码出现次数统计" andfont:FONT(13) andTitleColor:[UIColor darkGrayColor] andBackgroundColor:CLEAR andTextAlignment:0];
        [v2 addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(v2).offset(12);
            make.centerY.equalTo(v2);
        }];
        
        return v2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        PCTodayCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
        
        PCTodayModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        cell.numberlab.text = INTTOSTRING(indexPath.row);
        
        cell.firstcloselab.text = INTTOSTRING(model.numRegion.noOpen1);
        
        cell.firstopenlab.text = INTTOSTRING(model.numRegion.open1);
        
        cell.secondcloselab.text = INTTOSTRING(model.numRegion.noOpen2);
        
        cell.secondopenlab.text = INTTOSTRING(model.numRegion.open2);
        
        cell.thirdcloselab.text = INTTOSTRING(model.numRegion.noOpen3);
        
        cell.thirdopenlab.text = INTTOSTRING(model.numRegion.open3);
        
        for (UILabel *unreadlab in cell.noopenArray) {
            
            if (self.setdic) {
                
                unreadlab.backgroundColor = WHITE;
                
                if (self.setdic[@"y_color"]) {
                    
                    NSInteger y_min = [self.setdic[@"y_min"]integerValue];
                    NSInteger y_max = [self.setdic[@"y_max"]integerValue];
                    if (unreadlab.text.integerValue >= y_min && unreadlab.text.integerValue <= y_max) {
                        
                        unreadlab.backgroundColor = [UIColor colorWithHex:self.setdic[@"y_color"]];
                    }
                    
                }
                if (self.setdic[@"o_color"]) {
                    
                    NSInteger y_min = [self.setdic[@"o_min"]integerValue];
                    NSInteger y_max = [self.setdic[@"o_max"]integerValue];
                    if (unreadlab.text.integerValue >= y_min && unreadlab.text.integerValue <= y_max) {
                        
                        unreadlab.backgroundColor = [UIColor colorWithHex:self.setdic[@"o_color"]];
                    }
                }
                if (self.setdic[@"b_color"]) {
                    
                    NSInteger y_min = [self.setdic[@"b_min"]integerValue];
                    NSInteger y_max = [self.setdic[@"b_max"]integerValue];
                    if (unreadlab.text.integerValue >= y_min && unreadlab.text.integerValue <= y_max) {
                        
                        unreadlab.backgroundColor = [UIColor colorWithHex:self.setdic[@"b_color"]];
                    }
                }
            }
            else{
                unreadlab.backgroundColor = WHITE;
            }
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else {
        
        TodayTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:RJHeaderIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.numberlab.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        
        PCTodayModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        cell.countlab.text = [NSString stringWithFormat:@"%ld次",model.openCount];
        
        NSInteger total = model.numRegion.open1 + model.numRegion.noOpen1;
        
        if (total == 0) {
            
            cell.progressview.progress = 0;
            
            [cell layoutIfNeeded];
            
            return cell;
        }
        CGFloat progress = (CGFloat)model.openCount/total;
        
        cell.progressview.progress = progress;
     
        return cell;
    }
}

-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/pceggSg/getStatistics.json" params:@{@"time":self.time} success:^(BaseData *data) {
        
        @strongify(self)
        
        if ([[data.data valueForKey:@"list"]isKindOfClass:[NSArray class]]) {
            
            NSArray *arr = [PCTodayModel mj_objectArrayWithKeyValuesArray:[data.data valueForKey:@"list"]];
            
            [self.dataSource removeAllObjects];
            
            [self.dataSource addObjectsFromArray:arr];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        
    }];
}

-(void)setClick {
    
    ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
    [alert buildtodaysetWithtype:1 WithView:^(NSDictionary *dic) {
        
        NSInteger type = [[dic valueForKey:@"type"] integerValue];
        
        if (type == 0) {
            
            self.setdic = nil;
        }
        else {
            
            self.setdic = dic;
        }
        
        [self.tableView reloadData];
    }];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
