//
//  PK10TwoFaceMissListCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10TwoFaceMissListCtrl.h"
#import "PK10TwofaceMissHeadView.h"
@interface PK10TwoFaceMissListCtrl ()

@property (nonatomic, strong)PK10TwofaceMissHeadView *headView;

@property (nonatomic, assign) NSInteger selectindex;

@property (nonatomic, assign) NSInteger way;
@end

@implementation PK10TwoFaceMissListCtrl

-(PK10TwofaceMissHeadView *)headView {
    
    if (!_headView) {
        @weakify(self)
        _headView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([PK10TwofaceMissHeadView class]) owner:self options:nil]firstObject];
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 107);
        _headView.type1lab.text = self.type == 0 ? @"大" : @"单";
        _headView.type2lab.text = self.type == 0 ? @"小" : @"双";
        _headView.selectindexBlock = ^(NSInteger index) {
            @strongify(self)
            self.selectindex = index;
            
            [self initDataWithway:self.way];
        };
    }
    return _headView;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self hiddenavView];
     
    self.tableView.tableHeaderView = self.headView;
    self.tableView.rowHeight = 30;
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    
    self.selectindex = 1;
    self.way = 0;
    
    [self initDataWithway:0];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RJCellIdentifier];
        
        UIView *v = [UIView viewWithLabelNumber:4 Withlabelwidth:CGSizeMake(SCREEN_WIDTH/4, 30)];
        v.tag = 100;
        v.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell.contentView addSubview:v];
    }
    
    UIView *v = [cell.contentView viewWithTag:100];
    NSArray *array = [self.dataSource objectAtIndex:indexPath.row];
    for (UILabel *lab in v.subviews) {
        
        lab.text = nil;
        lab.backgroundColor = WHITE;
        lab.text = STRING([array objectAtIndex:lab.tag-200]);
        lab.font = FONT(13);
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)initDataWithway:(NSInteger)way {
    
    self.way = way;
    
    NSString *url = nil;
    if (self.lottery_type == 6) {
        
        url = @"/bjpksSg/lianMianYl.json";
    }
    else if (self.lottery_type == 7) {
        url = @"/xyftSg/lianMianYl.json";
    }   else if (self.lottery_type == 11) {
        url = @"/azPrixSg/lianMianYl.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"way":@(way == 0 ? 1 : 3),@"type":self.type == 0 ? @382 : @383,@"number":@(self.selectindex)} success:^(BaseData *data) {
        
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *bigarr = self.type == 0 ? data.data[@"大"] : data.data[@"单"];
        NSArray *smallarr = self.type == 0 ? data.data[@"小"] : data.data[@"双"];
        
        for (int i = 0; i<MAX(bigarr.count, smallarr.count); i++) {
            
            NSDictionary *bigdic = nil;
            NSDictionary *smalldic = nil;
            
            if (i<bigarr.count) {
                
                bigdic = bigarr[i];
            }
            else {
                bigdic = @{@"number":@"",@"times":@""};
            }
            if (i<smallarr.count) {
                
                smalldic = smallarr[i];
            }
            else {
                smalldic = @{@"number":@"",@"times":@""};
            }
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            
            [array addObject:bigdic[@"number"]];
            [array addObject:bigdic[@"times"]];
            [array addObject:smalldic[@"number"]];
            [array addObject:smalldic[@"times"]];
            
            [self.dataSource addObject:array];
        }
        
        [self.tableView reloadData];
        
        
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
