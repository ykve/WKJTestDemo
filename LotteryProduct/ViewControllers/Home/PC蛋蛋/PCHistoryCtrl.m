//
//  PCHistoryCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/13.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PCHistoryCtrl.h"
#import "RightTableViewCell.h"
#import "PCHistoryModel.h"
#define LeftTableViewWidth 100

@interface PCHistoryCtrl ()

@property (nonatomic, strong) UITableView *leftTableView, *rightTableView;

@property (nonatomic, strong) NSArray *rightTitles;

@property (nonatomic, strong) UIScrollView *buttomScrollView;

@property (nonatomic,assign) BOOL sort;

@property (nonatomic,copy) NSString *time;

@property (nonatomic, assign)BOOL isHistory;

@end

@implementation PCHistoryCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"历史开奖";
    
    @weakify(self)
    [self buildTimeViewWithType:5 With:^(UIButton *sender) {
        
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        alert.lastDate = self.time;
        [alert builddateView:^(NSString *date) {
            @strongify(self)
            [sender setTitle:date forState:UIControlStateNormal];
            
            self.isHistory = YES;
            self.time = date;
            [self refresh];
        }];
        [alert show];
    } With:^{
        @strongify(self)
        self.page = 1;
        
        self.isHistory = NO;
        
        [self initData];
    }];
    
    self.rightTitles = @[@"开奖号码",@"和值",@"大小",@"单双"];
    
    [self loadLeftTableView];
    [self loadRightTableView];

    self.time = [Tools getlocaletime];
    
    self.page = 1;
    
    [self initData];
    
//    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        [self refresh];
//    }];
    
    self.rightTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        @strongify(self)

        self.page ++ ;
        
        [self initData];
    }];
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_pcegg" object:nil];
    
}

-(void)removenotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_pcegg" object:nil];
}

-(void)refresh {
    
    self.page = 1;
    
    [self initData];
}

//设置分割线顶格
- (void)viewDidLayoutSubviews{
    [self.leftTableView setLayoutMargins:UIEdgeInsetsZero];
    [self.rightTableView setLayoutMargins:UIEdgeInsetsZero];
}

- (void)loadLeftTableView{

    self.leftTableView = [[UITableView alloc] init];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTableView.rowHeight = 40;
    [self.view addSubview:self.leftTableView];
    
    @weakify(self)
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(NAV_HEIGHT + 35);
        make.width.equalTo(@(LeftTableViewWidth));
        make.bottom.equalTo(self.view).offset(-SAFE_HEIGHT);
    }];
}

- (void)loadRightTableView{
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - LeftTableViewWidth, SCREEN_HEIGHT - NAV_HEIGHT - 35) style:UITableViewStylePlain];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.rowHeight = 40;
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
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(NAV_HEIGHT + 35);
        make.left.equalTo(self.leftTableView.mas_right);
        make.bottom.equalTo(self.view).offset(-SAFE_HEIGHT);
    }];
}

#pragma mark - table view dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isHistory) {
        return self.dataSource.count;
    }
    return self.dataSource.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        static NSString *reuseIdentifer = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifer];
            [self resetSeparatorInsetForCell:cell];
        }
        if (indexPath.row != 0) {
            
            PCHistoryModel *model;
            if (self.isHistory) {
                model = [self.dataSource objectAtIndex:indexPath.row];//daniel
            }else{
                model = [self.dataSource objectAtIndex:indexPath.row - 1];//daniel
            }
            cell.textLabel.text = [NSString stringWithFormat:@"%ld期",(long)[model.issue integerValue]];
        }
        else {
            PCHistoryModel *model = self.dataSource.firstObject;
            
            if (self.isHistory) {
                cell.textLabel.text = [NSString stringWithFormat:@"%ld期",(long)model.issue.integerValue];

            }
            else{
                cell.textLabel.text = [NSString stringWithFormat:@"%d期",model.issue.integerValue + 1];

            }
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = FONT(14);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
        return cell;
    }else{
        
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.rightTitles.count Withsize:CGSizeMake((SCREEN_WIDTH-100)/self.rightTitles.count, 40)];
        //这里先使用假数据
        UIView *view = [cell.contentView viewWithTag:100];
        int i= 0;
        
        for (UILabel *label in view.subviews) {
            label.text = nil;
            label.textColor = [UIColor darkGrayColor];
            label.font = FONT(14);
            NSString * now = [Tools getlocaletime];
     //&&self.time && [now isEqualToString:self.time]
            NSInteger index = indexPath.row;
            if (indexPath.row == 0&&self.time && [now isEqualToString:self.time]) {
                index = indexPath.row-1;
            }
            if (indexPath.row == 0&&self.time && [now isEqualToString:self.time]) {
                
//                NSLog(@"%@===%@", self.time,now);
                label.text = i == 0 ? @"等待开奖" : @"";
            }else {
                
                if(!self.isHistory){
                    index = indexPath.row-1;
                }
//                if (index<1) {
//                    index = 1;
//                }

                PCHistoryModel *model = [self.dataSource objectAtIndex:index];
                if (i == 0) {
                    label.text = model.number;
                }
                else if (i == 1) {
                    label.text = [NSString stringWithFormat:@"%ld",(long)model.sum];
                    label.textColor = LINECOLOR;
                }
                else if (i == 2) {
                    label.text = model.bigOrSmall;
                }
                else {
                    label.text = model.singleOrDouble;
                }
            }
            i ++;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
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


#pragma mark -- 设置左右两个table View的自定义头部View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTableView) {
        UIView *rightHeaderView = [UIView viewWithLabelNumber:self.rightTitles.count Withlabelwidth:CGSizeMake((SCREEN_WIDTH-100)/self.rightTitles.count, 40)];
        int i = 0;
        for (UILabel *label in rightHeaderView.subviews) {
            label.text = self.rightTitles[i++];
            label.font = FONT(13);
            label.textColor = [UIColor darkGrayColor];
        }
        rightHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return rightHeaderView;
    }else{
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectMake(0, 0, 80, 40) andTitle:@"期号" andTitleColor:[UIColor darkGrayColor] andBackgroundImage:nil andImage:IMAGE(@"期号排序降") andTarget:self andAction:@selector(sortClick:) andType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [btn setImage:IMAGE(@"期号排序升") forState:UIControlStateSelected];
        [btn setImagePosition:WPGraphicBtnTypeRight spacing:2];
        btn.titleLabel.font = FONT(13);
        btn.selected = self.sort;
        return btn;
        
    }
}
//必须实现以下方法才可以使用自定义头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
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

-(void)sortClick:(UIButton *)sender {
    
    sender.selected = ! sender.selected;
    
    self.sort = sender.selected;
    
    NSArray *reversedArray = [[self.dataSource reverseObjectEnumerator] allObjects];
    
    [self.dataSource removeAllObjects];
    
    [self.dataSource addObjectsFromArray:reversedArray];
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

-(void)initData {

    @weakify(self)
    
    [WebTools postWithURL:@"/pceggSg/getSgHistoryList.json" params:@{@"date":self.time,@"pageNum":@(self.page),@"pageSize":@30} success:^(BaseData *data) {
        
        @strongify(self)
        
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }
        
        NSArray *array = [PCHistoryModel mj_objectArrayWithKeyValuesArray:data.data];
        
        if (self.sort) {
            
            NSArray *reversedArray = [[array reverseObjectEnumerator] allObjects];
            
            NSIndexSet *helpIndex = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [reversedArray count])];
            
            [self.dataSource insertObjects:reversedArray atIndexes:helpIndex];
        }
        else {
            
            [self.dataSource addObjectsFromArray:array];
        }
        
        [self endRefresh:self.rightTableView WithdataArr:data.data];
        
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self endRefresh:self.rightTableView WithdataArr:nil];
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
