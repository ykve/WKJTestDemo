//
//  MissBigorSmallCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "MissBigorSmallCtrl.h"
#import "BigorSmallHeadView.h"
@interface MissBigorSmallCtrl ()

@property (nonatomic, strong)BigorSmallHeadView *headerView;

@property (nonatomic, assign)NSInteger sort;

@property (nonatomic, assign)NSInteger count;

@end

@implementation MissBigorSmallCtrl

-(BigorSmallHeadView *)headerView {
    
    if (!_headerView) {
        WS(weakSelf);
        _headerView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BigorSmallHeadView class]) owner:self options:nil]firstObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90);
        _headerView.selectnumberBlock = ^(NSInteger index) {
            
            weakSelf.sort = index;
            
            [weakSelf initData:weakSelf.count];
        };
    }
    return _headerView;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self hiddenavView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview: self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    
    self.sort = 1;
    [self initData:1];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 90;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RJCellIdentifier];
        
        UIView *v = [UIView viewWithLabelNumber:4 Withlabelwidth:CGSizeMake(SCREEN_WIDTH/4, 30)];
        v.tag = 100;
        [cell.contentView addSubview:v];
    }
    cell.backgroundColor = [UIColor colorWithHex:@"cccccc"];
    //这里先使用假数据
    UIView *view = [cell.contentView viewWithTag:100];
    NSArray *array = [self.dataSource objectAtIndex:indexPath.row];
    for (UILabel *label in view.subviews) {
        label.text = nil;
        label.text = STRING([array objectAtIndex:label.tag-200]);
        label.font = FONT(15);
        label.textColor = [UIColor darkGrayColor];
        label.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)initData:(NSInteger)count {
    
    self.count = count;
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscSizeMissCount.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscSizeMissCount.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcSizeMissCount.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"count":@(self.count),@"sort":@(self.sort)} success:^(BaseData *data) {
        
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *bigarr = data.data[@"bigList"];
        NSArray *smallarr = data.data[@"smallList"];
        
        for (int i = 0; i<MAX(bigarr.count, smallarr.count); i++) {
            
            NSDictionary *bigdic = nil;
            NSDictionary *smalldic = nil;
            
            if (i<bigarr.count) {
                
                bigdic = bigarr[i];
            }
            else {
                bigdic = @{@"missValue":@"",@"missCount":@""};
            }
            if (i<smallarr.count) {
                
                smalldic = smallarr[i];
            }
            else {
                smalldic = @{@"missValue":@"",@"missCount":@""};
            }
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            
            [array addObject:bigdic[@"missValue"]];
            [array addObject:bigdic[@"missCount"]];
            [array addObject:smalldic[@"missValue"]];
            [array addObject:smalldic[@"missCount"]];
            
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
