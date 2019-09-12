//
//  CartBPanBeijingPKViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/29.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CartBPanBeijingPKViewController.h"
#import "CartChongqinHeadCell.h"
#import "TopUpViewController.h"
#import "CartBPanBeijingPKHeaderView.h"
#import "IGKbetListCtrl.h"
#import "PK10DoubleSideTableViewCell.h"
#import "UIImage+color.h"
#import "BuyLotBottomView.h"

#define View_WIDTH  0.8 * [UIScreen mainScreen].bounds.size.width


@interface CartBPanBeijingPKViewController ()<WB_StopWatchDelegate,UITableViewDataSource, CartBPanBeijingPKHeaderViewDelegate>

/**
 展示section = 0的列表
 */
@property (nonatomic, assign) BOOL showhead;

@property (nonatomic, strong)CartBPanBeijingPKHeaderView *headView;

@property (nonatomic, strong) WB_Stopwatch *stopwatch;

@property (nonatomic, strong) NSArray *categoryArray;

@property (nonatomic, strong)UIScrollView *leftScrollView;
//记录选中 index
@property (nonatomic, assign)NSInteger selectedIndexPath;
@property (nonatomic, assign)NSInteger lastSelectedIndexPath;
@property (nonatomic, weak)UIButton *lastLeftBtn;
@property (nonatomic, weak)UIButton *currentLeftBtn;
@property (nonatomic, strong)NSMutableArray *LeftBtnsArray;

@property (nonatomic, strong) BuyLotBottomView *footView;

@end

@implementation CartBPanBeijingPKViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self getTypeRootData];
}

#pragma mark setupUI
- (void)setupUI{
    
    self.view.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CartChongqinHeadCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJHeaderIdentifier];
    [self.tableView registerClass:[PK10DoubleSideTableViewCell class] forCellReuseIdentifier:@"PK10DoubleSideTableViewCellID"];
    self.tableView.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.headView];
//    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.headView.frame));

//    [self.view addSubview:[self footview]];
//    
//    [self setupNav];
//    
//    [self setupTableViews];
    
//    [self setupCaculateView];
    
//    [self getTypeRootData];

    
}

#pragma mark 数据
#pragma mark - 获取购彩一级分类
-(void)getTypeRootData {
    
    [WebTools postWithURL:@"/lottery/queryFirstPlayByCateId.json" params:@{@"categoryId":@(self.categoryId)} success:^(BaseData *data) {
        
        self.categoryArray = [CartTypeModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self buildLeftScrollView];
        
        [self buildScrollView];
        
//        [self getfirstCategoryData];
        
//        [self getquerymiss];
//        [self buildDataSource];
        
//        [self.leftTableView reloadData];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)buildLeftScrollView{
    
    self.leftScrollView.pagingEnabled = YES;
    self.leftScrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.leftScrollView];

    UIView *leftSepelatorLine = [[UIView alloc] initWithFrame:CGRectMake(self.leftScrollView.width - 1, 0, 1, self.leftScrollView.height)];
    leftSepelatorLine.backgroundColor = [UIColor colorWithHex:@"2C3036"];
    
    [self.leftScrollView addSubview:leftSepelatorLine];
    
    
    CGFloat h = 40;
    
    for (int i = 0 ; i < self.categoryArray.count; i++) {
        
        CartTypeModel *model = self.categoryArray[i];
        
        CGFloat y = i * (h + 2);
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, y, self.leftScrollView.width - 5, h)];
        
        [self roundSide:2 button:btn];
        
        
        if (i == 0) {
            btn.selected = YES;
            self.lastLeftBtn = btn;
        }
        
        btn.tag = i;
        [self.LeftBtnsArray addObject:btn];
        
        [btn setTitle:model.name forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"2C3036"] size:btn.size] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"9C2D33"] size:btn.size] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIImage *yeallowImage = [UIImage imageWithColor:BASECOLOR size:CGSizeMake(8, 8)];
        //        UIImage *greenImage = [UIImage imageWithColor:[UIColor greenColor] size:CGSizeMake(8, 8)];
        
        [btn setImage:yeallowImage forState:UIControlStateSelected];
        btn.imageView.layer.masksToBounds = YES;
        btn.imageView.layer.cornerRadius = 4;
        
        [btn setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 22, 25)];
        
        if (btn.currentTitle.length >= 6) {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 22, 30)];
        }
        
        
        [self.leftScrollView addSubview:btn];
    }
    
    self.leftScrollView.contentSize = CGSizeMake(0, self.categoryArray.count * (h + 1));
    
}

- (void)buildScrollView{
    
    self.scrollView.frame = CGRectMake(SCREEN_WIDTH - View_WIDTH, CGRectGetMaxY(self.headView.frame), View_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.headView.frame) - self.footView.height);
    //    self.scrollView.scrollEnabled = NO;
    self.scrollView.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
    [self.view addSubview:self.scrollView];
    
    self.scrollView.pagingEnabled = YES;
    
    //创建子控制器
    for (int i = 0; i < self.categoryArray.count; i++) {
        
        if (i == 0) {
       
        }else if (i == 1){
            
  
            
        }else if(i == 2){
       
            
        }else if (i == 3){
            
       
            
        }
        
        
    }
    
    self.scrollView.contentSize = CGSizeMake(View_WIDTH, self.scrollView.height  * self.categoryArray.count);
    self.scrollView.scrollEnabled = NO;
    self.scrollView.delegate = self;
    
}

#pragma mark 分类按钮点击
- (void)clickLeftBtn:(UIButton *)btn{
    
    self.lastLeftBtn.selected = NO;
    btn.selected = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.height * btn.tag)];
    }];
    
    self.lastSelectedIndexPath = btn.tag;
    self.lastLeftBtn = btn;
    
    [self.tableView reloadData];
}

- (void)roundSide:(NSInteger)side button:(UIButton *)btn
{
    UIBezierPath *maskPath;
    
    if (side == 1)//左上,左下
        maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds
                                         byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                               cornerRadii:CGSizeMake(26.f, 26.f)];
    else if (side == 2)//右上,右下
        maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds
                                         byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                               cornerRadii:CGSizeMake(26.f, 26.f)];
    else if (side == 3)//
        maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds
                                         byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                               cornerRadii:CGSizeMake(26.f, 26.f)];
    else
        maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds
                                         byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                               cornerRadii:CGSizeMake(26.f, 26.f)];
    
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = btn.bounds;
    maskLayer.path = maskPath.CGPath;
    
    btn.layer.mask = maskLayer;
    
    [btn.layer setMasksToBounds:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PK10DoubleSideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PK10DoubleSideTableViewCellID" forIndexPath:indexPath];
    cell.backgroundColor = [[CPTThemeConfig shareManager] Buy_LotteryMainBackgroundColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark 查看历史数据
- (void)lookHistoryData:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    self.showhead = sender.selected;
    
    if (sender.selected) {
        
        [self.view addSubview:self.tableView];
        
        //        [UIView animateWithDuration:1.0 animations:^{
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.headView.frame));
        
        //        }];
        
        [self.tableView reloadData];
        
    }else{
        
        [self.tableView removeFromSuperview];
        
    }
    
}

#pragma mark CartCQBpanHeaderVeiwDelegate
- (void)ChargeController{
    if ([Person person].payLevelId.length == 0) {
        [MBProgressHUD showError:@"无用户层级, 暂无法充值"];
        return;
    }
    TopUpViewController *topUpVC = [[TopUpViewController alloc] init];
    [self.navigationController pushViewController:topUpVC animated:YES];
}


-(CartBPanBeijingPKHeaderView *)headView {
    
    if (!_headView) {
        WS(weakSelf);
        _headView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CartBPanBeijingPKHeaderView class]) owner:self options:nil]firstObject];
        
        _headView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 172);
        
        self.stopwatch = [[WB_Stopwatch alloc]initWithLabel:_headView.endtimelab andTimerType:WBTypeTimer];
        _headView.delegate = self;
        self.stopwatch.delegate = self;
        [self.stopwatch setTimeFormat:@"HH:mm:ss"];
        
        _headView.lookallBlock = ^{
            
            IGKbetListCtrl *list = [[IGKbetListCtrl alloc]init];
            list.lottery_type = weakSelf.lottery_type;
            list.titlestring = weakSelf.lottery_type == 1 ? @"重庆时时彩" : weakSelf.lottery_type == 2 ? @"新疆时时彩" : @"比特币分分彩";
            WEAKPUSH(list);
        };
    }
    return _headView;
}


- (UIScrollView *)leftScrollView{
    if (!_leftScrollView) {
        _leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame), SCREEN_WIDTH*0.2, SCREEN_HEIGHT - CGRectGetMaxY(self.headView.frame) - self.footView.height)];
    }
    return _leftScrollView;
}

- (NSMutableArray *)LeftBtnsArray{
    if (!_LeftBtnsArray) {
        _LeftBtnsArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _LeftBtnsArray;
}

-(BuyLotBottomView *)footview {

    if (!_footView) {
        _footView = [[BuyLotBottomView alloc] init];

        [self.view addSubview:_footView];
        _footView.frame = CGRectMake(0, SCREEN_HEIGHT  - 94 , SCREEN_WIDTH, 80);
    }
    return _footView;
    
}
@end
