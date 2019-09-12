//
//  CartSixCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartSixCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *blockBtn;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (weak, nonatomic) IBOutlet UILabel *Oddslab;

@property (copy, nonatomic) void (^cartsixBlock)(UIButton *sender);
@end
