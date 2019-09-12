//
//  CartChongqin2Cell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/29.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartChongqin2Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numbersBtns;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlabs;

@property (weak, nonatomic) IBOutlet UILabel *misstitlelab;

@property (copy, nonatomic) void (^selectBlock)(UIButton *btn);

@end
