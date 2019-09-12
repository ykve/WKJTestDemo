//
//  CartCQOneToFiveViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/28.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CartCQOneToFiveViewController.h"
#import "CQOneToFiveTableViewCell.h"
#import "DoubleSideHeaderView.h"

#define CQOneToFiveTableViewCellID @"CQOneToFiveTableViewCellID"

@interface CartCQOneToFiveViewController ()

@end

@implementation CartCQOneToFiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];//12421421

}


- (void)setupUI{
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.frame = self.view.bounds;
    
    [self.tableView registerClass:[CQOneToFiveTableViewCell class] forCellReuseIdentifier:CQOneToFiveTableViewCellID];
    
    
    [self hiddenavView];
}
-(void)hiddenavView {
    
    self.navView.hidden = YES;
    self.navView.alpha = 0;
}



#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        CQOneToFiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CQOneToFiveTableViewCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
//        cell.delegate = self;
    
        return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *objs = [[NSBundle mainBundle]loadNibNamed:@"DoubleSideHeaderView" owner:nil options:nil];
    
    DoubleSideHeaderView *header = objs.firstObject;
    
    if (section==0) {
        header.titleLbl.text = @"第一球";
    } else if (section == 1){
        header.titleLbl.text = @"第二球";
    }else if (section == 2){
        header.titleLbl.text = @"第三球";
    }else if (section == 3){
        header.titleLbl.text = @"第四球";
    }else if (section == 4){
        header.titleLbl.text = @"第五球";
    }
//    header.titleLbl.textColor = [UIColor colorWithHex:@"1B1E23"];
    header.titleLbl.textColor = [UIColor whiteColor];
    header.backgroundColor = [UIColor colorWithHex:@"1B1E23"];
    header.frame = CGRectMake(0, 0, self.view.width, 30);
    header.leftVeiw.backgroundColor = [UIColor colorWithHex:@"EC6630"];
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
