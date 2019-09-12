//
//  ConditionView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/8.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConditionModel.h"
@interface ConditionView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong, nonatomic) NSArray<ConditionModel *> * array;
@property (strong, nonatomic) ConditionModel *selectmodel;
@property (strong, nonatomic) UIControl *overlayView;
@property (copy, nonatomic) void (^conditionBlock) (ConditionModel *model);
@property (copy, nonatomic) void (^conditionclearBlock) (void);

+(ConditionView *)share;

+(void)tearDown;

-(void)show;

@end
