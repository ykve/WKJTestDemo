//
//  PK10historylistCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10historylistCtrl.h"
#import "RightTableViewCell.h"
#import "PK10HistoryModel.h"
#import "NSNumber+Select.h"
#define LeftTableViewWidth 125
#define RightCount 10
#define LeftCount 2
@interface PK10historylistCtrl ()

@property (nonatomic, strong) UITableView *leftTableView, *rightTableView;

@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, strong) UIScrollView *buttomScrollView;

@property (nonatomic,copy) NSString *time;
/**
 0：号码
 1：大小
 2：单双
 3：对子
 */
@property (nonatomic,assign) NSInteger filtertype;
@end

@implementation PK10historylistCtrl

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
    
    [self hiddenavView];
    [self loadLeftTableView];
    [self loadRightTableView];
  
    [self initDataWithtime:[Tools getlocaletime]];
    
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
        make.left.and.top.and.bottom.equalTo(self.view);
        make.width.equalTo(@(LeftTableViewWidth));
    }];
}

- (void)loadRightTableView{
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,  RightCount * (SCREEN_WIDTH - LeftTableViewWidth)/10, SCREEN_HEIGHT - NAV_HEIGHT - 34 - 44) style:UITableViewStylePlain];
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
        make.right.and.top.and.bottom.equalTo(self.view);
        make.left.equalTo(self.leftTableView.mas_right);
    }];
}

#pragma mark - table view dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:LeftCount Withsize:CGSizeMake(LeftTableViewWidth/2, 40)];
    
        UIView *view = [cell.contentView viewWithTag:100];
        
        PK10HistoryModel *model = [self.dataSource objectAtIndex:indexPath.row];

        for (UILabel *label in view.subviews) {
            label.text = nil;
            label.text = label.tag == 200 ? model.issue.length > 8 ? [model.issue substringFromIndex:8] : model.issue : model.time;
            label.font = FONT(15);
            label.textColor = [UIColor darkGrayColor];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
        return cell;
    }else{
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:RightCount Withsize:CGSizeMake((SCREEN_WIDTH - LeftTableViewWidth)/10, 40)];
     
        PK10HistoryModel *model = [self.dataSource objectAtIndex:indexPath.row];
        UIView *view = [cell.contentView viewWithTag:100];
        for (int i = 0; i< model.num.count; i++) {
            NSString *numer = INTTOSTRING(model.num[i].integerValue);
            NSString *bigorsmall = model.bigorsmallArray[i];
            NSString *singleordouble = model.sigleordoubleArray[i];
            UILabel *lab = [view viewWithTag:200+i];
            lab.text = nil;
            lab.font = FONT(15);
            lab.backgroundColor = CLEAR;
            if (self.filtertype == 1) {

                lab.text = bigorsmall;
                lab.textColor = [bigorsmall isEqualToString:@"大"] == YES ? LINECOLOR : kColor(106, 106, 106);
            }
            else if (self.filtertype == 2) {

                lab.text = singleordouble;
                lab.textColor = [singleordouble isEqualToString:@"单"] == YES ? LINECOLOR : kColor(106, 106, 106);
            }
            else {
                lab.text = numer;
                lab.textColor = LINECOLOR;
                if (self.filtertype == 3) {
                    
                    Numbers *numbers = model.numberArray[i];
                    lab.backgroundColor = numbers.isselect == YES ? BASECOLOR : CLEAR;
                }
                else{
                    lab.backgroundColor = CLEAR;
                }
            }

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
#pragma mark -- 设置左右两个table View的自定义头部View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTableView) {
        
        NSArray *array = @[@"号码",@"大小",@"单双",@"对子"];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - LeftTableViewWidth, 40)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        CGFloat btn_w = (SCREEN_WIDTH - LeftTableViewWidth - 5 * 5) / array.count;
        
        [self.btnArray removeAllObjects];
        
        for (int i = 0; i< array.count; i++) {
            
            UIButton *btn = [Tools createButtonWithFrame:CGRectMake(5 * (i+1) + btn_w * i, 2.5, btn_w, 30) andTitle:array[i] andTitleColor:YAHEI andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(typeClick:) andType:UIButtonTypeCustom];
            btn.layer.cornerRadius = 4;
            btn.backgroundColor = WHITE;
            btn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            btn.layer.borderWidth = 1;
            [self.btnArray addObject:btn];
            [view addSubview:btn];
        }
        
        UIButton *btn = [self.btnArray objectAtIndex:self.filtertype];
        btn.backgroundColor = LINECOLOR;
        [btn setTitleColor:WHITE forState:UIControlStateNormal];
        
        return view;
        
    }else{
        
        UIView *view = [UIView viewWithLabelNumber:LeftCount Withlabelwidth:CGSizeMake(62, 40)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        view.tag = 100;
        for (UILabel *label in view.subviews) {
            label.text = nil;
            label.text = label.tag == 200 ? @"期号" : @"时间";
            label.font = FONT(15);
            label.textColor = [UIColor darkGrayColor];
        }
        return view;
        
        
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

-(void)typeClick:(UIButton *)sender {
    
    for (UIButton *btn in self.btnArray) {
        
        btn.backgroundColor = WHITE;
        [btn setTitleColor:YAHEI forState:UIControlStateNormal];
    }
    
    sender.backgroundColor = LINECOLOR;
    [sender setTitleColor:WHITE forState:UIControlStateNormal];
    self.filtertype = [self.btnArray indexOfObject:sender];
    [self.rightTableView reloadData];
}

-(void)initDataWithtime:(NSString *)time {
    
    self.time = time;
    
    NSString *url = nil;
    if (self.lottery_type == 6) {
        url = @"/bjpksSg/historySg.json";
    }
    else if (self.lottery_type == 7) {
        url = @"/xyftSg/historySg.json";
    }
    else if (self.lottery_type == 11) {
        url = @"/azPrixSg/historySg.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@"301",@"date":time,@"pageNum":@(1),@"pageSize":@(10000)} success:^(BaseData *data) {
        @strongify(self)
        NSArray *array = [PK10HistoryModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:array];
        
        if (self.dataSource.count > 1){
            
            for (int i = 0; i< self.dataSource.count-1; i++) {
                
                PK10HistoryModel *model = self.dataSource[i];
                PK10HistoryModel *model2 = self.dataSource[i+1];
                
                for (int j = 0; j< model.numberArray.count; j++) {
                    
                    Numbers *num = model.numberArray[j];
                    Numbers *num2 = model2.numberArray[j];
                    
                    if (num.num == num2.num) {
                        
                        num.isselect = YES;
                        num2.isselect = YES;
                    }
                }
            }
        }
        
        
        [self endRefresh:self.rightTableView WithdataArr:array];
        
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self endRefresh:self.rightTableView WithdataArr:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
