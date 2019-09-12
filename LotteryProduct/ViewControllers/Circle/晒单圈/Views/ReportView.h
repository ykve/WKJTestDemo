//
//  ReportView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/16.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *reprotData;

@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) UIControl *overlayView;

@property (nonatomic, copy) void(^selectRortBlock)(NSDictionary *report);
-(void)show;

@end
