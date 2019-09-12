//
//  BanklistView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/10.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankModel.h"
@interface BanklistView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIControl *overlayView;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *banklist;

@property (copy, nonatomic) void (^selectbankBlock)(BankModel *bankmodel);

-(void)show:(NSArray *)array;

@end
