//
//  LeftCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface LeftCtrl : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSArray *dataSource;
@property (nonatomic , strong)RootCtrl *vc;
+(instancetype)share;

-(void)show:(RootCtrl *)viewcontroller;

-(void)dismiss;

@end
