//
//  ShowOrderCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/2.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ShowOrderCtrl.h"
#import "CircleSearchView.h"
#import "CircleDetailViewController.h"

@interface ShowOrderCtrl ()

@end

@implementation ShowOrderCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titlestring = @"晒单圈";
    
    [self rigBtn:nil Withimage:@"circle_nav_me" With:^(UIButton *sender) {
        
    }];
    
    UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE(@"circle_nav_search") andTarget:self andAction:@selector(searchClick) andType:UIButtonTypeCustom];
    [self.navView addSubview:btn];
    
    @weakify(self)
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.rightBtn.mas_left).offset(0);
        make.centerY.equalTo(self.rightBtn);
    }];
    
    self.tableView.rowHeight = 75;
    
    self.tableView.backgroundColor = CLEAR;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT, 0, 0, 0));
    }];
    
    NSArray *array = @[@"重庆时时彩",@"六合彩",@"北京PK10",@"新疆时时彩",@"幸运飞艇",@"比特币分分彩",@"PC蛋蛋"];
    
    for (int i = 0 ; i< array.count; i++) {
        
        NSString *imgstr = [NSString stringWithFormat:@"home_%d",i+1];
        
        NSDictionary *dic = @{@"title":array[i],@"icon":imgstr};
        
        [self.dataSource addObject:dic];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RJCellIdentifier];
    }
    
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.imageView.image = IMAGE(dic[@"icon"]);
    
    cell.textLabel.text = dic[@"title"];

    cell.detailTextLabel.text = @"下一个10万就是你";
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CircleDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
    [self.navigationController pushViewController:detail animated:YES];
//    if (indexPath.row==0) {
//
//
//    }
//    else if (indexPath.row == 2) {
//
//
//    }
}

-(void)searchClick {
    
    CircleSearchView *search = [[CircleSearchView alloc]init];
    
    PUSH(search);
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
