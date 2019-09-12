//
//  ActiveListCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/30.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ActiveListCtrl.h"
#import "ActivelistCell.h"
@interface ActiveListCtrl ()

@end

@implementation ActiveListCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"活动礼包";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActivelistCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    
    self.tableView.rowHeight = SCREEN_WIDTH * 0.68;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT, 0, 0, 0));
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivelistCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    
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
