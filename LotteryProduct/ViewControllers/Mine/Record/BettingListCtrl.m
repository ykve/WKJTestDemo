//
//  BettingListCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "BettingListCtrl.h"
#import "BettinglistCell.h"
#import "BettingHeadView.h"
#import "LotteryTypeView.h"
#import "BettingModel.h"
#import "BettingDetailCtrl.h"
#import "PushBettingCtrl.h"
#import "ChaseNumberCell.h"
#import "BallTool.h"
@interface BettingListCtrl ()

@property (nonatomic, strong)BettingHeadView *headView;

@property (nonatomic, strong)NSArray *lotteryIds;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, copy) NSString *sortName;

@property (nonatomic, copy) NSString *sortType;
@end

@implementation BettingListCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navView.hidden = YES;
    
    self.headView = [[NSBundle mainBundle]loadNibNamed:@"BettingHeadView" owner:self options:nil].firstObject;
    [self.view addSubview:self.headView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BettinglistCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChaseNumberCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJHeaderIdentifier];
    self.tableView.rowHeight = 126;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    @weakify(self)

    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.and.top.and.right.equalTo(self.view);
        make.height.equalTo(@95);
        
    }];
    
    
   
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)

        make.left.right.equalTo(self.view);
        make.top.equalTo(self.headView.mas_bottom);
        if (([self.status isEqualToString:@"WAIT"] || self.status == nil) && [self.Bettingtype isEqualToString:@"NORMAL"]) {
            
            make.bottom.equalTo(self.view).offset(-50);
        }
        else{
            make.bottom.equalTo(self.view);
        }
    }];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.headView.selectClickBlock = ^(NSInteger index,UIButton *sender) {
        @strongify(self)

        switch (index) {
            case 1:// 前一天
            {
                self.date = [self.date dateAfterDay:-1];
                
                self.time = [dateFormatter stringFromDate:self.date];
                
                [self updatetime];
                
                [self.tableView.mj_header beginRefreshing];
            }
                break;
            case 2:// 后一天
            {
                self.date = [self.date dateAfterDay:1];
                
                self.time = [dateFormatter stringFromDate:self.date];
                
                [self updatetime];
                
                [self.tableView.mj_header beginRefreshing];
            }
                break;
            case 3:// 日期
            {
                ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];

                [alert builddateView:^(NSString *date) {
                    @strongify(self)
                    self.time = date;
                    NSDate *date1=[dateFormatter dateFromString:date];
                    self.date = date1;
                    [self updatetime];
                    [self.tableView.mj_header beginRefreshing];
                }];
                
                [alert show];
            }
                break;
            case 4:// 全部彩种
            {
                LotteryTypeView *type = [LotteryTypeView share];
                if( ![self.Bettingtype isEqualToString:@"NORMAL"]){
                    type.isN = NO;
                }else{
                    type.isN = YES;
                }
                [type show];

                type.dismissBlock = ^(NSArray *lotteryIds) {
                    @strongify(self)

                    self.lotteryIds = lotteryIds;
                    
                    [self.tableView.mj_header beginRefreshing];
                };
                
            }
                break;
            case 5:// 投注金额
            {
                self.sortName = @"bet_amount";
                
                [self sortWith:sender];
            }
                break;
            case 6:// 中奖金额
            {
                self.sortName = @"win_amount";
                
                [self sortWith:sender];
            }
                break;
            case 7:// 时间
            {
                self.sortName = @"create_time";
                
                [self sortWith:sender];
            }
                break;
                
            default:
                break;
        }
    };
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        [self initData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page ++;
        [self initData];
    }];
    
    self.page = 1;
    self.date = [NSDate date];
    if ([self.Bettingtype isEqualToString:@"CHASE"]) {
        self.sortName = @"create_time";
        self.sortType = @"DESC";
    }
    [self initData];
}

- (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay  {  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];  [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];  NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];  NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];  NSDate *dateA = [dateFormatter dateFromString:oneDayStr];  NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];  NSComparisonResult result = [dateA compare:dateB];  NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);  if (result == NSOrderedDescending) {  NSLog(@"Date1  is in the future");  return 1;      }  else if (result == NSOrderedAscending){  NSLog(@"没有达到指定日期");  return -1;      }  NSLog(@"两时间相同");  return 0;
    
}

-(void)updatetime {
    @weakify(self)

    [Tools getDateWithDate:self.date success:^(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second, NSString *week) {
        @strongify(self)

        self.headView.datelab.text = [NSString stringWithFormat:@"%ld月%ld日 %@",month,day,week];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.Bettingtype isEqualToString:@"CHASE"]) {
        
        ChaseNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:RJHeaderIdentifier];
        
        BettingModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        cell.model = model;
        
        
        
        return cell;
    }
    BettinglistCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    cell.selectBtn.hidden = YES;
    
    __block BettingModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    for (id view in cell.backview.subviews) {
        
        if ([view isKindOfClass:[UILabel class]]) {
            
            UILabel *lab = (UILabel *)view;
            lab.textColor = [UIColor darkGrayColor];
            if (lab == cell.lotterylab || lab == cell.typelab || lab == cell.issuelab) {
                lab.textColor = [UIColor darkTextColor];
            }
            else if (lab == cell.resultlab) {
                lab.textColor = WHITE;
            }
        }
    }
    
    

    if (model.lotteryId == CPTBuyTicketType_SSC) {//重庆时时彩
        cell.iconimgv.image = [model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_1_2") : IMAGE(@"home_1");
        cell.issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue.length > 8 ? [model.issue substringFromIndex:8] : model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_XJSSC) {//新疆时时彩
        
        cell.iconimgv.image = [model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_4_2") : IMAGE(@"home_4");
        cell.issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue.length > 8 ? [model.issue substringFromIndex:8] : model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_TJSSC) {//天津时时彩
        cell.iconimgv.image = IMAGE(@"天津时时彩");
        cell.issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue.length > 8 ? [model.issue substringFromIndex:8] : model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_FFC) {//比特币分分彩
        
        cell.iconimgv.image = [model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_6_2") : IMAGE(@"home_6");
        cell.issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue.length > 9 ? [model.issue substringFromIndex:9] : model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_LiuHeCai) {//香港六合彩
        
        cell.iconimgv.image = [model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_2_2") : IMAGE(@"home_2");
        cell.issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_PCDD) {//PC蛋蛋
        
        cell.iconimgv.image = [model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_7_2") : IMAGE(@"home_7");
        cell.issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_PK10) {//北京PK10
        
        cell.iconimgv.image = [model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_3_2") : IMAGE(@"home_3");
        cell.issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_XYFT) {//幸运飞艇
        
        cell.iconimgv.image = [model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_5_2") : IMAGE(@"home_5");
        cell.issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue.length > 8 ? [model.issue substringFromIndex:8] : model.issue];
    } else {
        NSString *imageName = [NSString stringWithFormat:@"%ld",(long)model.lotteryId];
        cell.iconimgv.image = IMAGE(imageName);
        cell.issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue];
    }

    NSString * name = model.lotteryName;
    if([name isEqualToString:@"排列3/5"]){
        name= @"排列35";
    }
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        name = [NSString stringWithFormat:@"tw_%@",name];
    }
    cell.iconimgv.image = IMAGE(name);
    
    cell.lotterylab.text = model.lotteryName;
    cell.typelab.text = model.playName;
    cell.creattimelab.text = model.createTime;
    cell.oddslab.text = model.odds;
    if ([model.odds containsString:@","]) {
        
        NSString *odds = [model.odds componentsSeparatedByString:@","].firstObject;
        cell.iconimgv.alpha = 0.4;
        cell.oddslab.text = odds;
    }
    cell.paymoneylab.text = [NSString stringWithFormat:@"￥%.2f",model.betAmount.floatValue];
    if ([model.tbStatus isEqualToString:@"WAIT"]) {
        
        cell.resultlab.text = @"等待开奖";
        
        cell.selectBtn.hidden = NO;
        cell.iconimgv.alpha = 1.0;

        cell.resultlab.backgroundColor = kColor(177, 136, 62);
    }
    else if ([model.tbStatus isEqualToString:@"WIN"]) {
        
        NSString *money = [NSString stringWithFormat:@"中奖:￥%.2f",model.winAmount.floatValue];
        if(model.winAmount.integerValue >10000){
            money = [NSString stringWithFormat:@"中奖:%.2f万",model.winAmount.floatValue/10000];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:money];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(3, money.length-5)];
            cell.resultlab.attributedText = AttributedStr;
        }else{
            money = [NSString stringWithFormat:@"中奖:￥%.2f",model.winAmount.floatValue];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:money];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(4, money.length-4)];
            cell.resultlab.attributedText = AttributedStr;
        }
        
   
        cell.iconimgv.alpha = 1.0;

        cell.resultlab.backgroundColor = kColor(192, 26, 39);
    }
    else if ([model.tbStatus isEqualToString:@"NO_WIN"]) {
        
        cell.resultlab.text = @"未中奖";
        
        cell.resultlab.backgroundColor = kColor(208, 208, 208);
        cell.iconimgv.alpha = 0.4;
        
        for (id view in cell.backview.subviews) {
            
            if ([view isKindOfClass:[UILabel class]]) {
                
                UILabel *lab = (UILabel *)view;
                
                lab.textColor = [UIColor lightGrayColor];
            }
        }
    }
    else if ([model.tbStatus isEqualToString:@"BACK"]) {
        
        cell.resultlab.text = @"已撤单";
        cell.iconimgv.alpha = 0.4;

        cell.resultlab.backgroundColor = kColor(208, 208, 208);
        
        for (id view in cell.backview.subviews) {
            
            if ([view isKindOfClass:[UILabel class]]) {
                
                UILabel *lab = (UILabel *)view;
                
                lab.textColor = [UIColor lightGrayColor];
            }
        }
    }
    else {
        cell.resultlab.text = @"打和";
        cell.iconimgv.alpha = 0.4;

        cell.resultlab.backgroundColor = kColor(177, 136, 62);
    }
    if((model.lotteryId == CPTBuyTicketType_3D || model.lotteryId == CPTBuyTicketType_LiuHeCai|| model.lotteryId == CPTBuyTicketType_Shuangseqiu|| model.lotteryId == CPTBuyTicketType_PK10|| model.lotteryId == CPTBuyTicketType_SSC|| model.lotteryId == CPTBuyTicketType_XJSSC|| model.lotteryId == CPTBuyTicketType_TJSSC|| model.lotteryId == CPTBuyTicketType_QiLecai|| model.lotteryId == CPTBuyTicketType_HaiNanQiXingCai|| model.lotteryId == CPTBuyTicketType_PaiLie35) && [model.tbStatus isEqualToString:@"WAIT"]){
        cell.selectBtn.hidden = NO;
    }else{
        cell.selectBtn.hidden = YES;
    }
    cell.selectBtn.selected = model.selected;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if ([self.Bettingtype isEqualToString:@"CHASE"]) {
        return;
    }
    
    BettingModel *model = [self.dataSource objectAtIndex:indexPath.row];
    BettingDetailCtrl *detail = [[BettingDetailCtrl alloc] init];
    detail.status = self.status;
    detail.bettingtype = self.Bettingtype;
    detail.model = model;
    @weakify(self)
    detail.deleteorderBlock = ^{
        @strongify(self)
        [self.tableView.mj_header beginRefreshing];
    };
    
    PUSH(detail);
}

-(void)initData {
    
    if ([self.Bettingtype isEqualToString:@"CHASE"]) {
        [self initchaseData];
    }
    else{
        
        [self initnormalandbackData];
    }
    
}

#pragma mark - 获取追号列表
-(void)initchaseData {
    
    if ([AppDelegate shareapp].wkjScheme == Scheme_LotterEight) {
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:[Person person].uid forKey:@"userId"];
    [dic setValue:self.time forKey:@"date"];
    [dic setValue:[LotteryTypeView share].lottery_ids forKey:@"lotteryIds"];
    [dic setValue:@(self.page) forKey:@"pageNo"];
    [dic setValue:pageSize forKey:@"pageSize"];
//    [dic setValue:pageSize forKey:@"settingId"];
    if([self.sortName isEqualToString:@"bet_amount"]){
        self.sortName = @"bet_price";
    }
    [dic setValue:self.sortName forKey:@"sortName"];
    [dic setValue:self.sortType forKey:@"sortType"];
    MBLog(@"sort: %@",dic);
  @weakify(self)
    [WebTools postWithURL:@"/orderAppend/Y" params:dic success:^(BaseData *data) {
        @strongify(self)
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }
        
        NSArray *array = [BettingModel mj_objectArrayWithKeyValuesArray:data.data];
//        NSSortDescriptor *currSD = [NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending: NO];
//
//        array = [array sortedArrayUsingDescriptors:@[currSD]];
        
        [self.dataSource addObjectsFromArray:array];
        
        [self.tableView reloadData];
        
        [self endRefresh:self.tableView WithdataArr:data.data];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self endRefresh:self.tableView WithdataArr:nil];
    }];
}
#pragma mark - 获取投注和撤单列表
-(void)initnormalandbackData {
    @weakify(self)

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:[Person person].uid forKey:@"userId"];
    [dic setValue:self.Bettingtype forKey:@"type"];
    [dic setValue:self.status forKey:@"status"];
    [dic setValue:self.time forKey:@"date"];
    [dic setValue:[LotteryTypeView share].lottery_ids forKey:@"lotteryIds"];
    [dic setValue:@(self.page) forKey:@"pageNo"];
    [dic setValue:pageSize forKey:@"pageSize"];
    [dic setValue:self.sortName forKey:@"sortName"];
    [dic setValue:self.sortType forKey:@"sortType"];
    
    [WebTools postWithURL:@"/order/orderList.json" params:dic success:^(BaseData *data) {
        @strongify(self)

        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }
        
        NSArray *array = [BettingModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.dataSource addObjectsFromArray:array];
        
        [self.tableView reloadData];
        
        [self endRefresh:self.tableView WithdataArr:data.data];
        
    } failure:^(NSError *error) {
        @strongify(self)

        [self endRefresh:self.tableView WithdataArr:nil];
    }];
}

-(void)sortWith:(UIButton *)sender {
    
    NSArray *btnArray = @[self.headView.putmoneyBtn,self.headView.addmoneyBtn,self.headView.timeBtn];
    
    for (UIButton *btn in btnArray) {
        
        if (btn != sender) {
            btn.selecttype = 0;
            [btn setImage:IMAGE(@"期号不排序") forState:UIControlStateNormal];
            btn.selected = NO;
        }
    }
    if (sender.selecttype == 0) {
        
        sender.selecttype = 1;
        [sender setImage:IMAGE(@"期号排序升") forState:UIControlStateNormal];
    }
    else if (sender.selecttype == 1) {
        
        sender.selecttype = 2;
        [sender setImage:IMAGE(@"期号排序降") forState:UIControlStateNormal];
    }
    else if (sender.selecttype == 2) {
        
        sender.selecttype = 1;
        [sender setImage:IMAGE(@"期号排序升") forState:UIControlStateNormal];
    }
    
    sender.selected = YES;
    
    if ([self.Bettingtype isEqualToString:@"CHASE"]) {
        self.sortType = sender.selecttype == 1 ? @"ASC" : @"DESC";

//        [self sortWithsender:sender];
        [self.tableView.mj_header beginRefreshing];

    }
    else{
        self.sortType = sender.selecttype == 1 ? @"ASC" : @"DESC";
        
        [self.tableView.mj_header beginRefreshing];
    }
    
}

-(void)sortWithsender:(UIButton *)sender {
    
    if (sender.tag == 100) {
        
        NSSortDescriptor *numberSD = [NSSortDescriptor sortDescriptorWithKey:@"currentBetPrice" ascending:sender.selecttype == 1 ? YES : NO];
        
        self.dataArray = [self.dataSource sortedArrayUsingDescriptors:@[numberSD]];
    }
    else if (sender.tag == 101) {
        
        NSSortDescriptor *allSD = [NSSortDescriptor sortDescriptorWithKey:@"winAmount" ascending:sender.selecttype == 1 ? YES : NO];
        
        self.dataArray = [self.dataSource sortedArrayUsingDescriptors:@[allSD]];
    }
    else {
        
        NSSortDescriptor *currSD = [NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending:sender.selecttype == 1 ? YES : NO];
        
        self.dataArray = [self.dataSource sortedArrayUsingDescriptors:@[currSD]];
    }
    
    [self.dataSource removeAllObjects];
    
    [self.dataSource addObjectsFromArray:self.dataArray];
    
    [self.tableView reloadData];
}

-(void)refreshData {
    
    [self.tableView.mj_header beginRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
