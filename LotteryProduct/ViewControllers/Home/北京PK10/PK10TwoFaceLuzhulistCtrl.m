//
//  PK10TwoFaceLuzhulistCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10TwoFaceLuzhulistCtrl.h"
#import "PK10LuzhuCell.h"
#import "PK10LuzhuModel.h"
#define itemWidth  30        //每个item的宽度
@interface PK10TwoFaceLuzhulistCtrl ()

@property (nonatomic, copy) NSString *time;

@end

@implementation PK10TwoFaceLuzhulistCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[PK10LuzhuCell class] forCellReuseIdentifier:RJCellIdentifier];
    
    [self.view addSubview:self.tableView];
    
    if (self.type == 3 || self.type == 4) {
        
        @weakify(self)
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT + 34, 0, SAFE_HEIGHT, 0));
            
        }];
        
        if (self.type == 3) {
            
            self.titlestring = @"前后路珠";
        }
        else {
            
            self.titlestring = @"冠亚和路珠";
        }
        
        [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] WFSMImage] With:^(UIButton *sender) {
            @strongify(self)
            ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
            if (self.type == 3) {
                
                [alert buildPK10qianhouluzhuInfoView];
            }
            else {
                [alert buildPK10guanjunheluzhuInfoView];
            }
            
            [alert show];
        }];
        
        [self buildTimeViewWithType:self.lottery_type With:^(UIButton *sender) {
            @strongify(self)
            ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
            
            [alert builddateView:^(NSString *date) {
                
                [sender setTitle:date forState:UIControlStateNormal];
                
                [self initDataWithtime:date];
            }];
            
            [alert show];
        } With:^{
            @strongify(self)
            [self initDataWithtime:self.time];
        }];
        
        //投注按钮
        [self buildBettingBtn];
    }else {
        
        [self hiddenavView];
        @weakify(self)
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.edges.equalTo(self.view);
        }];
    }
    
    [self initDataWithtime:[Tools getlocaletime]];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PK10LuzhuModel *model = [self.dataSource objectAtIndex:indexPath.section];
    
    return model.cellheight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    head.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *lab = [Tools createLableWithFrame:CGRectMake(50, 0, SCREEN_WIDTH-100, 30) andTitle:nil andfont:FONT(14) andTitleColor:YAHEI andBackgroundColor:[UIColor groupTableViewBackgroundColor] andTextAlignment:1];
    [head addSubview:lab];
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectMake(SCREEN_WIDTH - 50, 0, 50, 30) andTitle:@"右最新" andfont:FONT(14) andTitleColor:[UIColor redColor] andBackgroundColor:[UIColor groupTableViewBackgroundColor] andTextAlignment:0];
    [head addSubview:lab2];
    
    PK10LuzhuModel *model = [self.dataSource objectAtIndex:section];
    
    if (self.type == 0) {
        
        lab.text = [NSString stringWithFormat:@"%@大小 今日累计：大(%ld)小(%ld)",model.title,model.numA,model.numB];
    }
    else if (self.type == 1) {
        
        lab.text = [NSString stringWithFormat:@"%@单双 今日累计：单(%ld)双(%ld)",model.title,model.numA,model.numB];
    }
    else if (self.type == 2) {
        
        lab.text = [NSString stringWithFormat:@"%@龙虎 今日累计：龙(%ld)虎(%ld)",model.title,model.numA,model.numB];
    }
    else if (self.type == 3) {
        
        lab.text = [NSString stringWithFormat:@"%@ 今日累计：前(%ld)后(%ld)",model.title,model.numA,model.numB];
    }
    else {
        if (section == 0) {
            
            lab.text = [NSString stringWithFormat:@"%@ 今日累计：大(%ld)小(%ld)",model.title,model.numA,model.numB];
        }
        else {
            lab.text = [NSString stringWithFormat:@"%@ 今日累计：单(%ld)双(%ld)",model.title,model.numA,model.numB];
        }
        
    }
    return head;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PK10LuzhuCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    PK10LuzhuModel *model = [self.dataSource objectAtIndex:indexPath.section];
    
    cell.dataArray = model.list;
    
    return cell;
}

-(void)initDataWithtime:(NSString *)time {
    
    self.time = time;
    
    switch (self.type) {
        case 0:
            
            [self initotherData:372];
            
            break;
        case 1:
            
            [self initotherData:373];
            
            break;
        case 2:
            
            [self initotherData:374];
            
            break;
        case 3:
            
            [self initotherData:371];
            
            break;
        case 4:
            
            [self initguanjunheluzhuData];
            
            break;
        default:
            break;
    }
}

-(void)initotherData:(NSInteger)type {
    
    NSString *url = nil;
    if (self.lottery_type == 6) {
        
        url = @"/bjpksSg/luzhuQ.json";
    }
    else if (self.lottery_type == 7) {
        url = @"/xyftSg/luzhuQ.json";
    }  else if (self.lottery_type == 11) {
        url = @"/azPrixSg/luzhuQ.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@(type),@"date":self.time} success:^(BaseData *data) {
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *arr = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10"];
        
        if (self.type == 2) {
            
            arr = @[@"01",@"02",@"03",@"04",@"05"];
        }
        if (self.lottery_type == 11) {
            arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
        }
        
        NSArray *arr1 = @[@"号码1",@"号码2",@"号码3",@"号码4",@"号码5",@"号码6",@"号码7",@"号码8",@"号码9",@"号码10"];
        
        NSArray *arr2 = @[@"冠军",@"亚军",@"第三名",@"第四名",@"第五名",@"第六名",@"第七名",@"第八名",@"第九名",@"第十名"];
        
        for (NSString *key in arr) {
            
            NSDictionary *dic = [data.data valueForKey:key];
            
            if (dic) {
                
                PK10LuzhuModel *model = [PK10LuzhuModel mj_objectWithKeyValues:dic];
                if (self.type == 3) {
                    
                    model.title = [arr1 objectAtIndex:key.integerValue-1];
                }
                else {
                    model.title = [arr2 objectAtIndex:key.integerValue-1];
                }
                model.cellheight = [self getCellheight:model.list];
                
                [self.dataSource addObject:model];
            }
            
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 冠亚和路珠
-(void)initguanjunheluzhuData {
    
    NSString *url = nil;
    if (self.lottery_type == 6) {
        url = @"/bjpksSg/luzhuG.json";
    } else if (self.lottery_type == 7) {
        url = @"/xyftSg/luzhuG.json";
    }  else if (self.lottery_type == 11) {
        url = @"/azPrixSg/luzhuG.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@(391),@"date":self.time} success:^(BaseData *data) {
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSDictionary *dic1 = [data.data valueForKey:@"大小"];
        NSDictionary *dic2 = [data.data valueForKey:@"单双"];
        
        if (dic1) {
            
            PK10LuzhuModel *model1 = [PK10LuzhuModel mj_objectWithKeyValues:dic1];
            model1.title = @"冠亚和大小";
            model1.cellheight = [self getCellheight:model1.list];
            [self.dataSource addObject:model1];
        }
        if (dic2) {
            
            PK10LuzhuModel *model2 = [PK10LuzhuModel mj_objectWithKeyValues:dic2];
            model2.title = @"冠亚和单双";
            model2.cellheight = [self getCellheight:model2.list];
            [self.dataSource addObject:model2];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(CGFloat)getCellheight:(NSArray *)array {
    
    CGFloat cellHeight = 0;
    
    for (NSString *tempStr in array) {
        
        CGSize size = [tempStr boundingRectWithSize:CGSizeMake(itemWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |  NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil].size;
        
        cellHeight = cellHeight < size.height? size.height: cellHeight;
    }
    
    return cellHeight;
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
