//
//  DaShenListViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/7/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "DaShenListViewController.h"
#import "DaShenRankView.h"
#import "DashenRecommendDetailViewController.h"
#import "DaShenShareOrderCell.h"
#import "ForrowOrderViewController.h"
#import "ExpertListViewController.h"
#import "ExpertModel.h"
#import "PushOrderModel.h"
#import "ExpertInfoCtrl.h"
#import "UIImage+color.h"
#import "GendanDetailVC.h"
#import "DaShenHeadAvatarView.h"

@interface DaShenListViewController () <DaShenShareOrderCellDelegate, UITableViewDataSource,UITableViewDelegate>

/// <#strong注释#>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *backImageView;
/// tag 0 盈利率 1 胜率 2 连中
@property (strong, nonatomic) NSMutableArray<UIButton *> *btns;
/// 冠军
@property (strong, nonatomic) DaShenHeadAvatarView *headImgView1;
/// 亚军
@property (strong, nonatomic) DaShenHeadAvatarView *headImgView2;
/// 季军
@property (strong, nonatomic) DaShenHeadAvatarView *headImgView3;
/// 全部专家
@property (strong, nonatomic) UIButton *allPeopleBtn;
@property (strong, nonatomic) UIView *topBackView;
@property (strong, nonatomic)  UILabel *headTitleLabel;
/// 布局控件
@property (nonatomic, strong) UIStackView *containerView;


@property (strong, nonatomic) NSMutableArray *expertArray;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) int page;
/// currenttype 1 盈利率 2 胜率 3 连中
@property (assign, nonatomic) NSInteger currenttype;

@end

@implementation DaShenListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.expertArray = [[NSMutableArray alloc]initWithArray:@[[NSNull null],[NSNull null],[NSNull null]]];
    self.dataSource = [[NSMutableArray alloc]init];
    
    [self setupUI];
    [self setUIValues];
    
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        
        [self initData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page ++ ;
        [self initData];
    }];
    
    [self getGodcount];
    
    [self.tableView registerClass:[DaShenShareOrderCell class] forCellReuseIdentifier:@"DaShenShareOrderCell"];
}

#pragma mark - vvUITableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        // 去除横线
        _tableView.separatorStyle = UITableViewCellAccessoryNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 215-30+60)];
    headView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headView;
    
    UIView *topBackView = [[UIView alloc] init];
    topBackView.backgroundColor = [UIColor colorWithHex:@"#4888CC"];
    [headView addSubview:topBackView];
    _topBackView = topBackView;
    [topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(headView);
        make.height.mas_equalTo(215-30);
    }];
    
    UIImageView *backImageView = [[UIImageView alloc] init];
    [topBackView addSubview:backImageView];
    _backImageView = backImageView;
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(topBackView);
    }];
    [self.topBackView sendSubviewToBack:backImageView];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBackView.mas_bottom);
        make.left.equalTo(headView.mas_left);
        make.right.equalTo(headView.mas_right);
        make.height.mas_equalTo(60);
    }];
    
    
    UIView *btnView = [[UIView alloc] init];
    btnView.backgroundColor = [UIColor clearColor];
    btnView.layer.cornerRadius = 2;
    btnView.layer.masksToBounds = YES;
    btnView.layer.borderWidth = 1;
    btnView.layer.borderColor = [UIColor whiteColor].CGColor;
    [topBackView addSubview:btnView];
    
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_top).offset(10);
        make.right.equalTo(headView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(160, 22));
    }];
    
    
    self.containerView = [[UIStackView alloc] init];
    self.containerView.backgroundColor = [UIColor orangeColor];
    //子控件的布局方向
    self.containerView.axis = UILayoutConstraintAxisHorizontal;
    
    self.containerView.distribution = UIStackViewDistributionFillEqually;
    self.containerView.spacing = 2;
    //    self.containerView.alignment = UIStackViewAlignmentFill;
    self.containerView.frame = CGRectMake(0, 0, 160, 22);
    [btnView addSubview:self.containerView];
    
    UIButton *btn1 = [[UIButton alloc] init];
    [btn1 setTitle:@"盈利率" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    btn1.tag = 0;
    [self.containerView addArrangedSubview:btn1];
    [self.btns addObject:btn1];
    
    UIButton *btn2 = [[UIButton alloc] init];
    [btn2 setTitle:@"胜率" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor clearColor];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    btn2.tag = 1;
    [self.containerView addArrangedSubview:btn2];
    [self.btns addObject:btn2];
    
    UIButton *btn3 = [[UIButton alloc] init];
    [btn3 setTitle:@"连中" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn3.backgroundColor = [UIColor clearColor];
    btn3.titleLabel.font = [UIFont systemFontOfSize:12];
    btn3.tag = 2;
    [self.containerView addArrangedSubview:btn3];
     [self.btns addObject:btn3];
    
    UILabel *headTitleLabel = [[UILabel alloc] init];
    headTitleLabel.text = @"专家周排名（在售）";
    headTitleLabel.font = [UIFont systemFontOfSize:14];
    headTitleLabel.textColor = [UIColor whiteColor];
    headTitleLabel.textAlignment = NSTextAlignmentLeft;
    [topBackView addSubview:headTitleLabel];
    _headTitleLabel = headTitleLabel;
    
    [headTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView.mas_centerY);
        make.left.equalTo(topBackView.mas_left).offset(10);
    }];
    
    
    
    DaShenHeadAvatarView *headImgView1 = [[DaShenHeadAvatarView alloc] init];
    headImgView1.imgWidht = 76;
    headImgView1.backgroundColor = [UIColor clearColor];
    [topBackView addSubview:headImgView1];
    _headImgView1 = headImgView1;
    [headImgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topBackView.mas_centerX);
        make.bottom.equalTo(topBackView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(100, 150));
    }];
    
    DaShenHeadAvatarView *headImgView2 = [[DaShenHeadAvatarView alloc] init];
    headImgView2.backgroundColor = [UIColor clearColor];
    [topBackView addSubview:headImgView2];
    _headImgView2 = headImgView2;
    [headImgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topBackView.mas_centerX).multipliedBy(0.3);
        make.bottom.equalTo(topBackView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(100, 135));
    }];
    
    DaShenHeadAvatarView *headImgView3 = [[DaShenHeadAvatarView alloc] init];
    headImgView3.backgroundColor = [UIColor clearColor];
    [topBackView addSubview:headImgView3];
    _headImgView3 = headImgView3;
    [headImgView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topBackView.mas_centerX).multipliedBy(1.7);;
        make.bottom.equalTo(topBackView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(100, 135));
    }];
    
    
    
    UIButton *allPeopleBtn = [[UIButton alloc] init];
    [allPeopleBtn setTitle:@"全部专家(-)" forState:UIControlStateNormal];
    [allPeopleBtn addTarget:self action:@selector(allPeopleClick:) forControlEvents:UIControlEventTouchUpInside];
    allPeopleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:allPeopleBtn];
    _allPeopleBtn = allPeopleBtn;
    
    [allPeopleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView.mas_centerX);
        make.top.equalTo(bottomView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 25));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"热门跟单";
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor colorWithHex:@"666666"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_bottom).offset(-8);
        make.left.equalTo(bottomView.mas_left).offset(10);
    }];
    
    UILabel *titsubLabel = [[UILabel alloc] init];
    titsubLabel.text = @"中奖后按比例分红,未达到报纸赔率不分红";
    titsubLabel.font = [UIFont systemFontOfSize:12];
    titsubLabel.textColor = [UIColor colorWithHex:@"666666"];
    titsubLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:titsubLabel];
    
    [titsubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.left.equalTo(titleLabel.mas_right).offset(10);
    }];
    
}

- (void)setUIValues {
    
    self.backImageView.image = [[CPTThemeConfig shareManager] IM_GD_DashenTableImgView];
    self.topBackView.backgroundColor = [[CPTThemeConfig shareManager] CO_GD_TopBackgroundColor];
    self.headTitleLabel.textColor = [[CPTThemeConfig shareManager] CO_GD_TopBackHeadTitle];
    
    [self btnClick:self.btns.firstObject];
    
    self.headImgView1.ccImg.image = [UIImage imageNamed:@"yellowcircle"];
    self.headImgView1.ttImg.image = [UIImage imageNamed:@"yellowcrown"];
    self.headImgView1.nameLabel.textColor = [UIColor colorWithHex:@"FFFFFF"];
    self.headImgView1.ppLabel.textColor = [UIColor colorWithHex:@"FFEA00"];
    
    self.headImgView2.ccImg.image = [UIImage imageNamed:@"bluecircle"];
    self.headImgView2.ttImg.image = [UIImage imageNamed:@"bluecrown"];
    self.headImgView2.nameLabel.textColor = [UIColor colorWithHex:@"FFFFFF"];
    self.headImgView2.ppLabel.textColor = [UIColor colorWithHex:@"FFEA00"];
    
    self.headImgView3.ccImg.image = [UIImage imageNamed:@"redcircle"];
    self.headImgView3.ttImg.image = [UIImage imageNamed:@"redcrown"];
    self.headImgView3.nameLabel.textColor = [UIColor colorWithHex:@"FFFFFF"];
    self.headImgView3.ppLabel.textColor = [UIColor colorWithHex:@"FFEA00"];
    
    [self.allPeopleBtn setTitleColor:[[CPTThemeConfig shareManager] CO_GD_AllPeople_BtnText] forState:UIControlStateNormal];
    
    
    
    NSInteger index1 = YES;
    for (UIButton *btn in self.btns) {
        [btn setTitleColor:[[CPTThemeConfig shareManager] CO_GD_SelectedTextNormal] forState:UIControlStateNormal];
        [btn setTitleColor:[[CPTThemeConfig shareManager] CO_GD_SelectedTextSelected] forState:UIControlStateSelected];
        
        if (index1) {
            [btn setBackgroundColor:[[CPTThemeConfig shareManager] CO_GD_Title_BtnBackSelected]];
            [btn setSelected:YES];
        }
        index1 = NO;
    }
}


/// tag 0 盈利率 1 胜率 2 连中
/// Title点击
- (IBAction)btnClick:(UIButton *)sender {
    for (UIButton *btn in self.btns) {
        btn.selected = NO;
        [btn setBackgroundColor:[[CPTThemeConfig shareManager] CO_GD_TopBackgroundColor]];
    }
    sender.selected = YES;
    sender.backgroundColor = [[CPTThemeConfig shareManager] CO_GD_Title_BtnBackSelected];
    
    
    self.currenttype = sender.tag + 1;
    
    NSDictionary *dic;
    NSString *url;
    if(self.lottery_id){
        dic = @{@"type":@(self.currenttype), @"lotteryId" : @(self.lottery_id),@"pageNum":@(1),@"pageSize":@(3)};
    }else{
        dic = @{@"type":@(self.currenttype), @"pageNum":@(1),@"pageSize":@(3)};
    }
    
    url = @"/circle/god/godLotteryList.json";
    
    if ([[self.expertArray objectAtIndex:sender.tag] isEqual:[NSNull null]]) {
        @weakify(self)
        [WebTools postWithURL:url params:dic success:^(BaseData *data) {
            @strongify(self)
            if(data){
                NSArray *array = [ExpertModel mj_objectArrayWithKeyValuesArray:data.data];
                
                if (array) {
                    [self.expertArray replaceObjectAtIndex:sender.tag withObject:array];
                    
                    [self updataDashenRangData:array];
                }
            }
        } failure:^(NSError *error) {
            
        } showHUD:NO];
    }
    else{
        
        NSArray *array = self.expertArray[sender.tag];
        
        [self updataDashenRangData:array];
        
        [self.tableView reloadData];
    }
    
    self.page = 1;
    [self initData];
}

// 全部专家
- (IBAction)allPeopleClick:(UIButton *)sender {
    
    ExpertListViewController *list = [[ExpertListViewController alloc]init];
    
    list.lottery_id = self.lottery_id;
    
    [self.navigationController pushViewController:list animated:YES];
}

#pragma mark -  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210;
    PushOrderModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    return [DaShenShareOrderCell getHeight:model];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    DaShenShareOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    DaShenShareOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DaShenShareOrderCell"];
    if(cell == nil) {
        cell = [DaShenShareOrderCell cellWithTableView:tableView reusableId:@"DaShenShareOrderCell"];
    }
    
    cell.delegate = self;
    cell.postMarkState = 1;
    
    PushOrderModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.lottery_id = self.lottery_id;
    cell.rateType = self.currenttype;
    cell.model = model;
    
    @weakify(self)
    [cell.headimgv tapHandle:^{
        @strongify(self)
        ExpertInfoCtrl *info = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertInfoCtrl"];
        info.godId = model.godId;
        PUSH(info);
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GendanDetailVC *dVc = [[GendanDetailVC alloc] init];
    PushOrderModel *model = [self.dataSource objectAtIndex:indexPath.row];
    dVc.trackId = model.pushOrderId;
    PUSH(dVc);
}

- (void)dashenForrowOrderAction:(PushOrderModel *)model {
    ForrowOrderViewController *forrow = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"ForrowOrderViewController"];
    forrow.model = model;
    [self.navigationController pushViewController:forrow animated:YES];
}

#pragma mark -  跟单热门
-(void)initData {
    
    NSDictionary *dic;
    if ([self.title isEqualToString:@"全部"]) {
        dic = @{@"type":@(self.currenttype),@"pageNum":@(self.page),@"pageSize":pageSize};
    }else{
        dic = @{@"lotteryId":@(self.lottery_id),@"type":@(self.currenttype),@"pageNum":@(self.page),@"pageSize":pageSize};
    }
    @weakify(self)
    [WebTools postWithURL:@"/circle/god/getPushOrderList.json" params: dic success:^(BaseData *data) {
        @strongify(self)
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }
        
        NSArray *array = [PushOrderModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.dataSource addObjectsFromArray:array];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if (array.count == 0) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } showHUD:NO];
}

#pragma mark - 头部前三名
-(void)updataDashenRangData:(NSArray *)array {
    
    ExpertModel *first = nil;
    ExpertModel *second = nil;
    ExpertModel *third = nil;
    
    if (array.count > 2) {
        first = array[0];
        second = array[1];
        third = array[2];
    } else if (array.count > 1) {
        first = array[0];
        second = array[1];
    } else if (array.count > 0) {
        first = array[0];
    }
    
    
    [self.headImgView1.headImg sd_setImageWithURL:IMAGEPATH(first.heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
    self.headImgView1.nameLabel.text = first.nickname;
    self.headImgView1.ppLabel.text = first.showRate;
    
    [self.headImgView2.headImg sd_setImageWithURL:IMAGEPATH(second.heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
    self.headImgView2.nameLabel.text = second.nickname;
    self.headImgView2.ppLabel.text = second.showRate;
    
    [self.headImgView3.headImg sd_setImageWithURL:IMAGEPATH(third.heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
    self.headImgView3.nameLabel.text = third.nickname;
    self.headImgView3.ppLabel.text = third.showRate;
    
    
    @weakify(self)
    [self.headImgView1 tapHandle:^{
        @strongify(self)
        ExpertInfoCtrl *info = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertInfoCtrl"];
        info.godId = first.godId;
        PUSH(info);
    }];
    [self.headImgView2 tapHandle:^{
        @strongify(self)
        ExpertInfoCtrl *info = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertInfoCtrl"];
        info.godId = second.godId;
        PUSH(info);
    }];
    [self.headImgView3 tapHandle:^{
        @strongify(self)
        ExpertInfoCtrl *info = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertInfoCtrl"];
        info.godId = third.godId;
        PUSH(info);
    }];
}

#pragma mark - 获取专家人数
-(void)getGodcount {
    
    NSDictionary *dic;
    if ([self.title isEqualToString:@"全部"]) {
        dic = nil;
    }else{
        dic = @{@"lotteryId" : @(self.lottery_id)};
    }
    @weakify(self)
    [WebTools postWithURL:@"/circle/god/godCount.json" params:dic success:^(BaseData *data) {
        
        @strongify(self)
        if(data.status.integerValue == 1){
            NSNumber *num = data.data[@"godCount"];
            [self.allPeopleBtn setTitle:[NSString stringWithFormat:@"全部专家（%@）>>",num] forState:UIControlStateNormal];
        }
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

- (NSMutableArray<UIButton *> *)btns {
    if (!_btns) {
        _btns = [[NSMutableArray alloc] init];
    }
    return _btns;
}


@end
