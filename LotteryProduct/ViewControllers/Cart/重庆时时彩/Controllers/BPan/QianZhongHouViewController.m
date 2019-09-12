//
//  QianZhongHouViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/15.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "QianZhongHouViewController.h"
#import "QianZhongHouTableViewCell.h"
#import "DoubleSideHeaderView.h"

static NSString *QianZhongHouTableViewCellID = @"QianZhongHouTableViewCellID";


@interface QianZhongHouViewController ()

@end

@implementation QianZhongHouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    
    [self.view addSubview:self.tableView];
    
    self.tableView.frame = self.view.bounds;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QianZhongHouTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:QianZhongHouTableViewCellID];
    self.tableView.backgroundColor = [UIColor colorWithHex:@"1B1E23"];

    
    [self hiddenavView];
}

-(void)hiddenavView {
    
    self.navView.hidden = YES;
    self.navView.alpha = 0;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QianZhongHouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QianZhongHouTableViewCellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
    
    
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 175;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *objs = [[NSBundle mainBundle]loadNibNamed:@"DoubleSideHeaderView" owner:nil options:nil];
    
    DoubleSideHeaderView *header = objs.firstObject;
    
    header.frame = CGRectMake(0, 0, self.view.width, 30);
    header.backgroundColor = [UIColor colorWithHex:@"1B1E23"];

    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
