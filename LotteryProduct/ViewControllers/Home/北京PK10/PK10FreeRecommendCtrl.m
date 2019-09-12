//
//  PK10FreeRecommendCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/21.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10FreeRecommendCtrl.h"
#import "PK10FreeRecommendCell.h"
#import "PK10FreeModel.h"

@interface PK10FreeRecommendCtrl ()

@property (nonatomic, strong)NSArray *titleArray;
/**
  解析数据KEY
 */
@property (nonatomic, strong)NSArray *keyArray;
@end

@implementation PK10FreeRecommendCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titlestring = @"免费推荐";
    @weakify(self)
    [self buildTimeViewWithType:self.lottery_type With:nil With:^{
        @strongify(self)
        [self refresh];
    }];
 
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PK10FreeRecommendCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    self.tableView.rowHeight = 25;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT + 34, 0, 0, 0));
    }];
    
    self.titleArray = @[@"名次",@"冠军",@"亚军",@"第三名",@"第四名",@"第五名",@"第六名",@"第七名",@"第八名",@"第九名",@"第十名",@"冠亚和"];
    
    self.keyArray = @[@"first",@"second",@"third",@"fourth",@"fifth",@"sixth",@"seventh",@"eighth",@"ninth",@"tenth",@"firstSecond"];
    
    self.page = 1;
    
    [self initData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self refresh];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)

        self.page ++ ;
        
        [self initData];
    }];
    
    //投注按钮
    [self buildBettingBtn];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self addnotification];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self removenotification];
}

-(void)addnotification {
    
    if (self.lottery_type == 6) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_bjpks" object:nil];
    }
    else{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_xyft" object:nil];
    }
    
}

-(void)removenotification {
    
    if (self.lottery_type == 6) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_bjpks" object:nil];
    }
    else{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xyft" object:nil];
    }
}

-(void)refresh {
    
    self.page = 1;
    
    [self initData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PK10FreeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.ranklab.text = [self.titleArray objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        
        cell.resultlab.text = @"开奖结果";
        cell.resultlab.showbg = NO;
        cell.resultlab.textColor = YAHEI;
        cell.titlelab.hidden = NO;
        cell.recommendlab.hidden = YES;
        cell.singleordoblelab.hidden = YES;
        cell.bigorsmalllab.hidden = YES;
    }
    else {
        
        PK10FreeModel *model = self.dataSource[indexPath.section];
        
        NSArray *array = model.datas;
        
        PK10FreeDataModel *datamodel = array[indexPath.row-1];
        
        cell.resultlab.text = datamodel.result;
               MBLog(@"mmmm %@", datamodel.result);
        cell.resultlab.textColor = WHITE;
        cell.recommendlab.text = datamodel.numbers;
        cell.singleordoblelab.text = datamodel.singleordouble;
        //        cell.bigorsmalllab.text = datamodel.bigorsmall;
        
        cell.resultlab.bgColor = LINECOLOR;
        cell.resultlab.showbg = YES;
        
        cell.titlelab.hidden = YES;
        cell.recommendlab.hidden = NO;
        cell.singleordoblelab.hidden = NO;
        cell.bigorsmalllab.hidden = NO;
        
        
    }
    
    if (indexPath.section ==0) {
        
        cell.resultlab_width.constant = 0;
        cell.recommendlab.textColor = YAHEI;
        cell.singleordoblelab.textColor = YAHEI;
        cell.bigorsmalllab.textColor = YAHEI;
    }
    else {
        cell.resultlab_width.constant = 80;
        
        PK10FreeModel *model = self.dataSource[indexPath.section];
        
        NSArray *array = model.datas;
        
        if (indexPath.row != 0) {
            
            PK10FreeDataModel *datamodel = array[indexPath.row-1];
            
            if ((datamodel.result.integerValue % 2 == 0 && [datamodel.singleordouble isEqualToString:@"双"]) ||(datamodel.result.integerValue %2 == 1 &&[datamodel.singleordouble isEqualToString:@"单"])) {
                
                cell.singleordoblelab.textColor = [UIColor redColor];
                
                cell.singleordoblelab.text = [datamodel.singleordouble stringByAppendingString:@"(赢)"];
            }
            else{
                cell.singleordoblelab.textColor = YAHEI;
                cell.singleordoblelab.text = datamodel.singleordouble;
            }
            if ((datamodel.result.integerValue < 6 && [datamodel.bigorsmall isEqualToString:@"小"]) || (datamodel.result.integerValue > 5 && [datamodel.bigorsmall isEqualToString:@"大"])) {
                
                cell.bigorsmalllab.textColor = [UIColor redColor];
                
                cell.bigorsmalllab.text = [datamodel.bigorsmall stringByAppendingString:@"(赢)"];
            }
            else{
                cell.bigorsmalllab.textColor = YAHEI;
                cell.bigorsmalllab.text = datamodel.bigorsmall;
            }
            //            NSString *num = INTTOSTRING(datamodel.result.integerValue);
            NSRange range ;
            BOOL content = NO;
            for (NSString *number in [datamodel.numbers componentsSeparatedByString:@","]) {
                
                if (number.integerValue == datamodel.result.integerValue){
                    
                    content = YES;
                    
                    range = NSRangeFromString(number);
                    break;
                }
            }
            
            if (content) {
                
                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[datamodel.numbers stringByAppendingString:@"(赢)"]];
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(AttributedStr.length-3, 3)];
                cell.recommendlab.attributedText = AttributedStr;
            }
            else{
                cell.recommendlab.text = datamodel.numbers;
            }
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 25;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    head.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    PK10FreeModel *model = [self.dataSource objectAtIndex:section];
    
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:model.time andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [head addSubview:lab1];
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:model.issue andfont:FONT(13) andTitleColor:[UIColor redColor] andBackgroundColor:CLEAR andTextAlignment:0];
    [head addSubview:lab2];
    
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(head);
        make.right.equalTo(head.mas_centerX);
    }];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(head);
        make.left.equalTo(head.mas_centerX);
    }];
    
    if (section == 0) {
        
        UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:@"投注参考" andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
        [head addSubview:lab3];
        [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(lab2.mas_right);
            make.centerY.equalTo(head);
            
        }];
    }
    
    
    return head;
}


-(void)initData {
    
    NSString *url = nil;
    if (self.lottery_type == 6) {
        
        url = @"/bjpksSg/recommendList.json";
    }
    else if (self.lottery_type == 7) {
        url = @"/xyftSg/recommendList.json";
    }    else if (self.lottery_type == 11) {
        url = @"/azPrixSg/recommendList.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"pageNum":@(self.page),@"pageSize":pageSize} success:^(BaseData *data) {
        
        @strongify(self)
        NSArray *array = data.data[@"list"];
        
        if (self.page == 1) {
         
            [self.dataSource removeAllObjects];
        }
        
        for (NSDictionary *dic in array) {
            
            PK10FreeModel *model = [[PK10FreeModel alloc]init];
            model.time = [dic[@"time"] componentsSeparatedByString:@" "].firstObject;
            model.issue = [NSString stringWithFormat:@"%@期", [dic[@"issue"]length] > 8 ? [dic[@"issue"] substringFromIndex:8] : dic[@"issue"]];
            NSMutableArray *dataarray = [[NSMutableArray alloc]init];
            for (NSString *key in self.keyArray) {
                
                PK10FreeDataModel *datamodel = [[PK10FreeDataModel alloc]init];
                NSString *datas = dic[key];
                NSArray *comp = [datas componentsSeparatedByString:@"|"];
                NSLog(@"%ld", comp.count);
                if (comp.count == 1) {
                    
                    datamodel.numbers = comp[0];
                }
                else if (comp.count == 2) {
                    
                    datamodel.result = comp[0];
                    datamodel.numbers = comp[1];
                }
                else if (comp.count == 3) {
                    
                    datamodel.result = nil;
                    datamodel.numbers = comp[0];
                    datamodel.singleordouble = comp[1];
                    datamodel.bigorsmall = comp[2];
                }
                else {
                    datamodel.result = comp[0];
                    datamodel.numbers = comp[1];
                    datamodel.singleordouble = comp[2];
                    datamodel.bigorsmall = comp[3];
                }
                [dataarray addObject:datamodel];
            }
            model.datas = dataarray;
            
            [self.dataSource addObject:model];
        }
        
        [self.tableView reloadData];
        
        [self endRefresh:self.tableView WithdataArr:array];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self endRefresh:self.tableView WithdataArr:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
