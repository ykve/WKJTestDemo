//
//  CartChongqinHeadCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartChongqinHeadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *versionslab;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlabs;

@end
