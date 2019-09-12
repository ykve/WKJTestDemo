//
//  IGKbetSetCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/26.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "IGKbetSetCtrl.h"
#import "IGKbetSetCell.h"
@interface IGKbetSetCtrl ()

@end

@implementation IGKbetSetCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"开奖推送";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([IGKbetSetCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT, 0, 0, 0));
    }];
    
    NSArray *array1 = @[@"开启声音提醒"];
    NSArray *array2 = @[@"重庆时时彩",@"六合彩",@"北京PK10",@"幸运飞艇",@"新疆时时彩",@"比特币分分彩",@"PC蛋蛋"];
    [self.dataSource addObject:array1];
    [self.dataSource addObject:array2];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataSource[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    head.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UITextView *text = [[UITextView alloc]init];
    text.backgroundColor = WHITE;
    text.contentInset = UIEdgeInsetsMake(12, 12, 0, 0);
    text.text = section == 0 ? @"声音" : @"彩种";
    text.font = FONT(13);
    text.textColor = [UIColor lightGrayColor];
    text.userInteractionEnabled = NO;
    [head addSubview:text];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(head).with.insets(UIEdgeInsetsMake(1, 0, 5, 0));
    }];
    return head;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IGKbetSetCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    cell.titlelab.text = self.dataSource[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0) {
        
        cell.subtitlelab.text = nil;
    }
    else {
        cell.subtitlelab.text = indexPath.row == 1 ? @"每周二、四、六提醒" : @"每天提醒";
    }
    
    return cell;
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
