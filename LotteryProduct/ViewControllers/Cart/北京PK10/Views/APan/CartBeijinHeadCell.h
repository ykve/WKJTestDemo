//
//  CartBeijinHeadCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/29.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartBeijinHeadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlabs;


@end
