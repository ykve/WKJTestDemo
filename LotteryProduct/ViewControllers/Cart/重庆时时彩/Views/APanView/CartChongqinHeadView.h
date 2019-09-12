//
//  CartChongqinHeadView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartChongqinHeadView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nextversionslab;
@property (weak, nonatomic) IBOutlet UILabel *currentversionslab;
@property (weak, nonatomic) IBOutlet UILabel *endtimelab;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlabs;
@property (weak, nonatomic) IBOutlet UILabel *waitinglab;

@property (copy, nonatomic) void(^lookallBlock)(void);

@end
