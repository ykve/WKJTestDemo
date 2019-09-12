//
//  PK10TwoFaceListCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10TwoFaceListCtrl.h"
#import "RightTableViewCell.h"
#define LeftTableViewWidth 80
#define RightTableViewWith 30
@interface PK10TwoFaceListCtrl ()

@property (nonatomic, strong) UITableView *leftTableView, *rightTableView;

@property (nonatomic, strong) NSArray *rightTitles;

@property (nonatomic, strong) UIScrollView *buttomScrollView;

@end

@implementation PK10TwoFaceListCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WHITE;
    [self hiddenavView];
    if (self.type == 2) {
        
        self.rightTitles = @[@"冠军",@"亚军",@"第三名",@"第四名",@"第五名"];
    }
    else {
        
        self.rightTitles = @[@"冠军",@"亚军",@"第三名",@"第四名",@"第五名",@"第六名",@"第七名",@"第八名",@"第九名",@"第十名"];
    }
    
    [self loadLeftTableView];
    [self loadRightTableView];
    
    self.page = 1;
    
    [self initData];
    @weakify(self)
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        
        [self initData];
    }];
    
    self.rightTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page ++ ;
        
        [self initData];
    }];
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
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, SCREEN_WIDTH - LeftTableViewWidth));
    }];
}

- (void)loadRightTableView{
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, RightTableViewWith * self.rightTitles.count * 2, SCREEN_HEIGHT - NAV_HEIGHT - 34) style:UITableViewStylePlain];
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
    
    [self.buttomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0,LeftTableViewWidth, 0, 0));
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
            
            UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
            lab.tag = 100;
            [cell.contentView addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.center.equalTo(cell.contentView);
            }];
        }
        
        UILabel *lab = [cell.contentView viewWithTag:100];
        
        NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        
        lab.text = dic[@"date"];
        
//        for (UILabel *lab in cell.contentView.subviews) {
//
//            if (lab.tag == 100) {
//
//                lab.text = [NSString stringWithFormat:@"06-%ld",indexPath.row+1];
//            }
//        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = WHITE;
        return cell;
    }else{
        RightTableViewCell *cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:self.rightTitles.count*2 Withsize:CGSizeMake(RightTableViewWith, 40)];
        //这里先使用假数据
        UIView *view = [cell.contentView viewWithTag:100];
        NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        int i = 0;
        for (UILabel *label in view.subviews) {
            label.text = nil;
            label.font = FONT(13);
            label.textColor = [UIColor darkGrayColor];
            label.backgroundColor = i %2 == 1 ? WHITE : [UIColor groupTableViewBackgroundColor];
            switch (i) {
                case 0:
                    {
                        label.text = self.type == 2 ? STRING(dic[@"onel"]) : STRING(dic[@"oned"]);
                    }
                    break;
                case 1:
                {
                    label.text = self.type == 2 ? STRING(dic[@"oneh"]) : self.type == 0 ? STRING(dic[@"onex"]) : STRING(dic[@"ones"]);
                }
                    break;
                case 2:
                {
                    label.text = self.type == 2 ? STRING(dic[@"twol"]) : STRING(dic[@"twod"]);
                }
                    break;
                case 3:
                {
                    label.text = self.type == 2 ? STRING(dic[@"twoh"]) : self.type == 0 ? STRING(dic[@"twox"]) : STRING(dic[@"twos"]);
                }
                    break;
                case 4:
                {
                    label.text = self.type == 2 ? STRING(dic[@"threel"]) : STRING(dic[@"threed"]);
                }
                    break;
                case 5:
                {
                    label.text = self.type == 2 ? STRING(dic[@"threeh"]) : self.type == 0 ? STRING(dic[@"threex"]) : STRING(dic[@"threes"]);
                }
                    break;
                case 6:
                {
                    label.text = self.type == 2 ? STRING(dic[@"fourl"]) : STRING(dic[@"fourd"]);
                }
                    break;
                case 7:
                {
                    label.text = self.type == 2 ? STRING(dic[@"fourh"]) : self.type == 0 ? STRING(dic[@"fourx"]) : STRING(dic[@"fours"]);
                }
                    break;
                case 8:
                {
                    label.text = self.type == 2 ? STRING(dic[@"fivel"]) : STRING(dic[@"fived"]);
                }
                    break;
                case 9:
                {
                    label.text = self.type == 2 ? STRING(dic[@"fiveh"]) : self.type == 0 ? STRING(dic[@"fivex"]) : STRING(dic[@"fives"]);
                }
                    break;
                case 10:
                {
                    label.text = self.type == 2 ? @"" : STRING(dic[@"sixd"]);
                }
                    break;
                case 11:
                {
                    label.text = self.type == 2 ? @"" : self.type == 0 ? STRING(dic[@"sixx"]) : STRING(dic[@"sixs"]);
                }
                    break;
                case 12:
                {
                    label.text = self.type == 2 ? @"" : STRING(dic[@"sevend"]);
                }
                    break;
                case 13:
                {
                    label.text = self.type == 2 ? @"" : self.type == 0 ? STRING(dic[@"sevenx"]) : STRING(dic[@"sevens"]);
                }
                    break;
                case 14:
                {
                    label.text = self.type == 2 ? @"" : STRING(dic[@"eightd"]);
                }
                    break;
                case 15:
                {
                    label.text = self.type == 2 ? @"" : self.type == 0 ? STRING(dic[@"eightx"]) : STRING(dic[@"eights"]);
                }
                    break;
                case 16:
                {
                    label.text = self.type == 2 ? @"" : STRING(dic[@"nightd"]);
                }
                    break;
                case 17:
                {
                    label.text = self.type == 2 ? @"" : self.type == 0 ? STRING(dic[@"nightx"]) : STRING(dic[@"nights"]);
                }
                    break;
                case 18:
                {
                    label.text = self.type == 2 ? @"" : STRING(dic[@"tend"]);
                }
                    break;
                case 19:
                {
                    label.text = self.type == 2 ? @"" : self.type == 0 ? STRING(dic[@"tenx"]) : STRING(dic[@"tens"]);
                }
                    break;
                default:
                    break;
            }
            i++;
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
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)];
        header.backgroundColor = [UIColor colorWithHex:@"dddddd"];
        
        UIView *rightHeaderView1 = [UIView viewWithLabelNumber:self.rightTitles.count Withlabelwidth:CGSizeMake(RightTableViewWith * 2, 25)];
        rightHeaderView1.frame = CGRectMake(0, 0, header.bounds.size.width, 20);
        [header addSubview:rightHeaderView1];
        int i = 0;
        for (UILabel *label in rightHeaderView1.subviews) {
            label.text = self.rightTitles[i++];
            label.font = FONT(13);
            label.backgroundColor = [UIColor groupTableViewBackgroundColor];
            label.textColor = YAHEI;
        }
        
        UIView *rightHeaderView2 = [UIView viewWithDrawlabNumber:self.rightTitles.count*2 WithDrawlabwidth:CGSizeMake(RightTableViewWith, 24)];
        rightHeaderView2.frame = CGRectMake(0, 26, header.bounds.size.width, 24);
        [header addSubview:rightHeaderView2];
        int j = 0;
        for (Drawlab *label in rightHeaderView2.subviews) {
            
            if (self.type == 0) {
                
                label.text = j %2 == 0 ? @"大" : @"小";
            }
            else if (self.type == 1) {
                
                label.text = j %2 == 0 ? @"单" : @"双";
            }
            else {
                label.text = j %2 == 0 ? @"龙" : @"虎";
            }
            label.textColor = WHITE;
            label.font = FONT(13);
            label.bgColor = j%2 == 0 ? kColor(188, 153, 89) : kColor(108, 120, 158);
            label.showbg = YES;
            label.backgroundColor = WHITE;
            j++;
            [label setNeedsDisplay];
        }
        return header;
    }else{
        
        UILabel *lab = [Tools createLableWithFrame:CGRectMake(0, 0, LeftTableViewWidth, 41) andTitle:@"日期" andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
        lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return lab;
        
    }
}
//必须实现以下方法才可以使用自定义头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
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
    
    NSString *url = nil;
    
    if (self.type == 0) {
        
        if (self.lottery_type == 6) {
            
            url = @"/bjpksSg/lianMianDx.json";
        }
        else if (self.lottery_type == 7) {
            url = @"/xyftSg/lianMianDx.json";
        } else if (self.lottery_type == 11) {
            url = @"/azPrixSg/lianMianDx.json";
        }
    }
    else if (self.type == 1) {
        
        if (self.lottery_type == 6) {
            
            url = @"/bjpksSg/lianMianDs.json";
        } else if (self.lottery_type == 7) {
            url = @"/xyftSg/lianMianDs.json";
        } else if (self.lottery_type == 11) {
            url = @"/azPrixSg/lianMianDs.json";
        }
        
    }
    else {
        if (self.lottery_type == 6) {
            
            url = @"/bjpksSg/lianMianLh.json";
        } else if (self.lottery_type == 7) {
            url = @"/xyftSg/lianMianLh.json";
        } else if (self.lottery_type == 11) {
            url = @"/azPrixSg/lianMianLh.json";
        }
        
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"pageNum":@(self.page),@"pageSize":@(30)} success:^(BaseData *data) {
        @strongify(self)
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }
        
        [self.dataSource addObjectsFromArray:data.data];
        
        [self endRefresh:self.rightTableView WithdataArr:data.data];
        
        [self.rightTableView reloadData];
        [self.leftTableView reloadData];
        
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
