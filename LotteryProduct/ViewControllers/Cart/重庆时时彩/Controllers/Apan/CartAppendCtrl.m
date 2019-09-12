//
//  CartAppendCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/18.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartAppendCtrl.h"
#import "RightTableViewCell.h"
#import "BettingRecordViewController.h"
#import "BallTool.h"
@interface CartAppendCtrl ()

@property (weak, nonatomic) IBOutlet UIButton *sameBtn;
@property (weak, nonatomic) IBOutlet UIButton *doubleBtn;
@property (weak, nonatomic) IBOutlet UIButton *touzhudelBtn;
@property (weak, nonatomic) IBOutlet UIButton *touzhuaddBtn;
@property (weak, nonatomic) IBOutlet UILabel *touzhulab;
@property (weak, nonatomic) IBOutlet UISegmentedControl *touzhusegment;
@property (weak, nonatomic) IBOutlet UIView *doubleView;
@property (weak, nonatomic) IBOutlet UIButton *fanbeidelBtn;
@property (weak, nonatomic) IBOutlet UIButton *fanbeiaddBtn;
@property (weak, nonatomic) IBOutlet UILabel *fanbeilab;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fanbeisegment;
@property (weak, nonatomic) IBOutlet UIButton *qishudelBtn;
@property (weak, nonatomic) IBOutlet UIButton *qishuaddBtn;
@property (weak, nonatomic) IBOutlet UILabel *qishulab;
@property (weak, nonatomic) IBOutlet UISegmentedControl *qishusegment;
@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UILabel *pricelab;
@property (strong, nonatomic) NSArray *zhuihaoArray;
@property (weak, nonatomic) IBOutlet UIButton *creatappendBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation CartAppendCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navView.hidden = YES;
    self.mytableView.delegate = self;
    self.mytableView.dataSource = self;
    self.mytableView.rowHeight = 30;
    self.mytableView.tableFooterView = [UIView new];
    
    [self replacesegment:self.touzhusegment];
    [self replacesegment:self.fanbeisegment];
    [self replacesegment:self.qishusegment];
    
    [self sameClick:self.sameBtn];
    
    [self gettotalprice];
}

-(void)replacesegment:(UISegmentedControl *)segment {
    
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}forState:UIControlStateSelected];
    
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}forState:UIControlStateNormal];
    
    [segment setDividerImage:[Tools createImageWithColor:[UIColor lightGrayColor] Withsize:CGSizeMake(1, 20)] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.zhuihaoArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDictionary *dic = self.zhuihaoArray[section];
    NSArray *appendinfo = dic[@"appendInfo"];
    return appendinfo.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    UILabel *label = [Tools createLableWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-10, 30) andTitle:@"" andfont:BOLDFONT(16) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [head addSubview:label];
    
    NSDictionary *dic = self.zhuihaoArray[section];
    
    label.text = dic[@"playName"];
    
    UIView *view = [UIView viewWithLabelNumber:3 Withlabelwidth:CGSizeMake(SCREEN_WIDTH/3, 30)];
    view.backgroundColor = [UIColor colorWithHex:@"dddddd"];
    view.layer.borderColor = [UIColor colorWithHex:@"dddddd"].CGColor;
    view.layer.borderWidth = 1.0f;
    view.frame = CGRectMake(0, 30, SCREEN_WIDTH, 30);
    [head addSubview:view];
    for (UILabel *label in view.subviews) {
        label.text = nil;
        label.textColor = [UIColor darkGrayColor];
        label.text = label.tag == 200 ? @"期号" : label.tag == 201 ? @"追号倍数" : @"追号金额";
        label.font = FONT(15);
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return head;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    if (cell == nil) {
        
        cell = [RightTableViewCell cellWithTableView:tableView WithNumberOfLabels:3 Withsize:CGSizeMake(SCREEN_WIDTH/3, 30)];
    }
    int i = 0;
    UIView *view = [cell.contentView viewWithTag:100];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    NSDictionary *dic = self.zhuihaoArray[indexPath.section];
    NSArray *appendinfo = dic[@"appendInfo"];
    NSDictionary *infodic = appendinfo[indexPath.row];
    
    for (UILabel *label in view.subviews) {
        
        NSString *str = i == 0 ? infodic[@"issue"] : i == 1 ? [infodic[@"multiples"]stringValue] : [infodic[@"amount"]stringValue];
        label.text = nil;
        label.textColor = [UIColor darkGrayColor];
        label.text = str;
        label.font = FONT(15);
        label.numberOfLines = 0;
        label.backgroundColor = WHITE;
        i ++;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (IBAction)sameClick:(UIButton *)sender {
    
    self.doubleView.hidden = YES;
    
    self.sameBtn.backgroundColor = [UIColor colorWithHex:@"C8A874"];
    [self.sameBtn setTitleColor:WHITE forState:UIControlStateNormal];
    self.doubleBtn.backgroundColor = CLEAR;
    [self.doubleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.fanbeilab.text = @"1";
    [self gettotalprice];

}

- (IBAction)doubleClick:(UIButton *)sender {
    
    self.doubleView.hidden = NO;
    
    self.doubleBtn.backgroundColor = [UIColor colorWithHex:@"C8A874"];
    [self.doubleBtn setTitleColor:WHITE forState:UIControlStateNormal];
    self.sameBtn.backgroundColor = CLEAR;
    [self.sameBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.fanbeilab.text = @"2";
    [self gettotalprice];
}

- (IBAction)touzhudelClick:(UIButton *)sender {
    
    NSInteger count = self.touzhulab.text.integerValue;
    
    count--;
    
    if (count <= 2) {
        
        count = 2;
    }
    
    self.touzhulab.text = INTTOSTRING(count);
    
    [self gettotalprice];
}

- (IBAction)touzhuaddClick:(UIButton *)sender {
    
    NSInteger count = self.touzhulab.text.integerValue;
    
    count++;
    
    self.touzhulab.text = INTTOSTRING(count);
    
    [self gettotalprice];
}

- (IBAction)touzhusegmentClick:(UISegmentedControl *)sender {
    
    self.touzhulab.text = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    
    [self gettotalprice];
}

- (IBAction)fanbeidelClick:(UIButton *)sender {
    
    NSInteger count = self.fanbeilab.text.integerValue;
    
    count--;
    
    if (count <= 2) {
        
        count = 2;
    }
    
    self.fanbeilab.text = INTTOSTRING(count);
    
    [self gettotalprice];
}

- (IBAction)fanbeiaddClick:(UIButton *)sender {
    
    NSInteger count = self.fanbeilab.text.integerValue;
    
    count++;
    
    self.fanbeilab.text = INTTOSTRING(count);
    
    [self gettotalprice];
}

- (IBAction)fanbeisegmentClick:(UISegmentedControl *)sender {
    
    self.fanbeilab.text = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    
    [self gettotalprice];
}

- (IBAction)zhuihaodelClick:(UIButton *)sender {
    
    NSInteger count = self.qishulab.text.integerValue;
    
    count--;
    
    if (count <= 2) {
        
        count = 2;
    }
    
    self.qishulab.text = INTTOSTRING(count);
    
    [self gettotalprice];
}

- (IBAction)zhuihaoaddClick:(UIButton *)sender {
    
    NSInteger count = self.qishulab.text.integerValue;
    
    count++;
    
    self.qishulab.text = INTTOSTRING(count);
    
    [self gettotalprice];
}

- (IBAction)zhuihaosegmentClick:(UISegmentedControl *)sender {
    
    self.qishulab.text = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    
    [self gettotalprice];
}

- (IBAction)creatOrderClick:(UIButton *)sender {
    
    if (self.dataSource.count == 0) {
        
//        [MBProgressHUD showError:@"购彩篮为空"];
        
        return;
    }
    @weakify(self)
    [WebTools postWithURL:@"/orderAppend/createAppendPlan.json" params:[self getappendData] success:^(BaseData *data) {
        @strongify(self)
        self.zhuihaoArray = data.data;
        
        [self.mytableView reloadData];
//        [self getprice];
        
    } failure:^(NSError *error) {
        MBLog(@"%@",error.description);
    }];
}

-(NSDictionary *)getappendData {

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:self.doubleView.hidden == YES ? @1 : @2 forKey:@"type"];
    [dic setValue:self.touzhulab.text forKey:@"betMultiples"];
    [dic setValue:self.doubleView.hidden == YES ? nil : self.fanbeilab.text forKey:@"doubleMultiples"];
    [dic setValue:self.qishulab.text forKey:@"appendCount"];
    [dic setValue:self.stopBtn.selected == YES ? @1 : @0 forKey:@"winStop"];
    [dic setValue:[Person person].uid forKey:@"userId"];
    
    
    NSMutableArray *list = [[NSMutableArray alloc]init];
    for (NSDictionary *cartdic in self.dataSource) {
//        if([BallTool isFantanSeriesLottery:_lotteryId]){
//            NSArray *dd = [[cartdic objectForKey:@"params"] objectForKey:@"orderBetList"];
//            [list addObject:dd[0]];
//        }else{
            NSMutableDictionary *listdic = [[NSMutableDictionary alloc]init];
            NSNumber *pricetype = cartdic[@"pricetype"];
            CGFloat amount = [cartdic[@"times"]integerValue] * pricetype.integerValue * [cartdic[@"count"]integerValue];
            
            [listdic setValue:@(amount) forKey:@"betPrice"];
            
            CartTypeModel *model = cartdic[@"type"];
//            if (self.lottery_type == 4) {
                [listdic setValue:cartdic[@"playId"] forKey:@"playId"];
//            }else {
//                [listdic setValue:@(model.ID) forKey:@"playId"];
//            }
        
            [listdic setValue:@(self.lotteryId) forKey:@"lotteryId"];
            
            [listdic setValue:cartdic[@"settingId"] forKey:@"settingId"];
            
            [listdic setValue:cartdic[@"number"] forKey:@"betNumber"];
            
            [listdic setValue:cartdic[@"count"] forKey:@"betCount"];
            
            [list addObject:listdic];
//        }
        
    }
    [dic setValue:list forKey:@"appendBet"];
    return dic;
}

- (IBAction)stopClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
}

- (IBAction)clearClick:(UIButton *)sender {
    
    self.zhuihaoArray = @[];
    
    [self.mytableView reloadData];
}

- (IBAction)sureClick:(UIButton *)sender {
    
    if (self.zhuihaoArray.count == 0) {
        
        [MBProgressHUD showError:@"还未生成追号计划"];
        
        return;
    }
    @weakify(self)

    [WebTools postWithURL:@"/orderAppend/createAppend.json" params:[self getappendData] success:^(BaseData *data) {
        @strongify(self)
        [MBProgressHUD showSuccess:data.info finish:^{
            @strongify(self)

            [self.dataSource removeAllObjects];
            
            if (self.updataArray) {
                
                self.updataArray(self.dataSource);
            }
            
            [Person person].balance = [Person person].balance - [self getprice];
            
            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
            
            BettingRecordViewController *bettingRecordVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"BettingRecordViewController"];
            bettingRecordVC.fromepublish = YES;
            [self.navigationController pushViewController:bettingRecordVC animated:YES];
        }];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(void)endtimeRefresh {
    
    [self creatOrderClick:self.creatappendBtn];
}

-(void)gettotalprice {
    
    
    
    self.pricelab.text = [NSString stringWithFormat:@"追号总金额:%.2f元",[self getprice]];
}

-(CGFloat)getprice {
    
    CGFloat price = 0.0;
    
    for (NSMutableDictionary *dic in self.dataSource) {
        
        CGFloat amount = [dic[@"times"]integerValue] * [dic[@"pricetype"]integerValue] * [dic[@"count"]integerValue] * self.touzhulab.text.integerValue ;
        
        NSInteger times = self.fanbeilab.text.integerValue;
        
        CGFloat qisuamount = 0.0;
        
        for (int i = 0 ; i< self.qishulab.text.integerValue ; i++) {
            
            NSInteger time = pow(times, i);
            
            NSLog(@"这一期的倍数是：%ld",time);
            
//            if (self.doubleView.hidden == YES) {
//
//                amount *=1;
//            }
//            else{
                qisuamount = amount * time;
//            }
            price += qisuamount;
        }
    }
    
    return price;
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
