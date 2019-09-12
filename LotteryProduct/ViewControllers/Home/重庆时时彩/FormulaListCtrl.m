//
//  FormulaListCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/6.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "FormulaListCtrl.h"
#import "FormulaCell.h"
#import "FormulaHeadView.h"
#import "NIDropDown.h"
@interface FormulaListCtrl ()

@property (nonatomic, strong)FormulaHeadView *headView;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *issue;

@end

@implementation FormulaListCtrl

-(FormulaHeadView *)headView {
    
    if (!_headView) {
        
        _headView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([FormulaHeadView class]) owner:self options:nil]firstObject];
        
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 35);
    }
    return _headView;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hiddenavView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FormulaCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    self.tableView.rowHeight = 24;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];

    self.headView.versionBlock = ^(UIButton *sender) {
       
        NIDropDown *down = [[NIDropDown alloc]initWithshowDropDown:sender Withheigh:160 Withlist:@[@"20期",@"40期",@"60期",@"80期"]];
        down.layer.borderColor = BASECOLOR.CGColor;
        down.layer.borderWidth = 1;
        down.selectBlock = ^(NSString *selectString, NSInteger index) {
            @strongify(self)
            [sender setTitle:selectString forState:UIControlStateNormal];
            
            self.issue = [selectString substringToIndex:2];
            
            [self initDataWithtime:self.time];
        };
    };
    
    self.issue = @"20";
    
    [self initDataWithtime:[Tools getlocaletime]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 35;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FormulaCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    
    if (self.lottery_type == 1 || self.lottery_type == 2 || self.lottery_type == 3) {
        
        NSString *versionstr = dic[@"issue"];
        cell.versionslab.text = [[versionstr substringFromIndex:self.lottery_type == 3 ? 9 : 8] stringByAppendingString:@"期"];
        cell.versionslab.adjustsFontSizeToFitWidth = YES;
        NSString *time = dic[@"time"];
        if ([time containsString:@" "]) {
            
            cell.timelab.text = [[time componentsSeparatedByString:@" "].lastObject substringToIndex:5];
        }
        
        cell.numberlab.text = STRING(dic[@"openNumber"]) ;
        if ([Tools isEmptyOrNull:STRING(dic[@"openNumber"])]) {
            
            cell.numberlab.text = @"?";
            cell.numberlab.backgroundColor = [UIColor redColor];
        }
        else {
            cell.numberlab.backgroundColor = [UIColor colorWithHex:@"CCAD73"];
        }
    }
    else if (self.lottery_type == 6 || self.lottery_type == 7 || self.lottery_type == 11){
        
        cell.numberlab.text = dic[@"sgNum"];
        cell.versionslab.text = [dic[@"issue"]length] > 8 ? [dic[@"issue"] substringFromIndex:8] : dic[@"issue"];
        cell.versionslab.adjustsFontSizeToFitWidth = YES;
        cell.timelab.text = dic[@"time"];
        cell.timelab.adjustsFontSizeToFitWidth = YES;
        if ([Tools isEmptyOrNull:dic[@"sgNum"]]) {
            
            cell.numberlab.text = @"?";
            cell.numberlab.backgroundColor = [UIColor redColor];
        }
        else {
            cell.numberlab.backgroundColor = [UIColor colorWithHex:@"CCAD73"];
        }
    }
    else if (self.lottery_type == 4) {
        
        NSString *versionstr = dic[@"issue"];
        cell.versionslab.text = [versionstr substringFromIndex:versionstr.length-3];
        cell.issixtype = self.number;
        
        if (self.number == 1) {
            
            cell.sixnumber.text = dic[@"sgNum"];
            
            if ([Tools isEmptyOrNull:dic[@"sgNum"]]) {
                
                cell.nosixvaluelab.hidden = NO;
            }
            else {
                cell.nosixvaluelab.hidden = YES;
            }
        }
        else {
            cell.numberlab.text = dic[@"sgNum"];
            
            if ([Tools isEmptyOrNull:dic[@"sgNum"]]) {
                
                cell.numberlab.text = @"?";
                cell.numberlab.backgroundColor = [UIColor redColor];
            }
            else {
                cell.nosixvaluelab.hidden = YES;
                cell.numberlab.backgroundColor = [UIColor colorWithHex:@"CCAD73"];
            }
        }
    }
    
    for (int i = 0; i< cell.numlabs.count; i++) {
        
        UILabel *lab = cell.numlabs[i];

        switch (i) {
            case 0:
                lab.text = STRING(dic[@"sin"]);
                break;
            case 1:
                lab.text = STRING(dic[@"sec"]);
                break;
            case 2:
                lab.text = STRING(dic[@"cos"]);
                break;
            case 3:
                lab.text = STRING(dic[@"cot"]);
                break;
            case 4:
                lab.text = STRING(dic[@"tan"]);
                break;
            default:
                break;
        }
        
        
        if (self.lottery_type == 1 || self.lottery_type == 2 || self.lottery_type == 3 || self.lottery_type == 6 || self.lottery_type == 7) {
            
            if ([cell.numberlab.text isEqualToString:lab.text]) {
                
                lab.backgroundColor = kColor(240, 255, 242);
            }else{
                lab.backgroundColor = kColor(254, 244, 241);
            }
        }
        else if (self.lottery_type == 4) {
            
            if (self.number == 1) {
                
                if ([cell.sixnumber.text containsString:lab.text]) {
                    
                    lab.backgroundColor = kColor(240, 255, 242);
                }
                else{
                    lab.backgroundColor = kColor(254, 244, 241);
                }
            }
            else{
                if ([cell.numberlab.text isEqualToString:lab.text]) {
                    
                    lab.backgroundColor = kColor(240, 255, 242);
                }else{
                    lab.backgroundColor = kColor(254, 244, 241);
                }
            }
        }
    }
    
    return cell;
}

-(void)initDataWithtime:(NSString *)time {
    
    self.time = time;
    
    if (self.lottery_type == 1 || self.lottery_type == 2 || self.lottery_type == 3) {
        
        NSString *url = nil;
        if (self.lottery_type == 1) {
            
            url = @"/cqsscSg/getCqsscGssh.json";
        }
        else if (self.lottery_type == 2) {
            url = @"/xjsscSg/getXjsscGssh.json";
        }else if (self.lottery_type == 3) {
            url = @"/txffcSg/getTxffcGssh.json";
        }
        
        @weakify(self)
        [WebTools postWithURL:url params:@{@"date":time,@"pageSize":self.issue,@"number":@(self.number)} success:^(BaseData *data) {
            @strongify(self)
            if ([[data.data valueForKey:@"list"] isKindOfClass:[NSArray class]]) {
                
                self.dataArray = [data.data valueForKey:@"list"];
            }
            
            [self.tableView reloadData];
            
            if (self.StatisticsBlock) {
                
                if (data.data[@"count"]) {
                    
                    NSDictionary *statis = @{@"count":data.data[@"count"]};
                    
                    self.StatisticsDic = [statis copy];
                    
                    self.StatisticsBlock(statis);
                }
                
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
    else if (self.lottery_type == 6 || self.lottery_type == 7 || self.lottery_type == 11){
        
        NSString *url = nil;
        if (self.lottery_type == 6) {
            
            url = @"/bjpksSg/killNumber.json";
        }
        else if (self.lottery_type == 7) {
            url = @"/xyftSg/killNumber.json";
        }
        else if (self.lottery_type == 11) {
            url = @"/azPrixSg/killNumber.json";
        }
        @weakify(self)
        [WebTools postWithURL:url params:@{@"date":time,@"issue":self.issue,@"number":@(self.number)} success:^(BaseData *data) {
            @strongify(self)
            if ([[data.data valueForKey:@"killList"] isKindOfClass:[NSArray class]]) {
                
                self.dataArray = [data.data valueForKey:@"killList"];
            }
            
            [self.tableView reloadData];
            
            if (self.StatisticsBlock) {
                
                if (data.data[@"current"] && data.data[@"max"] && data.data[@"win"]) {
                    
                    NSDictionary *statis = @{@"current":data.data[@"current"],@"max":data.data[@"max"],@"win":data.data[@"win"]};
                    
                    self.StatisticsDic = [statis copy];
                    
                    self.StatisticsBlock(statis);
                }
                
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
    else if (self.lottery_type == 4) {
        
        @weakify(self)
        [WebTools postWithURL:@"/lhcSg/killNumber.json" params:@{@"issue":self.issue} success:^(BaseData *data) {
            
            @strongify(self)
            if (self.number == 1) {
                
                if ([[data.data valueForKey:@"zKillList"] isKindOfClass:[NSArray class]]) {
                    
                    self.dataArray = [data.data valueForKey:@"zKillList"];
                    
                }
                
                [self.tableView reloadData];
                
                if (self.StatisticsBlock) {
                    
                    if (data.data[@"zCurrent"] && data.data[@"zMax"] && data.data[@"zWin"]) {
                        
                        NSDictionary *statis = @{@"current":data.data[@"zCurrent"],@"max":data.data[@"zMax"],@"win":data.data[@"zWin"]};
                        
                        self.StatisticsDic = [statis copy];
                        
                        self.StatisticsBlock(statis);
                    }
                    
                }
            }
            else{
                
                if ([[data.data valueForKey:@"tKillList"] isKindOfClass:[NSArray class]]) {
                    
                    self.dataArray = [data.data valueForKey:@"tKillList"];
                    
                }
                
                [self.tableView reloadData];
                
                if (self.StatisticsBlock) {
                    
                    if (data.data[@"tCurrent"] && data.data[@"tMax"] && data.data[@"tWin"]) {
                        
                        NSDictionary *statis = @{@"current":data.data[@"tCurrent"],@"max":data.data[@"tMax"],@"win":data.data[@"tWin"]};
                        
                        self.StatisticsDic = [statis copy];
                        
                        self.StatisticsBlock(statis);
                    }
                    
                }
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
