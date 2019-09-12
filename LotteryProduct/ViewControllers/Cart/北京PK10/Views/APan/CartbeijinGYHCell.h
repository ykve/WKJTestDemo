//
//  CartbeijinGYHCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/13.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartbeijinGYHCell : UITableViewCell

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (copy, nonatomic) void (^selectBlock)(UIButton *btn);

@property (strong, nonatomic) NSMutableArray <UILabel *> *numberLabels;
@end
