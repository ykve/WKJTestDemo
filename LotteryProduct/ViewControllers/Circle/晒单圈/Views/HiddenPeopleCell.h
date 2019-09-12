//
//  HiddenPeopleCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HiddenPeopleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *namelab;

@property (weak, nonatomic) IBOutlet UISwitch *open;

@property (copy, nonatomic) void (^onOffBlock)(BOOL onoff);

@end
