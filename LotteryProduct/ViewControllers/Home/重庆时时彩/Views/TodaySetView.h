//
//  TodaySetView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodaySetView : UIView

@property (weak, nonatomic) IBOutlet UITextField *yellowminfield;
@property (weak, nonatomic) IBOutlet UITextField *yellowmaxfield;

@property (weak, nonatomic) IBOutlet UITextField *orangeminfield;
@property (weak, nonatomic) IBOutlet UITextField *orangemaxfield;

@property (weak, nonatomic) IBOutlet UITextField *blueminfield;
@property (weak, nonatomic) IBOutlet UITextField *bluemaxfield;
/**
 1:今日统计（重庆时时彩）
 2：今日号码（北京PK10）
 */
@property (assign, nonatomic) NSInteger type;
@property (nonatomic, copy) void(^todaysetBlock)(NSDictionary *dic);

@end
