//
//  HalfRedBoViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "HalfRedBoViewController.h"
#import "HalfRedBoTableViewCell.h"


@interface HalfRedBoViewController ()

@end

@implementation HalfRedBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

}

#pragma mark setupUI
- (void)setupUI{
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.tableView];
    
    [self hiddenavView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HalfRedBoTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:HalfRedBoTableViewCellID];
}

-(void)hiddenavView {
    
    self.navView.hidden = YES;
    self.navView.alpha = 0;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HalfRedBoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HalfRedBoTableViewCellID forIndexPath:indexPath];
    return cell;
    
}


@end
