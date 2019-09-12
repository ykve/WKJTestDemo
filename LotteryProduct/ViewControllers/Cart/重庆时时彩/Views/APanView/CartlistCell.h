//
//  CartlistCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartlistCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UILabel *numberlab;
@property (weak, nonatomic) IBOutlet UILabel *countlab;
@property (weak, nonatomic) IBOutlet UILabel *totalcountlab;
@property (weak, nonatomic) IBOutlet UILabel *pricelab;
@property (copy, nonatomic) void(^updataBlock)(NSInteger time);
@property (copy, nonatomic) void(^deleteBlock)(void);
@end
