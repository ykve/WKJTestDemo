//
//  PCGraphCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PCGraphCtrl.h"
#import "RightTableViewCell.h"
#import "GraphModel.h"
#define LeftTableViewWidth 75
@interface PCGraphCtrl ()

@property (nonatomic, strong) UITableView *leftTableView, *rightTableView;

@property (nonatomic, strong) NSArray *rightTitles;

@property (nonatomic, strong) UIScrollView *buttomScrollView;

@property (nonatomic, strong)UIView *rightbottomView;

@property (nonatomic, assign) CGFloat righttablecell_width;

@property (nonatomic, strong)NSMutableArray *layerArray;
/**
 圆点展示的UIlabel
 */
@property (nonatomic, strong)NSMutableArray *selectnumArray;

@property (nonatomic, strong)CAShapeLayer *layer;

@end

@implementation PCGraphCtrl
- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self hiddenavView];
    self.rightTitles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    [self loadLeftTableView];
    [self loadRightTableView];
    [self initData];
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
    
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
        make.width.equalTo(@(LeftTableViewWidth));
    }];
    
    UIView *bottom = [[UIView alloc]init];
    bottom.backgroundColor = MAINCOLOR;
    [self.view addSubview:bottom];
    @weakify(self)
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.view);
        make.top.equalTo(self.leftTableView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(LeftTableViewWidth, 100));
    }];
    NSArray *array = @[@"出现总次数",@"平均遗漏值",@"最大遗漏值",@"最大连出值"];
    for (int i = 0 ; i< array.count; i++) {
        UILabel *lab = [Tools createLableWithFrame:CGRectMake(0, 25*i, LeftTableViewWidth, 25) andTitle:array[i] andfont:FONT(14) andTitleColor:BASECOLOR andBackgroundColor:i%2 == 0 ? CLEAR : BLACK andTextAlignment:1];
        [bottom addSubview:lab];
    }
    
    UILabel *lab = [Tools createLableWithFrame:CGRectMake(0, 0, LeftTableViewWidth, 40) andTitle:@"期号" andfont:FONT(13) andTitleColor:[UIColor darkGrayColor] andBackgroundColor:[UIColor groupTableViewBackgroundColor] andTextAlignment:1];
    [self.view addSubview:lab];
}

- (void)loadRightTableView{
    
    CGFloat righttable_width = 0;
    if ((SCREEN_WIDTH - LeftTableViewWidth)/ self.rightTitles.count < 30) {
        
        righttable_width = 30 * self.rightTitles.count;
        
        self.righttablecell_width = 30;
    }
    else {
        righttable_width = SCREEN_WIDTH - LeftTableViewWidth;
        
        self.righttablecell_width = (SCREEN_WIDTH - LeftTableViewWidth)/ self.rightTitles.count;
    }
    
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH - LeftTableViewWidth, SCREEN_HEIGHT - NAV_HEIGHT - 78 - 100 - 40) style:UITableViewStylePlain];
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
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    self.rightbottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.rightTableView.bounds)+40, CGRectGetWidth(self.rightTableView.bounds), 100)];
    self.rightbottomView.backgroundColor = MAINCOLOR;
    [self.buttomScrollView addSubview:self.rightbottomView];
    
    UIView *rightHeaderView = [UIView viewWithLabelNumber:self.rightTitles.count Withlabelwidth:CGSizeMake(self.righttablecell_width, 40)];
    int i = 0;
    for (UILabel *label in rightHeaderView.subviews) {
        label.text = self.rightTitles[i++];
        label.font = FONT(13);
        label.textColor = [UIColor darkGrayColor];
    }
    rightHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.buttomScrollView addSubview:rightHeaderView];
}

#pragma mark - table view dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfDrawlabs:1 Withsize:CGSizeMake(LeftTableViewWidth, 30)];
        
        GraphModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        UIView *view = [cell.contentView viewWithTag:100];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        for (UILabel *label in view.subviews) {
            label.text = nil;
            label.text =  model.version;
            label.font = FONT(13);
            label.textColor = [UIColor darkGrayColor];
            label.backgroundColor = WHITE;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfDrawlabs:self.rightTitles.count Withsize:CGSizeMake(self.righttablecell_width, 30)];
    
        GraphModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        UIView *view = [cell.contentView viewWithTag:100];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        int i = 0;
        for (Drawlab *label in view.subviews) {
            label.text = nil;
            label.text = [[model.array1 objectAtIndex:i]stringValue];
            label.font = FONT(13);
            label.textColor = [UIColor darkGrayColor];
            label.backgroundColor = WHITE;
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

-(void)initData {
    
    CGFloat righttable_width = 0;
    if ((SCREEN_WIDTH - LeftTableViewWidth)/ self.rightTitles.count < 30) {
        
        righttable_width = 30 * self.rightTitles.count;
        
        self.righttablecell_width = 30;
    }
    else {
        righttable_width = SCREEN_WIDTH - LeftTableViewWidth;
        
        self.righttablecell_width = (SCREEN_WIDTH - LeftTableViewWidth)/ self.rightTitles.count;
    }
    
    self.rightTableView.frame = CGRectMake(0, 40, righttable_width, SCREEN_HEIGHT - NAV_HEIGHT - 78 - 100 - 40);
    self.buttomScrollView.contentSize = CGSizeMake(self.rightTableView.bounds.size.width, 0);
    self.rightbottomView.frame = CGRectMake(0, CGRectGetHeight(self.rightTableView.bounds)+40, CGRectGetWidth(self.rightTableView.bounds), 100);
    
    [self initDataWithissue:0 Withsort:0];
}

-(void)initDataWithissue:(NSInteger)issue Withsort:(NSInteger)sort {
    
    NSInteger index = issue == 0 ? 30 : issue == 1 ? 50 : issue == 2 ? 100 : 200;
    
    @weakify(self)
    
    [WebTools postWithURL:@"/pceggSg/getRegionMissingValueList.json" params:@{@"region":@(self.type),@"pageSize":@(index)} success:^(BaseData *data) {
        
        @strongify(self)
        
        NSArray *array = data.data[@"missingValList"];
        
        [self.dataSource removeAllObjects];
        
        for (NSDictionary *dic in array) {
            
            GraphModel *model = [[GraphModel alloc]init];
            
            model.version = dic[@"issue"];
            
            model.selectnumber = [dic[@"realNum"]stringValue];
            
            for (NSString *str in self.rightTitles) {
                
                NSString *key = [NSString stringWithFormat:@"number%@",str];
                
                NSNumber *num = dic[key];
                
                [model.array1 addObject:num];
            }
            
            [self.dataSource addObject:model];
        }
        
        if (sort == 1) {
            
            NSArray *reversedArray = [[self.dataSource reverseObjectEnumerator] allObjects];
            
            [self.dataSource removeAllObjects];
            
            [self.dataSource addObjectsFromArray:reversedArray];
        }
        
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        [self removelayer];
        
        [self drawLine];
        
        [self addsublabinrightbottomview:data.data[@"statistics"]];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(void)addsublabinrightbottomview:(NSArray *)statistics {
    
    for (id view in self.rightbottomView.subviews) {
        
        [view removeFromSuperview];
    }
    
    for (int i = 0; i< statistics.count; i++) {
        
        UIView *view = [UIView viewWithLabelNumber:self.rightTitles.count Withlabelwidth:CGSizeMake(self.righttablecell_width, 25)];
        
        [self.rightbottomView addSubview:view];
        
        view.frame = CGRectMake(0, 25*i, self.rightTableView.bounds.size.width, 25);
        
        view.backgroundColor = i%2 == 0 ? MAINCOLOR : BLACK;
        
        NSDictionary *dic = statistics[i];
        
        int j = 0;
        for (UILabel *label in view.subviews) {
            
            NSString *key = [NSString stringWithFormat:@"number%@",self.rightTitles[j]];
            
            label.text = nil;
            label.text = STRING(dic[key]);
            label.font = FONT(13);
            label.textColor = WHITE;
            label.backgroundColor = CLEAR;
            
            j++;
        }
    }
}

-(void)drawLine{
    CGFloat startAngle = 0.0;
    CGFloat endAngle = M_PI * 2;
    
    UIBezierPath * linepath = [UIBezierPath bezierPath];
    
    for (int i= 0; i<self.dataSource.count; i++) {
        
        GraphModel *model = [self.dataSource objectAtIndex:i];
        
        NSInteger row = [self.rightTitles indexOfObject:model.selectnumber];
        
        CGFloat x = (row + 0.5)*self.righttablecell_width;
        CGFloat y = (i + 0.5) * 30;
        CGPoint p = CGPointMake(x, y);
        i==0 ? [linepath moveToPoint:p] : [linepath addLineToPoint:p];
        
        UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:p radius:10 startAngle:startAngle endAngle:endAngle clockwise:true];
        
        // 画圆
        CAShapeLayer * layer = [[CAShapeLayer alloc] init];
        
        layer.path = path.CGPath;
        layer.fillColor = LINECOLOR.CGColor;
        [self.rightTableView.layer addSublayer:layer];
        [self.layerArray addObject:layer];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.righttablecell_width, 25)];
        lab.center = p;
        lab.textColor = [UIColor whiteColor];
        lab.text = [model.array1[row]stringValue];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont boldSystemFontOfSize:13];
        [self.selectnumArray addObject:lab];
    }
    
    
    //画线
    self.layer = [[CAShapeLayer alloc] init];
    self.layer.path = linepath.CGPath;
    self.layer.lineWidth = 2;
    self.layer.fillColor = [UIColor clearColor].CGColor;
    self.layer.strokeColor = LINECOLOR.CGColor;
    [self.rightTableView.layer addSublayer:self.layer];
    
    for (UILabel * lbl in self.selectnumArray) {
        [self.rightTableView addSubview:lbl];
    }
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

//-(void)sortClick:(UIButton *)sender {
//    
//    
//}
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
