//
//  CartNormalCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/18.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartNormalCtrl.h"
#import "CartlistCell.h"
#import "BettingRecordViewController.h"
@interface CartNormalCtrl ()

@property (nonatomic, strong)UILabel *totalcountlab;

@property (nonatomic, strong)UILabel *totalpricelab;

@property (nonatomic, strong)UIButton *publishBtn;

@end

@implementation CartNormalCtrl
{
    NSArray *_fantanIDArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _fantanIDArray = @[@(CPTBuyTicketType_Shuangseqiu),@(CPTBuyTicketType_DaLetou),@(CPTBuyTicketType_QiLecai),@(CPTBuyTicketType_NiuNiu_JiShu),@(CPTBuyTicketType_NiuNiu_AoZhou),@(CPTBuyTicketType_NiuNiu_KuaiLe),@(CPTBuyTicketType_FantanSSC),@(CPTBuyTicketType_FantanPK10),@(CPTBuyTicketType_FantanXYFT)];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CartlistCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [self footview];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
}

-(void)clearlist {
    
    [self.dataSource removeAllObjects];
    if (self.updataArray) {
        
        self.updataArray(self.dataSource);
    }
    [self.tableView reloadData];
    
    [self gettotalprice];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];

    NSString *number = dic[@"number"];
    NSString*replacedStr = [number stringByReplacingOccurrencesOfString:@"_"withString:@"\n"];

    CGFloat h = [Tools createLableHighWithString:replacedStr andfontsize:14 andwithwidth:SCREEN_WIDTH - 40];
    
    return 123 + h;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CartlistCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    NSMutableDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    
    CartTypeModel *model = dic[@"type"];
    cell.titlelab.text = model.name;
    NSString*replacedStr = [dic[@"number"] stringByReplacingOccurrencesOfString:@"_"withString:@"\n"];
    cell.numberlab.text = replacedStr;
    
    NSNumber *times = dic[@"times"];
    cell.countlab.text = times.stringValue;
    
    cell.totalcountlab.text = [NSString stringWithFormat:@"共%@注，",dic[@"count"]];
    
    NSNumber *pricetype = dic[@"pricetype"];
    CGFloat amount = times.integerValue* pricetype.floatValue  * [dic[@"count"]integerValue];
    cell.pricelab.text = [NSString stringWithFormat:@"%.2f元",amount];
    __weak __typeof(&*cell)weakcell = cell;
    WS(weakSelf);
    cell.updataBlock = ^(NSInteger time) {
        
        [dic setValue:@(time) forKey:@"times"];
        if (self.updataArray) {
            
            self.updataArray(self.dataSource);
        }
        CGFloat amount = time*pricetype.floatValue  * [dic[@"count"]integerValue];//* [Tools lotteryprice:pricetype.floatValue]
        weakcell.pricelab.text = [NSString stringWithFormat:@"%.2f元",amount];
//        weakcell.pricelab.text = [NSString stringWithFormat:@"%.2f元",pricetype.floatValue*time];

        [weakSelf gettotalprice];
    };
    cell.deleteBlock = ^{
        
        [weakSelf.dataSource removeObject:dic];
        [[CPTBuyDataManager shareManager] removeModelFromCartArrayByDic:dic];
        [weakSelf.tableView reloadData];
        
        [weakSelf gettotalprice];
        
        if (weakSelf.updataArray) {
            
            weakSelf.updataArray(self.dataSource);
        }
        if (weakSelf.dataSource.count == 0) {
            
            [weakSelf popback];
        }
    };
    return cell;
}

-(UIView *)footview {
    
    UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125)];
    
    UIImageView *imgv = [[UIImageView alloc]initWithImage:IMAGE(@"cartclear")];
    
    [footview addSubview:imgv];
    
    self.totalcountlab = [Tools createLableWithFrame:CGRectZero andTitle:@"共0注，" andfont:FONT(14) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    
    [footview addSubview:self.totalcountlab];
    
    self.totalpricelab = [Tools createLableWithFrame:CGRectZero andTitle:@"投注总额：0.00元" andfont:FONT(14) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    
    [footview addSubview:self.totalpricelab];
    
    [self gettotalprice];
    
    UIButton *publishBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"立即投注" andTitleColor:WHITE andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(publishClick) andType:UIButtonTypeCustom];
    [publishBtn setTitle:@"封盘中" forState:UIControlStateSelected];
    self.publishBtn = publishBtn;
    publishBtn.layer.cornerRadius = 5;
    publishBtn.backgroundColor = BUTTONCOLOR;
    [footview addSubview:publishBtn];
    
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(footview).offset(12);
    }];
    
    [self.totalcountlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(imgv.mas_right).offset(8);
        make.centerY.equalTo(imgv);
    }];
    
    [self.totalpricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.totalcountlab.mas_right);
        make.centerY.equalTo(self.totalcountlab);
    }];
    
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(footview).offset(20);
        make.right.equalTo(footview).offset(-20);
        make.top.equalTo(imgv.mas_bottom).offset(30);
        make.height.equalTo(@45);
    }];
    
    return footview;
}

-(void)gettotalprice {
    
    CGFloat price = 0.0;
    NSInteger count = 0;
    for (NSMutableDictionary *dic in self.dataSource) {
        
        count += [dic[@"count"]integerValue];
        CGFloat amount = [dic[@"times"]integerValue] *[dic[@"pricetype"]floatValue]*[dic[@"count"]integerValue]; //* [Tools lotteryprice:]
//        CGFloat amount = [dic[@"pricetype"]floatValue];

        price += amount;
    }
    
    self.totalcountlab.text = [NSString stringWithFormat:@"共%ld注，",count];
    self.totalpricelab.text = [NSString stringWithFormat:@"投注总额：%.2f元",price];
}

-(void)publishClick {
    
    if (self.dataSource.count == 0) {
        
//        [MBProgressHUD showError:@"购彩篮为空"];
        
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:self.nextversion forKey:@"issue"];
    [dic setValue:@(self.lotteryId) forKey:@"lotteryId"];
    [dic setValue:[Person person].uid forKey:@"userId"];
    NSMutableArray *list = [[NSMutableArray alloc]init];
    for (NSDictionary *cartdic in self.dataSource) {
//        if([_fantanIDArray containsObject:@(_lotteryId)]){
//            NSArray *dd = [[cartdic objectForKey:@"params"] objectForKey:@"orderBetList"];
//            [list addObject:dd[0]];
//        }else{
            NSMutableDictionary *listdic = [[NSMutableDictionary alloc]init];
            NSNumber *pricetype = cartdic[@"pricetype"];
            CGFloat amount = [cartdic[@"times"]integerValue] *pricetype.floatValue * [cartdic[@"count"]integerValue];//* [Tools lotteryprice:]
            //        CGFloat amount = pricetype.floatValue;
            CartTypeModel *model = cartdic[@"type"];
            //        if (self.lotteryId == 4) {
                        [listdic setValue:cartdic[@"playId"] forKey:@"playId"];
            //        }else {
//            [listdic setValue:@(model.ID) forKey:@"playId"];
            //        }
        NSNumber * numberc =  cartdic[@"count"];
        NSInteger coo = amount/numberc.integerValue;
            [listdic setValue:cartdic[@"settingId"] forKey:@"settingId"];
            [listdic setValue:cartdic[@"number"] forKey:@"betNumber"];
            [listdic setValue:@(coo) forKey:@"betAmount"];
            [listdic setValue:cartdic[@"count"] forKey:@"betCount"];
            [list addObject:listdic];
//        }
        
    }
    [dic setValue:list forKey:@"orderBetList"];
    
    [WebTools postWithURL:@"/order/orderBet.json" params:dic success:^(BaseData *data) {
        
        [MBProgressHUD showSuccess:data.info];
        
        [self.dataSource removeAllObjects];
        
        if (self.updataArray) {
            
            self.updataArray(self.dataSource);
        }
        [[CPTBuyDataManager shareManager] clearCartArray];
        CGFloat price = 0.0;
        NSInteger count = 0;
        for (NSMutableDictionary *dic in self.dataSource) {
            
            count += [dic[@"count"]integerValue];
            CGFloat amount = [dic[@"times"]integerValue] * [dic[@"pricetype"]floatValue]*[dic[@"count"]integerValue];// * [Tools lotteryprice:[dic[@"pricetype"]floatValue]]
//            CGFloat amount = [dic[@"pricetype"] floatValue];
            price += amount;
        }
        
        [Person person].balance = [Person person].balance - price;
        
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
        
        BettingRecordViewController *bettingRecordVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"BettingRecordViewController"];
        bettingRecordVC.fromepublish = YES;
        [self.navigationController pushViewController:bettingRecordVC animated:YES];
        [[Person person] myAccount];
        
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
