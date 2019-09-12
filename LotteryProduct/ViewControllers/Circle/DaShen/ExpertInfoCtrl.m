//
//  ExpertInfoCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ExpertInfoCtrl.h"
#import "ExpertOrderCell.h"
#import "PushOrderModel.h"
#import "ForrowOrderViewController.h"
#import "PushResultCtrl.h"
#import "DaShenShareOrderCell.h"
#import "ZJDetailCell.h"
#import "BallTool.h"
#import "GendanDetailVC.h"
@interface ExpertInfoCtrl ()<UITableViewDelegate,UITableViewDataSource,DaShenShareOrderCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) UIView *sectionHeadView;
@property (strong, nonatomic) UIView *lineView;
@property (assign, nonatomic) NSInteger finishStatus;
@property (strong, nonatomic) UIButton *attentionBtn;
@property (assign, nonatomic) int page_ing;

@property (assign, nonatomic) int page_finish;
@property (nonatomic, weak)UIButton *lastBtn;

@end

@implementation ExpertInfoCtrl
{
    ZJDetailCell *headerCell;
    ExpertModel *_infoModel;
}

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.finishStatus = 1;
    
    self.title = @"专家详情";
    [self getexprtinfo];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

//    UIButton *btn = [Tools createButtonWithFrame:CGRectMake(0, 0, 70, 30) andTitle:@"关注" andTitleColor:WHITE andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(attentionClick:) andType:UIButtonTypeCustom];
//    [btn setTitle:@"取消关注" forState:UIControlStateSelected];
//    self.attentionBtn = btn;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.page_ing = 1;
    self.page_finish = 1;
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        if (self.finishStatus == 1) {
            self.page_ing = 1;
        }
        else{
            self.page_finish = 1;
        }
        
        [self initData];
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        @strongify(self)
        if (self.finishStatus == 1) {
            
            self.page_ing ++;
        }
        else{
            self.page_finish ++;
        }
        
        [self initData];
    }];
    [self initData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *array = self.finishStatus == 1 ? self.dataSource.firstObject : self.dataSource.lastObject;
    
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 210;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat h = [BallTool heightWithFont:13 limitWidth:SCREEN_WIDTH-20 string:_infoModel.personalContent];
    h = h>21?h:21;
    return 201+h;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    headerCell = [[[NSBundle mainBundle] loadNibNamed:@"ZJDetailCell" owner:nil options:nil]lastObject];
    if(_infoModel){
        [headerCell setDataWithModel:_infoModel];
    }
    @weakify(self)
    headerCell.didClickBtn = ^(NSInteger code) {
        @strongify(self)
        self.finishStatus = code == 1? 1:3;
        [self initData];
    };
    headerCell.didUpdateModel = ^(ExpertModel * model) {
        self->_infoModel = model;
    };
    headerCell.isGendan = NO;
    
    return headerCell.contentView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    ExpertOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//
//    NSMutableArray *array = self.finishStatus == 1 ? self.dataSource.firstObject : self.dataSource.lastObject;
//
//    PushOrderModel *model = [array objectAtIndex:indexPath.row];
//
//    cell.finishStatus = self.finishStatus;
//
//    cell.model = model;
//    @weakify(self)
//    cell.publishBlock = ^{
//        @strongify(self)
//        [self publish:model];
//    };
//    return cell;
    DaShenShareOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.delegate = self;
    cell.postMarkState = 1;
    NSMutableArray *array = self.finishStatus == 1 ? self.dataSource.firstObject : self.dataSource.lastObject;
    PushOrderModel *model = [array objectAtIndex:indexPath.row];
    
    
    cell.model = model;

    
    return cell;
    
}

-(void)getexprtinfo {
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/god/getGodInfo.json" params:@{@"godId":@(self.godId)} success:^(BaseData *data) {
       @strongify(self)
        _infoModel = [ExpertModel mj_objectWithKeyValues:data.data];
        _infoModel.godId = self.godId;
        _infoModel.ing = YES;
        [headerCell setDataWithModel:_infoModel];

    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(void)initData {
    
    NSMutableArray *array = self.finishStatus == 1 ? self.dataSource.firstObject : self.dataSource.lastObject;
    int page = self.finishStatus == 1 ? self.page_ing : self.page_finish;
    
    @weakify(self)
    NSDictionary *dic= @{@"godId":@(self.godId),@"finishStatus":@(self.finishStatus),@"pageNum":@(page),@"pageSize":pageSize};
    [WebTools postWithURL:@"/circle/god/getPushOrderListByGod.json" params:dic success:^(BaseData *data) {
        @strongify(self)
        if (page == 1) {
            
            [array removeAllObjects];
        }
        NSArray *datas = [PushOrderModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [array addObjectsFromArray:datas];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        if (datas.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        @strongify(self)
//        [array removeAllObjects];
//        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)attentionClick:(UIButton *)sender {
    
    [WebTools postWithURL:@"/circle/god/focusOrCancle" params:@{@"godId":@(self.godId),@"type":sender.selected == YES ? @2 : @1} success:^(BaseData *data) {
        
        [MBProgressHUD showSuccess:data.info finish:^{
            
            sender.selected = !sender.selected;
        }];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(void)typeClick:(UIButton *)sender {
    
//    for (id view in self.sectionHeadView.subviews) {
//
//        if ([view isKindOfClass:[UIButton class]]) {
//
//            UIButton *btn = (UIButton *)sender;
//
//            btn.selected = NO;
//        }
//    }
    self.lastBtn.selected = NO;
    sender.selected = YES;
    self.lastBtn = sender;
    @weakify(self)
    [UIView animateWithDuration:0.15 animations:^{
        @strongify(self)
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.bottom.equalTo(self.sectionHeadView);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2-40, 2));
            make.centerX.equalTo(sender);
        }];
    }];
    
    self.finishStatus = sender.tag == 100 ? 1 : 3;
    
    NSMutableArray *array = self.finishStatus == 1 ? self.dataSource.firstObject : self.dataSource.lastObject;
    
    if (array.count == 0) {
        
        [self initData];
    }
    else{
        [self.tableView reloadData];
    }
    
}
-(NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [[NSMutableArray alloc]init];
        
        NSMutableArray *data1 = [[NSMutableArray alloc]init];
        NSMutableArray *data2 = [[NSMutableArray alloc]init];
        
        [_dataSource addObject:data1];
        [_dataSource addObject:data2];
    }
    return _dataSource;
}

-(void)publish:(PushOrderModel *)model {
    
    if (self.finishStatus == 1) {
        
        ForrowOrderViewController *forrow = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"ForrowOrderViewController"];
        forrow.model = model;
        [self.navigationController pushViewController:forrow animated:YES];
    }else{
        PushResultCtrl *result = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"PushResultCtrl"];
        result.model = model;
        [self.navigationController pushViewController:result animated:YES];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GendanDetailVC *dVc = [[GendanDetailVC alloc] init];
    NSMutableArray *array = self.finishStatus == 1 ? self.dataSource.firstObject : self.dataSource.lastObject;
    PushOrderModel *model = [array objectAtIndex:indexPath.row];
    dVc.trackId = model.pushOrderId;
    PUSH(dVc);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
