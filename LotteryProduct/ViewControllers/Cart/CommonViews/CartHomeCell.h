//
//  CartHomeCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/30.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartHomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (weak, nonatomic) IBOutlet UILabel *timelab;

@property (strong, nonatomic) WB_Stopwatch *stopwatch;

@end
