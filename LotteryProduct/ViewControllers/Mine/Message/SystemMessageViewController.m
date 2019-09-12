//
//  SystemMessageViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SystemMessageViewController.h"

@interface SystemMessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation SystemMessageViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension; // 自适应单元格高度
    self.tableView.estimatedRowHeight = 50; //先估计一个高度
    
    [self initData];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 75;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = dic[@"message"];
    
    cell.textLabel.numberOfLines = 0;
    
    cell.textLabel.font = FONT(14);
    
    return cell;
}

-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/listInform.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        self.dataArray = data.data;
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
@end
