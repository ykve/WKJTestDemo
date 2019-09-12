//
//  PK10TodayNumberCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/21.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10TodayNumberCtrl.h"
#import "RightTableViewCell.h"
#define LeftTableViewWidth 60
#define RightTableViewWith 28
@interface PK10TodayNumberCtrl ()

@property (nonatomic, strong) UITableView *leftTableView, *rightTableView;

@property (nonatomic, strong) NSArray *rightTitles;

@property (nonatomic, strong) UIScrollView *buttomScrollView;

@property (nonatomic, strong) NSDictionary *setDic;

@end

@implementation PK10TodayNumberCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WHITE;
    self.titlestring = @"今日号码";
    [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] WFSMImage] With:^(UIButton *sender) {
        
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        [alert buildPK10todaynumberInfoView];
        [alert show];
    }];
    @weakify(self)
    UIButton *setBtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE([[CPTThemeConfig shareManager] IC_Nav_Setting_Gear]) andTarget:self andAction:@selector(setClick) andType:UIButtonTypeCustom];
    [self.navView addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.rightBtn.mas_left).offset(-8);
        make.size.mas_equalTo(CGSizeMake(43, 43));
        make.centerY.equalTo(self.rightBtn);
    }];
   
    [self buildTimeViewWithType:self.lottery_type With:nil With:^{
        @strongify(self)
        [self initData];
    }];
    
    self.rightTitles = @[@"冠军",@"亚军",@"第三名",@"第四名",@"第五名",@"第六名",@"第七名",@"第八名",@"第九名",@"第十名"];
    [self loadLeftTableView];
    [self loadRightTableView];
    
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
    
    if (self.lottery_type == 6) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"kj_bjpks" object:nil];
    }
    else{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"kj_xyft" object:nil];
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
//    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTableView.rowHeight = 40;
    self.leftTableView.backgroundColor = CLEAR;
    self.leftTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.leftTableView];
    @weakify(self)
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT+34, 0, SAFE_HEIGHT, SCREEN_WIDTH - LeftTableViewWidth));
    }];
}

- (void)loadRightTableView{
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, RightTableViewWith * 20, SCREEN_HEIGHT - NAV_HEIGHT - 34) style:UITableViewStylePlain];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
//    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.rowHeight = 40;
    self.rightTableView.backgroundColor = CLEAR;
    self.rightTableView.tableFooterView = [UIView new];
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
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT+34,LeftTableViewWidth, 0, 0));
    }];
}

#pragma mark - table view dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        static NSString *reuseIdentifer = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifer];
            
            [self resetSeparatorInsetForCell:cell];
            
            UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:WHITE andBackgroundColor:LINECOLOR andTextAlignment:1];
            lab.tag = 100;
            lab.layer.cornerRadius = 12;
            lab.layer.masksToBounds = YES;
            [cell.contentView addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.center.equalTo(cell.contentView);
                make.size.mas_equalTo(CGSizeMake(24, 24));
            }];
        }
        for (UILabel *lab in cell.contentView.subviews) {
            
            if (lab.tag == 100) {
                
                lab.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      
        cell.backgroundColor = WHITE;
        return cell;
    }else{
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.rightTitles.count*2 Withsize:CGSizeMake(RightTableViewWith, 40)];
        //这里先使用假数据
        UIView *view = [cell.contentView viewWithTag:100];

        NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        
        NSArray *array = [dic valueForKey:@"value"];
        
        for (int i = 0; i< array.count; i++) {
            
            NSInteger num = [array[i]integerValue];
            
            UILabel *label = [view viewWithTag:200+i];
            
            label.textColor = YAHEI;
            
            label.text = INTTOSTRING(num);
            
            label.font = FONT(13);
            
            label.textColor = [UIColor darkGrayColor];
            
            label.backgroundColor = i %2 == 0 ? WHITE : [UIColor groupTableViewBackgroundColor];
            
            if (self.setDic && i %2 == 1) {
                
                NSInteger y_min = [self.setDic[@"y_min"]integerValue];
                NSInteger y_max = [self.setDic[@"y_max"]integerValue];
                NSInteger o_min = [self.setDic[@"o_min"]integerValue];
                NSInteger o_max = [self.setDic[@"o_max"]integerValue];
                NSInteger b_min = [self.setDic[@"b_min"]integerValue];
                NSInteger b_max = [self.setDic[@"b_max"]integerValue];
                
                if (label.text.integerValue >= y_min && label.text.integerValue <= y_max) {
                    
                    label.textColor = kColor(207, 33, 39);
                }
                else if (label.text.integerValue >= o_min && label.text.integerValue <= o_max) {
                    
                    label.textColor = kColor(26, 154, 8);
                }
                else if (label.text.integerValue >= b_min && label.text.integerValue <= b_max) {
                    
                    label.textColor = kColor(10, 88, 191);
                }
            }
            
            /*
             if (self.yellowminfield.text.length > 0 && self.yellowmaxfield.text.length > 0) {
             
             [dic setValue:self.yellowminfield.text forKey:@"y_min"];
             [dic setValue:self.yellowmaxfield.text forKey:@"y_max"];
             [dic setValue:@"FFF8D9" forKey:@"y_color"];
             }
             if (self.orangeminfield.text.length > 0 && self.orangemaxfield.text.length > 0) {
             
             [dic setValue:self.orangeminfield.text forKey:@"o_min"];
             [dic setValue:self.orangemaxfield.text forKey:@"o_max"];
             [dic setValue:@"F9DDCB" forKey:@"o_color"];
             }
             if (self.blueminfield.text.length > 0 && self.bluemaxfield.text.length > 0) {
             
             [dic setValue:self.blueminfield.text forKey:@"b_min"];
             [dic setValue:self.bluemaxfield.text forKey:@"b_max"];
             [dic setValue:@"CCD8F9" forKey:@"b_color"];
             }
             */
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WHITE;
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
#pragma mark -- 设置左右两个table View的自定义头部View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTableView) {
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 41)];
        header.backgroundColor = [UIColor colorWithHex:@"dddddd"];
        
        UIView *rightHeaderView1 = [UIView viewWithLabelNumber:self.rightTitles.count Withlabelwidth:CGSizeMake(RightTableViewWith * 2, 20)];
        rightHeaderView1.frame = CGRectMake(0, 0, header.bounds.size.width, 20);
        [header addSubview:rightHeaderView1];
        int i = 0;
        for (UILabel *label in rightHeaderView1.subviews) {
            label.text = self.rightTitles[i++];
            label.font = FONT(13);
            label.backgroundColor = [UIColor groupTableViewBackgroundColor];
            label.textColor = YAHEI;
        }
        UIView *rightHeaderView2 = [UIView viewWithLabelNumber:self.rightTitles.count*2 Withlabelwidth:CGSizeMake(RightTableViewWith, 20)];
        rightHeaderView2.frame = CGRectMake(0, 21, header.bounds.size.width, 20);
        [header addSubview:rightHeaderView2];
        int j = 0;
        for (UILabel *label in rightHeaderView2.subviews) {
            label.text = j %2 == 0 ? @"总开" : @"未开";
            label.font = FONT(13);
            label.textColor = YAHEI;
            label.backgroundColor = [UIColor groupTableViewBackgroundColor];
            j++;
        }
        return header;
    }else{
        
        UILabel *lab = [Tools createLableWithFrame:CGRectMake(0, 0, LeftTableViewWidth, 41) andTitle:@"车号" andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
        lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return lab;
        
    }
}
//必须实现以下方法才可以使用自定义头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 41;
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

-(void)setClick {
    @weakify(self)
    ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
    [alert buildtodaysetWithtype:2 WithView:^(NSDictionary *dic) {
        @strongify(self)
        NSInteger type = [[dic valueForKey:@"type"] integerValue];
        
        if (type == 0) {
            
            self.setDic = nil;
        }
        else {
            self.setDic = dic;
        }
        
        [self.rightTableView reloadData];
    }];
    [alert showWith:self.view];
}

-(void)initData {
    
    NSString *url = nil;
    if (self.lottery_type == 6) {
        
        url = @"/bjpksSg/todayNumber.json";
    }
    else if (self.lottery_type == 7) {
        url = @"/xyftSg/todayNumber.json";
    }
    else if (self.lottery_type == 11) {
        url = @"/azPrixSg/todayNumber.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@(331)} success:^(BaseData *data) {
        
        @strongify(self)
        NSArray *array = data.data;
        
        [self.dataSource addObjectsFromArray:array];
        
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
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
