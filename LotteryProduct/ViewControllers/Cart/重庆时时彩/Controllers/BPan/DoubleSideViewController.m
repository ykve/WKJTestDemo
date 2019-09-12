//
//  DoubleSideViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "DoubleSideViewController.h"
#import "DoubleSideTotalDragonTableViewCell.h"
#import "DoubleSideBallTableViewCell.h"
#import "DoubleSideHeaderView.h"
#import "CartOddsModel.h"
#import "CartCQModel.h"

@class OddsList;

static NSString *DoubleSideBallTableViewCellID = @"DoubleSideBallTableViewCellID";


@interface DoubleSideViewController ()<DoubleSideBallTableViewCellDelegate,DoubleSideTotalDragonTableViewCellDelegate>

@property (nonatomic, strong)CartOddsModel *oddModel;
//@property (nonatomic, strong)OddsList *listModel;

@property (nonatomic, strong) NSMutableArray *itemModels;


@end

@implementation DoubleSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self creatModels];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(doubleSideSelectOtherBalls:) name:@"doubleSideSelectOtherBall" object:nil];


}

- (void)doubleSideSelectOtherBalls:(NSNotification *)noti{
    [self.tableView reloadData];
}

- (void)setTypeModel:(CartTypeModel *)typeModel{
    _typeModel = typeModel;
    [self initData];

}

- (void)setupUI{
    
    [self.view addSubview:self.tableView];
    
    self.tableView.frame = self.view.bounds;

    
    self.tableView.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DoubleSideTotalDragonTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:DoubleSideTotalDragonTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DoubleSideBallTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:DoubleSideBallTableViewCellID];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self initData];
    }];
    
    [self hiddenavView];
}

-(void)hiddenavView {
    
    self.navView.hidden = YES;
    self.navView.alpha = 0;
}

- (void)creatModels{
    for (int i = 0; i < 27; i ++) {
        CartCQModel *model = [[CartCQModel alloc] init];
        model.selected = NO;
        model.peiLv = @"2.0";
        model.ID = [NSString stringWithFormat:@"%d", i + 100];
        [self.itemModels addObject:model];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    CartChongqinModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    if (indexPath.section == 0) {
        DoubleSideTotalDragonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DoubleSideTotalDragonTableViewCellID forIndexPath:indexPath];
        
        for (UIButton *btn in cell.numberBtns) {
            
            for (int i = 0; i < cell.numberBtns.count; i ++) {
                btn.tag = i + 100;
            }

            for (CartCQModel *model in self.itemModels) {
                if (btn.tag == [model.ID intValue]) {
                    btn.selected = model.selected;
                }
            }

        }
        
        cell.itemModels = self.itemModels;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
                
        cell.oddModel = self.oddModel;
        
        cell.itemModels = self.itemModels;
        
        cell.delegate = self;
        
//        __weak typeof(self) weakSelf = self;
        
//        cell.selectBlock = ^(NSString *title){
//
//            if ([model.selectnumbers containsObject:title]) {
//
//                [model.selectnumbers removeObject:title];
//            }
//            else {
//                [model.selectnumbers addObject:title];
//            }
//
//            [self gettotallotteryCount];
//
//            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
//        };


        return cell;
        
    }else{
        
        DoubleSideBallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DoubleSideBallTableViewCellID forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        for (UIButton *btn in cell.numberBtns) {
            
            for (int i = 0; i < cell.numberBtns.count; i++) {
                btn.tag = (indexPath.section - 1) * 4 + i + 107;
                
                NSLog(@"%ld", (long)btn.tag);
            }
            
            for (UIButton *btn in cell.numberBtns) {
                NSLog(@"%ld", btn.tag);
            }
            
            for (CartCQModel *model in self.itemModels) {
                if (btn.tag == [model.ID intValue]) {
                    btn.selected = model.selected;
                }
            }
            
        }

        
        cell.itemModels = self.itemModels;
        
        cell.delegate = self;

        return cell;

    }
    
}

- (void)initData{
    //
    NSLog(@"%ld", (long)self.typeModel.ID);
    [WebTools postWithURL:@"/lottery/queryLhcPlayInfo.json" params:@{@"lotteryId":@(8),@"playId":@(self.typeModel.ID)} success:^(BaseData *data) {
        
        [self.tableView.mj_header endRefreshing];
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        NSLog(@"%@", data);
       self.oddModel = [CartOddsModel mj_objectWithKeyValues:data.data];
     
//        OddsList *listModel =  self.oddModel.oddsList.firstObject;
        
//        NSLog(@"%@", listModel.name);
        
        [self.tableView reloadData];
        
//        CartChongqinModel *model = [self.dataSource objectAtIndex:0];

//        self.oddsArray = [CartOddsModel mj_objectArrayWithKeyValuesArray:data.data];
//
//        [self addsubviewtofootview];
        
    } failure:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];

//        for (id view in self.footView.subviews) {
//
//            [view removeFromSuperview];
//        }
//        [self.dataSource removeAllObjects];
//        [self.ballDataArray removeAllObjects];
//        [self.block2DataArray removeAllObjects];
//        [self.blockDataArray removeAllObjects];
//        self.ballView = nil;
//        self.blockView = nil;
//        self.blockView2 = nil;
//        self.showcell = NO;
        [self.tableView reloadData];
    } showHUD:NO];
}


-(void)buildDataSource {
    
    [self.dataSource removeAllObjects];
    
//    self.showfoot = NO;
    
//    [self gettotallotteryCount];
    
//    [[BuyTools tools] getchongqinDataSourceWith:self.dataSource With:self.selectModels.firstObject With:self.textView];
    [self.tableView reloadData];
    
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 175;
    }
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *objs = [[NSBundle mainBundle]loadNibNamed:@"DoubleSideHeaderView" owner:nil options:nil];
    
    DoubleSideHeaderView *header = objs.firstObject;
    header.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
    
    if (section==0) {
        header.titleLbl.text = @"总和、龙虎";
    } else if (section == 1){
        header.titleLbl.text = @"第一球";
    }else if (section == 2){
        header.titleLbl.text = @"第二球";
    }else if (section == 3){
        header.titleLbl.text = @"第三球";
    }else if (section == 4){
        header.titleLbl.text = @"第四球";
    }else if (section == 5){
        header.titleLbl.text = @"第五球";
    }
    
    header.frame = CGRectMake(0, 0, self.view.width, 30);
    header.leftVeiw.backgroundColor = [UIColor colorWithHex:@"EC6630"];

    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark DoubleSideTotalDragonTableViewCellDelegate

- (void)selectBalls:(NSMutableArray *)selectBallsArray{
    
    if ([self.delegate respondsToSelector:@selector(selectBalls:)]) {
        [self.delegate selectBalls:selectBallsArray];
    }
}

#pragma mark DoubleSideBallTableViewCellDelegate

- (void)selectBigSmallBalls:(NSMutableArray *)selectBallsArray{
    
}

- (NSMutableArray *)itemModels{
    if (!_itemModels) {
        _itemModels = [NSMutableArray arrayWithCapacity:10];
    }
    return _itemModels;
}

- (NSMutableArray *)selectModels{
    if (!_selectModels) {
        _selectModels = [NSMutableArray arrayWithCapacity:10];
    }
    return _selectModels;
}

@end
