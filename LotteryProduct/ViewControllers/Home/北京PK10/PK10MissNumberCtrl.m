//
//  PK10MissNumberCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10MissNumberCtrl.h"
#import "RightTableViewCell.h"
#import "PK10MissNumModel.h"
#import "UIButton+touch.h"
#define LeftTableViewWidth 70
@interface PK10MissNumberCtrl ()

@property (nonatomic, strong) UITableView *leftTableView, *rightTableView;

@property (nonatomic, strong)NSArray *leftData;
/**
 左侧选中行
 */
@property (nonatomic, assign)NSInteger selectindex;

@property (nonatomic, strong)NSMutableArray *btnArray;

@property (nonatomic, retain) UIView *pointview;

@property (nonatomic , strong) NSArray<NumValue *> * currentValue;

@end

@implementation PK10MissNumberCtrl

-(NSMutableArray *)btnArray {
    
    if (!_btnArray) {
        
        _btnArray = [[NSMutableArray alloc]init];
    }
    return _btnArray;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titlestring = @"号码遗漏";
    
    [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] WFSMImage] With:^(UIButton *sender) {
        
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        
        [alert buildPK10missInfoView];
        
        [alert show];
    }];
    @weakify(self)
    [self buildTimeViewWithType:self.lottery_type With:nil With:^{
        @strongify(self)
        [self initData];
    }];
   
    NSArray *array = @[@"号码",@"今日出现",@"当前遗漏"];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(LeftTableViewWidth, NAV_HEIGHT + 34, SCREEN_WIDTH - LeftTableViewWidth, 40)];
    view1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGFloat btn_w = (SCREEN_WIDTH - LeftTableViewWidth) / array.count;
    [self.btnArray removeAllObjects];
    
    for (int i = 0; i< array.count; i++) {
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectMake(btn_w * i, 2.5, btn_w, 30) andTitle:array[i] andTitleColor:YAHEI andBackgroundImage:nil andImage:IMAGE(@"期号不排序") andTarget:self andAction:@selector(typeClick:) andType:UIButtonTypeCustom];
        [self.btnArray addObject:btn];
        [btn setImagePosition:WPGraphicBtnTypeRight spacing:4];
        btn.tag = 100+i;
        [view1 addSubview:btn];
        
        if (i == 0) {
            
            btn.selecttype = 1;
            [btn setImage:IMAGE(@"期号排序升") forState:UIControlStateNormal];
        }
    }
    UIView *view2 = [UIView viewWithLabelNumber:1 Withlabelwidth:CGSizeMake(62, 40)];
    view2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    view2.tag = 100;
    view2.frame = CGRectMake(0, NAV_HEIGHT+34, LeftTableViewWidth, 40);
    for (UILabel *label in view2.subviews) {
        label.text = @"名次";
        label.font = FONT(15);
        label.textColor = YAHEI;
    }
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    self.leftData = @[@"冠",@"亚",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十"];
    
    [self loadLeftTableView];
    [self loadRightTableView];
    [self addPointingView];
    
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
    
    self.leftTableView = [[UITableView alloc] init];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTableView.rowHeight = 40;
    self.leftTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.leftTableView];
    
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT+34+40, 0, 0, SCREEN_WIDTH - LeftTableViewWidth));
    }];
}

- (void)loadRightTableView{
    self.rightTableView = [[UITableView alloc] init];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
//    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.rowHeight = 40;
    self.rightTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.rightTableView];
    self.rightTableView.tableFooterView = [UIView new];
    @weakify(self)
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT+34 + 40,LeftTableViewWidth, 0, 0));
    }];
}

#pragma mark - table view dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:1 Withsize:CGSizeMake(LeftTableViewWidth, 40)];
        //这里先使用假数据
        UIView *view = [cell.contentView viewWithTag:100];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        for (UILabel *label in view.subviews) {
            label.text = nil;
            label.text = self.leftData[indexPath.row];
            label.font = FONT(15);
            if (indexPath.row == self.selectindex) {
                
                label.backgroundColor = LINECOLOR;
                label.textColor = WHITE;
                
                [cell addSubview:self.pointview];
                
                [self.pointview mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.right.equalTo(cell).offset(8);
                    make.centerY.equalTo(cell);
                    make.size.mas_equalTo(CGSizeMake(13, 15));
                }];
            }
            else {
                label.backgroundColor = kColor(245, 240, 245);
                label.textColor = YAHEI;
                
            }
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:3 Withsize:CGSizeMake((SCREEN_WIDTH - LeftTableViewWidth)/3, 40)];
        //这里先使用假数据
        UIView *view = [cell.contentView viewWithTag:100];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        NumValue *num = [self.currentValue objectAtIndex:indexPath.row];
        
        for (UILabel *label in view.subviews) {
            label.text = nil;
            label.text = label.tag == 200 ? INTTOSTRING(num.num) : label.tag == 201 ? INTTOSTRING(num.open) : INTTOSTRING(num.noOpen);
            label.font = FONT(15);
            label.backgroundColor = WHITE;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        
        self.selectindex = indexPath.row;
        
        PK10MissNumModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        self.currentValue = model.value;
        
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
    }
}

-(void)typeClick:(UIButton *)sender {
    
    for (UIButton *btn in self.btnArray) {
        
        if (btn != sender) {
            btn.selecttype = 0;
            [btn setImage:IMAGE(@"期号不排序") forState:UIControlStateNormal];
        }
    }
    if (sender.selecttype == 0) {
        
        sender.selecttype = 1;
        [sender setImage:IMAGE(@"期号排序升") forState:UIControlStateNormal];
    }
    else if (sender.selecttype == 1) {
        
        sender.selecttype = 2;
        [sender setImage:IMAGE(@"期号排序降") forState:UIControlStateNormal];
    }
    else if (sender.selecttype == 2) {

        sender.selecttype = 1;
        [sender setImage:IMAGE(@"期号排序升") forState:UIControlStateNormal];
    }
    
    [self sortWithsender:sender];
}

-(void)sortWithsender:(UIButton *)sender {
    
    if (sender.tag == 100) {
        
        NSSortDescriptor *numberSD = [NSSortDescriptor sortDescriptorWithKey:@"num" ascending:sender.selecttype == 1 ? YES : NO];
        
        self.currentValue = [self.currentValue sortedArrayUsingDescriptors:@[numberSD]];
    }
    else if (sender.tag == 101) {
        
        NSSortDescriptor *openSD = [NSSortDescriptor sortDescriptorWithKey:@"open" ascending:sender.selecttype == 1 ? YES : NO];
        
        self.currentValue = [self.currentValue sortedArrayUsingDescriptors:@[openSD]];
    }
    else {
        
        NSSortDescriptor *noOpenSD = [NSSortDescriptor sortDescriptorWithKey:@"noOpen" ascending:sender.selecttype == 1 ? YES : NO];
        
        self.currentValue = [self.currentValue sortedArrayUsingDescriptors:@[noOpenSD]];
    }
    
    [self.rightTableView reloadData];
}

- (void)addPointingView
{
    
    self.pointview = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.pointview.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    self.pointview.backgroundColor = WHITE;
    
}

-(void)initData {
    
    NSString *url = nil;
    if (self.lottery_type == 6) {
        
        url = @"/bjpksSg/numNoOpen.json";
    }
    else if (self.lottery_type == 7) {
        url = @"/xyftSg/numNoOpen.json";
    }
    else if (self.lottery_type == 11) {
        url = @"/azPrixSg/numNoOpen.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:nil success:^(BaseData *data) {
        @strongify(self)
        self.dataSource = [PK10MissNumModel mj_objectArrayWithKeyValuesArray:data.data];
        
        PK10MissNumModel *model = self.dataSource.firstObject;
        
        self.currentValue = model.value;
        
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
