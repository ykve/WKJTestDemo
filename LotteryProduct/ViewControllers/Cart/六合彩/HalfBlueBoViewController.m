//
//  HalfBlueBoViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "HalfBlueBoViewController.h"
#import "HalfBlueBoTableViewCell.h"

@interface HalfBlueBoViewController ()

@end

@implementation HalfBlueBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];

    [self.view addSubview:self.tableView];
    
    [self hiddenavView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HalfBlueBoTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:HalfBlueBoTableViewCellID];
}


-(void)hiddenavView {
    
    self.navView.hidden = YES;
    self.navView.alpha = 0;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HalfBlueBoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HalfBlueBoTableViewCellID forIndexPath:indexPath];
    return cell;
    
}

@end
