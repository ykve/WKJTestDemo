//
//  PK10NumberDistrubtionCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10NumberDistrubtionCtrl.h"
#import "RightTableViewCell.h"
#import "PK10HistoryModel.h"
#import "NSNumber+Select.h"
#define LeftTableViewWidth 125
#define RightCount 10
#define LeftCount 2

@interface PK10NumberDistrubtionCtrl ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (weak, nonatomic) IBOutlet UIButton *singleBtn;
@property (weak, nonatomic) IBOutlet UIButton *doubleBtn;

@property (weak, nonatomic) IBOutlet UIButton *bigBtn;
@property (weak, nonatomic) IBOutlet UIButton *smallBtn;

@property (weak, nonatomic) IBOutlet UIButton *recoveryBtn;

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic,copy) NSString *time;
/**
 0：号码
 1：大小
 2：单双
 3：对子
 */
@property (nonatomic,assign) NSInteger filtertype;

/**
 1~10,单，双，大，小
 */
@property (nonatomic,copy) NSString *selecttypestring;

@end

@implementation PK10NumberDistrubtionCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self hiddenavView];
    
    [self initDataWithtime:[Tools getlocaletime]];
}

-(NSMutableArray *)btnArray {
    
    if (!_btnArray) {
        
        _btnArray = [[NSMutableArray alloc]init];
    }
    return _btnArray;
}

#pragma mark - table view dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:LeftCount Withsize:CGSizeMake(LeftTableViewWidth/2, 40)];
        //这里先使用假数据
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
        PK10HistoryModel *model = [self.dataSource objectAtIndex:indexPath.row];
        UIView *view = [cell.contentView viewWithTag:100];
        for (int i = 0; i< model.num.count; i++) {
            NSNumber *num = model.num[i];
            NSString *numer = INTTOSTRING(num.integerValue);
            NSString *bigorsmall = model.bigorsmallArray[i];
            NSString *singleordouble = model.sigleordoubleArray[i];
            UILabel *lab = [view viewWithTag:200+i];
            lab.text = nil;
            lab.font = FONT(15);
            lab.backgroundColor = CLEAR;
            if (self.filtertype == 0) {
                
                lab.text = numer;
                lab.textColor = LINECOLOR;
                
                if ([Tools isPureInt:self.selecttypestring]) {
                    
                    if ([self.selecttypestring isEqualToString:lab.text]) {
                        
                        lab.backgroundColor = BASECOLOR;
                    }
                    else{
                        lab.backgroundColor = CLEAR;
                    }
                }
                else if ([self.selecttypestring isEqualToString:@"单"]) {
                    
                    lab.backgroundColor = lab.text.integerValue %2 == 0 ? CLEAR : BASECOLOR;
                }
                else if ([self.selecttypestring isEqualToString:@"双"]) {
                    
                    lab.backgroundColor = lab.text.integerValue %2 == 1 ? CLEAR : BASECOLOR;
                }
                else if ([self.selecttypestring isEqualToString:@"大"]) {
                    
                    lab.backgroundColor = lab.text.integerValue < 6 ? CLEAR : BASECOLOR;
                }
                else if ([self.selecttypestring isEqualToString:@"小"]) {
                    
                    lab.backgroundColor = lab.text.integerValue > 5 ? CLEAR : BASECOLOR;
                }
            }
            else if (self.filtertype == 1) {
                
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
                Numbers *numbers = model.numberArray[i];
                lab.backgroundColor = numbers.isselect == YES ? BASECOLOR : CLEAR;
            }
            
        }
        
        return cell;
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

- (IBAction)numberClick:(UIButton *)sender {
    
    [self recoveryClick:self.recoveryBtn];
    
    sender.backgroundColor = LINECOLOR;
    [sender setTitleColor:WHITE forState:UIControlStateSelected];
    
    self.selecttypestring = sender.titleLabel.text;
    
    [self.rightTableView reloadData];
}
- (IBAction)singleanddoubleClick:(UIButton *)sender {
    
    [self recoveryClick:self.recoveryBtn];
    
    sender.selected = YES;
    sender.backgroundColor = LINECOLOR;
    [sender setTitleColor:WHITE forState:UIControlStateSelected];
    
    self.selecttypestring = sender.titleLabel.text;
    
    [self.rightTableView reloadData];
}
- (IBAction)bigandsmallClick:(UIButton *)sender {
    
    [self recoveryClick:self.recoveryBtn];
    
    sender.selected = YES;
    sender.backgroundColor = LINECOLOR;
    [sender setTitleColor:WHITE forState:UIControlStateSelected];
    
    self.selecttypestring = sender.titleLabel.text;
    
    [self.rightTableView reloadData];
}
- (IBAction)recoveryClick:(UIButton *)sender {
    
    for (UIButton *btn in self.numberBtns) {
        
        [self returnnomalBtn:btn];
    }
    [self returnnomalBtn:self.doubleBtn];
    [self returnnomalBtn:self.singleBtn];
    [self returnnomalBtn:self.smallBtn];
    [self returnnomalBtn:self.bigBtn];
    
    self.selecttypestring = nil;
    
    [self.rightTableView reloadData];
}

-(void)returnnomalBtn:(UIButton *)sender {
    
    sender.selected = NO;
    sender.backgroundColor = WHITE;
    [sender setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
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
    [WebTools postWithURL:url params:@{@"type":@"301",@"date":time,@"pageNum":@(1),@"pageSize":@(1000)} success:^(BaseData *data) {
        
        @strongify(self)
        NSArray *array = [PK10HistoryModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.dataSource removeAllObjects];
        
        [self.dataSource addObjectsFromArray:array];
        
        if (self.dataSource.count > 1) {
            
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
