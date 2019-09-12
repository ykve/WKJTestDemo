//
//  PCNumberResultCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/13.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PCNumberResultCtrl.h"
#import "PCnumberresultCell.h"
#import "PCResultModel.h"

@interface PCNumberResultCtrl ()

@end

@implementation PCNumberResultCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self hiddenavView];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PCnumberresultCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    self.tableView.rowHeight = 35;
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
    
    [self initDataWithissue:0 Withsort:0];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 25;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    PCnumberresultCell *cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([PCnumberresultCell class]) owner:self options:nil]firstObject];
    
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 25);
    
    cell.numberlab.font = [UIFont systemFontOfSize:13];
    cell.versionlab.font = [UIFont systemFontOfSize:13];
    cell.biglab.font = [UIFont systemFontOfSize:13];
    cell.smalllab.font = [UIFont systemFontOfSize:13];
    cell.singlelab.font = [UIFont systemFontOfSize:13];
    cell.doublelab.font = [UIFont systemFontOfSize:13];
    cell.maxlab.font = [UIFont systemFontOfSize:13];

    
    cell.toptitlelab1.hidden = NO;
    
    cell.toptitlelab2.hidden = NO;
    
    cell.versionlab.text = @"期号";
    
    cell.numberlab.text = @"开奖号码";
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PCnumberresultCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    PCResultModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.versionlab.text = [NSString stringWithFormat:@"%@期",model.issue];
    
//    cell.versionlab.adjustsFontSizeToFitWidth = YES;
    
    if (model.waiting) {
        
        cell.numberlab.text = model.waiting;
        cell.smalllab.text = @"";
        cell.biglab.text = @"";
        cell.singlelab.text = @"";
        cell.doublelab.text = @"";
        cell.maxlab.text = @"";
        cell.leopardlab.text = @"";
    }
    else {
        NSArray *numarray = [model.number componentsSeparatedByString:@","];
        
        cell.numberlab.text = [NSString stringWithFormat:@"%ld+%ld+%ld=%ld",(long)[numarray[0]integerValue],(long)[numarray[1]integerValue],(long)[numarray[2]integerValue],model.sum];
        
        if ([model.bigOrSmall isEqualToString:@"大"]) {
            
            cell.smalllab.text = @"";
            cell.biglab.text = @"大";
        }
        else {
            cell.smalllab.text = @"小";
            cell.biglab.text = @"";
        }
        if ([model.singleOrDouble isEqualToString:@"双"]) {
            
            cell.singlelab.text = @"";
            cell.doublelab.text = @"双";
        }
        else {
            cell.singlelab.text = @"单";
            cell.doublelab.text = @"";
        }
        cell.maxlab.text = model.limitValue;
        cell.leopardlab.text = model.leopard;
    }
  
    for (UILabel *lab in cell.contentView.subviews) {
        
        lab.backgroundColor = indexPath.row%2 == 0 ? WHITE : [UIColor groupTableViewBackgroundColor];
    }
    
    return cell;
}

-(void)initDataWithissue:(NSInteger)issue Withsort:(NSInteger)sort {
    
    NSInteger index = issue == 0 ? 30 : issue == 1 ? 50 : issue == 2 ? 100 : 200;
    
    @weakify(self)
    [WebTools postWithURL:@"/pceggSg/getSgHistoryList2.json" params:@{@"pageSize":@(index)} success:^(BaseData *data) {
        
        @strongify(self)
        
        NSMutableArray *array = [PCResultModel mj_objectArrayWithKeyValuesArray:data.data];
        
        self.dataSource = array;
        
        PCResultModel *model = array.firstObject;
        
        if (sort == 1) {
            
            NSArray *reversedArray = [[self.dataSource reverseObjectEnumerator] allObjects];
            
            [self.dataSource removeAllObjects];
            
            [self.dataSource addObjectsFromArray:reversedArray];
        }
        
        PCResultModel *newmodel = [[PCResultModel alloc]init];
        newmodel.issue = INTTOSTRING(model.issue.integerValue + 1);
        newmodel.waiting = @"等待开奖";
        
        [self.dataSource insertObject:newmodel atIndex:0];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
