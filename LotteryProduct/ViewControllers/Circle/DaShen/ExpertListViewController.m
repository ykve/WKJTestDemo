//
//  ExpertListViewController.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ExpertListViewController.h"
#import "ExpertListCell.h"
#import "ExpertModel.h"
#import "ApplyExpertCtrl.h"
#import "ExpertInfoCtrl.h"
#import "LoginAlertViewController.h"

@interface ExpertListViewController ()<UITableViewDelegate,UITableViewDataSource>
 
@property (nonatomic, strong) CJScroViewBar *BarView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *pageNumArray;

@property (nonatomic, strong) NSMutableArray *isHiddenFooterArray;
/// 当前类型
@property (nonatomic, assign) NSInteger currentType;

/// 盈利率
@property (nonatomic, strong) NSMutableArray *winRateArray;
/// 胜率
@property (nonatomic, strong) NSMutableArray *profitRateArray;
/// 连中
@property (nonatomic, strong) NSMutableArray *evenInArray;
/// 我的关注
@property (nonatomic, strong) NSMutableArray *myAttentionArray;




@end

@implementation ExpertListViewController


- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
    
}

// AFan<<<
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"大神推荐";
    self.view.backgroundColor = WHITE;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.currentType = 1;
    
    if ([Person person].uid) {
        [self judgeisGod];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"申请专家" style:UIBarButtonItemStylePlain target:self action:@selector(applyClick)];
    }
    
    [self buildScrollBar];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self getListData:self.currentType];
    self.pageNumArray = nil;
    [self.BarView setViewIndex:self.currentType -1];
}

-(void)buildScrollBar {
    
    NSArray *titles = @[@"盈利率",@"胜率",@"连中",@"我的关注"];
    
    self.BarView = [[CJScroViewBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    self.BarView.lineColor = [[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor];
    self.BarView.backgroundColor = [[CPTThemeConfig shareManager] pushDanSubbarBackgroundcolor];;
    [self.view addSubview:self.BarView];
    
    [self initTableView];
    
    [self.BarView layoutIfNeeded];
    
    [self.BarView setData:titles NormalColor:[[CPTThemeConfig shareManager] pushDanSubBarNormalTitleColor] SelectColor:[[CPTThemeConfig shareManager]pushDanSubBarSelectTextColor] Font:[UIFont systemFontOfSize:16]];
    __weak __typeof(self)weakSelf = self;
    
    [self.BarView getViewIndex:^(NSString *title, NSInteger index) {
   __strong __typeof(weakSelf)strongSelf = weakSelf;
//         [self.tableView.mj_footer setHidden:[self.isHiddenFooterArray[self.currentType -1] boolValue]];
//         [self getListData:index +1];
        
        strongSelf.pageNumArray[index] = @(1);
        strongSelf.isHiddenFooterArray[index] = @(NO);
        [strongSelf.tableView.mj_footer setHidden:NO];
        [strongSelf getListData:index +1];
    }];
    
//    [self.BarView setViewIndex:0];
}

- (void)initTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 80;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:_tableView];
    
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(45, 0, SAFE_HEIGHT, 0));
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.pageNumArray[self.currentType -1] = @(1);
        self.isHiddenFooterArray[self.currentType -1] = @(NO);
        [self.tableView.mj_footer setHidden:NO];
        [self getListData:self.currentType];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.pageNumArray[self.currentType -1]  = @([self.pageNumArray[self.currentType -1] integerValue] + 1);
        [self getListData:self.currentType];
    }];
    
    [self.tableView registerClass:[ExpertListCell class] forCellReuseIdentifier:RJCellIdentifier];
}

#pragma mark -  获取大神列表
- (void)getListData:(NSInteger)index {
    
    self.currentType = index;
    
    NSMutableDictionary *dictPar = [[NSMutableDictionary alloc]init];
    [dictPar setValue:@(self.currentType) forKey:@"type"]; // （必须）1盈利率排序2胜率排序3连中排序4我的关注
    if (self.lottery_id) {
        [dictPar setValue:@(self.lottery_id) forKey:@"lotteryId"];  // （必须）彩种ID 不传则全部 传则彩种分类
    }
    [dictPar setValue:self.pageNumArray[self.currentType -1] forKey:@"pageNum"];  // 页码
    [dictPar setValue:pageSize forKey:@"pageSize"];   // 数量
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/god/godLotteryList.json" params:dictPar success:^(BaseData *data) {
        
        @strongify(self)
        
       NSInteger pageNum = [self.pageNumArray[self.currentType -1] integerValue];
        if (pageNum == 1) {
            if (self.currentType == 1) {
                [self.winRateArray removeAllObjects];
            } else if (self.currentType == 2) {
                 [self.profitRateArray removeAllObjects];
            } else if (self.currentType == 3) {
                [self.evenInArray removeAllObjects];
            } else if (self.currentType == 4) {
                [self.myAttentionArray removeAllObjects];
            }
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSArray *array = [ExpertModel mj_objectArrayWithKeyValuesArray:data.data];
        if ((!array || array.count == 0) || array.count < [pageSize integerValue]) {
            if (array.count > 0) {
                //                 [self hiddenNoDataImageView];
                if (self.currentType == 1) {
                    [self.winRateArray addObjectsFromArray:array];
                } else if (self.currentType == 2) {
                    [self.profitRateArray addObjectsFromArray:array];
                } else if (self.currentType == 3) {
                    [self.evenInArray addObjectsFromArray:array];
                } else if (self.currentType == 4) {
                    [self.myAttentionArray addObjectsFromArray:array];
                }
            }
            if (pageNum == 1 || (!array || array.count == 0)) {
                //                [self showNoDataImageView];
            }
            self.isHiddenFooterArray[self.currentType -1] = @(YES);
            [self.tableView.mj_footer setHidden:YES];
        } else {
            //            [self hiddenNoDataImageView];
            //        [self.dataSource replaceObjectAtIndex:index withObject:array];
            if (self.currentType == 1) {
                [self.winRateArray addObjectsFromArray:array];
            } else if (self.currentType == 2) {
                [self.profitRateArray addObjectsFromArray:array];
            } else if (self.currentType == 3) {
                [self.evenInArray addObjectsFromArray:array];
            } else if (self.currentType == 4) {
                [self.myAttentionArray addObjectsFromArray:array];
            }
        }
        [self.tableView reloadData];
        

    } failure:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }showHUD:NO];
}

#pragma mark -  自己是否是专家
/**
 自己是否是专家
 */
- (void)judgeisGod {
    @weakify(self)
    [WebTools postWithURL:@"/circle/god/isGod.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        if ([data.data[@"isGod"]boolValue] == false) {
            
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"申请专家" style:UIBarButtonItemStylePlain target:self action:@selector(applyClick)];
        }
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark -  关注大神 和 取消关注大神接口
-(void)attentionClick:(UIButton *)sender Withid:(ExpertModel *)model {
    
    [WebTools postWithURL:@"/circle/god/focusOrCancle.json" params:@{@"godId":@(model.godId),@"type":sender.selected == YES ? @2 : @1} success:^(BaseData *data) {
        __weak __typeof(self)weakSelf = self;
        [MBProgressHUD showSuccess:data.info finish:^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            sender.selected = !sender.selected;
            model.isFocus = sender.selected == YES ? 1 : 0;
            
            if (strongSelf.currentType == 4) {
                [strongSelf.myAttentionArray removeObject:model];
                [strongSelf.tableView reloadData];
            }
        }];
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.currentType == 1) {
      return self.winRateArray.count;
    } else if (self.currentType == 2) {
      return self.profitRateArray.count;
    } else if (self.currentType == 3) {
       return self.evenInArray.count;
    } else if (self.currentType == 4) {
       return self.myAttentionArray.count;
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExpertListCell *cell = [ExpertListCell cellWithTableView:tableView reusableId:RJCellIdentifier];
    
    NSArray *array;
    if (self.currentType == 1) {
       array = self.winRateArray;
    } else if (self.currentType == 2) {
        array = self.profitRateArray;
    } else if (self.currentType == 3) {
        array = self.evenInArray;
    } else if (self.currentType == 4) {
        array = self.myAttentionArray;
    } else {
        array = [NSArray array];
    }
    
    ExpertModel *model = [array objectAtIndex:indexPath.row];
    cell.nameType = self.currentType;
    cell.model = model;
    
    @weakify(self)
    cell.attentionBlock = ^(UIButton *sender) {
        @strongify(self)
        [self attentionClick:sender Withid:model];
    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array;
    if (self.currentType == 1) {
        array = self.winRateArray;
    } else if (self.currentType == 2) {
        array = self.profitRateArray;
    } else if (self.currentType == 3) {
        array = self.evenInArray;
    } else if (self.currentType == 4) {
        array = self.myAttentionArray;
    } else {
        array = [NSArray array];
    }
    
    ExpertModel *model = [array objectAtIndex:indexPath.row];
    
    ExpertInfoCtrl *info = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertInfoCtrl"];
    info.godId = model.godId;
    PUSH(info);
}

-(void)applyClick {
    
    if ([Person person].uid == nil) {
        
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:login animated:YES completion:nil];
        //        LoginCtrl *login = [[LoginCtrl alloc]initWithNibName:NSStringFromClass([LoginCtrl class]) bundle:[NSBundle mainBundle]];
        //        @weakify(self)
        //        login.loginBlock = ^(BOOL result) {
        //            if (result) {
        //                ApplyExpertCtrl *apply = [[ApplyExpertCtrl alloc]init];
        //                @strongify(self)
        //                [self.navigationController pushViewController:apply animated:YES];
        //            }
        //        };
        //        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
        //
        //        nav.navigationBar.hidden = YES;
        //
        //        [self presentViewController:nav animated:YES completion:nil];
    }
    else{
        ApplyExpertCtrl *apply = [[ApplyExpertCtrl alloc]init];
        
        [self.navigationController pushViewController:apply animated:YES];
    }
}



-(NSMutableArray *)winRateArray {
    
    if (!_winRateArray) {
        
        _winRateArray = [[NSMutableArray alloc]init];
    }
    return _winRateArray;
}
-(NSMutableArray *)profitRateArray {
    
    if (!_profitRateArray) {
        
        _profitRateArray = [[NSMutableArray alloc]init];
    }
    return _profitRateArray;
}
-(NSMutableArray *)evenInArray {
    
    if (!_evenInArray) {
        
        _evenInArray = [[NSMutableArray alloc]init];
    }
    return _evenInArray;
}
-(NSMutableArray *)myAttentionArray {
    
    if (!_myAttentionArray) {
        
        _myAttentionArray = [[NSMutableArray alloc]init];
    }
    return _myAttentionArray;
}

-(NSMutableArray *)pageNumArray {
    
    if (!_pageNumArray) {
        
        _pageNumArray = [NSMutableArray arrayWithArray: @[@(1),@(1),@(1),@(1)]];
    }
    return _pageNumArray;
}

-(NSMutableArray *)isHiddenFooterArray {
    
    if (!_isHiddenFooterArray) {
        
        _isHiddenFooterArray = [NSMutableArray arrayWithArray: @[@(NO),@(NO),@(NO),@(NO)]];
    }
    return _isHiddenFooterArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
