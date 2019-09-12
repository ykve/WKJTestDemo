//
//  LotteryListCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/31.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "LotteryListCtrl.h"
#import "RightTableViewCell.h"
#define LeftTableViewWidth 100
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

@interface LotteryListCtrl ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *leftTableView, *rightTableView;

@property (nonatomic,strong) NSArray *rightTitles;

@property (nonatomic,strong) UIScrollView *buttomScrollView;

@property (nonatomic,assign) BOOL sort;

@end

@implementation LotteryListCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self hiddenavView];
    
    self.rightTitles = @[@"开奖号码",@"十位",@"个位",@"后三"];
    
    [self loadLeftTableView];
    [self loadRightTableView];
    
    self.page = 1;
    
    [self initData:[Tools getlocaletime]];
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
    self.leftTableView.rowHeight = 40;
    [self.view addSubview:self.leftTableView];
    
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(self.view);
        make.width.equalTo(@(LeftTableViewWidth));
    }];
}

- (void)loadRightTableView{
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - LeftTableViewWidth, SCREEN_HEIGHT - NAV_HEIGHT - 34 - 44) style:UITableViewStylePlain];
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

    [self.buttomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.bottom.equalTo(self.view);
        make.left.equalTo(self.leftTableView.mas_right);
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
        }
        
        NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@期",dic[@"issue"]];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = FONT(15);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
        return cell;
    }else{
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.rightTitles.count Withsize:CGSizeMake((SCREEN_WIDTH-100)/self.rightTitles.count, 40)];
        //这里先使用假数据
        NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        NSArray *array = dic[@"list"];
        int i = 0;
        UIView *view = [cell.contentView viewWithTag:100];
        for (UILabel *label in view.subviews) {
            
            NSString *str = array[i];
            label.text = nil;
            label.textColor = [UIColor darkGrayColor];
            if (i == 0) {
                NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
                paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
                paraStyle.alignment = NSTextAlignmentCenter;
                NSDictionary *dic = @{NSFontAttributeName:FONT(15), NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@2.0f};
                NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:str attributes:dic];
                
                if (self.startype == 0) {
                    
                    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str.length - 1, 1)];
                }
                else if (self.startype > 0 && self.startype < 3) {
                    
                    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str.length - 2, 2)];
                }
                else if (self.startype > 2 && self.startype < 6) {
                    
                    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str.length - 3, 3)];
                }
                else if (self.startype > 5 && self.startype < 8) {
                    
                    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, str.length)];
                }
                else {
                    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str.length - 2, 2)];
                }
                label.attributedText = attributeStr;
            }
            else{
                label.text = str;
                label.font = FONT(15);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
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

-(void)setStartype:(NSInteger)startype {
    
    _startype = startype;
    
    [self.rightTableView reloadData];
}

-(void)initData:(NSString *)time {
    
    [WebTools postWithURL:@"/cqsscSg/lishiA.json" params:@{@"type":@(101),@"date":time} success:^(BaseData *data) {
        
        NSArray *array = data.data;
        
        [self.dataSource removeAllObjects];
        
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
